package dev.codex.xiaomiaccount.miuiintentfix;

import android.app.Activity;
import android.content.Context;
import android.util.Log;
import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.File;
import java.io.FileInputStream;
import java.lang.reflect.Method;
import java.security.MessageDigest;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicBoolean;

/** Opt-in metadata probes. Never changes results or initiates network/card operations. */
public final class WalletDiagnostics implements IXposedHookLoadPackage {
    private static final String TAG = "WalletCompatDiagnostic";
    private static final String APK_SHA256 =
            "c48ba0c5686e879c49416f0be3d18ae840e2f255f406345eab26e95bbe785e5c";
    private static final File ENABLED =
            new File("/data/local/tmp/xiaomi-wallet-diagnostics.enabled");
    private static final AtomicInteger EVENTS = new AtomicInteger();
    private static final AtomicBoolean READ_CHECK_STARTED = new AtomicBoolean();

    @Override public void handleLoadPackage(XC_LoadPackage.LoadPackageParam p) {
        if (!"com.miui.tsmclient".equals(p.packageName) || !ENABLED.isFile()) return;
        try {
            if (p.appInfo == null || !APK_SHA256.equals(sha256(p.appInfo.sourceDir))) {
                Log.i(TAG, "inactive: target APK does not match validated build");
                return;
            }
            ClassLoader loader = p.classLoader;
            WalletFlowDiagnostics.install(loader);
            XposedHelpers.findAndHookMethod("com.android.id.impl.IdProviderImpl", loader,
                    "getVAID", Context.class, observe("provider.vaid", true));
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.mitsmsdk.DeviceInfoImpl", loader,
                    "getDeviceId", Context.class, observe("device.id", true));
            Class<?> auth = XposedHelpers.findClass("com.miui.tsmclient.seitsm.a", loader);
            Class<?> card = XposedHelpers.findClass("com.miui.tsmclient.entity.CardInfo", loader);
            XposedHelpers.findAndHookMethod(auth, "k", Context.class, card,
                    observe("session.create", false));
            // Locate the inherited transport method without altering its arguments.
            for (Class<?> c = auth; c != null; c = c.getSuperclass()) {
                for (Method m : c.getDeclaredMethods()) {
                    if (m.getName().equals("d0")) {
                        XposedBridge.hookMethod(m, observe("transport", false));
                    }
                }
            }
            // A local read check avoids issuing/downloading a card just to test visibility.
            XposedHelpers.findAndHookMethod(Activity.class, "onPostResume", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam call) {
                    if (!ENABLED.isFile() || !READ_CHECK_STARTED.compareAndSet(false, true)) return;
                    final Context context = ((Activity) call.thisObject).getApplicationContext();
                    new Thread(() -> {
                        try {
                            Object provider = XposedHelpers.newInstance(XposedHelpers.findClass(
                                    "com.android.id.impl.IdProviderImpl", loader));
                            XposedHelpers.callMethod(provider, "getVAID", context);
                            Object device = XposedHelpers.newInstance(XposedHelpers.findClass(
                                    "com.miui.tsmclient.mitsmsdk.DeviceInfoImpl", loader));
                            XposedHelpers.callMethod(device, "getDeviceId", context);
                            if (new File("/data/local/tmp/xiaomi-wallet-signed-key-read.enabled").isFile()) {
                                Object adapter = XposedHelpers.callStaticMethod(XposedHelpers.findClass(
                                        "s6.f", loader), "b");
                                Object signed = XposedHelpers.callMethod(adapter, "e");
                                emit("local.signed-key-read length=" + (signed instanceof String ? ((String) signed).length() : -1));
                            }
                        } catch (Throwable error) {
                            emit("local.read-check " + error.getClass().getSimpleName());
                        }
                    }, "WalletCompatReadCheck").start();
                }
            });
            Log.i(TAG, "enabled: metadata only; target APK verified; maximum 200 events");
        } catch (Throwable error) {
            Log.i(TAG, "probe install failed: " + error.getClass().getSimpleName());
        }
    }

    private static XC_MethodHook observe(final String stage, final boolean text) {
        return new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam p) {
                emit(stage + " enter tid=" + Thread.currentThread().getId());
            }
            @Override protected void afterHookedMethod(MethodHookParam p) {
                Throwable error = p.getThrowable();
                Object result = p.getResult();
                String status = error == null ? "ok" : error.getClass().getSimpleName();
                if (text && error == null) {
                    status += " length=" + (result instanceof String ? ((String) result).length() : -1);
                }
                emit(stage + " exit tid=" + Thread.currentThread().getId() + " " + status);
            }
        };
    }

    private static void emit(String message) {
        if (ENABLED.isFile() && EVENTS.incrementAndGet() <= 200) Log.i(TAG, message);
    }

    private static String sha256(String path) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (FileInputStream stream = new FileInputStream(path)) {
            byte[] buffer = new byte[32768];
            int count;
            while ((count = stream.read(buffer)) != -1) digest.update(buffer, 0, count);
        }
        StringBuilder hex = new StringBuilder();
        for (byte b : digest.digest()) hex.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
        return hex.toString();
    }
}
