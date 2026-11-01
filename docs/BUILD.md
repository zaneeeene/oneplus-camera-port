# Build guide

These steps assume a Linux host with:
- JDK 17+ (`java`, `javac` or Eclipse ECJ)
- [apktool](https://apktool.org/) 2.9+
- Android SDK `android.jar` and `apksigner`
- Python 3
- `zip`/`unzip`

No proprietary APK, SDK jar, or vendor image is in this repo. Use files from your own
device/ROM.

The scripts are deliberately simple and were designed around the tapas
`com.oplus.camera` 7.006.125 APK and its OCS SDK jar. Other versions may need small
adjustments.

## 0. Prepare the toolchain

This project was built on an aarch64 Linux host. `apktool` works for decoding and for
building the resource-less OCS SDK jar. For app APKs, the build script only assembles
the changed dex files and replaces them in the original APK; that avoids needing a
native `aapt` binary.

Set variables:

```sh
export PROJECT=$PWD
export APKTOOL=/path/to/apktool.jar
export ANDROID_JAR=/path/to/android-35/android.jar
export APKSIGNER=/path/to/apksigner
export KEYSTORE=/path/to/debug.keystore
```

Compile the dex assembler helper:

```sh
mkdir -p build/asm
ecj -cp "$APKTOOL" -d build/asm scripts/AssembleSmali.java
```

(`ecj` is the Eclipse compiler; `javac -cp "$APKTOOL"` works too.)

## 1. Build the Camera2 OCS shim

Input: your device's `/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.jar`
(the stock XML may refer to it as `/product/framework/...`).

```sh
scripts/build-sdk-shim.sh path/to/com.oplus.camera.unit.sdk.jar module
```

The script:
1. decodes the SDK jar with apktool
2. replaces `CameraUnitImpl` with `shim/smali/...`
3. builds a new jar at `build/sdk/com.oplus.camera.unit.sdk.jar`

The script also copies the stock (unchanged) adapter jar if it sits beside the SDK jar:
- `/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.adapter.jar`

The module template expects these files at both:
- `module/system/framework/com.oplus.camera.unit.sdk.jar`
- `module/product/framework/com.oplus.camera.unit.sdk.jar`
- `module/system/framework/com.oplus.camera.unit.sdk.adapter.jar`
- `module/product/framework/com.oplus.camera.unit.sdk.adapter.jar`

The build script places it there. See `module/system/etc/permissions/com.oplus.camera.unit.sdk.xml`
and `module/product/etc/permissions/com.oplus.camera.unit.sdk_product.xml`.

## 2. Prepare the app APK

Input: your own Oplus-signed camera APK.

```sh
scripts/build-app.sh path/to/Camera.apk path/to/out/Camera-patched.apk
```

The script:
1. decodes the APK with apktool
2. runs `patches/app/apply-app-patches.py`
3. assembles each changed smali directory into its corresponding `classesN.dex`
4. replaces those dex files in the original APK (preserving resources)
5. zipaligns and signs the result

The patch script is version-specific. It logs missing targets rather than silently
continuing; read its output.

## 3. Build the module

```sh
scripts/make-module.sh
```

This zips `module/` into `build/oplus-camera-sdk.zip`. The module contains no
proprietary binaries until you add the jar from step 1 (the script does that).

## 4. Install and test

1. Install the patched camera APK.
2. Install the module in Magisk/KernelSU.
3. Reboot.
4. Grant Camera and Microphone permissions.
5. Capture logs with `logcat -b all -d -v threadtime`.

Look for:
```text
OcsCameraUnit: CameraConfigHelper.initialize done
OcsCameraUnit: openCamera rear_main ...
OcsCamera2Device: startPreview ...
```

### Current status

On tapas the UI opens but the app core never calls OCS `openCamera`, so the shim is not
reached. See `docs/FINDINGS.md` for the exact logs and the remaining blocker.

## Signing

The build script uses the supplied keystore. If you are updating an installed APK, sign
with the same key as the existing package. The original Oplus-signed APK is the best
base because it passes the port's Oplus "named app" signature check; a debug-signed APK
may be rejected on fresh install by that check.
