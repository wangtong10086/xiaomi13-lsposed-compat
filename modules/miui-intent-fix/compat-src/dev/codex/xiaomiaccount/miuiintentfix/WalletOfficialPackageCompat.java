package dev.codex.xiaomiaccount.miuiintentfix;

import android.system.Os;
import android.util.Log;
import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;

/** Keeps the verified OEM wallet in its existing separate UID; no signature migration hooks. */
public final class WalletOfficialPackageCompat implements IXposedHookLoadPackage {
    private static final String WALLET = "com.miui.tsmclient";
    private static final String OFFICIAL_APK = "1823e8ee6b6170884e135cb758baa1d06b7c9d038dcfea3cd2b1bca83a0f4170";
    private static final String FRAMEWORK = "c0294211aaf5379a44a93b988f7cb73a43cbbe31603c6ce9f64645f0de8ae25f";
    private static final String SERVICES = "3bb0348ccb8747be9c93ce3c64e5e4a9e6dbf61f06598546790db6eb1b5c01cd";
    private static final File ENABLED = new File("/data/local/tmp/xiaomi-wallet-official-package.enabled");

    @Override public void handleLoadPackage(XC_LoadPackage.LoadPackageParam p) {
        if (!"android".equals(p.packageName) || !"android".equals(p.processName)) return;
        try {
            if (!rootMarker(ENABLED) || !FRAMEWORK.equals(hashFile("/system/framework/framework.jar"))
                    || !SERVICES.equals(hashFile("/system/framework/services.jar"))) return;
            XposedHelpers.findAndHookMethod("com.android.internal.pm.parsing.pkg.PackageImpl", p.classLoader,
                    "setSharedUserId", String.class, new XC_MethodHook() {
                        @Override protected void beforeHookedMethod(MethodHookParam call) {
                            try {
                                if (!rootMarker(ENABLED) || !"android.uid.nfc".equals(call.args[0])
                                        || !WALLET.equals(XposedHelpers.callMethod(call.thisObject, "getPackageName"))) return;
                                String path = (String) XposedHelpers.callMethod(call.thisObject, "getBaseApkPath");
                                if (!OFFICIAL_APK.equals(hashFile(path))) return;
                                // Keep the wallet in its existing separate UID. Do not join NFC's UID.
                                call.args[0] = null;
                                Log.i("WalletOfficialPackageCompat", "verified OEM wallet parsed with separate UID");
                            } catch (Throwable error) { Log.i("WalletOfficialPackageCompat", "parse guard declined"); }
                        }
                    });
            Log.i("WalletOfficialPackageCompat", "verified OEM separate-UID parser enabled; migration hooks absent");
        } catch (Throwable error) { Log.i("WalletOfficialPackageCompat", "inactive: " + error.getClass().getSimpleName()); }
    }

    private static boolean rootMarker(File marker) {
        try { return marker.isFile() && Os.lstat(marker.getPath()).st_uid == 0
                && (Os.lstat(marker.getPath()).st_mode & 0022) == 0; }
        catch (Exception error) { return false; }
    }
    private static String hashFile(String path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (FileInputStream input = new FileInputStream(path)) {
            byte[] buffer = new byte[32768]; int n;
            while ((n = input.read(buffer)) != -1) digest.update(buffer, 0, n);
        }
        return hex(digest.digest());
    }
    private static String hex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte b : bytes) result.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
        return result.toString();
    }
}
