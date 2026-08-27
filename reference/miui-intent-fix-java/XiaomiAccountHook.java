package dev.codex.xiaomiaccount.miuiintentfix;

import android.accounts.Account;
import android.accounts.AccountAuthenticatorResponse;
import android.accounts.AccountManager;
import android.accounts.AccountManagerFuture;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.database.ContentObserver;
import android.nfc.NfcAdapter;
import android.nfc.Tag;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.UserHandle;
import android.provider.Settings;
import android.view.KeyEvent;
import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XC_MethodReplacement;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

/* JADX INFO: loaded from: classes.dex */
public final class XiaomiAccountHook implements IXposedHookLoadPackage {
    private static final String ACCOUNT_PACKAGE = "com.xiaomi.account";
    private static final String ESE_ROUTING_ENABLED_SETTING = "codex_xiaomi_ese_routing_enabled";
    private static final long ESE_ROUTING_RECONCILE_DELAY_MS = 100;
    private static final String GOOGLE_WALLET_PACKAGE = "com.google.android.apps.walletnfcrel";
    private static final String LEGACY_POWER_GESTURE_SCRIPT = "/data/adb/service.d/94-wallet-button-shortcuts.sh";
    private static final String NFC_DISABLE_SWITCH = "/data/local/tmp/disable-xiaomi-nfc-hook";
    private static final String NFC_SERVICE_PACKAGE = "com.android.nfc";
    private static final long POWER_GESTURE_COMMIT_DELAY_MS = 310;
    private static final String POWER_GESTURE_DECISION_EXTRA = "xiaomi_power_wallet_decision";
    private static final String POWER_GESTURE_DISABLE_SWITCH = "/data/local/tmp/disable-xiaomi-power-wallet-hook";
    private static final PowerWalletGestureController POWER_WALLET_GESTURES;
    private static final String SECURE_ELEMENT_PACKAGE = "com.android.se";
    private static final String SE_DISABLE_SWITCH = "/data/local/tmp/disable-xiaomi-se-hook";
    private static final String TAG = "XiaomiAccountMiuiIntentFix";
    private static final String TSM_AUTH_PH_CACHE = "/data/local/tmp/xiaomi-tsm-auth-ph";
    private static final String TSM_CARD_ACTIVATE_RECORD = "TSM_CARD_ACTIVATE_RECORD";
    private static final XiaomiEseRoutingController XIAOMI_ESE_ROUTING;
    private static volatile String lastStartTransferInOrderId;
    private static volatile String lastTsmAuthPh;
    private static volatile Object lastValidTsmAccountInfo;
    private static final String TSM_PACKAGE = "com.miui.tsmclient";
    private static final String[] XIAOMI_SE_CLIENTS = {TSM_PACKAGE, "com.mipay.wallet", "com.xiaomi.payment", "com.unionpay.tsmservice.mi"};
    private static final String[] XIAOMI_NFC_CLIENTS = {TSM_PACKAGE};

    static {
        POWER_WALLET_GESTURES = new PowerWalletGestureController();
        XIAOMI_ESE_ROUTING = new XiaomiEseRoutingController();
    }

    public void handleLoadPackage(XC_LoadPackage.LoadPackageParam loadPackageParam) {
        if ("android".equals(loadPackageParam.packageName) && "android".equals(loadPackageParam.processName)) {
            installSystemPowerWalletGestureHook(loadPackageParam.classLoader);
            return;
        }
        if (NFC_SERVICE_PACKAGE.equals(loadPackageParam.packageName) && NFC_SERVICE_PACKAGE.equals(loadPackageParam.processName)) {
            installXiaomiEseRoutingHook(loadPackageParam.classLoader);
            return;
        }
        if (SECURE_ELEMENT_PACKAGE.equals(loadPackageParam.packageName)) {
            installSecureElementHook(loadPackageParam.classLoader);
            return;
        }
        if (TSM_PACKAGE.equals(loadPackageParam.packageName)) {
            installTsmAccountPhHook(loadPackageParam.classLoader);
            installTsmAccountValidationProbe(loadPackageParam.classLoader);
            installStartTransferInDiagnostics(loadPackageParam.classLoader);
            installConfirmBizStatusDiagnostics(loadPackageParam.classLoader);
            installTransferCardModelDiagnostics(loadPackageParam.classLoader);
            installTsmNfcForegroundDispatchFix(loadPackageParam.classLoader);
        }
        if (isXiaomiNfcClient(loadPackageParam.packageName)) {
            installXiaomiNfcHook(loadPackageParam.classLoader, loadPackageParam.packageName);
            return;
        }
        if (ACCOUNT_PACKAGE.equals(loadPackageParam.packageName)) {
            log("loaded for process=" + loadPackageParam.processName);
            hookReturnInt(loadPackageParam.classLoader, "b6.h0", "a", 0, true, Intent.class);
            hookReturnInt(loadPackageParam.classLoader, "b6.m1", "b", 0, false, Intent.class);
            hookReturnInt(loadPackageParam.classLoader, "pa.c", "a", 0, false, Intent.class);
            hookNoOp(loadPackageParam.classLoader, "b6.m1", "a", false, Intent.class, Integer.TYPE);
            hookReturnObject(loadPackageParam.classLoader, "com.xiaomi.security.devicecredential.c", "c", false, false, new Object[0]);
            hookReturnObject(loadPackageParam.classLoader, "com.xiaomi.security.devicecredential.c", "a", "", false, new Object[0]);
            hookReturnObject(loadPackageParam.classLoader, "com.xiaomi.security.devicecredential.c", "g", new byte[0], false, byte[].class);
            hookNoOp(loadPackageParam.classLoader, "com.xiaomi.security.devicecredential.c", "d", false, new Object[0]);
            hookReturnObject(loadPackageParam.classLoader, "i4.c$b", "c", null, false, Context.class);
            hookReturnObject(loadPackageParam.classLoader, "i4.c", "d", null, false, Context.class);
            hookNoOp(loadPackageParam.classLoader, "i4.c$b", "a", false, Context.class);
            hookNoOp(loadPackageParam.classLoader, "i4.c", "a", false, Context.class);
            installXiaomiAccountTsmPhHook(loadPackageParam.classLoader);
        }
    }

