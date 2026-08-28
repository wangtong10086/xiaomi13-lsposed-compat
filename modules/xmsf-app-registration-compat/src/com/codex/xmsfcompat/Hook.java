package com.codex.xmsfcompat;

import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import dalvik.system.DexClassLoader;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Set;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public final class Hook implements IXposedHookLoadPackage {
    private static final String ALIPAY_PACKAGE = "com.eg.android.AlipayGphone";
    private static final String ALIPAY_PUSH_PROCESS = ALIPAY_PACKAGE + ":push";
    private static final long ALIPAY_VERSION_CODE = 212210L;
    private static final String ANJUKE_PACKAGE = "com.anjuke.android.app";
    private static final long ANJUKE_VERSION_CODE = 322403L;
    private static final String DOUYIN_PACKAGE = "com.ss.android.ugc.aweme";
    private static final long DOUYIN_VERSION_CODE = 400201L;
    private static final String MOBILE_TICKET_PACKAGE = "com.MobileTicket";
    private static final long MOBILE_TICKET_VERSION_CODE = 280L;
    private static final String LIEPIN_PACKAGE = "com.lietou.mishu";
    private static final long LIEPIN_VERSION_CODE = 13081L;
    private static final String TAX_PACKAGE = "cn.gov.tax.its";
    private static final long TAX_VERSION_CODE = 20303L;
    private static final String CCB_PACKAGE = "com.chinamworld.main";
    private static final long CCB_VERSION_CODE = 2351L;
    private static final String VECTOR_PACKAGE = "io.github.magisk317.mipush";
    private static final String VECTOR_VERSION_NAME = "0.6.1";
    private static final String CONTROL_DIR = "/data/local/tmp/xmsf-app-registration-compat/";
    private static final String LOG_PREFIX = "XmsfAppCompat: ";

    private static boolean attachHandled;
    private static boolean callbackHooksInstalled;
    private static boolean bindingHooksInstalled;
    private static boolean lifecycleHooksInstalled;
    private static boolean actionScheduled;
    private static boolean miuiPropertyHooksInstalled;
    private static boolean miuiClassHooksInstalled;
    private static boolean classCaptureInstalled;
    private static volatile Class<?> capturedMiPushClient;

    @Override
    public void handleLoadPackage(final XC_LoadPackage.LoadPackageParam lpparam) {
        if ("android".equals(lpparam.packageName) && "android".equals(lpparam.processName)) {
            installComponentStateGuard(lpparam.classLoader);
            return;
        }
        if (ANJUKE_PACKAGE.equals(lpparam.packageName)
                && ANJUKE_PACKAGE.equals(lpparam.processName)) {
            installGenericRegistrationHook(lpparam, ANJUKE_VERSION_CODE, false);
            return;
        }
        if (DOUYIN_PACKAGE.equals(lpparam.packageName)
                && DOUYIN_PACKAGE.equals(lpparam.processName)) {
            if (requestedAction(DOUYIN_PACKAGE) != null) {
                installStockMiuiPropertyHooks(lpparam.classLoader);
                installDouyinMiuiHooks(lpparam.classLoader);
                installMiPushClassCapture();
            }
            installGenericRegistrationHook(lpparam, DOUYIN_VERSION_CODE, true);
            return;
        }
        long genericVersion = genericVersionCode(lpparam.packageName);
        if (genericVersion > 0L && lpparam.packageName.equals(lpparam.processName)) {
            if (requestedAction(lpparam.packageName) != null) {
                installStockMiuiPropertyHooks(lpparam.classLoader);
                installMiPushClassCapture();
            }
            installGenericRegistrationHook(lpparam, genericVersion, false);
            return;
        }
        if (!ALIPAY_PACKAGE.equals(lpparam.packageName)) {
            return;
        }
        if (!ALIPAY_PACKAGE.equals(lpparam.processName)
                && !ALIPAY_PUSH_PROCESS.equals(lpparam.processName)) {
            return;
        }

        final String action = requestedAction(ALIPAY_PACKAGE);
        if (action == null) {
            return;
        }

        try {
            if (!"observe".equals(action)) {
                installStockMiuiPropertyHooks(lpparam.classLoader);
            }
            XposedHelpers.findAndHookMethod(
                    "android.app.Application",
                    lpparam.classLoader,
                    "attach",
                    Context.class,
                    new AttachHook(lpparam.classLoader, lpparam.processName, action));
            XposedBridge.log(LOG_PREFIX + "bounded hook armed for " + lpparam.processName
                    + " action=" + action);
        } catch (Throwable error) {
            XposedBridge.log(error);
        }
    }

    private static void installGenericRegistrationHook(
            final XC_LoadPackage.LoadPackageParam lpparam,
            final long expectedVersionCode,
            final boolean allowVectorCredential) {
        final String action = requestedAction(lpparam.packageName);
        if (action == null || "observe".equals(action)) {
            return;
        }
        try {
            XposedHelpers.findAndHookMethod(
                    "android.app.Application",
                    lpparam.classLoader,
                    "attach",
                    Context.class,
                    new GenericAttachHook(
                            lpparam.classLoader,
                            lpparam.packageName,
                            expectedVersionCode,
                            action,
                            allowVectorCredential));
            XposedBridge.log(LOG_PREFIX + "bounded generic hook armed for "
                    + lpparam.packageName + " action=" + action);
        } catch (Throwable error) {
            XposedBridge.log(error);
        }
    }

    private static long genericVersionCode(String packageName) {
        if (MOBILE_TICKET_PACKAGE.equals(packageName)) {
            return MOBILE_TICKET_VERSION_CODE;
        }
        if (LIEPIN_PACKAGE.equals(packageName)) {
            return LIEPIN_VERSION_CODE;
        }
        if (TAX_PACKAGE.equals(packageName)) {
            return TAX_VERSION_CODE;
        }
        if (CCB_PACKAGE.equals(packageName)) {
            return CCB_VERSION_CODE;
        }
        return -1L;
    }

    private static void installComponentStateGuard(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod(
                    "com.android.server.pm.PackageManagerService$IPackageManagerImpl",
                    classLoader,
                    "setComponentEnabledSetting",
                    ComponentName.class,
                    int.class,
                    int.class,
                    int.class,
                    String.class,
                    new ComponentStateGuard());
            XposedBridge.log(LOG_PREFIX + "system component-state guard installed");
        } catch (Throwable error) {
            XposedBridge.log(error);
        }
    }

    private static final class ComponentStateGuard extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (param.args.length < 5 || !(param.args[0] instanceof ComponentName)
                    || !(param.args[1] instanceof Integer)) {
                return;
            }
            ComponentName component = (ComponentName) param.args[0];
            int requestedState = ((Integer) param.args[1]).intValue();
            String callingPackage = param.args[4] instanceof String ? (String) param.args[4] : null;
            int callingUid = Binder.getCallingUid();
            if (!ALIPAY_PACKAGE.equals(component.getPackageName())
                    || !ALIPAY_PACKAGE.equals(callingPackage)
                    || callingUid < 10000
                    || !callerUidOwnsAlipay(param.thisObject, callingUid)
                    || !isProtectedPushComponent(component.getClassName())
                    || (requestedState != PackageManager.COMPONENT_ENABLED_STATE_DISABLED
                    && requestedState != PackageManager.COMPONENT_ENABLED_STATE_DISABLED_USER
                    && requestedState != PackageManager.COMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED)) {
                return;
            }
            param.setResult(null);
            XposedBridge.log(LOG_PREFIX + "blocked Alipay push component disable request");
        }
    }

    private static boolean callerUidOwnsAlipay(Object packageManager, int callingUid) {
        try {
            Object result = XposedHelpers.callMethod(
                    packageManager, "getPackagesForUid", Integer.valueOf(callingUid));
            if (!(result instanceof String[])) {
                return false;
            }
            for (String packageName : (String[]) result) {
                if (ALIPAY_PACKAGE.equals(packageName)) {
                    return true;
                }
            }
        } catch (Throwable error) {
            XposedBridge.log(LOG_PREFIX + "caller UID verification failed; allowing request");
        }
        return false;
    }

    private static boolean isProtectedPushComponent(String className) {
        return "com.alipay.pushsdk.thirdparty.xiaomi.XiaoMiMsgReceiver".equals(className)
                || "com.xiaomi.mipush.sdk.PushMessageHandler".equals(className)
                || "com.xiaomi.mipush.sdk.MessageHandleService".equals(className);
    }

    private static String requestedAction(String packageName) {
        if (new File(CONTROL_DIR + packageName + ".unregister.once").isFile()) {
            return "unregister";
        }
        if (new File(CONTROL_DIR + packageName + ".register.once").isFile()) {
            return "register";
        }
        if (new File(CONTROL_DIR + packageName + ".observe.once").isFile()) {
            return "observe";
        }
        return null;
    }

    private static final class GenericAttachHook extends XC_MethodHook {
        private final ClassLoader classLoader;
        private final String packageName;
        private final long expectedVersionCode;
        private final String action;
        private final boolean allowVectorCredential;

        GenericAttachHook(
                ClassLoader classLoader,
                String packageName,
                long expectedVersionCode,
                String action,
                boolean allowVectorCredential) {
            this.classLoader = classLoader;
            this.packageName = packageName;
            this.expectedVersionCode = expectedVersionCode;
            this.action = action;
            this.allowVectorCredential = allowVectorCredential;
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (actionScheduled || !(param.thisObject instanceof Application)) {
                return;
            }
            actionScheduled = true;
            Application application = (Application) param.thisObject;
            Handler handler = new Handler(Looper.getMainLooper());
            handler.postDelayed(
                    new GenericActionRunner(
                            application,
                            classLoader,
                            packageName,
                            expectedVersionCode,
                            action,
                            allowVectorCredential),
                    8000L);
            XposedBridge.log(LOG_PREFIX + "native " + action + " scheduled for " + packageName);
        }
    }

    private static final class GenericActionRunner implements Runnable {
        private static final int MAX_CLASS_LOADER_ATTEMPTS = 12;
        private static boolean completed;
        private static int classLoaderAttempts;
        private static int credentialAttempts;

        private final Application application;
        private final ClassLoader classLoader;
        private final String packageName;
        private final long expectedVersionCode;
        private final String action;
        private final boolean allowVectorCredential;

        GenericActionRunner(
                Application application,
                ClassLoader classLoader,
                String packageName,
                long expectedVersionCode,
                String action,
                boolean allowVectorCredential) {
            this.application = application;
            this.classLoader = classLoader;
            this.packageName = packageName;
            this.expectedVersionCode = expectedVersionCode;
            this.action = action;
            this.allowVectorCredential = allowVectorCredential;
        }

        @Override
        public void run() {
            if (completed) {
                return;
            }
            try {
                PackageInfo packageInfo = application.getPackageManager()
                        .getPackageInfo(packageName, 0);
                if (packageInfo.getLongVersionCode() != expectedVersionCode) {
                    completed = true;
                    XposedBridge.log(LOG_PREFIX + "version guard rejected installed build for "
                            + packageName);
                    return;
                }

                Class<?> miPushClient = resolveMiPushClient();
                if (miPushClient == null) {
                    classLoaderAttempts++;
                    if (classLoaderAttempts < MAX_CLASS_LOADER_ATTEMPTS) {
                        new Handler(Looper.getMainLooper()).postDelayed(this, 5000L);
                        XposedBridge.log(LOG_PREFIX + "waiting for MiPush SDK ClassLoader in "
                                + packageName + " attempt=" + classLoaderAttempts);
                    } else {
                        completed = true;
                        XposedBridge.log(LOG_PREFIX + "MiPush SDK ClassLoader retry exhausted for "
                                + packageName);
                    }
                    return;
                }
                if ("unregister".equals(action)) {
                    XposedHelpers.callStaticMethod(miPushClient, "unregisterPush", application);
                    completed = true;
                    XposedBridge.log(LOG_PREFIX + "native unregister invoked for " + packageName);
                    return;
                }

                String[] credential = resolveAppOwnedCredential(application);
                if (credential == null && allowVectorCredential) {
                    credential = resolveVectorCredential(application, packageName);
                }
                if (credential == null) {
                    credentialAttempts++;
                    if (credentialAttempts < MAX_CLASS_LOADER_ATTEMPTS) {
                        new Handler(Looper.getMainLooper()).postDelayed(this, 5000L);
                        XposedBridge.log(LOG_PREFIX + "waiting for app-owned Xiaomi credential in "
                                + packageName + " attempt=" + credentialAttempts);
                    } else {
                        completed = true;
                        XposedBridge.log(LOG_PREFIX
                                + "approved Xiaomi credential retry exhausted for " + packageName);
                    }
                    return;
                }
                XposedHelpers.callStaticMethod(
                        miPushClient, "registerPush", application, credential[0], credential[1]);
                completed = true;
                XposedBridge.log(LOG_PREFIX + "native register invoked for " + packageName);
            } catch (Throwable error) {
                completed = true;
                XposedBridge.log(LOG_PREFIX + "generic native action failed for " + packageName
                        + " type=" + error.getClass().getName());
            }
        }

        private Class<?> resolveMiPushClient() {
            if (capturedMiPushClient != null) {
                return capturedMiPushClient;
            }
            try {
                return XposedHelpers.findClass(
                        "com.xiaomi.mipush.sdk.MiPushClient", classLoader);
            } catch (Throwable ignored) {
            }
            try {
                return XposedHelpers.findClass(
                        "com.xiaomi.mipush.sdk.MiPushClient", application.getClassLoader());
            } catch (Throwable ignored) {
                return null;
            }
        }

        private static String[] resolveAppOwnedCredential(Application application) {
            SharedPreferences preferences = application.getSharedPreferences("mipush", 0);
            String appId = preferences.getString("appId", null);
            String appKey = preferences.getString("appToken", null);
            if (!TextUtils.isEmpty(appId) && !TextUtils.isEmpty(appKey)) {
                return new String[]{appId, appKey};
            }
            try {
                ApplicationInfo info = application.getPackageManager().getApplicationInfo(
                        application.getPackageName(), PackageManager.GET_META_DATA);
                Bundle metadata = info.metaData;
                if (metadata == null) {
                    return null;
                }
                appId = metadata.getString("com.xiaomi.mipush.sdk.appid");
                appKey = metadata.getString("com.xiaomi.mipush.sdk.appkey");
                if (!TextUtils.isEmpty(appId) && !TextUtils.isEmpty(appKey)) {
                    return new String[]{appId, appKey};
                }
            } catch (Throwable ignored) {
            }
            return null;
        }

        private static String[] resolveVectorCredential(
                Application application, String packageName) {
            File vectorApk = resolveVectorApk(packageName);
            if (vectorApk == null) {
                XposedBridge.log(LOG_PREFIX + "validated Vector APK path unavailable for "
                        + packageName);
                return null;
            }
            try {
                PackageInfo archiveInfo = application.getPackageManager()
                        .getPackageArchiveInfo(vectorApk.getAbsolutePath(), 0);
                if (archiveInfo == null
                        || !VECTOR_PACKAGE.equals(archiveInfo.packageName)
                        || !VECTOR_VERSION_NAME.equals(archiveInfo.versionName)) {
                    XposedBridge.log(LOG_PREFIX + "Vector archive version guard rejected for "
                            + packageName);
                    return null;
                }

                DexClassLoader vectorLoader = new DexClassLoader(
                        vectorApk.getAbsolutePath(),
                        application.getCodeCacheDir().getAbsolutePath(),
                        null,
                        ClassLoader.getSystemClassLoader());
                Class<?> generatedProfiles = vectorLoader.loadClass(
                        "io.github.magisk317.mipush.hook.fakedevice.compat.GeneratedCompatProfiles");
                Object registry = generatedProfiles.getField("INSTANCE").get(null);
                Object profilesValue = generatedProfiles.getMethod("getProfiles").invoke(registry);
                if (!(profilesValue instanceof List)) {
                    return null;
                }
                for (Object profile : (List<?>) profilesValue) {
                    Method getPackageName = profile.getClass().getMethod("getPackageName");
                    if (!packageName.equals(getPackageName.invoke(profile))) {
                        continue;
                    }
                    Object credential = profile.getClass()
                            .getMethod("getCredentialOverride").invoke(profile);
                    if (credential == null) {
                        return null;
                    }
                    String appId = (String) credential.getClass()
                            .getMethod("getAppId").invoke(credential);
                    String appKey = (String) credential.getClass()
                            .getMethod("getAppKey").invoke(credential);
                    if (TextUtils.isEmpty(appId) || TextUtils.isEmpty(appKey)) {
                        return null;
                    }
                    XposedBridge.log(LOG_PREFIX + "Vector credential profile resolved for "
                            + packageName);
                    return new String[]{appId, appKey};
                }
            } catch (Throwable error) {
                XposedBridge.log(LOG_PREFIX + "Vector credential resolution failed for "
                        + packageName + " type=" + error.getClass().getName());
            }
            return null;
        }

        private static File resolveVectorApk(String packageName) {
            File pathFile = new File(CONTROL_DIR + packageName + ".vector-apk.path");
            if (!pathFile.exists()) {
                return null;
            }
            try {
                File linkedApk = validateVectorApkPath(pathFile.getCanonicalPath());
                if (linkedApk != null && !pathFile.getCanonicalPath()
                        .equals(pathFile.getAbsolutePath())) {
                    return linkedApk;
                }
            } catch (Throwable ignored) {
            }
            try (BufferedReader reader = new BufferedReader(new FileReader(pathFile))) {
                return validateVectorApkPath(reader.readLine());
            } catch (Throwable ignored) {
                return null;
            }
        }

        private static File validateVectorApkPath(String path) {
            if (TextUtils.isEmpty(path)
                    || !path.startsWith("/data/app/")
                    || !path.endsWith("/base.apk")) {
                return null;
            }
            File apk = new File(path);
            return apk.isFile() ? apk : null;
        }
    }

    private static void installStockMiuiPropertyHooks(ClassLoader classLoader) {
        if (miuiPropertyHooksInstalled) {
            return;
        }
        StringPropertyHook stringHook = new StringPropertyHook();
        XposedHelpers.findAndHookMethod(
                "android.os.SystemProperties", classLoader, "get", String.class, stringHook);
        XposedHelpers.findAndHookMethod(
                "android.os.SystemProperties", classLoader, "get", String.class, String.class,
                new StringPropertyHook());
        XposedHelpers.findAndHookMethod(
                "android.os.SystemProperties", classLoader, "getInt", String.class, int.class,
                new IntPropertyHook());
        miuiPropertyHooksInstalled = true;
    }

    private static void installDouyinMiuiHooks(ClassLoader classLoader) {
        if (miuiClassHooksInstalled) {
            return;
        }
        try {
            String className = "com.ss.android.socialbase.appdownloader.util.MIUIUtils";
            Class<?> helper = XposedHelpers.findClass(className, classLoader);
            Set<XC_MethodHook.Unhook> miuiHooks = XposedBridge.hookAllMethods(
                    helper, "isMIUI", new BooleanTrueHook());
            Set<XC_MethodHook.Unhook> laterHooks = XposedBridge.hookAllMethods(
                    helper, "isMIUI6Later", new BooleanTrueHook());
            miuiClassHooksInstalled = (miuiHooks != null && !miuiHooks.isEmpty())
                    || (laterHooks != null && !laterHooks.isEmpty());
            XposedBridge.log(LOG_PREFIX + "bounded Douyin MIUI detection hooks installed");
        } catch (Throwable error) {
            XposedBridge.log(LOG_PREFIX + "Douyin MIUI helper unavailable type="
                    + error.getClass().getName());
        }
    }

    private static void installMiPushClassCapture() {
        if (classCaptureInstalled) {
            return;
        }
        try {
            Set<XC_MethodHook.Unhook> ignored = XposedBridge.hookAllMethods(
                    ClassLoader.class, "loadClass", new MiPushClassCaptureHook());
            classCaptureInstalled = ignored != null;
            XposedBridge.log(LOG_PREFIX + "bounded MiPush ClassLoader capture installed");
        } catch (Throwable error) {
            XposedBridge.log(LOG_PREFIX + "MiPush ClassLoader capture failed type="
                    + error.getClass().getName());
        }
    }

    private static final class BooleanTrueHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (!param.hasThrowable()) {
                param.setResult(Boolean.TRUE);
            }
        }
    }

    private static final class MiPushClassCaptureHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (capturedMiPushClient != null || param.hasThrowable()
                    || param.args.length == 0
                    || !"com.xiaomi.mipush.sdk.MiPushClient".equals(param.args[0])) {
                return;
            }
            Object result = param.getResult();
            if (result instanceof Class) {
                capturedMiPushClient = (Class<?>) result;
                XposedBridge.log(LOG_PREFIX + "MiPush SDK ClassLoader captured");
            }
        }
    }

    private static final class StringPropertyHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (param.args.length == 0 || !(param.args[0] instanceof String)) {
                return;
            }
            String key = (String) param.args[0];
            if ("ro.miui.ui.version.name".equals(key)) {
                param.setResult("V816");
            } else if ("ro.miui.ui.version.code".equals(key)) {
                param.setResult("816");
            }
        }
    }

    private static final class IntPropertyHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (param.args.length > 0
                    && "ro.miui.ui.version.code".equals(param.args[0])) {
                param.setResult(Integer.valueOf(816));
            }
        }
    }

    private static final class AttachHook extends XC_MethodHook {
        private final ClassLoader classLoader;
        private final String processName;
        private final String action;

        AttachHook(ClassLoader classLoader, String processName, String action) {
            this.classLoader = classLoader;
            this.processName = processName;
            this.action = action;
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (attachHandled || !(param.thisObject instanceof Application)) {
                return;
            }
            attachHandled = true;
            Application application = (Application) param.thisObject;

            try {
                installCallbackHooks(classLoader);
                installBindingHooks(classLoader);
                installLifecycleHooks(classLoader);
            } catch (Throwable error) {
                XposedBridge.log(error);
            }

            if (!"observe".equals(action)
                    && ALIPAY_PACKAGE.equals(processName)
                    && !actionScheduled) {
                actionScheduled = true;
                Handler handler = new Handler(Looper.getMainLooper());
                handler.postDelayed(new ActionRunner(application, classLoader, action), 8000L);
                XposedBridge.log(LOG_PREFIX + "native " + action + " scheduled");
            }
        }
    }

    private static void installLifecycleHooks(ClassLoader classLoader) {
        if (lifecycleHooksInstalled) {
            return;
        }
        String workerClass = "com.alipay.pushsdk.thirdparty.xiaomi.XiaoMIPushWorker";
        XposedHelpers.findAndHookMethod(
                workerClass, classLoader, "b", Context.class,
                new BindingStageHook("Xiaomi worker connect"));
        XposedHelpers.findAndHookMethod(
                workerClass, classLoader, "c", Context.class,
                new BindingStageHook("Xiaomi worker disconnect-c"));
        XposedHelpers.findAndHookMethod(
                workerClass, classLoader, "d", Context.class,
                new BindingStageHook("Xiaomi worker disconnect-d"));
        XposedHelpers.findAndHookMethod(
                workerClass, classLoader, "r", Context.class,
                new LifecycleDecisionHook());
        lifecycleHooksInstalled = true;
        XposedBridge.log(LOG_PREFIX + "Alipay Xiaomi worker lifecycle diagnostics installed");
    }

    private static final class LifecycleDecisionHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (param.hasThrowable()) {
                logOutcome("Alipay Xiaomi environment decision", param);
                return;
            }
            Object result = param.getResult();
            if (result instanceof Boolean) {
                XposedBridge.log(LOG_PREFIX + "Alipay Xiaomi environment supported=" + result);
            } else {
                XposedBridge.log(LOG_PREFIX + "Alipay Xiaomi environment decision missing result");
            }
        }
    }

    private static void installCallbackHooks(ClassLoader classLoader) {
        if (callbackHooksInstalled) {
            return;
        }
        Class<?> messageClass = XposedHelpers.findClass(
                "com.xiaomi.mipush.sdk.MiPushCommandMessage", classLoader);
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.xiaomi.XiaoMiMsgReceiver",
                classLoader,
                "onCommandResult",
                Context.class,
                messageClass,
                new RegisterCallbackHook());
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.xiaomi.XiaoMiMsgReceiver",
                classLoader,
                "onTokenAfter",
                Context.class,
                String.class,
                new TokenBindingHook());
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.xiaomi.XiaoMiMsgReceiver",
                classLoader,
                "onTokenBefore",
                Context.class,
                String.class,
                new TokenBindingHook());
        callbackHooksInstalled = true;
        XposedBridge.log(LOG_PREFIX + "Alipay callback hooks installed");
    }

    private static final class RegisterCallbackHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            try {
                Object message = param.args[1];
                Object command = XposedHelpers.callMethod(message, "getCommand");
                Object result = XposedHelpers.callMethod(message, "getResultCode");
                if ("register".equals(command)
                        && result instanceof Number
                        && ((Number) result).longValue() == 0L) {
                    XposedBridge.log(LOG_PREFIX + "native register command callback succeeded");
                }
            } catch (Throwable error) {
                XposedBridge.log(error);
            }
        }
    }

    private static final class TokenBindingHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            String methodName = "token callback";
            if (param.method instanceof Method) {
                methodName = ((Method) param.method).getName();
            }
            logOutcome("Alipay " + methodName, param);
        }
    }

    private static void installBindingHooks(ClassLoader classLoader) {
        if (bindingHooksInstalled) {
            return;
        }

        Class<?> workerInterface = XposedHelpers.findClass(
                "com.alipay.pushsdk.thirdparty.ITPPushWorker", classLoader);
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.push.PushRegisterAndBindManager",
                classLoader,
                "onNewTokenEvent",
                Context.class,
                workerInterface,
                String.class,
                new BindingStageHook("onNewTokenEvent"));
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.push.PushRegisterAndBindManager",
                classLoader,
                "syncToken",
                Context.class,
                String.class,
                String.class,
                new SyncTokenHook());
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.push.PushTokenRegAndBindOptManager",
                classLoader,
                "c",
                String.class,
                String.class,
                String.class,
                String.class,
                Bundle.class,
                int.class,
                new BindingStageHook("optimized token-bind enqueue"));
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.AbsTPPushWorker",
                classLoader,
                "t",
                Context.class,
                String.class,
                Bundle.class,
                new BindingStageHook("manufacturer token-bind RPC"));
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.AbsTPPushWorker",
                classLoader,
                "u",
                Context.class,
                String.class,
                Bundle.class,
                new BindingStageHook("manufacturer token-bind local RPC"));
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.thirdparty.AbsTPPushWorker",
                classLoader,
                "v",
                Context.class,
                String.class,
                Bundle.class,
                new BindingStageHook("manufacturer token-bind main-process RPC"));
        Class<?> tokenBindCallback = XposedHelpers.findClass(
                "com.alipay.pushsdk.push.ITokenBindCallback", classLoader);
        Class<?> tokenBindModel = XposedHelpers.findClass(
                "com.alipay.pushsdk.push.TokenBindModel", classLoader);
        XposedHelpers.findAndHookMethod(
                "com.alipay.pushsdk.push.TokenBindService",
                classLoader,
                "p",
                tokenBindCallback,
                int.class,
                tokenBindModel,
                new TokenBindResultHook());
        bindingHooksInstalled = true;
        XposedBridge.log(LOG_PREFIX + "Alipay token-binding diagnostics installed");
    }

    private static final class BindingStageHook extends XC_MethodHook {
        private final String stage;

        BindingStageHook(String stage) {
            this.stage = stage;
        }

        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            XposedBridge.log(LOG_PREFIX + "Alipay " + stage + " entered");
        }

        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            logOutcome("Alipay " + stage, param);
        }
    }

    private static final class SyncTokenHook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            if (param.hasThrowable()) {
                logOutcome("Alipay syncToken", param);
                return;
            }
            Object result = param.getResult();
            if (result instanceof boolean[] && ((boolean[]) result).length >= 2) {
                boolean[] flags = (boolean[]) result;
                XposedBridge.log(LOG_PREFIX + "Alipay syncToken completed stored="
                        + flags[0] + " bindAlreadyRunning=" + flags[1]);
                return;
            }
            XposedBridge.log(LOG_PREFIX + "Alipay syncToken completed without status flags");
        }
    }

    private static final class TokenBindResultHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            Object status = param.args.length > 1 ? param.args[1] : null;
            if (status instanceof Number) {
                XposedBridge.log(LOG_PREFIX + "Alipay token-bind callback status="
                        + ((Number) status).intValue());
            } else {
                XposedBridge.log(LOG_PREFIX + "Alipay token-bind callback missing status");
            }
        }
    }

    private static void logOutcome(String stage, XC_MethodHook.MethodHookParam param) {
        if (!param.hasThrowable()) {
            XposedBridge.log(LOG_PREFIX + stage + " completed");
            return;
        }
        Throwable throwable = param.getThrowable();
        String type = throwable == null ? "unknown" : throwable.getClass().getName();
        XposedBridge.log(LOG_PREFIX + stage + " failed type=" + type);
    }

    private static final class ActionRunner implements Runnable {
        private static boolean attempted;

        private final Application application;
        private final ClassLoader classLoader;
        private final String action;

        ActionRunner(Application application, ClassLoader classLoader, String action) {
            this.application = application;
            this.classLoader = classLoader;
            this.action = action;
        }

        @Override
        public void run() {
            if (attempted) {
                return;
            }
            attempted = true;

            try {
                PackageInfo packageInfo = application.getPackageManager()
                        .getPackageInfo(ALIPAY_PACKAGE, 0);
                if (packageInfo.getLongVersionCode() != ALIPAY_VERSION_CODE) {
                    XposedBridge.log(LOG_PREFIX + "version guard rejected installed Alipay build");
                    return;
                }

                Class<?> miPushClient = XposedHelpers.findClass(
                        "com.xiaomi.mipush.sdk.MiPushClient", classLoader);
                if ("register".equals(action)) {
                    Class<?> workerBase = XposedHelpers.findClass(
                            "com.alipay.pushsdk.thirdparty.AbsTPPushWorker", classLoader);
                    String appId = (String) XposedHelpers.callStaticMethod(
                            workerBase, "k", application, "com.xiaomi.mipush.sdk.appid");
                    String appKey = (String) XposedHelpers.callStaticMethod(
                            workerBase, "k", application, "com.xiaomi.mipush.sdk.appkey");
                    if (TextUtils.isEmpty(appId) || TextUtils.isEmpty(appKey)) {
                        XposedBridge.log(LOG_PREFIX + "app-owned Xiaomi credential metadata unavailable");
                        return;
                    }
                    XposedHelpers.callStaticMethod(
                            miPushClient, "registerPush", application, appId, appKey);
                } else {
                    XposedHelpers.callStaticMethod(miPushClient, "unregisterPush", application);
                }
                XposedBridge.log(LOG_PREFIX + "native " + action + " invoked");
            } catch (Throwable error) {
                XposedBridge.log(error);
            }
        }
    }
}
