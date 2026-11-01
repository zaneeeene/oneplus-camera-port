#!/usr/bin/env bash
# Decode an APK, apply patches, rebuild only changed dex files, zipalign, sign.
# Usage: [APKTOOL=...] [APKSIGNER=...] [KEYSTORE=...] build-app.sh <input.apk> <output.apk>
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IN="${1:?input apk}"
OUT="${2:?output apk}"
APKTOOL="${APKTOOL:-apktool}"
JAVA="${JAVA:-java}"
ECJ="${ECJ:-ecj}"
WORK="${WORK:-$ROOT/build/app-work}"
API="${API:-29}"

rm -rf "$WORK"
mkdir -p "$WORK"
"$APKTOOL" d -f -o "$WORK/decoded" "$IN" >/dev/null
python3 "$ROOT/patches/app/apply-app-patches.py" --app "$WORK/decoded"

# Build the dex assembler helper against apktool.jar.
mkdir -p "$WORK/asm"
"$ECJ" -cp "$APKTOOL" -d "$WORK/asm" "$ROOT/scripts/AssembleSmali.java" 2>/dev/null || \
  "$ECJ" -source 8 -target 8 -cp "$APKTOOL" -d "$WORK/asm" "$ROOT/scripts/AssembleSmali.java"

# Assemble every smali directory; this is slower but robust.
shopt -s nullglob
for d in "$WORK/decoded"/smali "$WORK/decoded"/smali_classes*; do
  [ -d "$d" ] || continue
  base="$(basename "$d")"
  if [ "$base" = "smali" ]; then dex="classes.dex"; else dex="classes${base#smali_classes}.dex"; fi
  "$JAVA" -cp "$WORK/asm:$APKTOOL" AssembleSmali "$d" "$WORK/$dex" "$API"
done

# Replace dex entries and strip old signatures.
python3 - "$IN" "$WORK" "$WORK/replaced.apk" <<'PY'
import os, sys, zipfile
src, work, out = sys.argv[1], sys.argv[2], sys.argv[3]
with zipfile.ZipFile(src) as zin, zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as zout:
    for it in zin.infolist():
        data = zin.read(it.filename)
        p = os.path.join(work, it.filename)
        if it.filename.startswith("classes") and it.filename.endswith(".dex") and os.path.exists(p):
            data = open(p, "rb").read()
            print("replaced", it.filename, len(data))
        if it.filename.startswith("META-INF/") and (it.filename.endswith((".SF", ".RSA", ".EC", ".DSA")) or it.filename.endswith("MANIFEST.MF")):
            continue
        zi = zipfile.ZipInfo(it.filename, it.date_time)
        zi.compress_type = it.compress_type
        zi.external_attr = it.external_attr
        zi.internal_attr = it.internal_attr
        zi.create_system = it.create_system
        zout.writestr(zi, data)
PY
python3 "$ROOT/scripts/zipalign.py" "$WORK/replaced.apk" "$WORK/aligned.apk"
if [ -n "${APKSIGNER:-}" ] && [ -n "${KEYSTORE:-}" ]; then
  "$ROOT/scripts/sign-apk.sh" "$WORK/aligned.apk" "$OUT"
else
  cp "$WORK/aligned.apk" "$OUT"
  echo "warning: APKSIGNER/KEYSTORE not set; output is only aligned, not signed"
fi
echo "built: $OUT"
