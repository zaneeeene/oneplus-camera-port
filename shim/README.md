# OCS Camera2 shim

`src/` is the human-readable Java implementation. `smali/` is the assembled form
inserted into the stock OCS SDK jar; it is our code only (no Oplus source).

Classes:
- `CameraUnitImpl` — implements `CameraUnitInterface`; opens Camera2 camera 0/1 and
  initializes `CameraConfigHelper`.
- `OcsCamera2Device` — implements `CameraDeviceInterface`; builds the Camera2 session
  from `SdkCameraDeviceConfig` and the app's preview Surface.
- `OcsCamera2Info` — implements `CameraDeviceInfoInterface` from
  `CameraManager.getCameraCharacteristics()`.

The shim was compiled against the stock OCS SDK class stubs. Rebuild it when the
target SDK changes; see `docs/BUILD.md`.
