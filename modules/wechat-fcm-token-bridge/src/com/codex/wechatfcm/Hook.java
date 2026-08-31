package com.codex.wechatfcm;

import android.app.Application;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.content.pm.SigningInfo;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.security.MessageDigest;
import java.util.Map;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

/**
 * Exact-version diagnostic and one-shot bridge for WeChat's app-owned FCM
 * registration path. Token values and message data are never logged or stored.
 */
public final class Hook implements IXposedHookLoadPackage {
    private static final String WECHAT = "com.tencent.mm";
    private static final long EXPECTED_VERSION_CODE = 3085L;
    private static final String EXPECTED_SIGNER_SHA256 =
            "0fe4ff85c215918396dadc7cd8ce6963339af33d37751a56e54c7206b63a3c7c";
    private static final String CONTROL_FILE =
            "/data/local/tmp/wechat-fcm-token-bridge/rebind.once";
    private static final String LOG_PREFIX = "WechatFcmTokenBridge: ";
    private static final long READINESS_TIMEOUT_MS = 60000L;
    private static final long RETRY_DELAY_MS = 5000L;

    private static final ThreadLocal<Boolean> FORCE_EMPTY_STORED_TOKEN =
            new ThreadLocal<Boolean>();

    private static boolean attachHandled;
    private static boolean hooksInstalled;
    private static boolean rebindHooksInstalled;
    private static boolean snapshotLogged;
    private static boolean actionAttempted;

    @Override
    public void handleLoadPackage(final XC_LoadPackage.LoadPackageParam lpparam) {
        if (!WECHAT.equals(lpparam.packageName) || !WECHAT.equals(lpparam.processName)) {
            return;
        }
        try {
            XposedHelpers.findAndHookMethod(
                    "android.app.Application",
                    lpparam.classLoader,
                    "attach",
                    Context.class,
                    new AttachHook(lpparam.classLoader));
            log("load", "armed", "process=main");
        } catch (Throwable error) {
            logFailure("load", "attach_hook_failed", error);
        }
    }

    private static final class AttachHook extends XC_MethodHook {
        private final ClassLoader loadPackageClassLoader;

        AttachHook(ClassLoader loadPackageClassLoader) {
            this.loadPackageClassLoader = loadPackageClassLoader;
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (attachHandled || !(param.thisObject instanceof Application)) {
                return;
            }
            attachHandled = true;
            Application application = (Application) param.thisObject;
            if (!verifyInstalledBuild(application)) {
                return;
            }
            ClassLoader classLoader = application.getClassLoader();
            if (classLoader == null) {
                classLoader = loadPackageClassLoader;
            }
            installHooks(classLoader);
            if (!hooksInstalled) {
                return;
            }
            new Handler(Looper.getMainLooper()).postDelayed(
                    new ReadinessRunner(application, classLoader, System.currentTimeMillis()),
                    3000L);
        }
    }

    private static boolean verifyInstalledBuild(Application application) {
        try {
            PackageManager packageManager = application.getPackageManager();
            PackageInfo basic = packageManager.getPackageInfo(WECHAT, 0);
            if (basic.getLongVersionCode() != EXPECTED_VERSION_CODE) {
                log("guard", "rejected", "reason=version_mismatch");
                return false;
            }
            PackageInfo signed = packageManager.getPackageInfo(
                    WECHAT, PackageManager.GET_SIGNING_CERTIFICATES);
            SigningInfo signingInfo = signed.signingInfo;
            Signature[] signers = signingInfo == null
                    ? null : signingInfo.getApkContentsSigners();
            if (signers == null || signers.length != 1) {
                log("guard", "rejected", "reason=signer_count");
                return false;
            }
            String digest = toHex(MessageDigest.getInstance("SHA-256")
                    .digest(signers[0].toByteArray()));
            if (!EXPECTED_SIGNER_SHA256.equals(digest)) {
                log("guard", "rejected", "reason=signer_mismatch");
                return false;
            }
            log("guard", "accepted", "version=3085 signer_match=true");
            return true;
        } catch (Throwable error) {
            logFailure("guard", "verification_failed", error);
            return false;
        }
    }

    private static String toHex(byte[] bytes) {
        char[] alphabet = "0123456789abcdef".toCharArray();
        char[] result = new char[bytes.length * 2];
        for (int i = 0; i < bytes.length; i++) {
            int value = bytes[i] & 0xff;
            result[i * 2] = alphabet[value >>> 4];
            result[i * 2 + 1] = alphabet[value & 0x0f];
        }
        return new String(result);
    }

