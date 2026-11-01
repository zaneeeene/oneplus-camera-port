# Contributing

The highest-value missing piece is making the OnePlus camera core call
`CameraUnitClient.openCamera()` on a non-Oplus ROM, or otherwise create its preview
`SurfaceTexture` so `Camera2PreviewBridge` can attach.

Useful contributions:

- A thread trace from the **main** camera PID (not the `:provider` process) showing where
  `CameraCore`/`CameraManager` initialization stops.
- A patch that makes `CameraManager.initialize()` / `CameraUnitClient` run without the
  Oplus APS stack.
- A working preview bridge that does not require the app's OCS camera core.
- Adaptation notes for a different OnePlus/OPPO camera version.

Please do not commit APKs, Oplus SDK jars, vendor images, or other proprietary binaries.
Post small patches and reproduction notes instead.
