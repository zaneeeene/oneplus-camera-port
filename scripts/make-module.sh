#!/usr/bin/env bash
# Package module/ into build/oplus-camera-sdk.zip
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/module"
mkdir -p "$ROOT/build"
rm -f "$ROOT/build/oplus-camera-sdk.zip"
zip -r9 "$ROOT/build/oplus-camera-sdk.zip" module.prop install.sh META-INF system product >/dev/null
echo "built: $ROOT/build/oplus-camera-sdk.zip"