    private static void installHooks(ClassLoader classLoader) {
        if (hooksInstalled) {
            return;
        }
        try {
            XposedHelpers.findAndHookMethod(
                    "x82.f", classLoader, "b", new StoredTokenHook());
            XposedHelpers.findAndHookMethod(
                    "x82.b", classLoader, "c", String.class, new RegisterTokenHook());
            rebindHooksInstalled = true;
        } catch (Throwable error) {
            logFailure("hooks", "required_hook_failed", error);
        }

        installBestEffortHook(classLoader, "x82.b", "a", new InitHook());
        try {
            Class<?> sceneClass = XposedHelpers.findClass(
                    "com.tencent.mm.modelbase.m1", classLoader);
            XposedHelpers.findAndHookMethod(
                    "x82.b", classLoader, "onSceneEnd",
                    int.class, int.class, String.class, sceneClass,
                    new SceneEndHook(classLoader));
        } catch (Throwable error) {
            logFailure("hooks", "scene_result_hook_failed", error);
        }
        try {
            Class<?> networkClass = XposedHelpers.findClass(
                    "com.tencent.mm.network.s", classLoader);
            Class<?> callbackClass = XposedHelpers.findClass(
                    "com.tencent.mm.modelbase.u0", classLoader);
            XposedHelpers.findAndHookMethod(
                    "x82.g", classLoader, "doScene", networkClass, callbackClass,
                    new SceneDispatchHook());
        } catch (Throwable error) {
            logFailure("hooks", "scene_dispatch_hook_failed", error);
        }
        installBestEffortHook(
                classLoader,
                "com.tencent.mm.plugin.fcm.FCMInstanceIDListenerService",
                "e",
                new TokenRefreshHook());
        try {
            Class<?> remoteMessage = XposedHelpers.findClass(
                    "com.google.firebase.messaging.RemoteMessage", classLoader);
            XposedHelpers.findAndHookMethod(
                    "com.tencent.mm.plugin.fcm.WCFirebaseMessagingService",
                    classLoader,
                    "f",
                    remoteMessage,
                    new MessageReceivedHook());
        } catch (Throwable error) {
            logFailure("hooks", "message_callback_hook_failed", error);
        }
        hooksInstalled = true;
        log("hooks", rebindHooksInstalled ? "ready" : "observe_only",
                "privacy=metadata_only");
    }

    private static void installBestEffortHook(
            ClassLoader classLoader, String className, String methodName,
            XC_MethodHook callback) {
        try {
            XposedHelpers.findAndHookMethod(
                    className, classLoader, methodName, callback);
        } catch (Throwable error) {
            logFailure("hooks", methodName + "_hook_failed", error);
        }
    }

