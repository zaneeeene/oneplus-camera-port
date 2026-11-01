# Adapting to another OnePlus/OPPO camera APK

Oplus obfuscates app classes, so paths change between versions. The OCS SDK interface
names are stable; the app classes are not.

## 1. Find the app patch targets

Decode the APK with apktool, then search the smali trees:

| Target | How to find it |
|---|---|
| `ApsService` | path contains `com/oplus/camera/aps/service/ApsService.smali`; service is declared in the manifest |
| `FloatingWindowDetectHelper` | `.source "FloatingWindowDetectHelper.java"`; methods reference `getVisibleTasks` / `unregisterComplexSceneObserver` |
| `UIShellContainer` | `.source "UIShellContainer.java"`; references `removeEmbeddedContainerTask` |
| gallery pre-decode | class containing `OplusPreTileDecodeService` and `bindService` |
| `PreviewProcessor` | `.source "PreviewProcessor.java"`; method containing `startPreview, wait for copying texture size` |
| `MyApplication` | path `com/oplus/camera/MyApplication.smali`; methods `h()` / `g()` use `ConditionVariable` |
| preview screen | `.source "SurfaceTextureScreenNail.java"`; contains `new-instance Landroid/graphics/SurfaceTexture;` |

Use `grep -R` over the decoded `smali*` directories.

## 2. Patch rules

`patches/app/apply-app-patches.py` performs the changes used on 7.006.125. It is guarded:
if a class/method cannot be located, it prints a warning. When adapting:

- Match method signatures, not line numbers.
- Add `SecurityException` / `RuntimeException` catches to the try range that contains
  the Oplus framework call.
- Remove optional Oplus calls only if the app can continue without them (flexible-window
  integration, gallery pre-decode).
- Keep `MyApplication.j()` available; it starts camera-characteristics pre-init. The port
  needs it not to block the UI, but skipping it may leave the camera core uninitialized.

## 3. Rebuilding dex without aapt

Building the full APK with apktool needs a native `aapt` binary. The provided
`build-app.sh` avoids that by:
1. assembling the changed `smali*` directories with `AssembleSmali.java`
2. replacing the corresponding `classesN.dex` entries in the original APK
3. zipaligning and signing

That preserves all resources and the original APK's structure.

Mapping:
- `smali/` → `classes.dex`
- `smali_classesN/` → `classesN.dex`

All replaced dex files must use the same dex version as the originals. The script uses
API 29 / dex `039` by default, which matched this APK. If your APK uses `035`/`040`,
adjust the API level passed to `AssembleSmali`.

## 4. Signing

- The original Oplus-signed APK is the best base for testing: the port's package manager
  has a custom "oplus named app" signature check that can reject debug-signed packages
  on fresh install.
- For updates, sign with the same key as the installed package.
- If you must use a debug key, install as a system/priv-app through the module, or patch
  the Oplus signature check in `oplus-services.jar` (out of scope here).

## 5. Camera2 shim adaptation

The shim compiles against the stock SDK classes. If the SDK's
`CameraUnitInterface` / `CameraDeviceInterface` / `CameraDeviceInfoInterface` changes:
- update the method set in `shim/src`
- rebuild the smali with the Android SDK and the target SDK jar
- replace `CameraUnitImpl` in the SDK jar
- keep `CameraConfigHelper.initialize(context)` in `initialize()`; OCS config parse is
  required for `AlgoSwitchConfig` conditions.

## 6. Debugging checklist

- `logcat -b all` (the SIGQUIT dump may go to tombstoned, not logcat).
- For a hang: `kill -3 <pid>`, then pull `/data/anr/trace_*` or `/data/tombstones/trace_*`.
- `dumpsys media.camera` shows whether any client actually opened the camera.
- If the app UI opens but no `OcsCameraUnit` logs appear, the app core is not calling OCS;
  the shim cannot help until that call happens.
