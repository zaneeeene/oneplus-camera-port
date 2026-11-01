package com.oplus.ocs.camera;

import android.content.Context;
import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureResult;
import android.media.Image;
import android.media.ImageReader;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import com.oplus.ocs.camera.appinterface.ApsStateCallback;
import com.oplus.ocs.camera.appinterface.CameraDeviceInfoInterface;
import com.oplus.ocs.camera.appinterface.CameraPictureCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraPreviewCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraStateCallbackAdapter;
import com.oplus.ocs.camera.appinterface.CameraUnitInterface;
import com.oplus.ocs.camera.common.util.ErrorResult;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Replacement for the vendor OCS CameraUnitImpl.
 *
 * The original implementation talks to the Oplus camera HAL through
 * CameraDeviceManager/ProducerImpl and requires Oplus vendor tags. This version
 * implements the exact same public CameraUnitInterface using standard Camera2,
 * so the stock OnePlus/OPPO camera UI drives the real tapas camera.
 */
public class CameraUnitImpl implements CameraUnitInterface {
    private static final String TAG = "OcsCameraUnit";

    private static final List<String> CAMERA_TYPES =
            Arrays.asList("rear_main", "front_main");

    private Context mContext;
    private CameraManager mCameraManager;
    private final Map<String, OcsCamera2Device> mDevices =
            new HashMap<String, OcsCamera2Device>();
    private Handler mMainHandler;

    public CameraUnitImpl() {
        Log.i(TAG, "CameraUnitImpl constructed");
    }

    private synchronized Handler handler(Handler requested) {
        if (requested != null) return requested;
        if (mMainHandler == null) {
            mMainHandler = new Handler(Looper.getMainLooper());
        }
        return mMainHandler;
    }

    @Override
    public void initialize(Context context) {
        initialize(context, null);
    }

    @Override
    public synchronized void initialize(Context context, ApsStateCallback apsStateCallback) {
        mContext = context;
        if (context != null) {
            mCameraManager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
            try {
                // The OCS client waits on AlgoSwitchConfig/config conditions. The
                // real CameraUnitImpl initialized CameraConfigHelper here; without
                // that, CameraThreadExector stays blocked forever.
                com.oplus.ocs.camera.producer.info.CameraConfigHelper.initialize(context);
                Log.i(TAG, "CameraConfigHelper.initialize done");
            } catch (Throwable t) {
                Log.e(TAG, "CameraConfigHelper.initialize failed", t);
            }
            try {
                com.oplus.ocs.camera.producer.info.CameraCharacteristicsWrapper.initCameraCharacteristicsGetterThread();
            } catch (Throwable t) {
                Log.e(TAG, "CameraCharacteristicsWrapper init failed", t);
            }
        }
        Log.i(TAG, "initialize context=" + context + " manager=" + mCameraManager);
        if (mCameraManager != null) {
            try {
                Log.i(TAG, "camera ids=" + Arrays.toString(mCameraManager.getCameraIdList()));
            } catch (Exception e) {
                Log.e(TAG, "getCameraIdList", e);
            }
        }
    }

    @Override
    public boolean checkAuthenticationPermission(Context context, String str, int i) {
        Log.i(TAG, "checkAuthenticationPermission -> true, client=" + str + " version=" + i);
        return true;
    }

    @Override
    public boolean isAuthedClient(Context context) {
        return true;
    }

    @Override
    public void preOpenCamera(Context context) {
        if (mContext == null) mContext = context;
    }

    @Override
    public List<String> getAllSupportCameraType() {
        Log.i(TAG, "getAllSupportCameraType -> " + CAMERA_TYPES);
        return new ArrayList<String>(CAMERA_TYPES);
    }

    @Override
    public Map<String, List<String>> getAllSupportCameraMode() {
        Map<String, List<String>> modes = new LinkedHashMap<String, List<String>>();
        modes.put("rear_main", Arrays.asList("photo_mode", "video_mode"));
        modes.put("front_main", Arrays.asList("photo_mode", "video_mode"));
        Log.i(TAG, "getAllSupportCameraMode -> " + modes);
        return modes;
    }

    @Override
    public CameraDeviceInfoInterface getCameraDeviceInfo(String cameraType, String modeName) {
        String type = normalizeType(cameraType);
        String id = cameraIdForType(type);
        Log.i(TAG, "getCameraDeviceInfo type=" + type + " mode=" + modeName + " id=" + id);
        if (mContext == null) {
            Log.e(TAG, "getCameraDeviceInfo before initialize");
            return null;
        }
        return new OcsCamera2Info(mContext, id, type, modeName);
    }

