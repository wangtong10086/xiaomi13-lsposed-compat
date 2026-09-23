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
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import org.json.JSONObject;

/** Read-only, opt-in metadata for the two official-wallet transit request paths. */
public final class WalletTransitDiagnostics implements IXposedHookLoadPackage {
    private static final String TAG = "WalletTransitDiagnostic";
    private static final String APK = "1823e8ee6b6170884e135cb758baa1d06b7c9d038dcfea3cd2b1bca83a0f4170";
    private static final File ENABLED = new File("/data/local/tmp/xiaomi-wallet-transit-diagnostics.enabled");
    private static final AtomicInteger EVENTS = new AtomicInteger();
    private static final AtomicInteger REQUESTS = new AtomicInteger();
    private static final AtomicBoolean LOCAL_READ = new AtomicBoolean();
    private static volatile String localDeviceId;
    private static final String[] PUBLIC_FIELDS = {"deviceModel", "miuiRomType", "miuiSystemVersion",
            "romType", "hyperOSVersion", "androidVersion", "tsmclientVersionCode", "appVersionCode"};

    @Override public void handleLoadPackage(XC_LoadPackage.LoadPackageParam p) {
        if (!"com.miui.tsmclient".equals(p.packageName) || !ENABLED.isFile()) return;
        try {
            if (p.appInfo == null || !APK.equals(hash(p.appInfo.sourceDir))) return;
            Class<?> transport = XposedHelpers.findClass("k8.f", p.classLoader);
            int count = 0;
            for (Method method : transport.getDeclaredMethods()) {
                if (!("c".equals(method.getName()) || "e".equals(method.getName()))
                        || method.getParameterTypes().length != 8
                        || method.getParameterTypes()[0] != String.class) continue;
                XposedBridge.hookMethod(method, transportProbe());
                count++;
            }
            if (count != 2) emit("unexpected transport method count=" + count);
            // The asynchronous transfer path uses OkHttp plus k8.f.b, rather
            // than k8.f.c/e. Observe its already decrypted response separately.
            XposedHelpers.findAndHookMethod("i5.a", p.classLoader, "G", boolean.class, String.class, new XC_MethodHook() {
                @Override protected void beforeHookedMethod(MethodHookParam call) {
                    if (!ENABLED.isFile()) return;
                    try {
                        String route = route(XposedHelpers.callMethod(call.thisObject, "r"));
                        if (!"startTransferIn".equals(route)) return;
                        int id = REQUESTS.incrementAndGet();
                        requestMetadata(id, route, (Map<?, ?>) XposedHelpers.callMethod(call.thisObject, "n"),
                                (Map<?, ?>) XposedHelpers.callMethod(call.thisObject, "i"), null);
                        emit("response id=" + id + " httpSuccessful=" + Boolean.TRUE.equals(call.args[0]));
                        responseMetadata(id, call.args[1]);
                    } catch (Throwable error) { emit("transfer observation failed=" + error.getClass().getSimpleName()); }
                }
            });
            final Class<?> device = XposedHelpers.findClass("com.miui.tsmclient.util.n0", p.classLoader);
            XposedHelpers.findAndHookMethod(Activity.class, "onPostResume", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam call) {
                    if (!ENABLED.isFile() || !LOCAL_READ.compareAndSet(false, true)) return;
                    final Context context = ((Activity) call.thisObject).getApplicationContext();
                    new Thread(() -> {
                        try {
                            localDeviceId = (String) XposedHelpers.callStaticMethod(device, "g", context, null);
                            emit("local deviceId=" + shape(localDeviceId)
                                    + " deviceModel=" + publicValue(XposedHelpers.callStaticMethod(device, "i", new Object[]{null}))
                                    + " miuiRomType=" + publicValue(XposedHelpers.callStaticMethod(device, "l", new Object[]{null}))
                                    + " miuiSystemVersion=" + publicValue(XposedHelpers.callStaticMethod(device, "o"))
                                    + " romType=" + publicValue(XposedHelpers.callStaticMethod(device, "j"))
                                    + " hyperOSVersion=" + publicValue(XposedHelpers.callStaticMethod(device, "k")));
                        } catch (Throwable error) { emit("local read failed=" + error.getClass().getSimpleName()); }
                    }, "WalletTransitMetadata").start();
                }
            });
            emit("enabled; official 1835 verified; metadata only; maximum 160 events");
        } catch (Throwable error) { emit("install failed=" + error.getClass().getSimpleName()); }
    }

    private static XC_MethodHook transportProbe() {
        return new XC_MethodHook() {
            @Override protected void beforeHookedMethod(MethodHookParam call) {
                if (!ENABLED.isFile()) return;
                String route = route(call.args[0]);
                if (route == null) return;
                int id = REQUESTS.incrementAndGet();
                call.setObjectExtra("wallet-transit-id", id);
                try {
                    requestMetadata(id, route, (Map<?, ?>) call.args[1], (Map<?, ?>) call.args[2], call.args[4]);
                } catch (Throwable error) { emit("request id=" + id + " metadata failed=" + error.getClass().getSimpleName()); }
            }
            @Override protected void afterHookedMethod(MethodHookParam call) {
                Object id = call.getObjectExtra("wallet-transit-id");
                if (id == null) return;
                if (call.hasThrowable()) {
                    emit("response id=" + id + " threw=" + call.getThrowable().getClass().getSimpleName());
                    return;
                }
                try {
                    Object result = call.getResult();
                    Object body = result == null ? null : XposedHelpers.callMethod(result, "f");
                    responseMetadata(id, body);
                } catch (Throwable error) { emit("response id=" + id + " metadata failed=" + error.getClass().getSimpleName()); }
            }
        };
    }

    private static void requestMetadata(int id, String route, Map<?, ?> params, Map<?, ?> cookies, Object key) {
        StringBuilder text = new StringBuilder("request id=" + id + " route=" + route);
        for (String field : PUBLIC_FIELDS) text.append(' ').append(field).append('=').append(publicValue(value(params, field)));
        for (String field : new String[]{"deviceId", "cplc", "seId", "orderId", "feeId", "userId"}) {
            text.append(' ').append(field).append('=').append(shape(value(params, field)));
        }
        Object requestId = value(params, "deviceId");
        text.append(" deviceIdMatchesLocal=").append(localDeviceId == null ? "unknown" : localDeviceId.equals(requestId));
        text.append(" cookieUserPresent=").append(present(value(cookies, "userId")));
        text.append(" cookieUserMatchesParam=").append(present(value(cookies, "userId"))
                && value(cookies, "userId").equals(value(params, "userId")));
        text.append(" serviceTokenPresent=").append(present(value(cookies, "serviceToken")));
        text.append(" tokenPresent=").append(present(value(params, "token")));
        text.append(" phPresent=").append(present(value(params, "tsm-auth_ph")) || present(value(cookies, "tsm-auth_ph")));
        text.append(" encryptionKeyPresent=").append(key == null ? "unobserved" : present(key));
        emit(text.toString());
    }
    private static void responseMetadata(Object id, Object body) throws Exception {
        if (!(body instanceof String)) { emit("response id=" + id + " body absent"); return; }
        JSONObject json = new JSONObject((String) body);
        String code = json.has("errCode") ? json.optString("errCode") : json.optString("code", "unknown");
        if (!code.matches("-?[0-9]{1,10}")) code = "unknown";
        emit("response id=" + id + " code=" + code + " dataPresent=" + json.has("data")
                + " errInfoPresent=" + json.has("errInfo"));
    }

    private static String route(Object url) {
        if (!(url instanceof String)) return null;
        if ("https://tsmapi.pay.xiaomi.com/api/login/transferCard/startTransferIn".equals(url)) return "startTransferIn";
        if ("https://tsmapi.pay.xiaomi.com/api/login/sporder/v2/create".equals(url)) return "createOrder";
        return null;
    }
    private static Object value(Map<?, ?> map, String key) { return map == null ? null : map.get(key); }
    private static boolean present(Object value) { return value instanceof String && !((String) value).isEmpty(); }
    private static String shape(Object value) {
        if (!(value instanceof String)) return "absent";
        String text = (String) value;
        return "len:" + text.length() + (text.startsWith("vaid_") ? ":vaid" : "");
    }
    private static String publicValue(Object value) {
        if (!(value instanceof String)) return "absent";
        String text = (String) value;
        if (text.isEmpty()) return "empty";
        return text.matches("[A-Za-z0-9._+\\-]{1,90}") ? text : "unclassified";
    }
    private static void emit(String message) {
        if (ENABLED.isFile() && EVENTS.incrementAndGet() <= 160) {
            Log.i(TAG, message);
            XposedBridge.log(TAG + ": " + message);
        }
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