    private static void installSystemPowerWalletGestureHook(ClassLoader classLoader) {
        if (!isPowerGestureHookDisabled()) {
            try {
                XposedHelpers.findAndHookMethod("com.android.server.GestureLauncherService", classLoader, "handleWalletGesture", new Object[]{new XC_MethodReplacement() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.1
                    protected Object replaceHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) throws Throwable {
                        if (XiaomiAccountHook.isPowerGestureHookDisabled()) {
                            XiaomiAccountHook.POWER_WALLET_GESTURES.cancelAndReset("hook_disabled");
                            return XposedBridge.invokeOriginalMethod(methodHookParam.method, methodHookParam.thisObject, methodHookParam.args);
                        }
                        try {
                            return Boolean.valueOf(Boolean.TRUE.equals(XposedHelpers.callMethod(methodHookParam.thisObject, "isUserSetupComplete", new Object[0])));
                        } catch (Throwable th) {
                            XiaomiAccountHook.log("system power wallet suppression failed: " + XiaomiAccountHook.describeThrowable(th));
                            XposedBridge.log(th);
                            return XposedBridge.invokeOriginalMethod(methodHookParam.method, methodHookParam.thisObject, methodHookParam.args);
                        }
                    }
                }});
                XposedHelpers.findAndHookMethod("com.android.server.GestureLauncherService", classLoader, "interceptPowerKeyDown", new Object[]{"android.view.KeyEvent", Boolean.TYPE, "android.util.MutableBoolean", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.2
                    protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                        try {
                            if (XiaomiAccountHook.isPowerGestureHookDisabled()) {
                                XiaomiAccountHook.POWER_WALLET_GESTURES.cancelAndReset("hook_disabled");
                                return;
                            }
                            boolean booleanField = XposedHelpers.getBooleanField(methodHookParam.thisObject, "mWalletDoubleTapPowerEnabled");
                            boolean zEquals = Boolean.TRUE.equals(XposedHelpers.callMethod(methodHookParam.thisObject, "isUserSetupComplete", new Object[0]));
                            if (booleanField && zEquals) {
                                KeyEvent keyEvent = (KeyEvent) methodHookParam.args[0];
                                PowerGestureStateMachine.Decision decisionOnPowerKeyDown = XiaomiAccountHook.POWER_WALLET_GESTURES.onPowerKeyDown(methodHookParam.thisObject, keyEvent.getEventTime(), keyEvent.isLongPress());
                                methodHookParam.setObjectExtra(XiaomiAccountHook.POWER_GESTURE_DECISION_EXTRA, decisionOnPowerKeyDown);
                                XiaomiAccountHook.log("power gesture eventTime=" + keyEvent.getEventTime() + " deviceId=" + keyEvent.getDeviceId() + " flags=0x" + Integer.toHexString(keyEvent.getFlags()) + " taps=" + decisionOnPowerKeyDown.tapCount + " action=" + decisionOnPowerKeyDown.action);
                                return;
                            }
                            XiaomiAccountHook.POWER_WALLET_GESTURES.cancelAndReset(booleanField ? "user_setup_incomplete" : "wallet_setting_disabled");
                        } catch (Throwable th) {
                            XiaomiAccountHook.POWER_WALLET_GESTURES.cancelAndReset("event_hook_failure");
                            XiaomiAccountHook.log("system power gesture observation failed: " + XiaomiAccountHook.describeThrowable(th));
                            XposedBridge.log(th);
                        }
                    }

                    protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                        try {
                            PowerGestureStateMachine.Decision decision = (PowerGestureStateMachine.Decision) methodHookParam.getObjectExtra(XiaomiAccountHook.POWER_GESTURE_DECISION_EXTRA);
                            if (decision != null && decision.consumePowerKey) {
                                XposedHelpers.setBooleanField(methodHookParam.args[2], "value", true);
                                methodHookParam.setResult(true);
                            }
                        } catch (Throwable th) {
                            XiaomiAccountHook.log("system power gesture interception failed: " + XiaomiAccountHook.describeThrowable(th));
                            XposedBridge.log(th);
                        }
                    }
                }});
                log("hooked system power gestures: double=Xiaomi cards, triple=Google Wallet");
                return;
            } catch (Throwable th) {
                log("critical system power wallet gesture hook failed");
                XposedBridge.log(th);
                return;
            }
        }
        log("system power wallet hook disabled by safety switch or legacy script conflict");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isPowerGestureHookDisabled() {
        return new File(POWER_GESTURE_DISABLE_SWITCH).exists() || new File(LEGACY_POWER_GESTURE_SCRIPT).exists();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean launchXiaomiCardUi(Object obj) {
        Context context = (Context) XposedHelpers.getObjectField(obj, "mContext");
        int intField = XposedHelpers.getIntField(obj, "mUserId");
        ComponentName componentName = new ComponentName(TSM_PACKAGE, "com.miui.tsmclient.ui.quick.DoubleClickActivity");
        Intent intent = new Intent("com.miui.intent.action.DOUBLE_CLICK");
        intent.addCategory("android.intent.category.DEFAULT");
        intent.setComponent(componentName);
        intent.addFlags(880803840);
        if (!isActivityAvailable(context, componentName)) {
            log("power gesture target unavailable action=xiaomi_cards component=" + componentName);
            return false;
        }
        startActivityAsUser(context, intent, intField);
        log("power gesture committed action=xiaomi_cards user=" + intField + " component=" + componentName);
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean launchGoogleWallet(Object obj) {
        Context context = (Context) XposedHelpers.getObjectField(obj, "mContext");
        int intField = XposedHelpers.getIntField(obj, "mUserId");
        ComponentName componentName = new ComponentName(GOOGLE_WALLET_PACKAGE, "com.google.commerce.tapandpay.android.wallet.WalletActivity");
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory("android.intent.category.LAUNCHER");
        intent.setComponent(componentName);
        intent.addFlags(872415232);
        if (!isActivityAvailable(context, componentName)) {
            log("power gesture target unavailable action=google_wallet component=" + componentName);
            return false;
        }
        startActivityAsUser(context, intent, intField);
        log("power gesture committed action=google_wallet user=" + intField + " component=" + componentName);
        return true;
    }

    private static boolean isActivityAvailable(Context context, ComponentName componentName) {
        try {
            ActivityInfo activityInfo = context.getPackageManager().getActivityInfo(componentName, 0);
            return activityInfo.enabled && activityInfo.applicationInfo != null && activityInfo.applicationInfo.enabled;
        } catch (Throwable th) {
            log("power gesture component validation failed component=" + componentName + " error=" + describeThrowable(th));
            return false;
        }
    }

    private static void startActivityAsUser(Context context, Intent intent, int i) {
        XposedHelpers.callMethod(context, "startActivityAsUser", new Object[]{intent, XposedHelpers.callStaticMethod(UserHandle.class, "of", new Object[]{Integer.valueOf(i)})});
    }

    private static final class PowerWalletGestureController {
        private long generation;
        private Handler handler;
        private final Object lock;
        private PowerGestureStateMachine.Action pendingAction;
        private Runnable pendingCommit;
        private final PowerGestureStateMachine stateMachine;

        private PowerWalletGestureController() {
            this.lock = new Object();
            this.stateMachine = new PowerGestureStateMachine(300L);
            this.pendingAction = PowerGestureStateMachine.Action.NONE;
        }

        PowerGestureStateMachine.Decision onPowerKeyDown(Object obj, long j, boolean z) {
            PowerGestureStateMachine.Decision decisionOnPowerDown;
            synchronized (this.lock) {
                decisionOnPowerDown = this.stateMachine.onPowerDown(j, z);
                switch (decisionOnPowerDown.action) {
                    case SCHEDULE_XIAOMI:
                    case SCHEDULE_GOOGLE:
                        scheduleCommitLocked(obj, decisionOnPowerDown.action, decisionOnPowerDown.tapCount);
                        break;
                    case CANCEL_WALLETS:
                        cancelPendingLocked("tap_count_" + decisionOnPowerDown.tapCount);
                        break;
                }
            }
            return decisionOnPowerDown;
        }

        void cancelAndReset(String str) {
            synchronized (this.lock) {
                this.stateMachine.reset();
                cancelPendingLocked(str);
            }
        }

        private void scheduleCommitLocked(final Object obj, final PowerGestureStateMachine.Action action, int i) {
            cancelPendingLocked("superseded_by_tap_" + i);
            if (this.handler == null) {
                this.handler = new Handler(Looper.getMainLooper());
            }
            final long j = this.generation + 1;
            this.generation = j;
            this.pendingAction = action;
            this.pendingCommit = new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.PowerWalletGestureController.1
                @Override // java.lang.Runnable
                public void run() {
                    synchronized (PowerWalletGestureController.this.lock) {
                        if (PowerWalletGestureController.this.pendingCommit == this && PowerWalletGestureController.this.generation == j) {
                            PowerWalletGestureController.this.pendingCommit = null;
                            PowerWalletGestureController.this.pendingAction = PowerGestureStateMachine.Action.NONE;
                            if (XiaomiAccountHook.isPowerGestureHookDisabled()) {
                                XiaomiAccountHook.log("power gesture commit skipped token=" + j + " reason=hook_disabled");
                                return;
                            }
                            try {
                                if (action == PowerGestureStateMachine.Action.SCHEDULE_XIAOMI) {
                                    XiaomiAccountHook.launchXiaomiCardUi(obj);
                                } else if (action == PowerGestureStateMachine.Action.SCHEDULE_GOOGLE) {
                                    XiaomiAccountHook.launchGoogleWallet(obj);
                                }
                            } catch (Throwable th) {
                                XiaomiAccountHook.log("power gesture commit failed token=" + j + " action=" + action + " error=" + XiaomiAccountHook.describeThrowable(th));
                                XposedBridge.log(th);
                            }
                        }
                    }
                }
            };
            this.handler.postDelayed(this.pendingCommit, XiaomiAccountHook.POWER_GESTURE_COMMIT_DELAY_MS);
            XiaomiAccountHook.log("power gesture scheduled token=" + j + " taps=" + i + " action=" + action + " delayMs=" + XiaomiAccountHook.POWER_GESTURE_COMMIT_DELAY_MS);
        }

        private void cancelPendingLocked(String str) {
            if (this.handler != null && this.pendingCommit != null) {
                this.handler.removeCallbacks(this.pendingCommit);
                XiaomiAccountHook.log("power gesture cancelled token=" + this.generation + " action=" + this.pendingAction + " reason=" + str);
            }
            this.pendingCommit = null;
            this.pendingAction = PowerGestureStateMachine.Action.NONE;
            this.generation++;
        }
    }

    private static void installXiaomiEseRoutingHook(ClassLoader classLoader) {
        try {
            XposedBridge.hookAllConstructors(XposedHelpers.findClass("com.android.nfc.NfcService", classLoader), new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.3
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if (methodHookParam.args.length == 0 || !(methodHookParam.args[0] instanceof Context)) {
                        XiaomiAccountHook.log("eSE routing controller attach skipped: NfcService context unavailable");
                    } else {
                        XiaomiAccountHook.XIAOMI_ESE_ROUTING.attach((Context) methodHookParam.args[0], methodHookParam.thisObject);
                    }
                }
            });
            XposedHelpers.findAndHookMethod("com.android.nfc.cardemulation.CardEmulationManager", classLoader, "onNfcEnabled", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.4
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.XIAOMI_ESE_ROUTING.onNfcEnabled(methodHookParam.thisObject);
                }
            }});
            XposedHelpers.findAndHookMethod("com.android.nfc.cardemulation.CardEmulationManager", classLoader, "onNfcDisabled", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.5
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.XIAOMI_ESE_ROUTING.onNfcDisabled(methodHookParam.thisObject);
                }
            }});
            XposedHelpers.findAndHookMethod("com.android.nfc.cardemulation.CardEmulationManager", classLoader, "onRoutingChangeCompleted", new Object[]{Integer.TYPE, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.6
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.XIAOMI_ESE_ROUTING.onFrameworkRoutingChangeCompleted();
                }
            }});
            Class clsFindClass = XposedHelpers.findClass("com.android.nfc.cardemulation.RoutingOptionManager", classLoader);
            XposedBridge.hookAllMethods(clsFindClass, "recoverOverridedRoutingTable", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.7
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.XIAOMI_ESE_ROUTING.onFrameworkRecovery();
                }
            });
            XposedBridge.hookAllMethods(clsFindClass, "overwriteRoutingTable", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.8
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.XIAOMI_ESE_ROUTING.onFrameworkRoutingOptionsOverwritten();
                }
            });
            log("hooked Android 16 Xiaomi eSE routing controller");
        } catch (Throwable th) {
            log("critical Android 16 eSE routing hook failed: " + describeThrowable(th));
            XposedBridge.log(th);
        }
    }

    private static final class XiaomiEseRoutingController {
        private Object cardEmulationManager;
        private Context context;
        private String deferredTrigger;
        private Object deviceHost;
        private volatile long frameworkRoutingMutationGeneration;
        private long generation;
        private Handler handler;
        private volatile boolean internalRoutingOperation;
        private final Object lock;
        private long nfcCycleGeneration;
        private boolean nfcReady;
        private boolean operationInFlight;
        private RoutingDefaultsSnapshot ownedRoutingDefaults;
        private Runnable pendingReconcile;
        private ExecutorService routingExecutor;
        private ContentObserver settingsObserver;
        private final EseRoutingStateMachine stateMachine;

        private XiaomiEseRoutingController() {
            this.lock = new Object();
            this.stateMachine = new EseRoutingStateMachine();
        }

        void attach(Context context, Object obj) {
            synchronized (this.lock) {
                if (this.context != null) {
                    return;
                }
                this.context = context.getApplicationContext();
                this.handler = new Handler(Looper.getMainLooper());
                this.routingExecutor = Executors.newSingleThreadExecutor(new ThreadFactory() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.1
                    @Override // java.util.concurrent.ThreadFactory
                    public Thread newThread(Runnable runnable) {
                        Thread thread = new Thread(runnable, "XiaomiEseRouting");
                        thread.setDaemon(true);
                        return thread;
                    }
                });
                try {
                    this.cardEmulationManager = XposedHelpers.getObjectField(obj, "mCardEmulationManager");
                    this.deviceHost = XposedHelpers.getObjectField(obj, "mDeviceHost");
                } catch (Throwable th) {
                    XiaomiAccountHook.log("eSE routing initial manager lookup deferred: " + XiaomiAccountHook.describeThrowable(th));
                }
                try {
                    this.settingsObserver = new ContentObserver(this.handler) { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.2
                        @Override // android.database.ContentObserver
                        public void onChange(boolean z) {
                            XiaomiEseRoutingController.this.scheduleReconcile("secure_setting_changed");
                        }
                    };
                    this.context.getContentResolver().registerContentObserver(Settings.Secure.getUriFor(XiaomiAccountHook.TSM_CARD_ACTIVATE_RECORD), false, this.settingsObserver);
                    this.context.getContentResolver().registerContentObserver(Settings.Secure.getUriFor(XiaomiAccountHook.ESE_ROUTING_ENABLED_SETTING), false, this.settingsObserver);
                    XiaomiAccountHook.log("eSE routing controller attached; observing TSM_CARD_ACTIVATE_RECORD and codex_xiaomi_ese_routing_enabled");
                } catch (Throwable th2) {
                    XiaomiAccountHook.log("eSE routing settings observer unavailable: " + XiaomiAccountHook.describeThrowable(th2));
                    XposedBridge.log(th2);
                }
            }
        }

        void onNfcEnabled(Object obj) {
            synchronized (this.lock) {
                this.cardEmulationManager = obj;
                this.nfcReady = true;
                this.nfcCycleGeneration++;
                this.stateMachine.onNfcCycleReset();
                scheduleReconcileLocked("nfc_enabled");
            }
        }

        void onNfcDisabled(Object obj) {
            synchronized (this.lock) {
                if (this.cardEmulationManager == null) {
                    this.cardEmulationManager = obj;
                }
                this.nfcReady = false;
                this.nfcCycleGeneration++;
                this.deferredTrigger = null;
                cancelPendingLocked("nfc_disabled");
                this.stateMachine.onNfcCycleReset();
                this.ownedRoutingDefaults = null;
                XiaomiAccountHook.log("eSE routing runtime state reset because NFC was disabled");
            }
        }

        void onFrameworkRecovery() {
            if (this.internalRoutingOperation) {
                return;
            }
            synchronized (this.lock) {
                this.stateMachine.onExternalRecovery();
                scheduleReconcileLocked("framework_routing_recovered");
            }
        }

        void onFrameworkRoutingOptionsOverwritten() {
            synchronized (this.lock) {
                this.frameworkRoutingMutationGeneration++;
                if (this.internalRoutingOperation) {
                    this.deferredTrigger = "framework_routing_overwritten_during_apply";
                    XiaomiAccountHook.log("eSE routing detected concurrent framework routing overwrite");
                } else {
                    this.stateMachine.onExternalRecovery();
                    this.ownedRoutingDefaults = null;
                    scheduleReconcileLocked("framework_routing_overwritten");
                }
            }
        }

        void onFrameworkRoutingChangeCompleted() {
            if (this.internalRoutingOperation) {
                return;
            }
            synchronized (this.lock) {
                scheduleReconcileLocked("framework_routing_change_completed");
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void scheduleReconcile(String str) {
            synchronized (this.lock) {
                scheduleReconcileLocked(str);
            }
        }

        private void scheduleReconcileLocked(final String str) {
            if (this.handler == null) {
                return;
            }
            if (this.pendingReconcile != null) {
                this.handler.removeCallbacks(this.pendingReconcile);
            }
            final long j = this.generation + 1;
            this.generation = j;
            this.pendingReconcile = new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.3
                @Override // java.lang.Runnable
                public void run() {
                    synchronized (XiaomiEseRoutingController.this.lock) {
                        if (XiaomiEseRoutingController.this.pendingReconcile == this && j == XiaomiEseRoutingController.this.generation) {
                            XiaomiEseRoutingController.this.pendingReconcile = null;
                            try {
                                XiaomiEseRoutingController.this.reconcileLocked(str, j);
                            } catch (Throwable th) {
                                XiaomiAccountHook.log("eSE routing reconcile failed closed token=" + j + " trigger=" + str + " error=" + XiaomiAccountHook.describeThrowable(th));
                                XposedBridge.log(th);
                            }
                        }
                    }
                }
            };
            this.handler.postDelayed(this.pendingReconcile, XiaomiAccountHook.ESE_ROUTING_RECONCILE_DELAY_MS);
        }

        private void cancelPendingLocked(String str) {
            if (this.handler != null && this.pendingReconcile != null) {
                this.handler.removeCallbacks(this.pendingReconcile);
                XiaomiAccountHook.log("eSE routing reconcile cancelled token=" + this.generation + " reason=" + str);
            }
            this.pendingReconcile = null;
            this.generation++;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void reconcileLocked(String str, long j) {
            if (this.context == null || this.cardEmulationManager == null) {
                XiaomiAccountHook.log("eSE routing reconcile deferred token=" + j + " trigger=" + str + " reason=manager_unavailable");
                return;
            }
            if (this.operationInFlight) {
                this.deferredTrigger = str;
                XiaomiAccountHook.log("eSE routing reconcile deferred token=" + j + " trigger=" + str + " reason=operation_in_flight");
            }
            String string = Settings.Secure.getString(this.context.getContentResolver(), XiaomiAccountHook.TSM_CARD_ACTIVATE_RECORD);
            boolean z = Settings.Secure.getInt(this.context.getContentResolver(), XiaomiAccountHook.ESE_ROUTING_ENABLED_SETTING, 1) != 0;
            boolean zIsTsmInstalledAndEnabled = isTsmInstalledAndEnabled();
            try {
                Object objectField = XposedHelpers.getObjectField(this.cardEmulationManager, "mRoutingOptionManager");
                if (XposedHelpers.getObjectField(this.cardEmulationManager, "mRoutingChangeFuture") != null) {
                    this.deferredTrigger = str;
                    XiaomiAccountHook.log("eSE routing reconcile deferred token=" + j + " trigger=" + str + " reason=framework_routing_in_flight");
                    scheduleReconcileLocked("framework_routing_in_flight");
                    return;
                }
                int iIntValue = ((Number) XposedHelpers.callMethod(objectField, "getRouteForSecureElement", new Object[]{"eSE1"})).intValue();
                EseRouteResolver.Result resultResolve = EseRouteResolver.resolve(iIntValue, fetchActiveNfcees(), this.context.getPackageManager().hasSystemFeature("com.nxp.mifare"), this.context.getPackageManager().hasSystemFeature("android.hardware.nfc.ese"));
                EseRoutingStateMachine.Decision decisionReconcile = this.stateMachine.reconcile(string, z, zIsTsmInstalledAndEnabled, resultResolve.isAvailable(), this.nfcReady, XposedHelpers.getIntField(this.cardEmulationManager, "mForegroundUid") != -1);
                XiaomiAccountHook.log("eSE routing reconcile token=" + j + " trigger=" + str + " action=" + decisionReconcile.action + " reason=" + decisionReconcile.reason + " frameworkRoute=0x" + Integer.toHexString(iIntValue) + " resolvedRoute=0x" + Integer.toHexString(resultResolve.route) + " routeReason=" + resultResolve.reason + " owned=" + this.stateMachine.ownsRouting());
                switch (decisionReconcile.action) {
                    case APPLY:
                        submitApplyLocked(this.cardEmulationManager, objectField, resultResolve.route, decisionReconcile, this.nfcCycleGeneration);
                        break;
                    case RECOVER:
                        submitRecoveryLocked(this.cardEmulationManager, objectField, decisionReconcile.reason, this.nfcCycleGeneration);
                        break;
                }
            } catch (Throwable th) {
                XiaomiAccountHook.log("eSE routing reflection failed token=" + j + " trigger=" + str + " error=" + XiaomiAccountHook.describeThrowable(th));
                XposedBridge.log(th);
            }
        }

        private void submitApplyLocked(final Object obj, final Object obj2, final int i, final EseRoutingStateMachine.Decision decision, final long j) {
            this.operationInFlight = true;
            try {
                this.routingExecutor.execute(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.4
                    @Override // java.lang.Runnable
                    public void run() {
                        final ApplyRoutingResult applyRoutingResultPerformApplyRouting = XiaomiEseRoutingController.this.performApplyRouting(obj, obj2, i, decision);
                        XiaomiEseRoutingController.this.handler.post(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.4.1
                            @Override // java.lang.Runnable
                            public void run() {
                                synchronized (XiaomiEseRoutingController.this.lock) {
                                    XiaomiEseRoutingController.this.operationInFlight = false;
                                    if (!XiaomiEseRoutingController.this.nfcReady || j != XiaomiEseRoutingController.this.nfcCycleGeneration) {
                                        XiaomiEseRoutingController.this.stateMachine.onNfcCycleReset();
                                        XiaomiEseRoutingController.this.ownedRoutingDefaults = null;
                                    } else {
                                        XiaomiEseRoutingController.this.stateMachine.onApplyResult(decision, applyRoutingResultPerformApplyRouting.success, applyRoutingResultPerformApplyRouting.recoverySucceeded);
                                        if (applyRoutingResultPerformApplyRouting.success) {
                                            XiaomiEseRoutingController.this.ownedRoutingDefaults = applyRoutingResultPerformApplyRouting.originalDefaults;
                                        } else if (applyRoutingResultPerformApplyRouting.recoverySucceeded) {
                                            XiaomiEseRoutingController.this.ownedRoutingDefaults = null;
                                        }
                                    }
                                    XiaomiEseRoutingController.this.scheduleAfterOperationLocked("apply_complete");
                                }
                            }
                        });
                    }
                });
            } catch (Throwable th) {
                this.operationInFlight = false;
                this.stateMachine.onApplyResult(decision, false, true);
                XiaomiAccountHook.log("eSE routing worker rejected apply: " + XiaomiAccountHook.describeThrowable(th));
                scheduleAfterOperationLocked("apply_worker_rejected");
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        /* JADX WARN: Code duplicated, block: B:33:0x014e A[PHI: r11 r13
  0x014e: PHI (r11v2 dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot) =
  (r11v1 dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot)
  (r11v4 dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot)
 binds: [B:32:0x014c, B:23:0x010e] A[DONT_GENERATE, DONT_INLINE]
  0x014e: PHI (r13v2 boolean) = (r13v1 boolean), (r13v14 boolean) binds: [B:32:0x014c, B:23:0x010e] A[DONT_GENERATE, DONT_INLINE]] */
        public ApplyRoutingResult performApplyRouting(Object obj, Object obj2, int i, EseRoutingStateMachine.Decision decision) {
            boolean z;
            RoutingDefaultsSnapshot routingDefaultsSnapshotCapture;
            long j = this.frameworkRoutingMutationGeneration;
            boolean zRecoverRoutingInternal = true;
            this.internalRoutingOperation = true;
            try {
                routingDefaultsSnapshotCapture = RoutingDefaultsSnapshot.capture(obj2);
                try {
                    if (j != this.frameworkRoutingMutationGeneration) {
                        throw new IllegalStateException("framework routing changed while defaults were captured");
                    }
                    int iIntValue = ((Number) XposedHelpers.callMethod(obj2, "getDefaultFelicaRoute", new Object[0])).intValue();
                    XposedHelpers.callMethod(obj2, "overrideDefaultRoute", new Object[]{Integer.valueOf(i)});
                    XposedHelpers.callMethod(obj2, "overrideDefaultIsoDepRoute", new Object[]{Integer.valueOf(i)});
                    XposedHelpers.callMethod(obj2, "overrideDefaultTechRoute", new Object[]{Integer.valueOf(i), Integer.valueOf(iIntValue)});
                    int iCommitRouting = commitRouting(obj);
                    if (iCommitRouting == 0) {
                        z = true;
                    } else {
                        z = false;
                    }
                    if (z) {
                        try {
                            if (j != this.frameworkRoutingMutationGeneration || !routingDefaultsSnapshotCapture.matches(obj2)) {
                                XiaomiAccountHook.log("eSE routing apply rejected because framework defaults changed during transient override original=" + routingDefaultsSnapshotCapture.describe() + " current=" + RoutingDefaultsSnapshot.capture(obj2).describe());
                                z = false;
                            }
                        } catch (Throwable th) {
                            th = th;
                            try {
                                XiaomiAccountHook.log("eSE routing apply failed record=" + decision.record.fingerprint() + " error=" + XiaomiAccountHook.describeThrowable(th));
                                XposedBridge.log(th);
                                if (!z) {
                                    zRecoverRoutingInternal = recoverRoutingInternal(obj, obj2, "apply_failure", routingDefaultsSnapshotCapture);
                                }
                            } catch (Throwable th2) {
                                if (!z) {
                                    recoverRoutingInternal(obj, obj2, "apply_failure", routingDefaultsSnapshotCapture);
                                }
                                this.internalRoutingOperation = false;
                                throw th2;
                            }
                        }
                    }
                    if (!z) {
                        XiaomiAccountHook.log("eSE routing commit rejected result=" + iCommitRouting + " record=" + decision.record.fingerprint());
                    } else {
                        XiaomiAccountHook.log("eSE routing applied record=" + decision.record.fingerprint() + " type=" + decision.record.type + " eSE=0x" + Integer.toHexString(i) + " felica=0x" + Integer.toHexString(iIntValue));
                    }
                    if (!z) {
                        zRecoverRoutingInternal = recoverRoutingInternal(obj, obj2, "apply_failure", routingDefaultsSnapshotCapture);
                    }
                    this.internalRoutingOperation = false;
                    return new ApplyRoutingResult(z, zRecoverRoutingInternal, z ? routingDefaultsSnapshotCapture : null);
                } catch (Throwable th3) {
                    th = th3;
                    z = false;
                }
            } catch (Throwable th4) {
                th = th4;
                z = false;
                routingDefaultsSnapshotCapture = null;
            }
        }

        private void submitRecoveryLocked(final Object obj, final Object obj2, final String str, final long j) {
            XiaomiEseRoutingController xiaomiEseRoutingController;
            this.operationInFlight = true;
            try {
                xiaomiEseRoutingController = this;
                try {
                    this.routingExecutor.execute(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.5
                        @Override // java.lang.Runnable
                        public void run() {
                            XiaomiEseRoutingController.this.internalRoutingOperation = true;
                            try {
                                final boolean zRecoverRoutingInternal = XiaomiEseRoutingController.this.recoverRoutingInternal(obj, obj2, str, XiaomiEseRoutingController.this.ownedRoutingDefaults);
                                XiaomiEseRoutingController.this.internalRoutingOperation = false;
                                XiaomiEseRoutingController.this.handler.post(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.XiaomiEseRoutingController.5.1
                                    @Override // java.lang.Runnable
                                    public void run() {
                                        synchronized (XiaomiEseRoutingController.this.lock) {
                                            XiaomiEseRoutingController.this.operationInFlight = false;
                                            if (!XiaomiEseRoutingController.this.nfcReady || j != XiaomiEseRoutingController.this.nfcCycleGeneration) {
                                                XiaomiEseRoutingController.this.stateMachine.onNfcCycleReset();
                                                XiaomiEseRoutingController.this.ownedRoutingDefaults = null;
                                            } else {
                                                XiaomiEseRoutingController.this.stateMachine.onRecoverResult(zRecoverRoutingInternal);
                                                if (zRecoverRoutingInternal) {
                                                    XiaomiEseRoutingController.this.ownedRoutingDefaults = null;
                                                }
                                            }
                                            XiaomiEseRoutingController.this.scheduleAfterOperationLocked("recovery_complete");
                                        }
                                    }
                                });
                            } catch (Throwable th) {
                                XiaomiEseRoutingController.this.internalRoutingOperation = false;
                                throw th;
                            }
                        }
                    });
                } catch (Throwable th) {
                    th = th;
                    xiaomiEseRoutingController.operationInFlight = false;
                    xiaomiEseRoutingController.stateMachine.onRecoverResult(false);
                    XiaomiAccountHook.log("eSE routing worker rejected recovery: " + XiaomiAccountHook.describeThrowable(th));
                    scheduleAfterOperationLocked("recovery_worker_rejected");
                }
            } catch (Throwable th2) {
                th = th2;
                xiaomiEseRoutingController = this;
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public void scheduleAfterOperationLocked(String str) {
            if (this.deferredTrigger != null) {
                str = this.deferredTrigger;
            }
            this.deferredTrigger = null;
            if (this.nfcReady) {
                scheduleReconcileLocked(str);
            }
        }

        /* JADX INFO: Access modifiers changed from: private */
        public boolean recoverRoutingInternal(Object obj, Object obj2, String str, RoutingDefaultsSnapshot routingDefaultsSnapshot) {
            if (routingDefaultsSnapshot != null) {
                try {
                    if (routingDefaultsSnapshot.restoreIfChanged(obj2)) {
                        XiaomiAccountHook.log("eSE routing restored in-memory framework defaults before recovery " + routingDefaultsSnapshot.describe());
                    }
                } catch (Throwable th) {
                    XiaomiAccountHook.log("eSE routing recovery failed reason=" + str + " error=" + XiaomiAccountHook.describeThrowable(th));
                    XposedBridge.log(th);
                    return false;
                }
            }
            XposedHelpers.callMethod(obj2, "recoverOverridedRoutingTable", new Object[0]);
            int iCommitRouting = commitRouting(obj);
            if (iCommitRouting != 0) {
                XiaomiAccountHook.log("eSE routing recovery rejected reason=" + str + " result=" + iCommitRouting);
                return false;
            }
            XiaomiAccountHook.log("eSE routing recovered native defaults reason=" + str);
            return true;
        }

        private int commitRouting(Object obj) {
            Object objCallMethod = XposedHelpers.callMethod(obj, "callRoutingOverridedOrRecovered", new Object[0]);
            if (objCallMethod instanceof Number) {
                return ((Number) objCallMethod).intValue();
            }
            return 2;
        }

        private Map<String, Integer> fetchActiveNfcees() {
            if (this.deviceHost == null) {
                throw new IllegalStateException("NFC device host unavailable");
            }
            try {
                Object objCallMethod = XposedHelpers.callMethod(this.deviceHost, "dofetchActiveNfceeList", new Object[0]);
                if (!(objCallMethod instanceof Map)) {
                    throw new IllegalStateException("active NFCEE result is not a Map");
                }
                return (Map) objCallMethod;
            } catch (Throwable th) {
                throw new IllegalStateException("active NFCEE query failed", th);
            }
        }

        private static final class ApplyRoutingResult {
            final RoutingDefaultsSnapshot originalDefaults;
            final boolean recoverySucceeded;
            final boolean success;

            ApplyRoutingResult(boolean z, boolean z2, RoutingDefaultsSnapshot routingDefaultsSnapshot) {
                this.success = z;
                this.recoverySucceeded = z2;
                this.originalDefaults = routingDefaultsSnapshot;
            }
        }

        private static final class RoutingDefaultsSnapshot {
            final int defaultRoute;
            final int felicaRoute;
            final int isoDepRoute;
            final int offHostRoute;
            final int systemCodeRoute;

            RoutingDefaultsSnapshot(int i, int i2, int i3, int i4, int i5) {
                this.defaultRoute = i;
                this.isoDepRoute = i2;
                this.offHostRoute = i3;
                this.felicaRoute = i4;
                this.systemCodeRoute = i5;
            }

            static RoutingDefaultsSnapshot capture(Object obj) {
                return new RoutingDefaultsSnapshot(XposedHelpers.getIntField(obj, "mDefaultRoute"), XposedHelpers.getIntField(obj, "mDefaultIsoDepRoute"), XposedHelpers.getIntField(obj, "mDefaultOffHostRoute"), XposedHelpers.getIntField(obj, "mDefaultFelicaRoute"), XposedHelpers.getIntField(obj, "mDefaultScRoute"));
            }

            boolean matches(Object obj) {
                return this.defaultRoute == XposedHelpers.getIntField(obj, "mDefaultRoute") && this.isoDepRoute == XposedHelpers.getIntField(obj, "mDefaultIsoDepRoute") && this.offHostRoute == XposedHelpers.getIntField(obj, "mDefaultOffHostRoute") && this.felicaRoute == XposedHelpers.getIntField(obj, "mDefaultFelicaRoute") && this.systemCodeRoute == XposedHelpers.getIntField(obj, "mDefaultScRoute");
            }

            boolean restoreIfChanged(Object obj) {
                if (matches(obj)) {
                    return false;
                }
                XposedHelpers.setIntField(obj, "mDefaultRoute", this.defaultRoute);
                XposedHelpers.setIntField(obj, "mDefaultIsoDepRoute", this.isoDepRoute);
                XposedHelpers.setIntField(obj, "mDefaultOffHostRoute", this.offHostRoute);
                XposedHelpers.setIntField(obj, "mDefaultFelicaRoute", this.felicaRoute);
                XposedHelpers.setIntField(obj, "mDefaultScRoute", this.systemCodeRoute);
                return true;
            }

            String describe() {
                return "{aid=0x" + Integer.toHexString(this.defaultRoute) + ",iso=0x" + Integer.toHexString(this.isoDepRoute) + ",ab=0x" + Integer.toHexString(this.offHostRoute) + ",f=0x" + Integer.toHexString(this.felicaRoute) + ",sc=0x" + Integer.toHexString(this.systemCodeRoute) + "}";
            }
        }

        private boolean isTsmInstalledAndEnabled() {
            try {
                return this.context.getPackageManager().getApplicationInfo(XiaomiAccountHook.TSM_PACKAGE, 0).enabled;
            } catch (Throwable th) {
                return false;
            }
        }
    }

    private static void installXiaomiAccountTsmPhHook(final ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("com.xiaomi.passport.accountmanager.e", classLoader, "h", new Object[]{"com.xiaomi.accounts.AccountAuthenticatorResponse", Account.class, String.class, Bundle.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.9
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if ("tsm-auth".equals((String) methodHookParam.args[2])) {
                        Bundle bundleAsBundle = XiaomiAccountHook.asBundle(methodHookParam.getResult());
                        if (bundleAsBundle == null) {
                            XiaomiAccountHook.log("Xiaomi Account own tsm-auth result is " + XiaomiAccountHook.describeObject(methodHookParam.getResult()));
                        } else if (XiaomiAccountHook.injectOwnAccountPh(classLoader, methodHookParam.thisObject, (Account) methodHookParam.args[1], bundleAsBundle)) {
                            methodHookParam.setResult(bundleAsBundle);
                        }
                    }
                }
            }});
            log("hooked Xiaomi Account own tsm-auth ph injection");
        } catch (Throwable th) {
            log("critical Xiaomi Account own tsm-auth ph hook failed");
            XposedBridge.log(th);
        }
        try {
            XposedHelpers.findAndHookMethod("v3.c", classLoader, "getAuthToken", new Object[]{AccountAuthenticatorResponse.class, Account.class, String.class, Bundle.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.10
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if (!"tsm-auth".equals((String) methodHookParam.args[2])) {
                        return;
                    }
                    Object result = methodHookParam.getResult();
                    if (!(result instanceof Bundle)) {
                        XiaomiAccountHook.log("Xiaomi Account tsm-auth result is " + XiaomiAccountHook.describeObject(result));
                        return;
                    }
                    Bundle bundle = (Bundle) result;
                    if (!XiaomiAccountHook.isEmpty(bundle.getString("ph"))) {
                        XiaomiAccountHook.log("Xiaomi Account tsm-auth already has ph");
                        return;
                    }
                    try {
                        Account account = (Account) methodHookParam.args[1];
                        Object objectField = XposedHelpers.getObjectField(methodHookParam.thisObject, "a");
                        if (!(objectField instanceof Context)) {
                            objectField = XposedHelpers.getObjectField(methodHookParam.thisObject, "mContext");
                        }
                        if ((objectField instanceof Context) && account != null) {
                            String userData = AccountManager.get(((Context) objectField).getApplicationContext()).getUserData(account, "tsm-auth_ph");
                            if (XiaomiAccountHook.isEmpty(userData)) {
                                XiaomiAccountHook.log("Xiaomi Account tsm-auth_ph missing in userData");
                                return;
                            }
                            bundle.putString("ph", userData);
                            methodHookParam.setResult(bundle);
                            XiaomiAccountHook.log("Xiaomi Account tsm-auth ph injected, length=" + userData.length());
                            return;
                        }
                        XiaomiAccountHook.log("Xiaomi Account tsm-auth ph skipped: no context/account");
                    } catch (Throwable th2) {
                        XiaomiAccountHook.log("Xiaomi Account tsm-auth ph injection failed: " + XiaomiAccountHook.describeThrowable(th2));
                    }
                }
            }});
            log("hooked Xiaomi Account tsm-auth ph injection");
        } catch (Throwable th2) {
            log("critical Xiaomi Account tsm-auth ph hook failed");
            XposedBridge.log(th2);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean injectOwnAccountPh(ClassLoader classLoader, Object obj, Account account, Bundle bundle) {
        if (!isEmpty(bundle.getString("ph"))) {
            log("Xiaomi Account own tsm-auth already has ph");
            return false;
        }
        try {
            Object objectField = XposedHelpers.getObjectField(obj, "c");
            if ((objectField instanceof Context) && account != null) {
                String str = (String) XposedHelpers.callMethod(XposedHelpers.callStaticMethod(XposedHelpers.findClass("com.xiaomi.passport.accountmanager.i", classLoader), "x", new Object[]{((Context) objectField).getApplicationContext()}), "getUserData", new Object[]{account, "tsm-auth_ph"});
                if (isEmpty(str)) {
                    log("Xiaomi Account own tsm-auth_ph missing in userData");
                    return false;
                }
                bundle.putString("ph", str);
                log("Xiaomi Account own tsm-auth ph injected, length=" + str.length());
                return true;
            }
            log("Xiaomi Account own tsm-auth ph skipped: no context/account");
            return false;
        } catch (Throwable th) {
            log("Xiaomi Account own tsm-auth ph injection failed: " + describeThrowable(th));
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Bundle asBundle(Object obj) {
        if (obj instanceof Bundle) {
            return (Bundle) obj;
        }
        return null;
    }

    private static void installTsmAccountPhHook(final ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("w4.d$b", classLoader, "run", new Object[]{AccountManagerFuture.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.11
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Object obj = methodHookParam.args[0];
                    if (obj == null) {
                        return;
                    }
                    try {
                        Object objCallMethod = XposedHelpers.callMethod(obj, "getResult", new Object[0]);
                        if (!(objCallMethod instanceof Bundle)) {
                            XiaomiAccountHook.log("TSM auth future result is " + XiaomiAccountHook.describeObject(objCallMethod));
                            return;
                        }
                        Bundle bundle = (Bundle) objCallMethod;
                        String string = bundle.getString("ph");
                        if (XiaomiAccountHook.isEmpty(string)) {
                            string = bundle.getString("encrypted_ph");
                        }
                        if (XiaomiAccountHook.isEmpty(string)) {
                            string = bundle.getString("phoneHash");
                        }
                        if (XiaomiAccountHook.isEmpty(string)) {
                            XiaomiAccountHook.log("TSM auth bundle has no ph, keys=" + bundle.keySet());
                        } else {
                            String unused = XiaomiAccountHook.lastTsmAuthPh = string;
                            XiaomiAccountHook.log("TSM auth ph captured, length=" + string.length() + ", keys=" + bundle.keySet());
                        }
                    } catch (Throwable th) {
                        XiaomiAccountHook.log("TSM auth future probe failed: " + XiaomiAccountHook.describeThrowable(th));
                    }
                }
            }});
            XposedHelpers.findAndHookMethod("w4.d", classLoader, "h", new Object[]{Context.class, String.class, Boolean.TYPE, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.12
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if ("tsm-auth".equals((String) methodHookParam.args[1])) {
                        String unused = XiaomiAccountHook.lastTsmAuthPh = null;
                    }
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Object result = methodHookParam.getResult();
                    String str = (String) methodHookParam.args[1];
                    if (result == null && "tsm-auth".equals(str)) {
                        Object staticTsmAccountInfo = XiaomiAccountHook.lastValidTsmAccountInfo;
                        if (staticTsmAccountInfo == null) {
                            staticTsmAccountInfo = XiaomiAccountHook.readStaticTsmAccountInfo(classLoader);
                        }
                        if (XiaomiAccountHook.isValidAccountInfo(staticTsmAccountInfo)) {
                            methodHookParam.setResult(staticTsmAccountInfo);
                            XiaomiAccountHook.log("TSM AccountInfo reused valid cache after null result");
                            return;
                        }
                        return;
                    }
                    if (result != null) {
                        if (!XiaomiAccountHook.isEmpty((String) XposedHelpers.callMethod(result, "c", new Object[0]))) {
                            if (XiaomiAccountHook.isValidAccountInfo(result)) {
                                Object unused = XiaomiAccountHook.lastValidTsmAccountInfo = result;
                                return;
                            }
                            return;
                        }
                        String tsmAuthPhCache = XiaomiAccountHook.lastTsmAuthPh;
                        if (XiaomiAccountHook.isEmpty(tsmAuthPhCache)) {
                            tsmAuthPhCache = XiaomiAccountHook.readXiaomiAccountUserDataPh((Context) methodHookParam.args[0], (String) methodHookParam.args[1]);
                        }
                        if (XiaomiAccountHook.isEmpty(tsmAuthPhCache)) {
                            tsmAuthPhCache = XiaomiAccountHook.readTsmAuthPhCache();
                        }
                        if (XiaomiAccountHook.isEmpty(tsmAuthPhCache)) {
                            XiaomiAccountHook.log("TSM AccountInfo ph still empty; no captured or cached ph");
                            return;
                        }
                        XposedHelpers.setObjectField(result, "e", tsmAuthPhCache);
                        XiaomiAccountHook.log("TSM AccountInfo ph filled, length=" + tsmAuthPhCache.length() + ", valid=" + XiaomiAccountHook.describeAccountInfoValidity(result));
                        if (XiaomiAccountHook.isValidAccountInfo(result)) {
                            Object unused2 = XiaomiAccountHook.lastValidTsmAccountInfo = result;
                        }
                    }
                }
            }});
            log("hooked TSM account ph compatibility");
        } catch (Throwable th) {
            log("critical TSM account ph hook failed");
            XposedBridge.log(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Object readStaticTsmAccountInfo(ClassLoader classLoader) {
        try {
            Object staticObjectField = XposedHelpers.getStaticObjectField(XposedHelpers.findClass("w4.d", classLoader), "a");
            if (isValidAccountInfo(staticObjectField)) {
                log("TSM AccountInfo loaded from w4.d static cache");
                return staticObjectField;
            }
            return null;
        } catch (Throwable th) {
            log("TSM static AccountInfo read failed: " + describeThrowable(th));
            return null;
        }
    }

    private static void installTsmAccountValidationProbe(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("n6.e", classLoader, "L", new Object[]{Context.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.13
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM BizStatus account validation threw " + XiaomiAccountHook.describeThrowable(throwable));
                    } else {
                        XiaomiAccountHook.log("TSM BizStatus account validation result=" + XiaomiAccountHook.describeAccountInfoValidity(methodHookParam.getResult()));
                    }
                }
            }});
            log("hooked TSM BizStatus account validation probe");
        } catch (Throwable th) {
            log("optional TSM BizStatus validation probe failed");
            XposedBridge.log(th);
        }
    }

    private static void installStartTransferInDiagnostics(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookConstructor("n6.f2", classLoader, new Object[]{Context.class, "com.miui.tsmclient.entity.PayableCardInfo", "e5.i", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.14
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM startTransferIn constructed params=" + XiaomiAccountHook.describeRequestParams(methodHookParam.thisObject) + ", card=" + XiaomiAccountHook.describeCardInfo(methodHookParam.args[1]));
                }
            }});
            log("hooked TSM startTransferIn constructor diagnostics");
        } catch (Throwable th) {
            log("optional TSM startTransferIn constructor diagnostics failed");
            XposedBridge.log(th);
        }
        try {
            XposedHelpers.findAndHookMethod("h5.a", classLoader, "e", new Object[]{String.class, String.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.15
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if (!XiaomiAccountHook.isStartTransferInRequest(methodHookParam.thisObject)) {
                        return;
                    }
                    String strValueOf = String.valueOf(methodHookParam.args[0]);
                    String strNormalizeStartTransferParam = XiaomiAccountHook.normalizeStartTransferParam(strValueOf, (String) methodHookParam.args[1]);
                    if (strNormalizeStartTransferParam != methodHookParam.args[1]) {
                        methodHookParam.args[1] = strNormalizeStartTransferParam;
                    }
                    if ("orderId".equals(strValueOf) && !XiaomiAccountHook.isEmpty(strNormalizeStartTransferParam)) {
                        String unused = XiaomiAccountHook.lastStartTransferInOrderId = strNormalizeStartTransferParam;
                    }
                    XiaomiAccountHook.log("TSM startTransferIn param " + strValueOf + "=" + XiaomiAccountHook.sanitizeStartTransferParam(strValueOf, strNormalizeStartTransferParam));
                }
            }});
            log("hooked TSM startTransferIn param diagnostics");
        } catch (Throwable th2) {
            log("optional TSM startTransferIn param diagnostics failed");
            XposedBridge.log(th2);
        }
        try {
            XposedHelpers.findAndHookMethod("n6.f2", classLoader, "b", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.16
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM startTransferIn extra params threw " + XiaomiAccountHook.describeThrowable(throwable));
                    } else {
                        XiaomiAccountHook.log("TSM startTransferIn ready params=" + XiaomiAccountHook.describeRequestParams(methodHookParam.thisObject));
                    }
                }
            }});
            log("hooked TSM startTransferIn extra-param diagnostics");
        } catch (Throwable th3) {
            log("optional TSM startTransferIn extra-param diagnostics failed");
            XposedBridge.log(th3);
        }
        try {
            XposedHelpers.findAndHookMethod("h5.f$a", classLoader, "d", new Object[]{"c5.a", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.17
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Object obj = methodHookParam.args[0];
                    if (obj != null && obj.getClass().getName().equals("com.miui.tsmclient.entity.OrderResponseInfo")) {
                        XiaomiAccountHook.log("TSM startTransferIn response=" + XiaomiAccountHook.describeCommonResponse(obj) + ", order=" + XiaomiAccountHook.describeOrderResponse(obj));
                    }
                }
            }});
            log("hooked TSM startTransferIn response diagnostics");
        } catch (Throwable th4) {
            log("optional TSM startTransferIn response diagnostics failed");
            XposedBridge.log(th4);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isStartTransferInRequest(Object obj) {
        return obj != null && "n6.f2".equals(obj.getClass().getName());
    }

    private static void installConfirmBizStatusDiagnostics(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.entity.ConfirmBizStatusInfo", classLoader, "upload", new Object[]{Context.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.18
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.repairShenzhenTransferConfirm(methodHookParam.thisObject);
                    XiaomiAccountHook.log("TSM confirm upload begin " + XiaomiAccountHook.describeConfirmBizStatus(methodHookParam.thisObject));
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM confirm upload threw " + XiaomiAccountHook.describeThrowable(throwable) + " info=" + XiaomiAccountHook.describeConfirmBizStatus(methodHookParam.thisObject));
                    } else {
                        XiaomiAccountHook.log("TSM confirm upload result=" + XiaomiAccountHook.describeModelResult(methodHookParam.getResult()) + " info=" + XiaomiAccountHook.describeConfirmBizStatus(methodHookParam.thisObject));
                    }
                }
            }});
            log("hooked TSM confirm upload diagnostics");
        } catch (Throwable th) {
            log("optional TSM confirm upload diagnostics failed");
            XposedBridge.log(th);
        }
        try {
            XposedHelpers.findAndHookConstructor("n6.e", classLoader, new Object[]{Context.class, "com.miui.tsmclient.entity.ConfirmBizStatusInfo", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.19
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM confirm request constructed info=" + XiaomiAccountHook.describeConfirmBizStatus(methodHookParam.args[1]) + ", params=" + XiaomiAccountHook.describeRequestParams(methodHookParam.thisObject));
                }
            }});
            log("hooked TSM confirm request constructor diagnostics");
        } catch (Throwable th2) {
            log("optional TSM confirm request constructor diagnostics failed");
            XposedBridge.log(th2);
        }
        try {
            XposedHelpers.findAndHookMethod("h5.a", classLoader, "e", new Object[]{String.class, String.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.20
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if (!XiaomiAccountHook.isConfirmBizStatusRequest(methodHookParam.thisObject)) {
                        return;
                    }
                    String strValueOf = String.valueOf(methodHookParam.args[0]);
                    String strNormalizeStartTransferParam = XiaomiAccountHook.normalizeStartTransferParam(strValueOf, (String) methodHookParam.args[1]);
                    if (strNormalizeStartTransferParam != methodHookParam.args[1]) {
                        methodHookParam.args[1] = strNormalizeStartTransferParam;
                    }
                    XiaomiAccountHook.log("TSM confirm param " + strValueOf + "=" + XiaomiAccountHook.sanitizeConfirmParam(strValueOf, strNormalizeStartTransferParam));
                }
            }});
            log("hooked TSM confirm param diagnostics");
        } catch (Throwable th3) {
            log("optional TSM confirm param diagnostics failed");
            XposedBridge.log(th3);
        }
        try {
            XposedHelpers.findAndHookMethod("h5.f$a", classLoader, "d", new Object[]{"c5.a", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.21
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Object obj = methodHookParam.args[0];
                    if (obj != null && obj.getClass().getName().equals("com.miui.tsmclient.entity.BizStatusConfirmResponseInfo")) {
                        XiaomiAccountHook.log("TSM confirm response=" + XiaomiAccountHook.describeCommonResponse(obj) + ", biz=" + XiaomiAccountHook.describeBizStatusResponse(obj));
                    }
                }
            }});
            log("hooked TSM confirm response diagnostics");
        } catch (Throwable th4) {
            log("optional TSM confirm response diagnostics failed");
            XposedBridge.log(th4);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isConfirmBizStatusRequest(Object obj) {
        return obj != null && "n6.e".equals(obj.getClass().getName());
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void repairShenzhenTransferConfirm(Object obj) {
        if (obj == null) {
            return;
        }
        try {
            String str = (String) XposedHelpers.callMethod(obj, "getCardName", new Object[0]);
            String str2 = (String) XposedHelpers.callMethod(obj, "getActionType", new Object[0]);
            String str3 = (String) XposedHelpers.callMethod(obj, "getCoreOperation", new Object[0]);
            String str4 = (String) XposedHelpers.callMethod(obj, "getOrderId", new Object[0]);
            if ("SZT_MOT".equals(str) && "TRANSFER_IN".equals(str2) && "pretransferIn".equals(str3) && isEmpty(str4) && !isEmpty(lastStartTransferInOrderId)) {
                XposedHelpers.setObjectField(obj, "mOrderId", lastStartTransferInOrderId);
                XposedHelpers.setObjectField(obj, "mCoreOperation", "transferIn");
                log("TSM repaired SZT_MOT confirm orderId=" + lastStartTransferInOrderId + ", coreOperation=transferIn");
            }
        } catch (Throwable th) {
            log("TSM SZT_MOT confirm repair failed: " + describeThrowable(th));
        }
    }

    private static void installTransferCardModelDiagnostics(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.model.e1", classLoader, "o", new Object[]{"com.miui.tsmclient.entity.PayableCardInfo", "e5.i", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.22
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM transfer model o begin card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]) + ", callback=" + XiaomiAccountHook.describeObject(methodHookParam.args[1]));
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM transfer model o threw " + XiaomiAccountHook.describeThrowable(throwable) + ", card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    } else {
                        XiaomiAccountHook.log("TSM transfer model o exit card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    }
                }
            }});
            log("hooked TSM transfer model o diagnostics");
        } catch (Throwable th) {
            log("optional TSM transfer model o diagnostics failed");
            XposedBridge.log(th);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.model.e1", classLoader, "p", new Object[]{"com.miui.tsmclient.entity.PayableCardInfo", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.23
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM transfer model p begin card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM transfer model p threw " + XiaomiAccountHook.describeThrowable(throwable) + ", card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    } else {
                        XiaomiAccountHook.log("TSM transfer model p result=" + XiaomiAccountHook.describeModelResult(methodHookParam.getResult()) + ", card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    }
                }
            }});
            log("hooked TSM transfer model p diagnostics");
        } catch (Throwable th2) {
            log("optional TSM transfer model p diagnostics failed");
            XposedBridge.log(th2);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.model.e1", classLoader, "q", new Object[]{"com.miui.tsmclient.entity.PayableCardInfo", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.24
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM transfer model q begin card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("TSM transfer model q threw " + XiaomiAccountHook.describeThrowable(throwable) + ", card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    } else {
                        XiaomiAccountHook.log("TSM transfer model q result=" + XiaomiAccountHook.describeModelResult(methodHookParam.getResult()) + ", card=" + XiaomiAccountHook.describePayableCardInfo(methodHookParam.args[0]));
                    }
                }
            }});
            log("hooked TSM transfer model q diagnostics");
        } catch (Throwable th3) {
            log("optional TSM transfer model q diagnostics failed");
            XposedBridge.log(th3);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.model.e1$a", classLoader, "c", new Object[]{Integer.TYPE, String.class, "com.miui.tsmclient.entity.OrderResponseInfo", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.25
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM transfer callback failure code=" + methodHookParam.args[0] + ", msg=" + methodHookParam.args[1] + ", orderResponse=" + XiaomiAccountHook.describeOrderResponse(methodHookParam.args[2]) + ", card=" + XiaomiAccountHook.describeCallbackPayableCard(methodHookParam.thisObject));
                }
            }});
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.model.e1$a", classLoader, "d", new Object[]{"com.miui.tsmclient.entity.OrderResponseInfo", new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.26
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("TSM transfer callback success orderResponse=" + XiaomiAccountHook.describeOrderResponse(methodHookParam.args[0]) + ", card=" + XiaomiAccountHook.describeCallbackPayableCard(methodHookParam.thisObject));
                }
            }});
            log("hooked TSM transfer callback diagnostics");
        } catch (Throwable th4) {
            log("optional TSM transfer callback diagnostics failed");
            XposedBridge.log(th4);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String normalizeStartTransferParam(String str, String str2) {
        if ("miuiRomType".equals(str) && ("OTHER".equals(str2) || isEmpty(str2))) {
            return "STABLE";
        }
        if ("romType".equals(str) && ("OTHER".equals(str2) || isEmpty(str2))) {
            return "MIUI";
        }
        if ("hyperOSVersion".equals(str) && isEmpty(str2)) {
            return "OS3.0.2.0.WMCCNXM";
        }
        return str2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String readXiaomiAccountUserDataPh(Context context, String str) {
        if (context == null || isEmpty(str)) {
            return null;
        }
        try {
            AccountManager accountManager = AccountManager.get(context.getApplicationContext());
            Account[] accountsByType = accountManager.getAccountsByType("com.xiaomi");
            if (accountsByType != null && accountsByType.length != 0) {
                String userData = accountManager.getUserData(accountsByType[0], str + "_ph");
                if (isEmpty(userData)) {
                    log("TSM cached ph missing in AccountManager userData key=" + str + "_ph");
                } else {
                    log("TSM cached ph loaded from AccountManager userData, length=" + userData.length());
                }
                return userData;
            }
            log("TSM cached ph lookup skipped: no Xiaomi account");
            return null;
        } catch (Throwable th) {
            log("TSM cached ph lookup failed: " + describeThrowable(th));
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String readTsmAuthPhCache() {
        BufferedReader bufferedReader;
        try {
            File file = new File(TSM_AUTH_PH_CACHE);
            if (!file.isFile()) {
                log("TSM ph cache missing: /data/local/tmp/xiaomi-tsm-auth-ph");
                return null;
            }
            bufferedReader = new BufferedReader(new FileReader(file));
            try {
                String line = bufferedReader.readLine();
                if (isEmpty(line)) {
                    log("TSM ph cache is empty");
                } else {
                    log("TSM ph loaded from root-synced cache, length=" + line.length());
                }
                try {
                    bufferedReader.close();
                } catch (Throwable th) {
                }
                return line;
            } catch (Throwable th2) {
                th = th2;
                try {
                    log("TSM ph cache read failed: " + describeThrowable(th));
                    return null;
                } finally {
                    if (bufferedReader != null) {
                        try {
                            bufferedReader.close();
                        } catch (Throwable th3) {
                        }
                    }
                }
            }
        } catch (Throwable th4) {
            th = th4;
            bufferedReader = null;
        }
    }

    private static void installSecureElementHook(final ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("com.android.se.security.AccessControlEnforcer", classLoader, "setUpChannelAccess", new Object[]{byte[].class, String.class, byte[].class, Boolean.TYPE, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.27
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    String str = (String) methodHookParam.args[1];
                    if (!XiaomiAccountHook.isXiaomiSeClient(str)) {
                        return;
                    }
                    if (new File(XiaomiAccountHook.SE_DISABLE_SWITCH).exists()) {
                        XiaomiAccountHook.log("SE hook disabled by /data/local/tmp/disable-xiaomi-se-hook");
                        return;
                    }
                    String terminalName = XiaomiAccountHook.getTerminalName(methodHookParam.thisObject);
                    if (terminalName == null || !terminalName.startsWith("eSE")) {
                        XiaomiAccountHook.log("SE skip package=" + str + " terminal=" + terminalName);
                    } else {
                        methodHookParam.setResult(XiaomiAccountHook.createAllowedChannelAccess(classLoader, str));
                        XiaomiAccountHook.log("SE allow package=" + str + " terminal=" + terminalName + " aid=" + XiaomiAccountHook.toHex((byte[]) methodHookParam.args[0]));
                    }
                }
            }});
            log("hooked com.android.se.security.AccessControlEnforcer.setUpChannelAccess");
        } catch (Throwable th) {
            log("critical SE hook failed");
            XposedBridge.log(th);
        }
    }

    private static void installXiaomiNfcHook(final ClassLoader classLoader, final String str) {
        if (new File(NFC_DISABLE_SWITCH).exists()) {
            log("MI NFC hook disabled by /data/local/tmp/disable-xiaomi-nfc-hook for " + str);
            return;
        }
        try {
            XposedHelpers.findAndHookConstructor("com.xiaomi.nfc.MiNfcAdapter", classLoader, new Object[]{Context.class, new XC_MethodReplacement() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.28
                protected Object replaceHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XposedHelpers.setObjectField(methodHookParam.thisObject, "mContext", methodHookParam.args[0]);
                    XposedHelpers.setObjectField(methodHookParam.thisObject, "mListener", XiaomiAccountHook.createNoOpSeConnectedListener(classLoader));
                    XposedHelpers.setObjectField(methodHookParam.thisObject, "mMiNfcAdapter", XiaomiAccountHook.createMiNfcAdapterProxy(classLoader, (Context) methodHookParam.args[0]));
                    XiaomiAccountHook.log("MI NFC adapter shim constructed for " + str);
                    return null;
                }
            }});
            hookReturnInt(classLoader, "com.xiaomi.nfc.MiNfcAdapter", "getSeRouting", 1, true, new Object[0]);
            hookReturnInt(classLoader, "com.xiaomi.nfc.MiNfcAdapter", "getVersion", 1, false, new Object[0]);
            hookReturnObject(classLoader, "com.xiaomi.nfc.MiNfcAdapter", "getChipId", "0xa4", false, new Object[0]);
            hookReturnObject(classLoader, "com.xiaomi.nfc.MiNfcAdapter", "getChipName", "NXP-SN100T", false, new Object[0]);
            hookReturnObject(classLoader, "com.xiaomi.nfc.MiNfcAdapter", "getFwVersion", "NXP.01.01", false, new Object[0]);
            hookReturnBoolean(classLoader, "s6.e", "a", true, false, new Object[0]);
            hookReturnInt(classLoader, "s6.e", "j", 1, false, new Object[0]);
            log("hooked MI NFC compatibility for " + str);
        } catch (Throwable th) {
            log("critical MI NFC hook failed for " + str);
            XposedBridge.log(th);
        }
    }

    private static void installTsmNfcForegroundDispatchFix(ClassLoader classLoader) {
        try {
            XposedHelpers.findAndHookMethod("com.tsmclient.smartcard.handler.TagReader", classLoader, "startPoll", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.29
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Object objectField = XposedHelpers.getObjectField(methodHookParam.thisObject, "mActivity");
                    if (objectField != null && "com.miui.tsmclient.ui.NewMifareCardActivity".equals(objectField.getClass().getName())) {
                        methodHookParam.setResult((Object) null);
                        XiaomiAccountHook.log("TSM NFC legacy foreground dispatch suppressed for copy flow");
                    }
                }
            }});
            log("hooked TSM legacy NFC dispatch suppression");
        } catch (Throwable th) {
            log("critical TSM legacy NFC dispatch suppression hook failed");
            XposedBridge.log(th);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.ui.BaseActivity", classLoader, "onResume", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.30
                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if ("com.miui.tsmclient.ui.NewMifareCardActivity".equals(methodHookParam.thisObject.getClass().getName())) {
                        XiaomiAccountHook.rearmTsmNfcForegroundDispatch(methodHookParam.thisObject, 0);
                    }
                }
            }});
            log("hooked TSM NFC foreground dispatch lifecycle");
        } catch (Throwable th2) {
            log("critical TSM NFC foreground dispatch hook failed");
            XposedBridge.log(th2);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.ui.BaseActivity", classLoader, "onPause", new Object[]{new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.31
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    if ("com.miui.tsmclient.ui.NewMifareCardActivity".equals(methodHookParam.thisObject.getClass().getName())) {
                        XiaomiAccountHook.disableTsmNfcReaderMode((Activity) methodHookParam.thisObject);
                    }
                }
            }});
            log("hooked TSM NFC reader-mode lifecycle");
        } catch (Throwable th3) {
            log("critical TSM NFC reader-mode lifecycle hook failed");
            XposedBridge.log(th3);
        }
        try {
            XposedHelpers.findAndHookMethod("com.miui.tsmclient.ui.d9", classLoader, "r4", new Object[]{Intent.class, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.32
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Tag tag;
                    Intent intent = (Intent) methodHookParam.args[0];
                    if (intent == null) {
                        tag = null;
                    } else {
                        tag = (Tag) intent.getParcelableExtra("android.nfc.extra.TAG");
                    }
                    XiaomiAccountHook.log("TSM NFC tag delivered action=" + (intent == null ? "null" : intent.getAction()) + ", tag=" + (tag != null ? tag.toString() : "null"));
                }
            }});
            log("hooked TSM NFC tag delivery diagnostics");
        } catch (Throwable th4) {
            log("optional TSM NFC tag delivery diagnostics failed");
            XposedBridge.log(th4);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void rearmTsmNfcForegroundDispatch(final Object obj, final int i) {
        Object objectField;
        try {
            Activity activity = (Activity) obj;
            if (!activity.isFinishing() && !activity.isDestroyed()) {
                Object objectField2 = XposedHelpers.getObjectField(obj, "y");
                if (objectField2 == null) {
                    objectField = null;
                } else {
                    objectField = XposedHelpers.getObjectField(objectField2, "Y");
                }
                if (objectField != null) {
                    XposedHelpers.callMethod(objectField, "resetBlockPoll", new Object[0]);
                    enableTsmNfcReaderMode(activity, objectField2);
                    log("TSM NFC reader mode re-armed after onResume attempt=" + i);
                } else if (i >= 8) {
                    log("TSM NFC foreground dispatch retry skipped: presenter not ready");
                } else {
                    new Handler(Looper.getMainLooper()).postDelayed(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.33
                        @Override // java.lang.Runnable
                        public void run() {
                            XiaomiAccountHook.rearmTsmNfcForegroundDispatch(obj, i + 1);
                        }
                    }, 250L);
                }
            }
        } catch (Throwable th) {
            log("TSM NFC foreground dispatch retry failed: " + describeThrowable(th));
            XposedBridge.log(th);
        }
    }

    private static void enableTsmNfcReaderMode(Activity activity, final Object obj) {
        try {
            NfcAdapter defaultAdapter = NfcAdapter.getDefaultAdapter(activity);
            if (defaultAdapter != null && defaultAdapter.isEnabled()) {
                defaultAdapter.enableReaderMode(activity, new NfcAdapter.ReaderCallback() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.34
                    @Override // android.nfc.NfcAdapter.ReaderCallback
                    public void onTagDiscovered(final Tag tag) {
                        XiaomiAccountHook.log("TSM NFC reader mode received tag=" + tag);
                        new Handler(Looper.getMainLooper()).post(new Runnable() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.34.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    Intent intent = new Intent("android.nfc.action.TAG_DISCOVERED");
                                    intent.putExtra("android.nfc.extra.TAG", tag);
                                    XposedHelpers.callMethod(obj, "r4", new Object[]{intent});
                                    XiaomiAccountHook.log("TSM NFC reader mode forwarded tag to copy flow");
                                } catch (Throwable th) {
                                    XiaomiAccountHook.log("TSM NFC reader mode forward failed: " + XiaomiAccountHook.describeThrowable(th));
                                    XposedBridge.log(th);
                                }
                            }
                        });
                    }
                }, 129, null);
                log("TSM NFC reader mode armed");
                return;
            }
            log("TSM NFC reader mode unavailable: adapter disabled");
        } catch (Throwable th) {
            log("TSM NFC reader mode arm failed: " + describeThrowable(th));
            XposedBridge.log(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void disableTsmNfcReaderMode(Activity activity) {
        try {
            NfcAdapter defaultAdapter = NfcAdapter.getDefaultAdapter(activity);
            if (defaultAdapter != null) {
                defaultAdapter.disableReaderMode(activity);
                log("TSM NFC reader mode disarmed");
            }
        } catch (Throwable th) {
            log("TSM NFC reader mode disarm failed: " + describeThrowable(th));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Object createNoOpSeConnectedListener(ClassLoader classLoader) {
        try {
            Class clsFindClass = XposedHelpers.findClass("android.se.omapi.SEService$OnConnectedListener", classLoader);
            return Proxy.newProxyInstance(clsFindClass.getClassLoader(), new Class[]{clsFindClass}, new InvocationHandler() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.35
                @Override // java.lang.reflect.InvocationHandler
                public Object invoke(Object obj, Method method, Object[] objArr) {
                    return null;
                }
            });
        } catch (Throwable th) {
            log("MI NFC listener shim failed: " + describeThrowable(th));
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Object createMiNfcAdapterProxy(ClassLoader classLoader, final Context context) {
        try {
            Class clsFindClass = XposedHelpers.findClass("com.xiaomi.nfc.IMiNfcAdapter", classLoader);
            return Proxy.newProxyInstance(clsFindClass.getClassLoader(), new Class[]{clsFindClass}, new InvocationHandler() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.36
                @Override // java.lang.reflect.InvocationHandler
                public Object invoke(Object obj, Method method, Object[] objArr) {
                    int iIntValue;
                    String name = method.getName();
                    if ("getSeRouting".equals(name) || "getVersion".equals(name)) {
                        return 1;
                    }
                    if ("getChipId".equals(name)) {
                        return "0xa4";
                    }
                    if ("getFwVersion".equals(name)) {
                        return "NXP.01.01";
                    }
                    if ("getNfccDieid".equals(name)) {
                        return new byte[]{0};
                    }
                    if ("setSeRouting".equals(name)) {
                        if (objArr != null && objArr.length > 0 && (objArr[0] instanceof Number)) {
                            iIntValue = ((Number) objArr[0]).intValue();
                        } else {
                            iIntValue = -1;
                        }
                        boolean z = iIntValue == 1;
                        if (z && context != null) {
                            context.getContentResolver().notifyChange(Settings.Secure.getUriFor(XiaomiAccountHook.TSM_CARD_ACTIVATE_RECORD), null);
                        }
                        XiaomiAccountHook.log("MI NFC setSeRouting request=" + iIntValue + " accepted=" + z);
                        return Boolean.valueOf(z);
                    }
                    if ("asBinder".equals(name)) {
                        return null;
                    }
                    return XiaomiAccountHook.defaultValue(method.getReturnType());
                }
            });
        } catch (Throwable th) {
            log("MI NFC adapter proxy failed: " + describeThrowable(th));
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Object defaultValue(Class<?> cls) {
        if (cls == Void.TYPE) {
            return null;
        }
        if (cls == Boolean.TYPE) {
            return false;
        }
        if (cls == Integer.TYPE) {
            return 0;
        }
        if (cls == Long.TYPE) {
            return 0L;
        }
        if (cls == Float.TYPE) {
            return Float.valueOf(0.0f);
        }
        if (cls == Double.TYPE) {
            return Double.valueOf(0.0d);
        }
        if (cls == Byte.TYPE) {
            return (byte) 0;
        }
        if (cls == Short.TYPE) {
            return (short) 0;
        }
        return cls == Character.TYPE ? (char) 0 : null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static Object createAllowedChannelAccess(ClassLoader classLoader, String str) {
        return XposedHelpers.callStaticMethod(XposedHelpers.findClass("com.android.se.security.ChannelAccess", classLoader), "getPrivilegeAccess", new Object[]{str, 0});
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String getTerminalName(Object obj) {
        Object objCallMethod;
        try {
            Object objectField = XposedHelpers.getObjectField(obj, "mTerminal");
            if (objectField != null && (objCallMethod = XposedHelpers.callMethod(objectField, "getName", new Object[0])) != null) {
                return String.valueOf(objCallMethod);
            }
            return null;
        } catch (Throwable th) {
            log("SE terminal lookup failed: " + describeThrowable(th));
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isXiaomiSeClient(String str) {
        if (str == null) {
            return false;
        }
        for (String str2 : XIAOMI_SE_CLIENTS) {
            if (str2.equals(str)) {
                return true;
            }
        }
        return false;
    }

    private static boolean isXiaomiNfcClient(String str) {
        if (str == null) {
            return false;
        }
        for (String str2 : XIAOMI_NFC_CLIENTS) {
            if (str2.equals(str)) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String toHex(byte[] bArr) {
        if (bArr == null) {
            return "null";
        }
        char[] cArr = new char[bArr.length * 2];
        char[] charArray = "0123456789abcdef".toCharArray();
        for (int i = 0; i < bArr.length; i++) {
            int i2 = bArr[i] & 255;
            int i3 = i * 2;
            cArr[i3] = charArray[i2 >>> 4];
            cArr[i3 + 1] = charArray[i2 & 15];
        }
        return new String(cArr);
    }

    private static void installLoginProbes(ClassLoader classLoader) {
        hookProbe(classLoader, "com.xiaomi.account.ui.s", "K", false, String.class, String.class, String.class, String.class, String.class);
        hookProbe(classLoader, "com.xiaomi.passport.uicontroller.b", "f", false, "com.xiaomi.accountsdk.account.data.PasswordLoginParams", "com.xiaomi.passport.uicontroller.a$d");
        hookProbe(classLoader, "m6.b", "b", false, new Object[0]);
        hookProbe(classLoader, "m6.b", "onServiceConnected", false, ComponentName.class, IBinder.class);
        hookProbe(classLoader, "m6.b", "onNullBinding", false, ComponentName.class);
        hookProbe(classLoader, "m6.b", "onBindingDied", false, ComponentName.class);
        hookProbe(classLoader, "m6.b", "onServiceDisconnected", false, ComponentName.class);
        hookProbe(classLoader, "com.xiaomi.passport.uicontroller.b$a", "l", false, new Object[0]);
        hookProbe(classLoader, "com.xiaomi.passport.MiPassportUIControllerService$a", "loginByPassword", false, "com.xiaomi.accountsdk.account.data.PasswordLoginParams");
        hookProbe(classLoader, "com.xiaomi.passport.utils.a", "n", false, "com.xiaomi.accountsdk.account.data.PasswordLoginParams");
        hookProbe(classLoader, "com.xiaomi.passport.utils.a", "d", false, new Object[0]);
        hookProbe(classLoader, "com.xiaomi.accountsdk.account.f", "J", false, "com.xiaomi.accountsdk.account.data.PasswordLoginParams");
        hookProbe(classLoader, "com.xiaomi.accountsdk.account.f", "n", false, "r6.k");
        hookProbe(classLoader, "com.xiaomi.accountsdk.account.f", "a", false, "r6.k", String.class);
        hookProbe(classLoader, "com.xiaomi.accountsdk.account.f", "b", false, "r6.k");
        hookProbe(classLoader, "com.xiaomi.accountsdk.account.f", "s", false, new Object[0]);
        hookProbe(classLoader, "r6.g", "e", false, String.class);
        hookProbe(classLoader, "r6.m0", "g", false, new Object[0]);
        hookProbe(classLoader, "f5.a", "c", false, Context.class, "f5.b", String[].class);
        hookProbe(classLoader, "b6.u", "b", false, new Object[0]);
        hookProbe(classLoader, "i4.c$b", "c", false, Context.class);
        hookProbe(classLoader, "i4.c", "d", false, Context.class);
        hookProbe(classLoader, "p6.k", "b", false, new Object[0]);
        hookProbe(classLoader, "p6.j", "a", false, new Object[0]);
        hookProbe(classLoader, "p6.n$b", "a", false, new Object[0]);
        hookProbe(classLoader, "p6.s", "k", false, String.class, Map.class, Map.class, Map.class, Map.class, Boolean.TYPE, Integer.class);
        hookProbe(classLoader, "p6.r", "r", false, String.class, Map.class, Map.class, Integer.class);
        hookProbe(classLoader, "p6.r", "u", false, String.class, Map.class, Map.class, Map.class, Map.class, Boolean.TYPE, Integer.class);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpURLConnectionImpl", "connect", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpURLConnectionImpl", "getResponseCode", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpURLConnectionImpl", "getOutputStream", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpURLConnectionImpl", "getInputStream", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpsURLConnectionImpl", "connect", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpsURLConnectionImpl", "getResponseCode", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpsURLConnectionImpl", "getOutputStream", false, new Object[0]);
        hookProbe(classLoader, "com.android.okhttp.internal.huc.HttpsURLConnectionImpl", "getInputStream", false, new Object[0]);
        hookProbe(classLoader, "m6.a", "e", false, Object.class);
        hookProbe(classLoader, "m6.a", "f", false, Throwable.class);
        hookProbe(classLoader, "m6.a", "done", false, new Object[0]);
        hookProbe(classLoader, "com.xiaomi.passport.uicontroller.a$c", "h", false, "com.xiaomi.accountsdk.account.data.MiLoginResult");
        hookProbe(classLoader, "com.xiaomi.passport.uicontroller.a$c", "i", false, ExecutionException.class);
    }

    private static void hookReturnInt(ClassLoader classLoader, String str, String str2, int i, boolean z, Object... objArr) {
        try {
            XposedHelpers.findAndHookMethod(str, classLoader, str2, appendCallback(objArr, XC_MethodReplacement.returnConstant(Integer.valueOf(i))));
            log("hooked " + str + "." + str2 + " -> " + i);
        } catch (Throwable th) {
            log((z ? "critical " : "optional ") + "hook failed: " + str + "." + str2);
            XposedBridge.log(th);
        }
    }

    private static void hookReturnObject(ClassLoader classLoader, String str, String str2, Object obj, boolean z, Object... objArr) {
        try {
            XposedHelpers.findAndHookMethod(str, classLoader, str2, appendCallback(objArr, XC_MethodReplacement.returnConstant(obj)));
            log("hooked " + str + "." + str2 + " -> " + String.valueOf(obj));
        } catch (Throwable th) {
            log((z ? "critical " : "optional ") + "hook failed: " + str + "." + str2);
            XposedBridge.log(th);
        }
    }

    private static void hookReturnBoolean(ClassLoader classLoader, String str, String str2, boolean z, boolean z2, Object... objArr) {
        try {
            XposedHelpers.findAndHookMethod(str, classLoader, str2, appendCallback(objArr, XC_MethodReplacement.returnConstant(Boolean.valueOf(z))));
            log("hooked " + str + "." + str2 + " -> " + z);
        } catch (Throwable th) {
            log((z2 ? "critical " : "optional ") + "hook failed: " + str + "." + str2);
            XposedBridge.log(th);
        }
    }

    private static void hookNoOp(ClassLoader classLoader, String str, String str2, boolean z, Object... objArr) {
        try {
            XposedHelpers.findAndHookMethod(str, classLoader, str2, appendCallback(objArr, new XC_MethodReplacement() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.37
                protected Object replaceHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    return null;
                }
            }));
            log("hooked " + str + "." + str2 + " -> no-op");
        } catch (Throwable th) {
            log((z ? "critical " : "optional ") + "hook failed: " + str + "." + str2);
            XposedBridge.log(th);
        }
    }

    private static void hookProbe(ClassLoader classLoader, final String str, final String str2, boolean z, Object... objArr) {
        try {
            XposedHelpers.findAndHookMethod(str, classLoader, str2, appendCallback(objArr, new XC_MethodHook() { // from class: dev.codex.xiaomiaccount.miuiintentfix.XiaomiAccountHook.38
                protected void beforeHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    XiaomiAccountHook.log("probe enter " + str + "." + str2 + " thread=" + Thread.currentThread().getName());
                }

                protected void afterHookedMethod(XC_MethodHook.MethodHookParam methodHookParam) {
                    Throwable throwable = methodHookParam.getThrowable();
                    if (throwable != null) {
                        XiaomiAccountHook.log("probe throw " + str + "." + str2 + " error=" + XiaomiAccountHook.describeThrowable(throwable));
                    } else {
                        XiaomiAccountHook.log("probe exit " + str + "." + str2 + " result=" + XiaomiAccountHook.describeObject(methodHookParam.getResult()));
                    }
                }
            }));
            log("probe hooked " + str + "." + str2);
        } catch (Throwable th) {
            log((z ? "critical " : "optional ") + "probe failed: " + str + "." + str2);
            XposedBridge.log(th);
        }
    }

    private static Object[] appendCallback(Object[] objArr, Object obj) {
        Object[] objArr2 = new Object[objArr.length + 1];
        System.arraycopy(objArr, 0, objArr2, 0, objArr.length);
        objArr2[objArr.length] = obj;
        return objArr2;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeObject(Object obj) {
        if (obj == null) {
            return "null";
        }
        String name = obj.getClass().getName();
        if ("com.xiaomi.accountsdk.account.data.MiLoginResult".equals(name)) {
            try {
                return name + "{code=" + XposedHelpers.getIntField(obj, "u") + "}";
            } catch (Throwable th) {
                return name;
            }
        }
        return name;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeRequestParams(Object obj) {
        try {
            Object objCallMethod = XposedHelpers.callMethod(obj, "n", new Object[0]);
            if (!(objCallMethod instanceof Map)) {
                return describeObject(objCallMethod);
            }
            StringBuilder sb = new StringBuilder("{");
            for (Map.Entry entry : ((Map) objCallMethod).entrySet()) {
                if (sb.length() > 1) {
                    sb.append(", ");
                }
                String strValueOf = String.valueOf(entry.getKey());
                sb.append(strValueOf).append('=').append(sanitizeStartTransferParam(strValueOf, String.valueOf(entry.getValue())));
            }
            sb.append('}');
            return sb.toString();
        } catch (Throwable th) {
            return "paramsFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String sanitizeStartTransferParam(String str, String str2) {
        if (str2 == null || "null".equals(str2)) {
            return "null";
        }
        if ("orderId".equals(str) || "deviceModel".equals(str)) {
            return str2;
        }
        return "len=" + str2.length() + ",prefix=" + str2.substring(0, Math.min(8, str2.length()));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String sanitizeConfirmParam(String str, String str2) {
        if (str2 == null || "null".equals(str2)) {
            return "null";
        }
        if ("orderId".equals(str) || "cardName".equals(str) || "businessId".equals(str) || "sessionId".equals(str) || "cardCategory".equals(str) || "actionType".equals(str) || "result".equals(str) || "errorCode".equals(str) || "errorDesc".equals(str) || "coreOperation".equals(str) || "orderSource".equals(str)) {
            return str2;
        }
        return "len=" + str2.length() + ",prefix=" + str2.substring(0, Math.min(8, str2.length()));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeCardInfo(Object obj) {
        if (obj == null) {
            return "null";
        }
        try {
            return "type=" + String.valueOf(XposedHelpers.getObjectField(obj, "mCardType")) + ", name=" + String.valueOf(XposedHelpers.getObjectField(obj, "mCardName"));
        } catch (Throwable th) {
            return "cardFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describePayableCardInfo(Object obj) {
        if (obj == null) {
            return "null";
        }
        StringBuilder sb = new StringBuilder("{");
        try {
            sb.append("type=").append(String.valueOf(XposedHelpers.getObjectField(obj, "mCardType")));
        } catch (Throwable th) {
            sb.append("type=?");
        }
        try {
            sb.append(", name=").append(String.valueOf(XposedHelpers.getObjectField(obj, "mCardName")));
        } catch (Throwable th2) {
        }
        try {
            sb.append(", orderId=").append(String.valueOf(XposedHelpers.callMethod(obj, "getOrderId", new Object[0])));
        } catch (Throwable th3) {
        }
        try {
            sb.append(", transferOutToken=").append(presentValue((String) XposedHelpers.callMethod(obj, "getTransferOutToken", new Object[0])));
        } catch (Throwable th4) {
        }
        try {
            sb.append(", unfinishTransferOut=").append(describeTransferOutOrderInfo(XposedHelpers.callMethod(obj, "getUnfinishTransferOutInfo", new Object[0])));
        } catch (Throwable th5) {
            sb.append(", unfinishTransferOutFailed=").append(describeThrowable(th5));
        }
        sb.append('}');
        return sb.toString();
    }

    private static String describeTransferOutOrderInfo(Object obj) {
        if (obj == null) {
            return "null";
        }
        try {
            return "{orderId=" + String.valueOf(XposedHelpers.callMethod(obj, "getOrderId", new Object[0])) + ", token=" + presentValue((String) XposedHelpers.callMethod(obj, "getTransferOutToken", new Object[0])) + '}';
        } catch (Throwable th) {
            return "transferOutInfoFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeCallbackPayableCard(Object obj) {
        try {
            return describePayableCardInfo(XposedHelpers.getObjectField(obj, "a"));
        } catch (Throwable th) {
            return "callbackCardFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeCommonResponse(Object obj) {
        try {
            return "success=" + XposedHelpers.callMethod(obj, "isSuccess", new Object[0]) + ", errCode=" + XposedHelpers.callMethod(obj, "getErrorCode", new Object[0]) + ", errDesc=" + XposedHelpers.callMethod(obj, "getErrorDesc", new Object[0]);
        } catch (Throwable th) {
            return "responseFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeOrderResponse(Object obj) {
        try {
            Object objCallMethod = XposedHelpers.callMethod(obj, "getOrderInfo", new Object[0]);
            if (objCallMethod == null) {
                return "null";
            }
            StringBuilder sb = new StringBuilder(describeObject(objCallMethod));
            appendObjectField(sb, objCallMethod, "mOrderId", "orderId");
            appendObjectField(sb, objCallMethod, "mOrderStatus", "status");
            appendObjectField(sb, objCallMethod, "mOrderType", "type");
            return sb.toString();
        } catch (Throwable th) {
            return "orderFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeBizStatusResponse(Object obj) {
        try {
            return "needWait=" + XposedHelpers.callMethod(obj, "needWait", new Object[0]) + ", failed=" + XposedHelpers.callMethod(obj, "isFailed", new Object[0]) + ", message=" + String.valueOf(XposedHelpers.callMethod(obj, "getMessage", new Object[0]));
        } catch (Throwable th) {
            return "bizResponseFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeConfirmBizStatus(Object obj) {
        if (obj == null) {
            return "null";
        }
        try {
            return "{orderId=" + String.valueOf(XposedHelpers.callMethod(obj, "getOrderId", new Object[0])) + ", cardName=" + String.valueOf(XposedHelpers.callMethod(obj, "getCardName", new Object[0])) + ", businessId=" + String.valueOf(XposedHelpers.callMethod(obj, "getBusinessId", new Object[0])) + ", sessionId=" + presentValue((String) XposedHelpers.callMethod(obj, "getSessionId", new Object[0])) + ", cardCategory=" + String.valueOf(XposedHelpers.callMethod(obj, "getCardCategory", new Object[0])) + ", actionType=" + String.valueOf(XposedHelpers.callMethod(obj, "getActionType", new Object[0])) + ", result=" + String.valueOf(XposedHelpers.callMethod(obj, "getResult", new Object[0])) + ", errorCode=" + String.valueOf(XposedHelpers.callMethod(obj, "getErrorCode", new Object[0])) + ", errorDesc=" + String.valueOf(XposedHelpers.callMethod(obj, "getErrorDesc", new Object[0])) + ", coreOperation=" + String.valueOf(XposedHelpers.callMethod(obj, "getCoreOperation", new Object[0])) + ", extra=" + presentValue((String) XposedHelpers.callMethod(obj, "getExtra", new Object[0])) + ", orderSource=" + String.valueOf(XposedHelpers.callMethod(obj, "getOrderSource", new Object[0])) + '}';
        } catch (Throwable th) {
            return "confirmInfoFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeModelResult(Object obj) {
        if (obj == null) {
            return "null";
        }
        try {
            return describeObject(obj) + "{success=" + String.valueOf(XposedHelpers.callMethod(obj, "c", new Object[0])) + ", code=" + String.valueOf(XposedHelpers.callMethod(obj, "a", new Object[0])) + ", message=" + String.valueOf(XposedHelpers.callMethod(obj, "b", new Object[0])) + '}';
        } catch (Throwable th) {
            return describeObject(obj) + "{modelResultFailed=" + describeThrowable(th) + '}';
        }
    }

    private static String presentValue(String str) {
        return isEmpty(str) ? "empty" : "len=" + str.length() + ",prefix=" + str.substring(0, Math.min(8, str.length()));
    }

    private static void appendObjectField(StringBuilder sb, Object obj, String str, String str2) {
        try {
            sb.append(", ").append(str2).append('=').append(String.valueOf(XposedHelpers.getObjectField(obj, str)));
        } catch (Throwable th) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeThrowable(Throwable th) {
        if (th == null) {
            return "null";
        }
        String message = th.getMessage();
        return th.getClass().getName() + (message == null ? "" : ":" + message);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String describeAccountInfoValidity(Object obj) {
        if (obj == null) {
            return "null";
        }
        try {
            return "valid=" + XposedHelpers.callMethod(obj, "g", new Object[0]) + ", authToken=" + present((String) XposedHelpers.callMethod(obj, "a", new Object[0])) + ", serviceToken=" + present((String) XposedHelpers.callMethod(obj, "f", new Object[0])) + ", security=" + present((String) XposedHelpers.callMethod(obj, "d", new Object[0])) + ", userId=" + present((String) XposedHelpers.callMethod(obj, "e", new Object[0])) + ", ph=" + present((String) XposedHelpers.callMethod(obj, "c", new Object[0]));
        } catch (Throwable th) {
            return "probeFailed=" + describeThrowable(th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isValidAccountInfo(Object obj) {
        if (obj == null) {
            return false;
        }
        try {
            return Boolean.TRUE.equals(XposedHelpers.callMethod(obj, "g", new Object[0]));
        } catch (Throwable th) {
            return false;
        }
    }

    private static String present(String str) {
        return isEmpty(str) ? "empty" : "len=" + str.length();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void log(String str) {
        XposedBridge.log("XiaomiAccountMiuiIntentFix: " + str);
    }
}
