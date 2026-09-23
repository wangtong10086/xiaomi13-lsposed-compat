#!/usr/bin/env python3
"""Build the original smali module plus its source-based wallet additions.

Needs JDK, Apktool 3.0.3, an Android SDK and the compile-only Xposed API 82 JAR.
Optional signing uses APK_KEYSTORE_PASSWORD / APK_KEY_PASSWORD environment values.
Diagnostic classes and their Xposed entry points are excluded unless explicitly requested.
"""
import argparse
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import zipfile


def run(*args):
    subprocess.run([str(x) for x in args], check=True)


def build(args):
    repo = Path(__file__).resolve().parents[1]
    module = repo / "modules" / "miui-intent-fix"
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    project = output / "apktool-project"
    if project.exists():
        shutil.rmtree(project)
    shutil.copytree(module, project, ignore=shutil.ignore_patterns(
        "build", "dist", "compat-src", "diagnostics-src", "stubs"))
    sources = sorted((module / "compat-src").rglob("*.java"))
    if args.include_diagnostics:
        sources += sorted((module / "diagnostics-src").rglob("*.java"))
        with (project / "assets" / "xposed_init").open("a", encoding="utf-8") as entries:
            for name in ["WalletDiagnostics", "WalletUnionPayDiagnostics", "WalletTransitDiagnostics"]:
                entries.write("dev.codex.xiaomiaccount.miuiintentfix." + name + "\n")
    classes = output / "wallet-classes"
    if classes.exists():
        shutil.rmtree(classes)
    classes.mkdir()
    dex = output / "wallet-dex"
    if dex.exists():
        shutil.rmtree(dex)
    dex.mkdir()
    bt = args.build_tools.resolve()
    run("javac", "-encoding", "UTF-8", "--release", "8", "-cp",
        os.pathsep.join(map(str, [args.android_jar, args.xposed_api])), "-d", classes, *sources)
    run(bt / "d8", "--min-api", "26", "--lib", args.android_jar,
        "--classpath", args.xposed_api, "--output", dex, *sorted(classes.rglob("*.class")))
    if list(dex.glob("*.dex")) != [dex / "classes.dex"]:
        raise RuntimeError("Expected one dex containing only the wallet additions")
    unsigned = output / "miui-intent-fix-unsigned.apk"
    run("java", "-jar", args.apktool, "b", project, "-o", unsigned)
    with zipfile.ZipFile(unsigned, "a", compression=zipfile.ZIP_DEFLATED) as apk:
        if "classes2.dex" in apk.namelist():
            raise RuntimeError("Existing secondary dex requires explicit merge review")
        apk.write(dex / "classes.dex", "classes2.dex")
    aligned = output / "miui-intent-fix-aligned.apk"
    run(bt / "zipalign", "-f", "4", unsigned, aligned)
    artifact = aligned
    if args.keystore:
        if not args.alias or not os.environ.get("APK_KEYSTORE_PASSWORD") or not os.environ.get("APK_KEY_PASSWORD"):
            raise RuntimeError("Signing requires alias and both password environment variables")
        artifact = output / "miui-intent-fix.apk"
        run(bt / "apksigner", "sign", "--v4-signing-enabled", "false", "--ks", args.keystore,
            "--ks-key-alias", args.alias, "--ks-pass", "env:APK_KEYSTORE_PASSWORD",
            "--key-pass", "env:APK_KEY_PASSWORD", "--out", artifact, aligned)
        run(bt / "apksigner", "verify", "--verbose", "--print-certs", artifact)
    print(f"Artifact: {artifact}")
    print(f"SHA256: {hashlib.sha256(artifact.read_bytes()).hexdigest()}")


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    for name in ["apktool", "android-jar", "build-tools", "xposed-api", "output"]:
        p.add_argument("--" + name, required=True, type=Path)
    p.add_argument("--keystore", type=Path)
    p.add_argument("--alias")
    p.add_argument("--include-diagnostics", action="store_true",
                   help="Include opt-in metadata probes; never enabled by the production build")
    build(p.parse_args())
