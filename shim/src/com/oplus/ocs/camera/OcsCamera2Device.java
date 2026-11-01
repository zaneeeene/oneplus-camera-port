package com.oplus.ocs.camera;

import android.content.Context;
import android.graphics.Bitmap;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureFailure;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.TotalCaptureResult;
import android.os.Handler;
import android.util.Log;
import android.view.Surface;

import com.oplus.ocs.camera.appinterface.CameraDeviceInfoInterface;
import com.oplus.ocs.camera.appinterface.CameraDeviceInterface;
import com.oplus.ocs.camera.appinterface.CameraFlashCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraPictureCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraPreviewAssistCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraPreviewCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraRecordingCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraStateCallbackAdapter;
import com.oplus.ocs.camera.common.parameter.SdkCameraDeviceConfig;
import com.oplus.ocs.camera.common.surface.SurfaceWrapper;
import com.oplus.ocs.camera.common.util.ErrorResult;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

/**
 * CameraDeviceInterface implemented directly on top of Camera2.
 *
 * The Oplus app's client adapters (CameraDeviceAdapterV2 etc.) are unchanged; they
 * feed us the same SdkCameraDeviceConfig / Surface objects the real OCS producer
 * used, and we create a real Camera2 capture session with those surfaces.
 */
public final class OcsCamera2Device implements CameraDeviceInterface {
    private static final String TAG = "OcsCamera2Device";

    private final Context mContext;
    private final String mCameraId;
    private final String mCameraType;
    private final CameraStateCallbackAdapter mStateCallback;
    private final Handler mHandler;

    private CameraDevice mCameraDevice;
    private CameraCaptureSession mSession;
    private final List<Surface> mSessionSurfaces = new ArrayList<Surface>();
    private final LinkedHashSet<Surface> mPreviewSurfaces = new LinkedHashSet<Surface>();
    private final LinkedHashSet<Surface> mPictureSurfaces = new LinkedHashSet<Surface>();
    private final Map<String, Object> mParameters = new HashMap<String, Object>();

    private CameraPreviewCallbackAdapter mPreviewCallback;
    private String mModeName = "photo_mode";
    private boolean mPreviewing;
    private boolean mFirstFrame;
    private boolean mConfiguredCallbackSent;
    private boolean mSessionFailed;

    public OcsCamera2Device(Context context, String cameraId, String cameraType,
                            CameraStateCallbackAdapter stateCallback, Handler handler) {
        mContext = context;
        mCameraId = cameraId;
        mCameraType = cameraType == null ? "rear_main" : cameraType;
        mStateCallback = stateCallback;
        mHandler = handler;
        Log.i(TAG, "created type=" + mCameraType + " id=" + mCameraId);
    }

    public void setCameraDevice(CameraDevice device) {
        mCameraDevice = device;
    }

    public String getCameraType() {
        return mCameraType;
    }

