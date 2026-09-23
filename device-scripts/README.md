# Existing device startup script repair

`91-esepower-fix.sh` replaces the existing file at
`/data/adb/service.d/91-esepower-fix.sh` on the tested Xiaomi 13. It is not a
new Magisk module and is not a generic installer. Back up the device file and
preserve its root ownership, executable mode and SELinux context when replacing it.

The original script restored esepower and the secure-element HAL at boot, then
scheduled an unconditional SecureElement SIGKILL 75 seconds later. A wallet APDU
was interrupted at the exact logged kill time and PID, causing `1010033`.
This version removes only that delayed kill and preserves boot recovery.

Validate shell syntax, reboot, confirm the normal Vector SecureElement hook loads,
and monitor the process beyond the old delayed window. Keep original backups
outside the repository; restoring a script cannot reverse card/chip operations.

See [wallet evidence and remaining failures](../docs/xiaomi-wallet-compat-android16.md).
