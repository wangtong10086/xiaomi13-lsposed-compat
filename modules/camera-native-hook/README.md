# Camera native hook

Scope: `com.android.camera` only.

At package load, the module:

1. enables the camera2 hidden-API namespace needed by Xiaomi Camera;
2. hooks `com.xiaomi.protocol.ICustomCaptureResult.toTotalCaptureResult`;
3. constructs the Android 16 `TotalCaptureResult` form expected by the app when its older constructor path is unavailable.

The current smali logs `camera2 hidden API exemption and Android 16 TotalCaptureResult bridge active`. It does not implement the OIS driver; kernel/OIS work lives in the companion camera-kernel repository.

The application label/description in the preserved manifest is historical and less precise than the implemented v2 behavior. The smali and scope are authoritative.
