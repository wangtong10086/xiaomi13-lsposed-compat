package dev.codex.xiaomiaccount.miuiintentfix;

import android.os.Build;
import android.app.Activity;
import android.content.Context;
import android.util.Log;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/** Called only after the official wallet APK hash guard has passed. */
final class WalletTransitIdFormatCompat {
    private static final File ENABLED = new File("/data/local/tmp/xiaomi-wallet-transit-id-format.enabled");
    private static final String TAG = "WalletTransitIdFormat";
    private static final AtomicInteger EVENTS = new AtomicInteger();
    private static final String PROVIDER_APK = "de57aa85d979ca9c801f71737c635df100b21da15408e7ecd35d410a0b25c1de";
    private static volatile int providerMatch;

    static void install(ClassLoader loader) {
        if (!"fuxi".equals(Build.DEVICE)) return;
        XposedHelpers.findAndHookMethod(Activity.class, "onPostResume", new XC_MethodHook() {
            @Override protected void afterHookedMethod(MethodHookParam call) {
                if (ENABLED.isFile() && providerMatch == 0) providerMatches((Context) call.thisObject);
            }
        });
        Class<?> coder = XposedHelpers.findClass("l8.d", loader);
        XposedHelpers.findAndHookMethod("k8.f", loader, "b", String.class, String.class,
                Map.class, String.class, coder, new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam call) {
                if (!ENABLED.isFile() || !(call.args[2] instanceof Map)) return;
                try {
                    if (TransitIdFormatPolicy.route(call.args[0], call.args[1]) == null) return;
                    Context context = (Context) XposedHelpers.callStaticMethod(
                            XposedHelpers.findClass("android.app.ActivityThread", null), "currentApplication");
                    if (!providerMatches(context)) return;
                    Map<String, String> copy = TransitIdFormatPolicy.copyForRequest(
                            call.args[0], call.args[1], (Map<?, ?>) call.args[2]);
                    if (copy == null) return;
                    call.args[2] = copy;
                    emit("request mapped route=" + TransitIdFormatPolicy.route(call.args[0], call.args[1])
                            + " originalLength=41 mappedLength=21 originalMapUnchanged=true");
                } catch (Throwable error) {
                    emit("compatibility declined=" + error.getClass().getSimpleName());
                }
            }
        });
    }

    private static synchronized boolean providerMatches(Context context) {
        if (providerMatch != 0) return providerMatch == 1;
        if (context == null) return false;
        try {
            String source = context.getPackageManager().getApplicationInfo("com.miui.securitycenter", 0).sourceDir;
            MessageDigest hash = MessageDigest.getInstance("SHA-256");
            try (FileInputStream input = new FileInputStream(source)) {
                byte[] bytes = new byte[16384]; int n;
                while ((n = input.read(bytes)) != -1) hash.update(bytes, 0, n);
            }
            StringBuilder hex = new StringBuilder();
            for (byte b : hash.digest()) hex.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
            providerMatch = PROVIDER_APK.equals(hex.toString()) ? 1 : -1;
            emit("providerHashMatched=" + (providerMatch == 1) + " persistentProviderUnchanged=true");
        } catch (Throwable error) {
            providerMatch = -1;
            emit("provider validation declined=" + error.getClass().getSimpleName());
        }
        return providerMatch == 1;
    }

    private static void emit(String value) {
        if (EVENTS.incrementAndGet() <= 40) {
            Log.i(TAG, value);
            XposedBridge.log(TAG + ": " + value);
        }
    }
}
