package dev.codex.xiaomiaccount.miuiintentfix;

import android.os.Bundle;
import android.util.Log;
import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;
import java.util.concurrent.atomic.AtomicInteger;

/** Temporary, opt-in observation of wallet initialization. Never logs payloads or alters results. */
public final class WalletUnionPayDiagnostics implements IXposedHookLoadPackage {
    private static final File ENABLED = new File("/data/local/tmp/xiaomi-wallet-unionpay-diagnostics.enabled");
    private static final String APK = "7ae930ef12b71c309c463ff502a042716e1758932cf4e7a8a3bdb87f5e88e63e";
    private static final AtomicInteger EVENTS = new AtomicInteger();

    @Override public void handleLoadPackage(XC_LoadPackage.LoadPackageParam p) {
        if (!"com.unionpay.tsmservice.mi".equals(p.packageName) || !ENABLED.isFile()) return;
        try {
            if (p.appInfo == null || !APK.equals(hash(p.appInfo.sourceDir))) return;
            hook(p.classLoader, "com.unionpay.tsm.n", "com.unionpay.tsm.data.param.UPAddonInitParam", "init", "getHostPacakageName");
            hook(p.classLoader, "com.unionpay.tsm.ese.xiaomi.a", "com.unionpay.tsm.data.param.UPAddonInfoCompareParam", "info-compare", "getHostPackageName");
            emit("enabled; verified service APK; observation only");
        } catch (Throwable error) { emit("install-failed " + error.getClass().getSimpleName()); }
    }

    private static void hook(ClassLoader loader, String owner, String argument, String stage, String hostGetter) {
        XposedHelpers.findAndHookMethod(owner, loader, "a", XposedHelpers.findClass(argument, loader), new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                if (!ENABLED.isFile()) return;
                try {
                    if (!"com.miui.tsmclient".equals(XposedHelpers.callMethod(p.args[0], hostGetter))) return;
                    p.setObjectExtra("wallet-observation", Boolean.TRUE);
                    String classification = "";
                    if (stage.equals("init")) {
                        Object digest = XposedHelpers.callMethod(p.args[0], "getHostHash");
                        classification = " signer=" + ("1d679172de01e2b780ffa82a63402fca4c0eb443".equalsIgnoreCase(String.valueOf(digest))
                                ? "installed-debug" : "7b6dc7079c34739ce81159719fb5eb61d2a03225".equalsIgnoreCase(String.valueOf(digest))
                                ? "official-xiaomi" : "other");
                    }
                    emit(stage + " enter tid=" + Thread.currentThread().getId() + classification);
                } catch (Throwable ignored) { emit(stage + " metadata-unavailable"); }
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                if (!Boolean.TRUE.equals(p.getObjectExtra("wallet-observation"))) return;
                String code = "unavailable";
                try {
                    if (p.getResult() instanceof Bundle) {
                        String value = ((Bundle) p.getResult()).getString("resp");
                        if (value != null && value.matches("[0-9]{4,10}")) code = value;
                    }
                    emit(stage + " exit tid=" + Thread.currentThread().getId() + " resp=" + code
                            + " threw=" + p.hasThrowable());
                } catch (Throwable ignored) { emit(stage + " result-unavailable"); }
            }
        });
    }

    private static void emit(String text) {
        if (ENABLED.isFile() && EVENTS.incrementAndGet() <= 50) Log.i("WalletUnionPayDiagnostic", text);
    }
    private static String hash(String path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (FileInputStream input = new FileInputStream(path)) {
            byte[] buffer = new byte[32768]; int n;
            while ((n = input.read(buffer)) != -1) digest.update(buffer, 0, n);
        }
        StringBuilder result = new StringBuilder();
        for (byte b : digest.digest()) result.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
        return result.toString();
    }
}
