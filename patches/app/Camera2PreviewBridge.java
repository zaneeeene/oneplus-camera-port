package com.oplus.camera;

import android.content.Context;
import android.graphics.SurfaceTexture;
import android.hardware.camera2.CameraCaptureSession;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CaptureRequest;
import android.os.Handler;
import android.os.HandlerThread;
import android.util.Log;
import android.view.Surface;

import java.util.Arrays;

/** Minimal Camera2 preview bridge for the OnePlus preview SurfaceTexture. */
public final class Camera2PreviewBridge {
    private static final String TAG = "Cam2PreviewBridge";
    private static CameraManager sManager;
    private static CameraDevice sDevice;
    private static CameraCaptureSession sSession;
    private static Surface sSurface;
    private static HandlerThread sThread;
    private static Handler sHandler;

    public static synchronized void start(Context context, SurfaceTexture texture) {
        if (context == null || texture == null) return;
        stop();
        try {
            texture.setDefaultBufferSize(1440, 1080);
            sSurface = new Surface(texture);
            if (sThread == null) {
                sThread = new HandlerThread("Cam2PreviewBridge");
                sThread.start();
                sHandler = new Handler(sThread.getLooper());
            }
            sManager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
            if (sManager == null) return;
            Log.i(TAG, "opening camera 0");
            sManager.openCamera("0", new CameraDevice.StateCallback() {
                @Override public void onOpened(CameraDevice camera) {
                    Log.i(TAG, "camera opened");
                    sDevice = camera;
                    try {
                        camera.createCaptureSession(Arrays.asList(sSurface), new CameraCaptureSession.StateCallback() {
                            @Override public void onConfigured(CameraCaptureSession session) {
                                Log.i(TAG, "session configured");
                                sSession = session;
                                try {
                                    CaptureRequest.Builder b = camera.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW);
                                    b.addTarget(sSurface);
                                    b.set(CaptureRequest.CONTROL_MODE, CaptureRequest.CONTROL_MODE_AUTO);
                                    b.set(CaptureRequest.CONTROL_AF_MODE, CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE);
                                    b.set(CaptureRequest.CONTROL_AE_MODE, CaptureRequest.CONTROL_AE_MODE_ON);
                                    b.set(CaptureRequest.CONTROL_AWB_MODE, CaptureRequest.CONTROL_AWB_MODE_AUTO);
                                    session.setRepeatingRequest(b.build(), null, sHandler);
                                    Log.i(TAG, "repeating preview started");
                                } catch (Throwable t) {
                                    Log.e(TAG, "start repeating", t);
                                }
                            }
                            @Override public void onConfigureFailed(CameraCaptureSession session) {
                                Log.e(TAG, "session configure failed");
                            }
                        }, sHandler);
                    } catch (Throwable t) {
                        Log.e(TAG, "createCaptureSession", t);
                    }
                }
                @Override public void onDisconnected(CameraDevice camera) {
                    Log.e(TAG, "camera disconnected");
                    try { camera.close(); } catch (Throwable ignored) {}
                    sDevice = null;
                }
                @Override public void onError(CameraDevice camera, int error) {
                    Log.e(TAG, "camera error " + error);
                    try { camera.close(); } catch (Throwable ignored) {}
                    sDevice = null;
                }
            }, sHandler);
        } catch (Throwable t) {
            Log.e(TAG, "start", t);
        }
    }

    public static synchronized void stop() {
        try { if (sSession != null) sSession.close(); } catch (Throwable ignored) {}
        sSession = null;
        try { if (sDevice != null) sDevice.close(); } catch (Throwable ignored) {}
        sDevice = null;
        try { if (sSurface != null) sSurface.release(); } catch (Throwable ignored) {}
        sSurface = null;
    }
}
