#!/usr/bin/env python3
"""Minimal zipalign for stored entries (4096-byte data alignment)."""
import struct
import sys
import zipfile

ALIGN = 4096
EXTRA_ID = 0xD935

def align_extra(pos, name_len):
    base = pos + 30 + name_len
    rem = base % ALIGN
    pad = (ALIGN - rem) % ALIGN
    if pad < 4:
        pad += ALIGN
    return struct.pack("<HH", EXTRA_ID, pad - 4) + b"\x00" * (pad - 4)

def main():
    src, dst = sys.argv[1], sys.argv[2]
    with zipfile.ZipFile(src) as zin, zipfile.ZipFile(dst, "w") as zout:
        for it in zin.infolist():
            info = zipfile.ZipInfo(it.filename, it.date_time)
            info.compress_type = it.compress_type
            info.external_attr = it.external_attr
            info.internal_attr = it.internal_attr
            info.create_system = it.create_system
            info.comment = it.comment
            data = zin.read(it.filename)
            if it.compress_type == zipfile.ZIP_STORED:
                name_len = len(it.filename.encode("utf-8"))
                info.extra = align_extra(zout.fp.tell(), name_len)
            zout.writestr(info, data)
    print(f"{dst}: aligned")

if __name__ == "__main__":
    main()
