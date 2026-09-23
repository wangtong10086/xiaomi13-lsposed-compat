#!/usr/bin/env python3
"""Create a reviewable HMA configuration with one wallet provider exception.

This edits an exported JSON file, not the device. Keep exports outside the repo.
The derived template is a snapshot; rerun after editing its source template.
"""
import argparse
import copy
import json
from pathlib import Path

WALLET = "com.miui.tsmclient"
PROVIDER = "com.miui.securitycenter"


def repair(config):
    result = copy.deepcopy(config)
    scope = result["scope"].get(WALLET)
    if scope is None:
        return result
    if scope.get("useWhitelist"):
        if PROVIDER not in scope.setdefault("extraAppList", []):
            scope["extraAppList"].append(PROVIDER)
        return result
    scope["extraAppList"] = [p for p in scope.get("extraAppList", []) if p != PROVIDER]
    templates = result["templates"]
    applied = []
    for name in scope.get("applyTemplates", []):
        # Refresh a previously derived template from the current original.
        source = name.removesuffix("_wallet_compat")
        if source not in templates:
            source = name
        template = templates[source]
        if template.get("isWhitelist"):
            raise ValueError("Mixed whitelist templates need manual review")
        if PROVIDER in template.get("appList", []):
            derived = source + "_wallet_compat"
            for package, other in result["scope"].items():
                if package != WALLET and derived in other.get("applyTemplates", []):
                    raise ValueError("Derived template is shared with another application")
            replacement = copy.deepcopy(template)
            replacement["appList"] = [p for p in template["appList"] if p != PROVIDER]
            templates[derived] = replacement
            applied.append(derived)
        else:
            applied.append(source)
    scope["applyTemplates"] = applied
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("destination", type=Path)
    args = parser.parse_args()
    if args.source.resolve() == args.destination.resolve():
        parser.error("Keep the original export for rollback; use a different destination")
    source = json.loads(args.source.read_text())
    args.destination.write_text(json.dumps(repair(source), ensure_ascii=False, indent=2) + "\n")
    args.destination.chmod(0o600)
