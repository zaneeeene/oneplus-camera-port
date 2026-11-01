package com.oplus.ocs.camera;

import android.content.Context;
import android.graphics.ImageFormat;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.params.StreamConfigurationMap;
import android.media.MediaRecorder;
import android.util.Pair;
import android.util.Size;
import android.view.SurfaceHolder;
import android.graphics.SurfaceTexture;

import com.oplus.ocs.camera.appinterface.CameraDeviceInfoInterface;
import com.oplus.ocs.camera.common.surface.SurfaceWrapper;
import com.oplus.ocs.camera.metadata.RequestKey;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

/** CameraDeviceInfoInterface backed by a real Camera2 CameraCharacteristics. */
public final class OcsCamera2Info implements CameraDeviceInfoInterface {
    private final String mCameraId;
    private final String mCameraType;
    private final String mModeName;
    private final CameraCharacteristics mChars;
    private final StreamConfigurationMap mMap;

    public OcsCamera2Info(Context context, String cameraId, String cameraType, String modeName) {
        mCameraId = cameraId;
        mCameraType = cameraType == null ? "rear_main" : cameraType;
        mModeName = modeName == null ? "photo_mode" : modeName;
        CameraCharacteristics chars = null;
        StreamConfigurationMap map = null;
        try {
            CameraManager manager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
            if (manager != null) {
                chars = manager.getCameraCharacteristics(cameraId);
                map = chars.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP);
            }
        } catch (Exception e) {
            android.util.Log.e("OcsCamera2Info", "getCameraCharacteristics " + cameraId, e);
        }
        mChars = chars;
        mMap = map;
    }

    @Override
    public <T> T get(CameraCharacteristics.Key<T> key) {
        if (mChars == null || key == null) return null;
        try {
            return mChars.get(key);
        } catch (IllegalArgumentException e) {
            // Tapas does not define the Oplus vendor keys. CameraCharacteristics.get()
            // throws for unknown keys instead of returning null, so treat every
            // unsupported vendor key as absent.
            android.util.Log.w("OcsCamera2Info", "missing key " + key.getName());
            return null;
        } catch (Exception e) {
            android.util.Log.e("OcsCamera2Info", "get " + key.getName(), e);
            return null;
        }
    }

    @Override
    public CameraCharacteristics getCameraCharacteristics() {
        return mChars;
    }

    @Override
    public List<String> getConfigureListByParameter(RequestKey requestKey) {
        return Collections.emptyList();
    }

    @Override
    public Object getConfigureParameterRange(String str) {
        return null;
    }

    @Override
    public Map<String, Object> getConfigureParameterRangeMap() {
        return new HashMap<String, Object>();
    }

    @Override
    @Deprecated
    public Map<String, List<String>> getConflictParameter() {
        return new HashMap<String, List<String>>();
    }

    @Override
    public Map<String, List<String>> getConflictParameter(String str, String str2) {
        return new HashMap<String, List<String>>();
    }

    @Override
    public Map<String, String> getCustomInfoMap() {
        return new HashMap<String, String>();
    }

    @Override
    public List<String> getPhysicalCameraTypeList() {
        return Collections.singletonList(mCameraType);
    }

    @Override
    public Hashtable<Size, Size> getPreviewMappingSizesFromConfig(String str, Map<String, String> map) {
        return new Hashtable<Size, Size>();
    }

    @Override
    public Object getPreviewParameterRange(String str) {
        return null;
    }

    @Override
    public Map<String, Object> getPreviewParameterRangeMap() {
        return new HashMap<String, Object>();
    }

    @Override
    public List<Integer> getSupportPictureFormat() {
        return Collections.singletonList(ImageFormat.JPEG);
    }

    @Override
    public List<Integer> getSupportPictureFormat(Map<String, String> map) {
        return getSupportPictureFormat();
    }

    @Override
    public List<Size> getSupportPictureSize() {
        if (mMap == null) return new ArrayList<Size>();
        Size[] sizes = null;
        try {
            sizes = mMap.getOutputSizes(ImageFormat.JPEG);
        } catch (Exception e) {
            android.util.Log.e("OcsCamera2Info", "JPEG sizes", e);
        }
        return sizes == null ? new ArrayList<Size>() : new ArrayList<Size>(Arrays.asList(sizes));
    }

    @Override
    public List<Size> getSupportPictureSize(Map<String, String> map) {
        return getSupportPictureSize();
    }

    @Override
    public List<Size> getSupportPreviewSize(int surfaceType) {
        if (mMap == null) return new ArrayList<Size>();
        Class<?> clazz = SurfaceWrapper.getSurfaceClass(surfaceType);
        if (clazz == null) clazz = SurfaceTexture.class;
        Size[] sizes = null;
        try {
            sizes = mMap.getOutputSizes(clazz);
        } catch (Exception e) {
            android.util.Log.e("OcsCamera2Info", "preview sizes for " + clazz, e);
        }
        if (sizes == null || sizes.length == 0) {
            try {
                sizes = mMap.getOutputSizes(SurfaceTexture.class);
            } catch (Exception e) {
                android.util.Log.e("OcsCamera2Info", "fallback preview sizes", e);
            }
        }
        return sizes == null ? new ArrayList<Size>() : new ArrayList<Size>(Arrays.asList(sizes));
    }

    @Override
    public List<Size> getSupportPreviewSize(int surfaceType, Map<String, String> map) {
        return getSupportPreviewSize(surfaceType);
    }

    @Override
    public List<Size> getSupportVideoSize() {
        if (mMap == null) return new ArrayList<Size>();
        Size[] sizes = null;
        try {
            sizes = mMap.getOutputSizes(MediaRecorder.class);
        } catch (Exception e) {
            android.util.Log.e("OcsCamera2Info", "video sizes", e);
        }
        if (sizes == null || sizes.length == 0) {
            try {
                sizes = mMap.getOutputSizes(SurfaceHolder.class);
            } catch (Exception e) {
                android.util.Log.e("OcsCamera2Info", "fallback video sizes", e);
            }
        }
        return sizes == null ? new ArrayList<Size>() : new ArrayList<Size>(Arrays.asList(sizes));
    }

    @Override
    public List<Size> getSupportVideoSize(Map<String, String> map) {
        return getSupportVideoSize();
    }

    @Override
    public Pair<Size, Size> getVideoMappingSizesFromConfig(String str, Map<String, String> map) {
        return null;
    }

    @Override
    public boolean isPreviewAlgoDisable(int i) {
        return false;
    }

    @Override
    public boolean isSupportConfigureParameter(String str) {
        return false;
    }

    @Override
    public boolean isSupportPreviewParameter(String str) {
        return false;
    }
}
