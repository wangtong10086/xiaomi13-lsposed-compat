#!/usr/bin/env python3
"""Check wallet APK class definitions and entry points without including any device data."""
import argparse
from pathlib import Path
import struct
import zipfile

PREFIX = "dev.codex.xiaomiaccount.miuiintentfix."
PRODUCTION_ENTRIES = {PREFIX + n for n in ["XiaomiAccountHook", "WalletSignedKeyBridge", "WalletOfficialPackageCompat"]}
DIAGNOSTIC_ENTRIES = {PREFIX + n for n in ["WalletDiagnostics", "WalletUnionPayDiagnostics", "WalletTransitDiagnostics"]}
DIAGNOSTIC_NAMES = ["WalletDiagnostics", "WalletFlowDiagnostics", "WalletUnionPayDiagnostics", "WalletTransitDiagnostics"]


def defined_classes(dex):
    if not dex.startswith(b"dex\n"):
        raise ValueError("Expected a standard DEX file")
    def uint(offset):
        return struct.unpack_from("<I", dex, offset)[0]
    strings = []
    for index in range(uint(56)):
        offset = uint(uint(60) + index * 4)
        while dex[offset] & 0x80:
            offset += 1
        offset += 1
        strings.append(dex[offset:dex.index(b"\0", offset)].decode("utf-8", "replace"))
    types = [strings[uint(uint(68) + index * 4)] for index in range(uint(64))]
    return {types[uint(uint(100) + index * 32)] for index in range(uint(96))}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("apk", type=Path)
    parser.add_argument("--include-diagnostics", action="store_true")
    args = parser.parse_args()
    with zipfile.ZipFile(args.apk) as apk:
        entries = apk.read("assets/xposed_init").decode("utf-8").splitlines()
        expected = PRODUCTION_ENTRIES | (DIAGNOSTIC_ENTRIES if args.include_diagnostics else set())
        if set(entries) != expected or len(entries) != len(expected):
            raise ValueError("Unexpected Xposed entry points")
        classes = set()
        for name in apk.namelist():
            if name.startswith("classes") and name.endswith(".dex"):
                classes.update(defined_classes(apk.read(name)))
        if any(name.startswith("Lde/robv/android/xposed/") for name in classes):
            raise ValueError("Compile-only Xposed stubs were packaged")
        for name in DIAGNOSTIC_NAMES:
            descriptor = "L" + PREFIX.replace(".", "/") + name + ";"
            if (descriptor in classes) != args.include_diagnostics:
                raise ValueError("Diagnostic class inclusion differs from the requested variant")
        secondary = apk.read("classes2.dex")
        for removed_hook in [b"verifySignatures", b"checkCapability", b"doesSignatureMatchForPermissions", b"preparePackage"]:
            if removed_hook in secondary:
                raise ValueError("One-time signature migration hook remains in wallet additions")
    print("Wallet APK checked: " + ("diagnostic" if args.include_diagnostics else "production")
          + "; expected entry points; no Xposed API definitions or one-time migration hooks")


if __name__ == "__main__":
    main()
