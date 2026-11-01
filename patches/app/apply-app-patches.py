#!/usr/bin/env python3
"""
Apply the tapas/OnePlus-camera 7.006.125 startup+preview patches to a decoded APK.

Usage:
  apply-app-patches.py --app /path/to/apktool-decoded-app [--no-preload] [--no-bridge]

The script is intentionally guarded. It prints a warning for every target it cannot
find instead of silently continuing, because Oplus app class names change per version.
"""
import argparse
import re
import shutil
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent


def find(app, name):
    hits = list(Path(app).rglob(name))
    return hits[0] if hits else None


def replace_method(path, signature, body):
    if path is None:
        return False
    s = path.read_text(errors="replace")
    pat = re.compile(r"(?ms)^\.method[^\n]*" + re.escape(signature) + r"[^\n]*\n.*?^\.end method")
    if not pat.search(s):
        return False
    s = pat.sub(body, s, count=1)
    path.write_text(s)
    return True


def add_catch(path):
    if path is None:
        return False
    s = path.read_text(errors="replace")
    line = "    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0"
    if line not in s:
        return False
    if "catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0" in s:
        return True
    repl = ("    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0\n"
            "    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0\n" + line)
    s = s.replace(line, repl)
    path.write_text(s)
    return True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--app", required=True)
    ap.add_argument("--no-preload", action="store_true", help="do not start MyApplication.j() in the background")
    ap.add_argument("--no-bridge", action="store_true", help="do not add the experimental Camera2 SurfaceTexture bridge")
    args = ap.parse_args()
    app = Path(args.app)
    changed = []
    missing = []

    # ApsService: prevent the service from blocking the main thread on this port.
    aps = find(app, "ApsService.smali")
    if aps:
        replace_method(aps, "onCreate()V", """.method public onCreate()V
    .locals 0

    return-void
.end method""")
        replace_method(aps, "onStartCommand(Landroid/content/Intent;II)I", """.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method""")
        replace_method(aps, "onDestroy()V", """.method public onDestroy()V
    .locals 0

    return-void
.end method""")
        replace_method(aps, "onStop()V", """.method public onStop()V
    .locals 0

    return-void
.end method""")
        replace_method(aps, "addStageProtectInfo()V", """.method public addStageProtectInfo()V
    .locals 0

    return-void
.end method""")
        changed.append(str(aps))
    else:
        missing.append("ApsService.smali")

    # MyApplication: do not wait on OCS/APS condition variables forever.
    myapp = find(app, "MyApplication.smali")
    if myapp:
        if not args.no_preload:
            pre = myapp.parent / "OcsPreloadRunnable.smali"
            src = HERE / "smali" / "com" / "oplus" / "camera" / "OcsPreloadRunnable.smali"
            if src.exists():
                shutil.copyfile(src, pre)
            replace_method(myapp, "h()V", """.method public static h()V
    .locals 2

    new-instance v0, Lcom/oplus/camera/OcsPreloadRunnable;

    invoke-direct {v0}, Lcom/oplus/camera/OcsPreloadRunnable;-><init>()V

    new-instance v1, Ljava/lang/Thread;

    invoke-direct {v1, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    return-void
.end method""")
        else:
            replace_method(myapp, "h()V", """.method public static h()V
    .locals 0

    return-void
.end method""")
        replace_method(myapp, "g()V", """.method public final g()V
    .locals 0

    return-void
.end method""")
        changed.append(str(myapp))
    else:
        missing.append("MyApplication.smali")

    # FloatingWindowDetectHelper: catch Oplus safe.WINDOW SecurityException.
    n1 = find(app, "n1.smali")
    if n1 and add_catch(n1):
        changed.append(str(n1))
    elif n1:
        missing.append("n1.smali catch range")

    # UIShellContainer: remove optional flexible-window integration calls.
    removed = 0
    for f in app.rglob("*.smali"):
        s = f.read_text(errors="replace")
        pat = re.compile(
            r"\n    invoke-static \{\}, Lcom/oplus/flexiblewindow/FlexibleWindowManager;->getInstance\(\)Lcom/oplus/flexiblewindow/FlexibleWindowManager;.*?removeEmbeddedContainerTask\(II\)V",
            re.S,
        )
        ns, n = pat.subn("", s, count=1)
        if n:
            f.write_text(ns)
            changed.append(str(f))
            removed += 1
    if not removed:
        missing.append("removeEmbeddedContainerTask call")

    # Gallery pre-decode: optional bind throws SecurityException on this port.
    gallery_removed = 0
    for f in app.rglob("*.smali"):
        s = f.read_text(errors="replace")
        pat = re.compile(
            r"\n    iget-object v2, v0, Lzs/d;->g:Lzs/d\$c;.*?bindService\(Landroid/content/Intent;Landroid/content/ServiceConnection;I\)Z",
            re.S,
        )
        ns, n = pat.subn("", s, count=1)
        if n:
            f.write_text(ns)
            changed.append(str(f))
            gallery_removed += 1
    if not gallery_removed:
        missing.append("gallery bindService call")

    # PreviewProcessor: remove the GL texture hand-off wait that can deadlock.
    preview = None
    for candidate in app.rglob("g.smali"):
        if candidate.parent.name == "gn":
            preview = candidate
            break
    if preview:
        s = preview.read_text(errors="replace")
        pat = re.compile(
            r"\n    iget-object v1, p0, Lgn/g;->m0:Landroid/os/ConditionVariable;\n\n    \.line 383\n    \.line 384\n    invoke-virtual \{v1\}, Landroid/os/ConditionVariable;->block\(\)V",
            re.S,
        )
        ns, n = pat.subn("", s, count=1)
        if n:
            preview.write_text(ns)
            changed.append(str(preview))
        else:
            missing.append("PreviewProcessor m0 wait")
    else:
        missing.append("gn/g.smali")

    # Experimental Camera2 SurfaceTexture bridge.
    if not args.no_bridge:
        target = find(app, "go/i1.smali")
        if target:
            for src in (HERE / "smali" / "com" / "oplus" / "camera").glob("Camera2PreviewBridge*.smali"):
                shutil.copyfile(src, target.parent / src.name)
            s = target.read_text(errors="replace")
            s = s.replace("if-ne v1, v0, :cond_3", "if-ne v1, v1, :cond_3", 1)
            marker = """    :cond_3
    :goto_1
    iget-object v0, p0, Lgo/i1;->v:Lcom/oplus/camera/filter/IEffectProcessor;"""
            hook = """    :cond_3
    :goto_1
    iget-object v2, p0, Lgo/i1;->u0:Landroid/graphics/SurfaceTexture;

    if-nez v2, :cond_bridge

    invoke-static {}, Lhp/a;->a()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v2}, Lcom/oplus/camera/Camera2PreviewBridge;->start(Landroid/content/Context;Landroid/graphics/SurfaceTexture;)V

    :cond_bridge
    iget-object v0, p0, Lgo/i1;->v:Lcom/oplus/camera/filter/IEffectProcessor;"""
            if marker in s:
                s = s.replace(marker, hook, 1)
                target.write_text(s)
                changed.append(str(target))
            else:
                missing.append("go/i1 preview hook")
        else:
            missing.append("go/i1.smali")

    print("changed:")
    for c in sorted(set(changed)):
        print("  " + c)
    if missing:
        print("not found / skipped (inspect these for your app version):")
        for m in missing:
            print("  " + m)
    print("done")


if __name__ == "__main__":
    main()
