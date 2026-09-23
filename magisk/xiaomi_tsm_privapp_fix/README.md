# Existing Xiaomi TSM module update

This is an overlay update to the existing `xiaomi_tsm_privapp_fix`, not a new
module. Preserve its existing TSM permission XML and back up its TSM APK. The old
TSM 1755 had an Android Debug signature. On the tested device, a separately
authorized migration installed the unchanged official TSM 1835 and replaced the
system copy while retaining UID and application data. Migration alone is not proof
that UnionPay authorization or card provisioning succeeds. Supply the installed,
unmodified NextPay APK externally at
`system/system_ext/priv-app/MiuiNextPay/MiuiNextPay.apk`; do not commit APKs here.
Verify its certificate and byte-for-byte hash before deploying. Keep application
data and its data partition update. A reboot is required for privileged status.

For the exact approved official TSM hash, `post-fs-data.sh` maintains the opt-in
marker for the companion Vector module's separate-UID parser. It never enables
signature migration. After replacing the system APK, back up and invalidate only
its `MiuiTsmClient-*` package parsing cache, then reboot and confirm both active and
disabled-system records reflect the official version. Do not clear wallet data.
Do not remove the companion parser while this official APK still declares the
NFC shared UID on the custom ROM. See the migration guards and rollback limits in
[the wallet investigation](../../docs/xiaomi-wallet-compat-android16.md).

The custom Provider permission is `signature|privileged`. Only NextPay receives
the additional grant. Existing OMAPI lookup policy is preserved. NFC property
rules authorize the `priv_app` SELinux domain to set the `nfc_prop` type, which
includes `persist.nfc_cfg.selectcard`; SELinux cannot restrict this rule to one
package or one property name. Do not grant `default_prop` or disable enforcing.

Use Magisk's space-separated rule grammar, not the `target:class` syntax from
SELinux `.te` files. The latter produced a syntax error on this device while
returning status zero. Check diagnostic output as well as the exit status.
The existing early live-policy loader is retained. It accepts only the exact
already-existing messages for the two new MTD types; other parser output fails.

Version 2.3 also restores startup of the existing OEM `vendor.mtdservice-1-3`.
`prepare-mtd.sh` verifies the executable and `libmt@1.3.so` hashes, copies the
unchanged executable within this module, and binds its correct executable label
into init's mount namespace. `service.sh` starts the existing init service. No OEM
binary is distributed in this repository. Unknown firmware fails closed.

MTD uses a dedicated enforcing domain. The current ROM has no MTD hwservice
context entry; temporary context-file overlays would not update the already cached
hwservicemanager lookup. Registry access to `default_android_hwservice` is therefore
granted to this trusted MTD daemon (add/find) and the existing secure-element HAL
(find), with Binder communication between them. This covers that registry type,
not just one service name. No application domain gets this registry permission.
Do not copy these rules to unrelated ROMs. A ROM-integrated fix should restore the
OEM service context and use `hal_mtdservice_hwservice` instead.

The repair does not grant persist writes, DAC override, tracefs access, or permissive
mode. Remaining diagnostic-only denials for those operations were not required for
the real signed-key read, which returned 357 bytes successfully.

Create `disable-mtd` inside the module and reboot to stop applying the executable
label binding and service start. Disable the whole module and reboot to remove its
SELinux additions too. Removing a marker cannot undo an already live policy/bind.

Back up the complete previous module and verify rollback before deployment.
Removing this update does not roll back card provisioning or secure-element state.

Version 2.4 adds an explicitly configured transit request compatibility marker.
Create `enable-transit-id-format-compat` inside this existing module only on the
validated installation. With the exact official wallet hash, `post-fs-data.sh`
recreates `/data/local/tmp/xiaomi-wallet-transit-id-format.enabled`. Companion
Vector version 29 additionally checks the Provider APK hash and limits its stable
UUID-to-16-hex mapping to two exact POST transit routes. It does not alter the
Provider's identifier, account state, bank routes, or server responses. Both transit
APIs returned 200 in the controlled run; the user confirmed cloud-card transfer-in.
The backend's precise length/identity validation mechanism remains unknown.

To disable this mapping, remove both the module configuration file and the runtime
marker. Removing only the marker lasts until the next boot when configuration is
still enabled. No reboot or card deletion is required to stop future request
mapping. This does not reverse completed card operations.
