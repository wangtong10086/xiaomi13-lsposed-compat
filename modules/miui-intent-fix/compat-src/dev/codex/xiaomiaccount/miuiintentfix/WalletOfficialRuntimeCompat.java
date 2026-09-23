package dev.codex.xiaomiaccount.miuiintentfix;

import android.accounts.Account;
import android.accounts.AccountManagerFuture;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.FileInputStream;
import java.security.MessageDigest;

/** Version-specific replacement for the legacy wallet's obfuscated account hooks. */
public final class WalletOfficialRuntimeCompat {
    private static volatile Bundle lastAuth;
    private static volatile Object lastValid;

    public static boolean installIfMatched(XC_LoadPackage.LoadPackageParam p) {
        try {
            if (p.appInfo == null || !"1823e8ee6b6170884e135cb758baa1d06b7c9d038dcfea3cd2b1bca83a0f4170".equals(hash(p.appInfo.sourceDir))) return false;
        } catch (Throwable error) { return false; }
        try {
            ClassLoader loader = p.classLoader;
            try { WalletTransitIdFormatCompat.install(loader); }
            catch (Throwable error) { Log.i("WalletOfficialRuntime", "transit format compatibility unavailable: " + error.getClass().getSimpleName()); }
            Class<?> legacy = XposedHelpers.findClass("dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook",
                    WalletOfficialRuntimeCompat.class.getClassLoader());
            XposedHelpers.findAndHookMethod("x4.d$b", loader, "run", AccountManagerFuture.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam call) {
                    try {
                        Object result = XposedHelpers.callMethod(call.args[0], "getResult");
                        if (result instanceof Bundle) lastAuth = new Bundle((Bundle) result);
                    } catch (Throwable ignored) { /* Original callback/result remains unchanged. */ }
                }
            });
            XposedHelpers.findAndHookMethod("x4.d", loader, "h", Context.class, String.class, boolean.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam call) {
                    if (!"tsm-auth".equals(call.args[1]) || call.hasThrowable()) return;
                    try {
                        Account account = (Account) XposedHelpers.callMethod(call.thisObject, "f", call.args[0]);
                        if (account == null) return;
                        Object result = call.getResult();
                        if (result == null) {
                            Object cached = lastValid;
                            if (cached == null) cached = XposedHelpers.getStaticObjectField(
                                    XposedHelpers.findClass("x4.d", loader), "a");
                            if (validForAccount(cached, account.name)) {
                                call.setResult(cached);
                                Log.i("WalletOfficialRuntime", "reused existing same-account token cache");
                            }
                            return;
                        }
                        if (!account.name.equals(XposedHelpers.callMethod(result, "f"))) return;
                        if (empty((String) XposedHelpers.callMethod(result, "c"))) {
                            String ph = null;
                            Bundle auth = lastAuth;
                            if (auth != null && account.name.equals(auth.getString("authAccount"))) {
                                for (String key : new String[]{"ph", "encrypted_ph", "phoneHash"}) {
                                    ph = auth.getString(key); if (!empty(ph)) break;
                                }
                            }
                            if (empty(ph)) ph = (String) XposedHelpers.callStaticMethod(legacy,
                                    "readXiaomiAccountUserDataPh", call.args[0], "tsm-auth");
                            if (empty(ph)) ph = (String) XposedHelpers.callStaticMethod(legacy, "readTsmAuthPhCache");
                            if (!empty(ph)) {
                                XposedHelpers.setObjectField(result, "e", ph);
                                Log.i("WalletOfficialRuntime", "restored existing auth metadata; no value logged");
                            }
                        }
                        if (validForAccount(result, account.name)) lastValid = result;
                    } catch (Throwable error) { Log.i("WalletOfficialRuntime", "account compatibility declined: " + error.getClass().getSimpleName()); }
                }
            });
            // These framework/Activity hooks are not obfuscated. The obsolete optional
            // d9 tag-delivery probe may decline; it never changes NFC behavior.
            XposedHelpers.callStaticMethod(legacy, "installTsmNfcForegroundDispatchFix", loader);
            Log.i("WalletOfficialRuntime", "enabled for verified official wallet 1835");
        } catch (Throwable error) { Log.i("WalletOfficialRuntime", "install failed: " + error.getClass().getSimpleName()); }
        // Do not run legacy obfuscated hooks against a different app version.
        return true;
    }

    private static boolean validForAccount(Object value, String account) {
        return value != null && account.equals(XposedHelpers.callMethod(value, "f"))
                && Boolean.TRUE.equals(XposedHelpers.callMethod(value, "g"));
    }
    private static boolean empty(String value) { return value == null || value.isEmpty(); }
    private static String hash(String path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (FileInputStream input = new FileInputStream(path)) {
            byte[] bytes = new byte[32768]; int n;
            while ((n = input.read(bytes)) != -1) digest.update(bytes, 0, n);
        }
        StringBuilder result = new StringBuilder();
        for (byte b : digest.digest()) result.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
        return result.toString();
    }
}