    private static final class StoredTokenHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (Boolean.TRUE.equals(FORCE_EMPTY_STORED_TOKEN.get())) {
                param.setResult("");
                log("rebind_compare", "overridden", "scope=current_thread");
            }
        }
    }

    private static final class InitHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            log("firebase_init", "entered", "source=wechat_native");
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("firebase_init", param);
        }
    }

    private static final class RegisterTokenHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            boolean present = param.args != null && param.args.length > 0
                    && param.args[0] instanceof String
                    && !TextUtils.isEmpty((String) param.args[0]);
            log("register_entry", "entered", "token_present=" + present
                    + " rebind_window="
                    + Boolean.TRUE.equals(FORCE_EMPTY_STORED_TOKEN.get()));
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("register_entry", param);
        }
    }

    private static final class SceneDispatchHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            log("scene216_dispatch", "entered", "path=wechat_native");
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("scene216_dispatch", param);
        }
    }

    private static final class SceneEndHook extends XC_MethodHook {
        private final Class<?> registrationSceneClass;

        SceneEndHook(ClassLoader classLoader) {
            registrationSceneClass = XposedHelpers.findClass("x82.g", classLoader);
        }

        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (param.args == null || param.args.length < 4
                    || !registrationSceneClass.isInstance(param.args[3])) {
                return;
            }
            Integer errType = param.args[0] instanceof Integer
                    ? (Integer) param.args[0] : null;
            Integer errCode = param.args[1] instanceof Integer
                    ? (Integer) param.args[1] : null;
            boolean success = errType != null && errCode != null
                    && errType.intValue() == 0 && errCode.intValue() == 0;
            log("scene216_result", success ? "success" : "failure",
                    "err_type=" + safeNumber(errType)
                            + " err_code=" + safeNumber(errCode));
        }
    }

    private static final class TokenRefreshHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            log("firebase_token_callback", "entered", "token_value_logged=false");
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("firebase_token_callback", param);
        }
    }

    private static final class MessageReceivedHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            int keyCount = -1;
            boolean payloadPresent = param.args != null && param.args.length > 0
                    && param.args[0] != null;
            if (payloadPresent) {
                try {
                    Object data = XposedHelpers.callMethod(param.args[0], "D");
                    if (data instanceof Map) {
                        keyCount = ((Map<?, ?>) data).size();
                    }
                } catch (Throwable ignored) {
                    keyCount = -1;
                }
            }
            log("fcm_message_callback", "entered",
                    "payload_present=" + payloadPresent + " key_count=" + keyCount);
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("fcm_message_callback", param);
        }
    }

    private static final class ReadinessRunner implements Runnable {
        private final Application application;
        private final ClassLoader classLoader;
        private final long startedAt;

        ReadinessRunner(Application application, ClassLoader classLoader, long startedAt) {
            this.application = application;
            this.classLoader = classLoader;
            this.startedAt = startedAt;
        }

        @Override
        public void run() {
            if (actionAttempted) {
                return;
            }
            try {
                Snapshot snapshot = readSnapshot(application, classLoader);
                if (!snapshotLogged) {
                    snapshotLogged = true;
                    log("snapshot", "observed",
                            "gms_code=" + snapshot.gmsCode
                                    + " logged_in=" + snapshot.loggedIn
                                    + " current_present=" + snapshot.currentPresent
                                    + " stored_present=" + snapshot.storedPresent
                                    + " token_equal=" + snapshot.tokenEqual
                                    + " reg_age_minutes=" + snapshot.registrationAgeMinutes);
                }

                Control control = readControl();
                if (control == null) {
                    return;
                }
                if (!rebindHooksInstalled) {
                    actionAttempted = true;
                    log("rebind", "rejected", "reason=required_hooks_missing");
                    return;
                }
                if (!snapshot.ready()) {
                    if (System.currentTimeMillis() - startedAt < READINESS_TIMEOUT_MS) {
                        new Handler(Looper.getMainLooper()).postDelayed(this, RETRY_DELAY_MS);
                        log("rebind", "waiting", "reason=prerequisite_not_ready");
                    } else {
                        actionAttempted = true;
                        log("rebind", "rejected", "reason=readiness_timeout");
                    }
                    return;
                }
                if (!snapshot.storedPresent || !snapshot.tokenEqual) {
                    actionAttempted = true;
                    log("rebind", "rejected", "reason=no_equal_token_short_circuit");
                    return;
                }

                actionAttempted = true;
                Class<?> registerClass = XposedHelpers.findClass("x82.b", classLoader);
                Object register = XposedHelpers.callStaticMethod(registerClass, "b");
                if (register == null) {
                    log("rebind", "rejected", "reason=register_instance_missing");
                    return;
                }
                FORCE_EMPTY_STORED_TOKEN.set(Boolean.TRUE);
                try {
                    XposedHelpers.callMethod(register, "c", snapshot.currentToken);
                } finally {
                    FORCE_EMPTY_STORED_TOKEN.remove();
                }
                log("rebind", "accepted", "native_scene=216 one_shot=true");
            } catch (Throwable error) {
                actionAttempted = true;
                logFailure("rebind", "execution_failed", error);
            }
        }
    }

    private static Snapshot readSnapshot(Application application, ClassLoader classLoader)
            throws Throwable {
        Class<?> firebaseInstanceId = XposedHelpers.findClass(
                "com.google.firebase.iid.FirebaseInstanceId", classLoader);
        Object instance = XposedHelpers.callStaticMethod(firebaseInstanceId, "b");
        Object tokenResult = instance == null ? null
                : XposedHelpers.callMethod(instance, "c");
        String current = tokenResult instanceof String ? (String) tokenResult : null;

        Class<?> tokenManager = XposedHelpers.findClass("x82.f", classLoader);
        Object storedResult = XposedHelpers.callStaticMethod(tokenManager, "b");
        String stored = storedResult instanceof String ? (String) storedResult : null;

        Class<?> accountClass = XposedHelpers.findClass("em0.k1", classLoader);
        Object account = XposedHelpers.callStaticMethod(accountClass, "b");
        Object loginResult = account == null ? null : XposedHelpers.callMethod(account, "n");
        boolean loggedIn = Boolean.TRUE.equals(loginResult);

        Class<?> gmsUtil = XposedHelpers.findClass(
                "com.google.android.gms.common.GooglePlayServicesUtil", classLoader);
        Object gmsResult = XposedHelpers.callStaticMethod(
                gmsUtil, "isGooglePlayServicesAvailable", application);
        int gmsCode = gmsResult instanceof Number ? ((Number) gmsResult).intValue() : -1;

        long ageMinutes = -1L;
        try {
            Class<?> storageClass = XposedHelpers.findClass(
                    "com.tencent.mm.sdk.platformtools.o4", classLoader);
            Object storage = XposedHelpers.callStaticMethod(storageClass, "K");
            Object timeResult = XposedHelpers.callMethod(
                    storage, "getLong", "fcm_curr_reg_time", Long.valueOf(0L));
            if (timeResult instanceof Number) {
                long registeredAt = ((Number) timeResult).longValue();
                if (registeredAt > 0L) {
                    ageMinutes = Math.max(0L,
                            (System.currentTimeMillis() - registeredAt) / 60000L);
                }
            }
        } catch (Throwable ignored) {
            ageMinutes = -1L;
        }
        return new Snapshot(current, stored, loggedIn, gmsCode, ageMinutes);
    }

    private static Control readControl() {
        File file = new File(CONTROL_FILE);
        if (!file.isFile() || file.length() <= 0L || file.length() > 512L) {
            return null;
        }
        String action = null;
        String nonce = null;
        long expires = -1L;
        try {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            try {
                String line;
                int lines = 0;
                while ((line = reader.readLine()) != null && lines++ < 8) {
                    if (line.startsWith("action=")) {
                        action = line.substring("action=".length());
                    } else if (line.startsWith("nonce=")) {
                        nonce = line.substring("nonce=".length());
                    } else if (line.startsWith("expires_epoch=")) {
                        expires = Long.parseLong(line.substring("expires_epoch=".length()));
                    }
                }
            } finally {
                reader.close();
            }
        } catch (Throwable error) {
            logFailure("control", "read_failed", error);
            return null;
        }
        long now = System.currentTimeMillis() / 1000L;
        if (!"rebind".equals(action)
                || nonce == null || !nonce.matches("[0-9a-f]{32}")
                || expires < now || expires > now + 300L) {
            log("control", "rejected", "reason=invalid_or_expired");
            return null;
        }
        log("control", "accepted", "action=rebind expiry_valid=true");
        return new Control(expires);
    }

    private static final class Control {
        final long expiresEpoch;

        Control(long expiresEpoch) {
            this.expiresEpoch = expiresEpoch;
        }
    }

    private static final class Snapshot {
        final String currentToken;
        final boolean loggedIn;
        final int gmsCode;
        final boolean currentPresent;
        final boolean storedPresent;
        final boolean tokenEqual;
        final long registrationAgeMinutes;

        Snapshot(String currentToken, String storedToken, boolean loggedIn,
                int gmsCode, long registrationAgeMinutes) {
            this.currentToken = currentToken;
            this.loggedIn = loggedIn;
            this.gmsCode = gmsCode;
            this.currentPresent = !TextUtils.isEmpty(currentToken);
            this.storedPresent = !TextUtils.isEmpty(storedToken);
            this.tokenEqual = currentPresent && storedPresent
                    && currentToken.equals(storedToken);
            this.registrationAgeMinutes = registrationAgeMinutes;
        }

        boolean ready() {
            return loggedIn && gmsCode == 0 && currentPresent;
        }
    }

    private static int safeNumber(Integer value) {
        return value == null ? Integer.MIN_VALUE : value.intValue();
    }

    private static void logOutcome(String event, XC_MethodHook.MethodHookParam param) {
        if (param.hasThrowable()) {
            Throwable error = param.getThrowable();
            log(event, "failure", "error_type="
                    + (error == null ? "unknown" : error.getClass().getName()));
        } else {
            log(event, "completed", "throwable=false");
        }
    }

    private static void logFailure(String event, String reason, Throwable error) {
        String type = error == null ? "unknown" : error.getClass().getName();
        log(event, "failure", "reason=" + reason + " error_type=" + type);
    }

    private static void log(String event, String outcome, String details) {
        XposedBridge.log(LOG_PREFIX + "epoch_ms=" + System.currentTimeMillis()
                + " event=" + event + " outcome=" + outcome + " " + details);
    }
}
