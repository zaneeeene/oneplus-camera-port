# Findings and failure history

## Target

- Device: Redmi Note 12 4G (tapas, SM6225/bengal)
- ROM: ColorOS/Realme UI 7 port, Android 17 / SDK 37
- App: `com.oplus.camera` 7.006.125 (also tested 7.013.30)
- Camera HAL: tapas Qualcomm provider, 7 camera IDs; main `s5kjn1`, ultra `ov08d10`,
  macro `ov2680`, front `ov13b10`

## OCS SDK

The port physically ships these in its product overlay:
```
/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.jar
/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.adapter.jar
/my_product/product_overlay/etc/permissions/com.oplus.camera.unit.sdk_product.xml
```
The stock XML points the library name at `/product/framework/...`; that path is not
always active on a ported ROM. The module therefore adds an active
`/system/etc/permissions` XML and installs the shim at `/system/framework` (plus an
optional `/product/framework` fallback).

## Why the stock app does not start the camera

The app expects OCS vendor metadata (`com.oplus.supported.cameraid.type`,
`com.oplus.available.stream.fps.ranges`, vendor tags, APS). Tapas does not export these.
The app's `CameraUnitImpl` is a consumer of the Oplus producer; without the vendor HAL it
never opens a session.

## Camera2 shim

`shim/src` replaces `com.oplus.ocs.camera.CameraUnitImpl` with a direct Camera2
implementation. It provides:
- camera type list: `rear_main`, `front_main`
- Camera2 id mapping: rear 0, front 1
- `CameraDeviceInfoInterface` from real `CameraCharacteristics`
- a real `CameraCaptureSession` using the app's preview Surface
- Camera2 config initialization (`CameraConfigHelper.initialize`)

The app's own `CameraUnitClientAdapter` / `CameraDeviceAdapterV2` remain in the APK; they
call the replacement SDK class.

## App-level fixes necessary on this port

Chronological crash/hang findings:

1. **Missing Oplus vendor keys**
   `CameraCharacteristics.get("com.oplus.available.stream.fps.ranges")` throws
   `IllegalArgumentException`. Catch in `OcsCamera2Info.get()`.

2. **`ApsService` start ANR**
   `executing service com.oplus.camera/.aps.service.ApsService, waited 20005ms`.
   Stub `onCreate`/`onStartCommand`/`onStop`/`onDestroy` for testing.

3. **`FloatingWindowDetectHelper` permission crash**
   `getVisibleTasks` and `unregisterComplexSceneObserver` require
   `com.oplus.permission.safe.WINDOW`. Catch `SecurityException`/`RuntimeException`.

4. **`UIShellContainer` permission crash**
   `removeEmbeddedContainerTask` requires the same Oplus permission. Remove the optional
   flexible-window call.

5. **Gallery pre-decode bind crash**
   Binding `com.coloros.gallery3d/...OplusPreTileDecodeService` throws
   `SecurityException`. Remove the optional bind.

6. **`PreviewProcessor` wait**
   `ConditionVariable.block` inside `gn.g.G` (preview texture copy) can deadlock.
   Removed that wait for testing.

7. **`MyApplication` pre-init wait**
   `h()` / `g()` block on condition variables fed by OCS/APS pre-init. No-op or run the
   preload in one background thread.

## Where it stops

The app remains in:
```
OCAM_CameraCore: applyParameters failed, preview state is not started,
maybe session just configured.
```
There are no `OcsCameraUnit` logs: `CameraUnitClient`/`openCamera` is never reached.
A full thread dump shows main/camera threads idle, not blocked. The app's preview view
(`go.i1`, `SurfaceTextureScreenNail`) is also not created, so a Camera2 `SurfaceTexture`
bridge has no surface to attach to.

A Camera2 preview bridge was added experimentally (`patches/app/Camera2PreviewBridge.java`)
and a hook in `go.i1`, but no `Cam2PreviewBridge` logs appeared: the preview view is never
instantiated.

## Conclusion

The UI-level fixes are complete enough to keep the OnePlus UI open. The camera core's
OCS initialization is still the missing link. The next promising direction is a donor
Oplus camera HAL with matching sensors, or a deeper app rewrite that creates its own
preview view.
