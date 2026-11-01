#!/usr/bin/env bash
# Build the Camera2-backed OCS SDK jar from a stock OCS SDK jar.
# Usage: build-sdk-shim.sh <stock-sdk.jar> [module-dir]
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SDK_JAR="${1:?usage: $0 <stock-sdk.jar> [module-dir]}"
MODULE="${2:-$ROOT/module}"
ADAPTER_JAR="${ADAPTER_JAR:-$(dirname "$SDK_JAR")/com.oplus.camera.unit.sdk.adapter.jar}"
APKTOOL="${APKTOOL:-apktool}"
WORK="${WORK:-$ROOT/build/sdk-work}"

rm -rf "$WORK"
mkdir -p "$WORK"
"$APKTOOL" d -f -o "$WORK/decoded" "$SDK_JAR" >/dev/null

# Replace the OCS implementation (and remove its old inner classes).
rm -f "$WORK/decoded/smali/com/oplus/ocs/camera/CameraUnitImpl"*.smali
mkdir -p "$WORK/decoded/smali/com/oplus/ocs/camera"
cp "$ROOT"/shim/smali/com/oplus/ocs/camera/*.smali "$WORK/decoded/smali/com/oplus/ocs/camera/"

"$APKTOOL" b "$WORK/decoded" -o "$WORK/sdk-new.apk" >/dev/null
unzip -p "$WORK/sdk-new.apk" classes.dex > "$WORK/classes.dex"
python3 - "$WORK/classes.dex" "$WORK/com.oplus.camera.unit.sdk.jar" <<'PY'
import sys, zipfile
with zipfile.ZipFile(sys.argv[2], "w", zipfile.ZIP_DEFLATED) as z:
    z.write(sys.argv[1], "classes.dex")
PY

mkdir -p "$MODULE/system/framework" "$MODULE/product/framework"
cp "$WORK/com.oplus.camera.unit.sdk.jar" "$MODULE/system/framework/com.oplus.camera.unit.sdk.jar"
cp "$WORK/com.oplus.camera.unit.sdk.jar" "$MODULE/system/framework/com.oplus.camera.unit.sdk.cam2.jar"
cp "$WORK/com.oplus.camera.unit.sdk.jar" "$MODULE/product/framework/com.oplus.camera.unit.sdk.jar"
cp "$WORK/com.oplus.camera.unit.sdk.jar" "$MODULE/product/framework/com.oplus.camera.unit.sdk.cam2.jar"

# The adapter jar is stock and unchanged; copy it beside the shim if available.
if [ -f "$ADAPTER_JAR" ]; then
  cp "$ADAPTER_JAR" "$MODULE/system/framework/com.oplus.camera.unit.sdk.adapter.jar"
  cp "$ADAPTER_JAR" "$MODULE/product/framework/com.oplus.camera.unit.sdk.adapter.jar"
  echo "copied adapter: $ADAPTER_JAR"
else
  echo "warning: adapter jar not found at $ADAPTER_JAR; copy it manually"
fi

echo "built: $WORK/com.oplus.camera.unit.sdk.jar"
echo "module: $MODULE"