    @Override
    public synchronized void openCamera(String cameraType, final CameraStateCallbackAdapter callback,
                                        Handler handler) {
        final String type = normalizeType(cameraType);
        final String id = cameraIdForType(type);
        final Handler h = handler(handler);
        Log.i(TAG, "openCamera " + cameraType + " -> type=" + type + " id=" + id);
        if (mContext == null || mCameraManager == null) {
            Log.e(TAG, "openCamera before initialize");
            h.post(new Runnable() {
                @Override
                public void run() {
                    callback.onCameraError(ErrorResult.ILLEGAL_STATE_ERROR);
                }
            });
            return;
        }

        OcsCamera2Device device = new OcsCamera2Device(mContext, id, type, callback, h);
        mDevices.put(type, device);

        try {
            mCameraManager.openCamera(id, new CameraDevice.StateCallback() {
                @Override
                public void onOpened(CameraDevice camera) {
                    Log.i(TAG, "Camera2 opened id=" + id);
                    device.setCameraDevice(camera);
                    h.post(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                callback.onCameraOpened(device);
                            } catch (Exception e) {
                                Log.e(TAG, "onCameraOpened callback", e);
                            }
                        }
                    });
                }

                @Override
                public void onDisconnected(CameraDevice camera) {
                    Log.e(TAG, "Camera2 disconnected id=" + id);
                    try {
                        camera.close();
                    } catch (Exception ignored) {
                    }
                    h.post(new Runnable() {
                        @Override
                        public void run() {
                            callback.onCameraDisconnected();
                        }
                    });
                }

                @Override
                public void onError(CameraDevice camera, int error) {
                    Log.e(TAG, "Camera2 error id=" + id + " error=" + error);
                    try {
                        camera.close();
                    } catch (Exception ignored) {
                    }
                    h.post(new Runnable() {
                        @Override
                        public void run() {
                            callback.onCameraError(ErrorResult.ILLEGAL_STATE_ERROR);
                        }
                    });
                }
            }, h);
        } catch (CameraAccessException e) {
            Log.e(TAG, "openCamera access", e);
            h.post(new Runnable() {
                @Override
                public void run() {
                    callback.onCameraError(ErrorResult.ILLEGAL_STATE_ERROR);
                }
            });
        } catch (SecurityException e) {
            Log.e(TAG, "openCamera security", e);
            h.post(new Runnable() {
                @Override
                public void run() {
                    callback.onCameraError(ErrorResult.ILLEGAL_STATE_ERROR);
                }
            });
        } catch (Exception e) {
            Log.e(TAG, "openCamera unexpected", e);
            h.post(new Runnable() {
                @Override
                public void run() {
                    callback.onCameraError(ErrorResult.ILLEGAL_STATE_ERROR);
                }
            });
        }
    }

    private static String normalizeType(String cameraType) {
        if (cameraType == null) return "rear_main";
        String t = cameraType.toLowerCase(Locale.US);
        if (t.equals("0")) return "rear_main";
        if (t.equals("1")) return "front_main";
        if (t.contains("front")) return "front_main";
        if (t.contains("wide") || t.contains("ultra")) return "rear_wide";
        if (t.contains("macro")) return "rear_macro";
        if (t.contains("tele")) return "rear_tele";
        if (t.contains("rear")) return "rear_main";
        return "rear_main";
    }

    private static String cameraIdForType(String type) {
        if ("front_main".equals(type)) return "1";
        if ("rear_wide".equals(type)) return "2";
        if ("rear_macro".equals(type)) return "4";
        if ("rear_tele".equals(type)) return "3";
        return "0";
    }

    @Override
    public CameraPreviewCallbackAdapter.PreviewResult getRequestedPreviewResult() {
        return null;
    }

    @Override
    public boolean registerCaptureDeferPictureCallback(CameraPictureCallbackAdapter callback, Handler handler) {
        return false;
    }

    @Override
    public synchronized void release() {
        Log.i(TAG, "release");
        for (OcsCamera2Device device : mDevices.values()) {
            try {
                device.close(true);
            } catch (Exception ignored) {
            }
        }
        mDevices.clear();
    }

    @Override
    public Map<String, String> executeDeferJob(int i, Map<String, String> map) {
        return new HashMap<String, String>();
    }

    @Override
    public String collectFluencyData() {
        return "";
    }

    @Override
    public long getRuntimeInputMemSizeInMb() {
        return 0L;
    }

    @Override
    public void setPreCaptureParams(Bundle bundle) {
    }

    @Override
    public void updateRequestedDecisionResultLockState(boolean z) {
    }

    @Override
    public void addDeferJobParam(ImageReader imageReader, Image image,
                                 CaptureResult captureResult, Map<String, String> map) {
    }

    @Override
    public void addDeferJobParam(ImageReader imageReader, Image image, Map<String, Object> map) {
    }

    @Override
    public void addSnapShotBuffer(Map<String, Object> map) {
    }

    @Override
    public void discardFreeBuffersImageReader() {
    }
}
