#!/usr/bin/env python3
"""Compile wallet variants with compile-only stubs and run synthetic regressions."""
import argparse
import os
from pathlib import Path
import subprocess
import sys


def run(*args):
    subprocess.run([str(x) for x in args], check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--android-jar", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    repo = Path(__file__).resolve().parents[1]
    module = repo / "modules/miui-intent-fix"
    output = args.output.resolve()
    for name in ["stubs", "production", "diagnostics", "tests"]:
        (output / name).mkdir(parents=True, exist_ok=True)
    javac = ["javac", "-encoding", "UTF-8", "--release", "8"]
    run(*javac, "-cp", args.android_jar, "-d", output / "stubs",
        *sorted((module / "stubs").rglob("*.java")))
    classpath = os.pathsep.join(map(str, [args.android_jar, output / "stubs"]))
    run(*javac, "-cp", classpath, "-d", output / "production",
        *sorted((module / "compat-src").rglob("*.java")))
    run(*javac, "-cp", classpath + os.pathsep + str(output / "production"),
        "-d", output / "diagnostics", *sorted((module / "diagnostics-src").rglob("*.java")))
    sources = module / "compat-src/dev/codex/xiaomiaccount/miuiintentfix"
    run(*javac, "-d", output / "tests", sources / "WalletSignedKeyFormat.java",
        sources / "TransitIdFormatPolicy.java", *sorted((repo / "tools/tests").glob("*.java")))
    for name in ["WalletSignedKeyFormatTest", "TransitIdFormatPolicyTest"]:
        run("java", "-cp", output / "tests", "dev.codex.xiaomiaccount.miuiintentfix." + name)
    run(sys.executable, repo / "tools/Test-WalletCompat.py")
    print("Wallet production and diagnostic sources compiled; stubs remain separate")


if __name__ == "__main__":
    main()