    @Override
    public void configure(SdkCameraDeviceConfig config) {
        if (config == null) return;
        mModeName = config.getModeName() == null ? mModeName : config.getModeName();
        try {
            for (SurfaceWrapper sw : config.getPreviewSurfaces()) {
                if (sw != null && sw.getSurface() != null) {
                    mPreviewSurfaces.add(sw.getSurface());
                }
            }
            for (SurfaceWrapper sw : config.getPictureSurfaces()) {
                if (sw != null && sw.getSurface() != null) {
                    mPictureSurfaces.add(sw.getSurface());
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "configure surfaces", e);
        }
        Log.i(TAG, "configure type=" + mCameraType + " mode=" + mModeName
                + " preview=" + mPreviewSurfaces.size() + " picture=" + mPictureSurfaces.size());
        if (mPreviewSurfaces.isEmpty()) {
            // The app builds the config first and supplies the real preview Surface
            // in CameraDevice.startPreview(map, ...). Its state machine waits for
            // onSessionConfigured before it makes that call, so acknowledge here;
            // the actual Camera2 session is created from the map in startPreview().
            Log.i(TAG, "configure: no real preview surface yet, scheduling callback");
            final Handler h = mHandler;
            if (h != null) {
                h.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        Log.i(TAG, "configure: delayed onSessionConfigured");
                        notifySessionConfigured();
                    }
                }, 1000);
            } else {
                notifySessionConfigured();
            }
            return;
        }
        ensureSession(new ArrayList<Surface>(mPreviewSurfaces), mPreviewing ? new Runnable() {
            @Override
            public void run() {
                startRepeating();
            }
        } : null);
    }

    @Override
    public void startPreview(Map<String, Surface> map, CameraPreviewCallbackAdapter callback, Handler handler) {
        startPreview(map, callback, handler, null);
    }

    @Override
    public void startPreview(Map<String, Surface> map, CameraPreviewCallbackAdapter callback,
                             Handler handler, CameraPreviewAssistCallbackAdapter assist) {
        mPreviewCallback = callback;
        if (map != null) {
            for (Surface surface : map.values()) {
                if (surface != null) {
                    mPreviewSurfaces.add(surface);
                }
            }
        }
        Log.i(TAG, "startPreview type=" + mCameraType + " map=" + (map == null ? "null" : map.size())
                + " surfaces=" + mPreviewSurfaces.size());
        if (mPreviewSurfaces.isEmpty()) {
            Log.e(TAG, "startPreview without a surface");
            fail(ErrorResult.PARAMETER_ERROR);
            return;
        }
        ensureSession(new ArrayList<Surface>(mPreviewSurfaces), new Runnable() {
            @Override
            public void run() {
                startRepeating();
            }
        });
    }

    private void ensureSession(final List<Surface> surfaces, final Runnable onReady) {
        if (mCameraDevice == null) {
            Log.e(TAG, "ensureSession: camera device is null");
            fail(ErrorResult.ILLEGAL_STATE_ERROR);
            return;
        }
        if (surfaces == null || surfaces.isEmpty()) {
            fail(ErrorResult.PARAMETER_ERROR);
            return;
        }
        if (mSession != null && sameSurfaces(surfaces)) {
            if (onReady != null) onReady.run();
            return;
        }
        if (mSession != null) {
            try {
                mSession.close();
            } catch (Exception ignored) {
            }
            mSession = null;
            mSessionSurfaces.clear();
        }
        mSessionFailed = false;
        try {
            mCameraDevice.createCaptureSession(surfaces, new CameraCaptureSession.StateCallback() {
                @Override
                public void onConfigured(CameraCaptureSession session) {
                    mSession = session;
                    mSessionSurfaces.clear();
                    mSessionSurfaces.addAll(surfaces);
                    Log.i(TAG, "session configured type=" + mCameraType + " surfaces=" + surfaces.size());
                    notifySessionConfigured();
                    if (onReady != null) onReady.run();
                }

                @Override
                public void onConfigureFailed(CameraCaptureSession session) {
                    Log.e(TAG, "session configure failed type=" + mCameraType);
                    mSessionFailed = true;
                    fail(ErrorResult.STREAM_SURFACE_ERROR);
                }
            }, mHandler);
        } catch (CameraAccessException e) {
            Log.e(TAG, "createCaptureSession", e);
            fail(ErrorResult.STREAM_SURFACE_ERROR);
        } catch (Exception e) {
            Log.e(TAG, "createCaptureSession unexpected", e);
            fail(ErrorResult.STREAM_SURFACE_ERROR);
        }
    }

    private void notifySessionConfigured() {
        if (mConfiguredCallbackSent) return;
        mConfiguredCallbackSent = true;
        try {
            mStateCallback.onSessionConfigured();
        } catch (Exception e) {
            Log.e(TAG, "onSessionConfigured callback", e);
        }
    }

    private boolean sameSurfaces(List<Surface> surfaces) {
        if (mSessionSurfaces.size() != surfaces.size()) return false;
        for (int i = 0; i < surfaces.size(); i++) {
            if (mSessionSurfaces.get(i) != surfaces.get(i)) return false;
        }
        return true;
    }

    private void startRepeating() {
        if (mSession == null) {
            Log.e(TAG, "startRepeating without session");
            return;
        }
        try {
            CaptureRequest.Builder builder = mCameraDevice.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW);
            for (Surface surface : mPreviewSurfaces) {
                builder.addTarget(surface);
            }
            setSafe(builder, CaptureRequest.CONTROL_MODE, CaptureRequest.CONTROL_MODE_AUTO);
            setSafe(builder, CaptureRequest.CONTROL_AF_MODE, CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE);
            setSafe(builder, CaptureRequest.CONTROL_AE_MODE, CaptureRequest.CONTROL_AE_MODE_ON);
            setSafe(builder, CaptureRequest.CONTROL_AWB_MODE, CaptureRequest.CONTROL_AWB_MODE_AUTO);
            applyParameters(builder);
            mSession.setRepeatingRequest(builder.build(), mCaptureCallback, mHandler);
            mPreviewing = true;
            Log.i(TAG, "repeating preview started type=" + mCameraType);
            try {
                mStateCallback.onActive();
            } catch (Exception e) {
                Log.e(TAG, "onActive", e);
            }
        } catch (Exception e) {
            Log.e(TAG, "setRepeatingRequest", e);
            fail(ErrorResult.ILLEGAL_STATE_ERROR);
        }
    }

    private static <T> void setSafe(CaptureRequest.Builder builder, CaptureRequest.Key<T> key, T value) {
        try {
            builder.set(key, value);
        } catch (Exception ignored) {
        }
    }

    private void applyParameters(CaptureRequest.Builder builder) {
        for (Map.Entry<String, Object> entry : mParameters.entrySet()) {
            try {
                // Key name lookup is deliberately not used: the OCS string keys are
                // vendor tags that tapas does not export. Only Android keys are set
                // by the typed setParameter overloads and stored by key name.
                CaptureRequest.Key key = keyForName(entry.getKey());
                if (key != null) {
                    builder.set(key, entry.getValue());
                }
            } catch (Exception ignored) {
            }
        }
    }

    private static CaptureRequest.Key keyForName(String name) {
        if (name == null) return null;
        if (name.equals(CaptureRequest.CONTROL_AE_EXPOSURE_COMPENSATION.getName()))
            return CaptureRequest.CONTROL_AE_EXPOSURE_COMPENSATION;
        if (name.equals(CaptureRequest.CONTROL_AF_MODE.getName()))
            return CaptureRequest.CONTROL_AF_MODE;
        if (name.equals(CaptureRequest.CONTROL_AE_MODE.getName()))
            return CaptureRequest.CONTROL_AE_MODE;
        if (name.equals(CaptureRequest.CONTROL_AWB_MODE.getName()))
            return CaptureRequest.CONTROL_AWB_MODE;
        if (name.equals(CaptureRequest.SCALER_CROP_REGION.getName()))
            return CaptureRequest.SCALER_CROP_REGION;
        return null;
    }

    private final CameraCaptureSession.CaptureCallback mCaptureCallback = new CameraCaptureSession.CaptureCallback() {
        @Override
        public void onCaptureStarted(CameraCaptureSession session, CaptureRequest request, long timestamp, long frameNumber) {
            if (mPreviewCallback != null && !mPreviewing) {
                return;
            }
            if (mPreviewCallback != null) {
                try {
                    mPreviewCallback.onPreviewCaptureStarted(request, timestamp, frameNumber);
                } catch (Exception e) {
                    Log.e(TAG, "onPreviewCaptureStarted", e);
                }
            }
        }

        @Override
        public void onCaptureCompleted(CameraCaptureSession session, CaptureRequest request, TotalCaptureResult result) {
            if (!mFirstFrame) {
                mFirstFrame = true;
                Log.i(TAG, "first preview frame type=" + mCameraType);
                try {
                    if (mPreviewCallback != null) mPreviewCallback.onFirstMetaArrived();
                    mStateCallback.onReady();
                } catch (Exception e) {
                    Log.e(TAG, "first frame callbacks", e);
                }
            }
            if (mPreviewCallback != null) {
                try {
                    mPreviewCallback.onPreviewCaptureProgressed(request, result);
                } catch (Exception e) {
                    Log.e(TAG, "onPreviewCaptureProgressed", e);
                }
            }
        }

        @Override
        public void onCaptureFailed(CameraCaptureSession session, CaptureRequest request, CaptureFailure failure) {
            Log.e(TAG, "preview capture failed reason=" + failure.getReason());
            if (mPreviewCallback != null) {
                try {
                    mPreviewCallback.onPreviewCaptureFailed(request, failure);
                } catch (Exception e) {
                    Log.e(TAG, "onPreviewCaptureFailed", e);
                }
            }
        }
    };

    private void fail(ErrorResult error) {
        try {
            mStateCallback.onSessionConfigureFail(error);
        } catch (Exception e) {
            Log.e(TAG, "onSessionConfigureFail", e);
        }
    }

    @Override
    public void stopPreview() {
        stopPreview(false);
    }

    @Override
    public void stopPreview(boolean z) {
        mPreviewing = false;
        if (mSession != null) {
            try {
                mSession.stopRepeating();
                mSession.abortCaptures();
            } catch (Exception e) {
                Log.e(TAG, "stopPreview", e);
            }
        }
    }

    @Override
    public void close(boolean z) {
        close(z, true);
    }

    @Override
    public void close(boolean z, boolean z2) {
        mPreviewing = false;
        try {
            if (mSession != null) {
                mSession.close();
            }
        } catch (Exception ignored) {
        }
        mSession = null;
        try {
            if (mCameraDevice != null) {
                mCameraDevice.close();
            }
        } catch (Exception ignored) {
        }
        mCameraDevice = null;
        try {
            mStateCallback.onCameraClosed();
        } catch (Exception e) {
            Log.e(TAG, "onCameraClosed", e);
        }
    }

    @Override
    public void closeSession() {
        try {
            if (mSession != null) mSession.close();
        } catch (Exception ignored) {
        }
        mSession = null;
        mSessionSurfaces.clear();
        mConfiguredCallbackSent = false;
        try {
            mStateCallback.onSessionClosed();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void abortCaptures() {
        if (mSession != null) {
            try {
                mSession.abortCaptures();
            } catch (Exception ignored) {
            }
        }
    }

    @Override
    public CameraDeviceInfoInterface getCameraDeviceInfo(String str, String str2) {
        return new OcsCamera2Info(mContext, mCameraId, mCameraType, str2 == null ? mModeName : str2);
    }

    @Override
    public Surface getVideoSurface() {
        return null;
    }

    @Override
    public boolean isPreviewProcessByAps() {
        return false;
    }

    @Override
    public boolean notifyLastCaptureFrame() {
        return false;
    }

    @Override
    public void onFirstPreviewFrameDrawn() {
    }

    @Override
    public void pauseRecording() {
    }

    @Override
    public void pauseRecordingToHal() {
    }

    @Override
    public Bitmap processBitmap(Bitmap bitmap, CaptureResult captureResult, int i, int i2, int i3) {
        return bitmap;
    }

    @Override
    public void registerFlashCallback(CameraFlashCallbackAdapter cameraFlashCallbackAdapter, Handler handler) {
    }

    @Override
    public void resumeRecording() {
    }

    @Override
    public void resumeRecordingToHal(CameraRecordingCallbackAdapter cameraRecordingCallbackAdapter, Handler handler) {
    }

    @Override
    public void setDisablePreview(boolean z) {
    }

    @Override
    public <T> void setParameter(CaptureRequest.Key<T> key, T value) {
        if (key != null) {
            mParameters.put(key.getName(), value);
        }
    }

    @Override
    public <T> void setParameter(String str, CaptureRequest.Key<T> key, T value) {
        setParameter(key, value);
    }

    @Override
    public void setParameter(String str, Object obj) {
        if (str != null) mParameters.put(str, obj);
    }

    @Override
    public void setParameter(String str, String str2, Object obj) {
        if (str2 != null) mParameters.put(str2, obj);
    }

    @Override
    public void setStopPreviewAfterCapture(boolean z) {
    }

    @Override
    public void startRecording(CameraRecordingCallbackAdapter cameraRecordingCallbackAdapter, Handler handler) {
    }

    @Override
    public void stopRecording() {
    }

    @Override
    public void takePicture(CameraPictureCallbackAdapter cameraPictureCallbackAdapter, Handler handler) {
        // Preview milestone: a real still-capture path will be added after the
        // live preview is confirmed. Do not crash the shutter path.
        Log.i(TAG, "takePicture requested (not implemented yet) type=" + mCameraType);
    }

    @Override
    public void takePictureTouchDownStage2() {
    }

    @Override
    public void takePictureTouchDownStage2(int i) {
    }

    @Override
    public void updateThumbnailMap(long j) {
    }
}
