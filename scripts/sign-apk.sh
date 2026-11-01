#!/usr/bin/env bash
# Usage: APKSIGNER=/path/to/apksigner KEYSTORE=/path/to/key.jks KS_PASS=... \
#        sign-apk.sh <aligned.apk> <out.apk>
set -euo pipefail
: "${APKSIGNER:?set APKSIGNER}"
: "${KEYSTORE:?set KEYSTORE}"
IN="${1:?input apk}"
OUT="${2:?output apk}"
"$APKSIGNER" sign --ks "$KEYSTORE" --ks-pass "pass:${KS_PASS:-android}" --key-pass "pass:${KS_PASS:-android}" --out "$OUT" "$IN"
"$APKSIGNER" verify "$OUT"
