# OnePlus Camera on non-Oplus devices — OCS → Camera2 research port

This repository contains the tooling and reverse-engineering work from an attempt to run
the stock OnePlus/OPPO camera app (`com.oplus.camera`, 7.006.125) on a **Redmi Note 12 4G
(tapas, SM6225)** running a ColorOS/Realme UI 7 port (Android 17 / SDK 37).

> **Status: partial. The OnePlus camera UI opens, but live preview is not working yet.**
> The UI and startup crashes were fixed. The remaining blocker is that the app's own camera
> core never calls the OCS `CameraUnitClient.openCamera()` path, so neither the Oplus HAL nor
> the Camera2 shim is reached. Contributions toward that blocker are welcome.

Do not expect a drop-in APK: APKs, vendor blobs, and decoded proprietary code are **not**
included. You must supply your own APK/ROM files.

## What was done

1. Extracted the OCS shared library from the port's product overlay:
   - `/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.jar`
   - `/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.adapter.jar`

   The stock permission XML in that overlay points the shared library at
   `/product/framework/...`. That path is not reliably active on every port, so the
   module instead registers its own `/system/etc/permissions` XML and installs the shim
   under `/system/framework` (with an optional `/product/framework` fallback).
2. Replaced `com.oplus.ocs.camera.CameraUnitImpl` with a Camera2 implementation:
   - `CameraUnitImpl` implements `CameraUnitInterface`
   - `OcsCamera2Device` implements `CameraDeviceInterface`
   - `OcsCamera2Info` implements `CameraDeviceInfoInterface`
3. Restored OCS config initialization (`CameraConfigHelper.initialize`) in the shim.
4. Patched the app for this port:
   - disabled/neutralized `ApsService` startup blocking
   - caught Oplus-only `safe.WINDOW` permission failures in
     `FloatingWindowDetectHelper` and `UIShellContainer`
   - removed the optional ColorOS gallery pre-decode bind
   - bypassed broken `MyApplication` pre-init waits
   - removed a `PreviewProcessor` GL-texture handshake wait
5. Added an experimental `Camera2PreviewBridge` that can feed Camera2 frames into the
   app's `SurfaceTexture` (the app currently does not create that texture on this port).

## Why preview still fails

The camera service/HAL is fine: camera 0 is present and can be opened. The OnePlus app's
camera core (`CameraManager`/`CameraCore`) starts, but it stays in:

```text
OCAM_CameraCore: applyParameters failed, preview state is not started
```

No `CameraUnitClient` / `OcsCameraUnit` logs appear, so the OCS SDK shim is never used.
The app's preview view (`go.i1` / `SurfaceTextureScreenNail`) is also never instantiated,
so the Camera2 bridge has no Surface to render into.

The remaining work is app-side: either
- make the app initialize its OCS camera core and call `openCamera`, or
- instantiate/attach a preview view and feed it through `Camera2PreviewBridge`.

A full thread dump on the target showed the main/camera threads idle, not blocked, which
points to an app-state/initialization guard rather than a HAL deadlock.

## Repository layout

```
shim/src/          Java sources for the Camera2-backed OCS implementation
shim/smali/        Assembled smali for the same (our code only)
patches/app/       App patch script, bridge source, and helper smali
scripts/           Build helpers (dex assembly, zipalign, module packaging)
module/            Magisk module template (no proprietary jars/binaries)
docs/              Findings, build instructions, and adaptation notes
```

## Quick start

See [`docs/BUILD.md`](docs/BUILD.md) for the full process. In short:

1. Decode your **own** `com.oplus.camera` APK and its `com.oplus.camera.unit.sdk.jar`.
2. Copy `shim/smali` into the decoded SDK jar, replacing `CameraUnitImpl`.
3. Assemble the SDK jar and put it in the Magisk module under
   `system/framework` and `product/framework` with a shared-library permission XML.
4. Decode your APK, run `patches/app/apply-app-patches.py`, assemble the changed dex files,
   replace them in the original APK, zipalign, and sign.
5. Install the APK + module, reboot, and test.

## Adapting to another OnePlus/OPPO camera APK

See [`docs/ADAPTING.md`](docs/ADAPTING.md). Class names and methods in the app are
obfuscated differently between versions. Locate them by:
- `.source "CameraUnitInterface.java"`, `"CameraDeviceInterface.java"`, `"CameraManager.java"`
- strings: `applyParameters failed`, `removeEmbeddedContainerTask`, `ApsService`,
  `FloatingWindowDetectHelper`, `SurfaceTextureScreenNail`
- the OCS SDK interface names, which are stable across SDK versions.

The patch script is intentionally guarded: it logs when a target is absent rather than
silently producing a broken APK. Treat it as a starting point, not a universal patcher.

## Legal / scope

This is an interoperability research project. No APKs, ROM images, vendor blobs, or
Oplus SDK binaries are distributed. You must own/obtain the files you patch, and comply
with the licenses/terms that apply to them. The code in this repository is offered for
study and contribution.

## Credits

Built during a long on-device debugging session against the tapas ColorOS port and the
OnePlus camera 7.006.125 APK. Contributions and corrections are welcome.
