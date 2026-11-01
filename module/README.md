# Module template

Place the built OCS shim jar here:

- `system/framework/com.oplus.camera.unit.sdk.jar`
- `system/framework/com.oplus.camera.unit.sdk.cam2.jar`
- `system/framework/com.oplus.camera.unit.sdk.adapter.jar` (stock, unchanged)
- `product/framework/com.oplus.camera.unit.sdk.jar`
- `product/framework/com.oplus.camera.unit.sdk.cam2.jar`

`scripts/build-sdk-shim.sh` does this automatically. The stock SDK jar usually lives at
`/my_product/product_overlay/framework/com.oplus.camera.unit.sdk.jar`; its permission XML
may point at `/product/framework/...`. The module's own XML under `system/etc/permissions`
points at the `/system/framework` copy, which is the reliable path on this port.

The `.jar` files are ignored by git; do not commit proprietary Oplus SDK binaries.

The permission XMLs point the `com.oplus.camera.unit.sdk` shared library at
`com.oplus.camera.unit.sdk.cam2.jar` to avoid stale oat files in the stock jar path.

The module intentionally does not include the camera APK, OCS configs, or vendor
libraries. Add only files you are allowed to redistribute.
