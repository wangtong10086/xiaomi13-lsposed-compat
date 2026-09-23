#!/usr/bin/env python3
"""Privacy regression checks for the wallet-only HMA exception."""
import copy
import importlib.util
from pathlib import Path
import unittest

spec = importlib.util.spec_from_file_location("wallet_hma", Path(__file__).with_name("Repair-WalletHmaConfig.py"))
hma = importlib.util.module_from_spec(spec)
spec.loader.exec_module(hma)


def fixture():
    return {
        "configVersion": 95,
        "templates": {
            "root_tools": {"isWhitelist": False, "appList": ["root.manager", hma.PROVIDER]},
            "rom": {"isWhitelist": False, "appList": ["rom.settings"]},
        },
        "scope": {
            hma.WALLET: {"useWhitelist": False, "applyTemplates": ["root_tools", "rom"],
                         "extraAppList": ["debug.tool", hma.PROVIDER], "excludeSystemApps": True},
            "example.bank": {"useWhitelist": False, "applyTemplates": ["root_tools", "rom"],
                             "extraAppList": [], "excludeSystemApps": True},
        },
    }


def hidden(config, package):
    scope = config["scope"][package]
    result = set(scope.get("extraAppList", []))
    for name in scope["applyTemplates"]:
        result.update(config["templates"][name]["appList"])
    return result


class WalletConfigTests(unittest.TestCase):
    def test_only_provider_visibility_changes_for_wallet(self):
        original = fixture()
        frozen = copy.deepcopy(original)
        fixed = hma.repair(original)
        self.assertEqual(original, frozen)
        self.assertEqual(hidden(fixed, hma.WALLET), hidden(original, hma.WALLET) - {hma.PROVIDER})
        self.assertEqual(fixed["scope"]["example.bank"], original["scope"]["example.bank"])
        self.assertEqual(hidden(fixed, "example.bank"), hidden(original, "example.bank"))
        self.assertEqual(fixed["templates"]["root_tools"], original["templates"]["root_tools"])

    def test_idempotent_and_refreshes_source_template(self):
        fixed = hma.repair(fixture())
        self.assertEqual(hma.repair(fixed), fixed)
        fixed["templates"]["root_tools"]["appList"].append("new.root.manager")
        refreshed = hma.repair(fixed)
        self.assertIn("new.root.manager", hidden(refreshed, hma.WALLET))
        self.assertNotIn(hma.PROVIDER, hidden(refreshed, hma.WALLET))

    def test_shared_derived_template_is_not_silently_changed(self):
        config = fixture()
        config["scope"]["example.bank"]["applyTemplates"] = ["root_tools_wallet_compat"]
        with self.assertRaises(ValueError):
            hma.repair(config)

    def test_missing_scope_is_unchanged(self):
        config = fixture()
        del config["scope"][hma.WALLET]
        self.assertEqual(config, hma.repair(config))


if __name__ == "__main__":
    unittest.main()
