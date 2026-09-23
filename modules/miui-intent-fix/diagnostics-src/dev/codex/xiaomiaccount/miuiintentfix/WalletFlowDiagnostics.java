package dev.codex.xiaomiaccount.miuiintentfix;

import android.os.Bundle;
import android.util.Log;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import java.io.File;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;

/** Called only after WalletDiagnostics verifies the opt-in marker and target APK hash. */
final class WalletFlowDiagnostics {
    private static final File ENABLED = new File("/data/local/tmp/xiaomi-wallet-diagnostics.enabled");
    private static final AtomicInteger EVENTS = new AtomicInteger();

    static void install(ClassLoader loader) {
        hook(loader, "com.miui.tsmclient.model.h1", null);
        hook(loader, "z5.e", null);
        hook(loader, "com.miui.tsmclient.seitsm.a", null);
        hook(loader, "com.miui.tsmclient.ui.za", new String[]{
                "checkBasicFunction", "initUpTsmAddon", "preparePayApplet", "enrollUPBankCard"});
        hook(loader, "com.miui.tsmclient.presenter.s0", new String[]{
                "queryApplyToken", "preparePayApplet", "onModelChanged"});
        hook(loader, "g7.c", new String[]{"J4"});
        hook(loader, "com.unionpay.tsmservice.mi.UPTsmAddon", new String[]{
                "bind", "isConnected", "init"});
        hook(loader, "com.miui.tsmclient.entity.ConfirmBizStatusInfo", new String[]{"upload"});
        hook(loader, "com.miui.tsmclient.model.g", new String[]{"i"});
    }

    private static void hook(ClassLoader loader, String name, String[] names) {
        try {
            Class<?> type = XposedHelpers.findClass(name, loader);
            int count = 0;
            for (Method method : type.getDeclaredMethods()) {
                if (method.isSynthetic() || method.isBridge()) continue;
                if (names != null && !Arrays.asList(names).contains(method.getName())) continue;
                if (names == null && !(method.getReturnType().getName().equals("com.miui.tsmclient.model.h")
                        || method.getReturnType().getName().startsWith("com.miui.tsmclient.seitsm.TsmRpcModels$"))) continue;
                final String stage = name + "." + method.getName();
                XposedBridge.hookMethod(method, new XC_MethodHook() {
                    @Override protected void beforeHookedMethod(MethodHookParam p) {
                        if (!ENABLED.isFile()) return;
                        String meta = "";
                        if (name.equals("com.miui.tsmclient.model.g") && p.args.length == 2) {
                            meta = " event=" + (Integer) p.args[0];
                            if (p.args[1] instanceof Bundle) {
                                Bundle bundle = (Bundle) p.args[1];
                                if (bundle.containsKey("model_result_code"))
                                    meta += " code=" + bundle.getInt("model_result_code");
                            }
                        }
                        if (name.equals("com.miui.tsmclient.entity.ConfirmBizStatusInfo")) {
                            Object op = XposedHelpers.callMethod(p.thisObject, "getCoreOperation");
                            // Never log unknown strings or identifiers.
                            meta = " operation=" + (Arrays.asList("preissue", "pretransferIn", "issue", "transferIn")
                                    .contains(op) ? op : "other");
                        }
                        emit(stage + " enter tid=" + Thread.currentThread().getId() + meta);
                    }
                    @Override protected void afterHookedMethod(MethodHookParam p) {
                        if (!ENABLED.isFile()) return;
                        String result;
                        try {
                            if (p.hasThrowable()) result = "throw=" + p.getThrowable().getClass().getName();
                            else if (p.getResult() instanceof Boolean || p.getResult() instanceof Integer)
                                result = "result=" + p.getResult();
                            else if (p.getResult() != null && p.getResult().getClass().getName().equals("com.miui.tsmclient.model.h"))
                                result = "code=" + XposedHelpers.getIntField(p.getResult(), "a");
                            else if (p.getResult() != null && p.getResult().getClass().getName().startsWith("com.miui.tsmclient.seitsm.TsmRpcModels$")) {
                                Method getter;
                                try { getter = p.getResult().getClass().getMethod("getResult"); }
                                catch (NoSuchMethodException ignored) { getter = null; }
                                result = getter != null && getter.getReturnType() == int.class
                                        ? "code=" + getter.invoke(p.getResult()) : "returned";
                            } else result = "returned";
                        } catch (Throwable ignored) { result = "metadata-unavailable"; }
                        emit(stage + " exit tid=" + Thread.currentThread().getId() + " " + result);
                    }
                });
                count++;
            }
            emit("installed " + name + " methods=" + count);
        } catch (Throwable error) {
            emit("unavailable " + name + " " + error.getClass().getSimpleName());
        }
    }

    private static void emit(String value) {
        if (ENABLED.isFile() && EVENTS.incrementAndGet() <= 1000)
            Log.i("WalletFlowDiagnostic", value);
    }
}
