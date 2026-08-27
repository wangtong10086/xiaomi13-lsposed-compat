.class public final Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Lde/robv/android/xposed/IXposedHookLoadPackage;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;,
        Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;
    }
.end annotation


# static fields
.field private static final ACCOUNT_PACKAGE:Ljava/lang/String; = "com.xiaomi.account"

.field private static final ESE_ROUTING_ENABLED_SETTING:Ljava/lang/String; = "codex_xiaomi_ese_routing_enabled"

.field private static final ESE_ROUTING_RECONCILE_DELAY_MS:J = 0x64L

.field private static final GOOGLE_WALLET_PACKAGE:Ljava/lang/String; = "com.google.android.apps.walletnfcrel"

.field private static final LEGACY_POWER_GESTURE_SCRIPT:Ljava/lang/String; = "/data/adb/service.d/94-wallet-button-shortcuts.sh"

.field private static final NFC_DISABLE_SWITCH:Ljava/lang/String; = "/data/local/tmp/disable-xiaomi-nfc-hook"

.field private static final NFC_SERVICE_PACKAGE:Ljava/lang/String; = "com.android.nfc"

.field private static final POWER_GESTURE_COMMIT_DELAY_MS:J = 0x136L

.field private static final POWER_GESTURE_DECISION_EXTRA:Ljava/lang/String; = "xiaomi_power_wallet_decision"

.field private static final POWER_GESTURE_DISABLE_SWITCH:Ljava/lang/String; = "/data/local/tmp/disable-xiaomi-power-wallet-hook"

.field private static final POWER_WALLET_GESTURES:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

.field private static final SECURE_ELEMENT_PACKAGE:Ljava/lang/String; = "com.android.se"

.field private static final SE_DISABLE_SWITCH:Ljava/lang/String; = "/data/local/tmp/disable-xiaomi-se-hook"

.field private static final TAG:Ljava/lang/String; = "XiaomiAccountMiuiIntentFix"

.field private static final TSM_AUTH_PH_CACHE:Ljava/lang/String; = "/data/local/tmp/xiaomi-tsm-auth-ph"

.field private static final TSM_CARD_ACTIVATE_RECORD:Ljava/lang/String; = "TSM_CARD_ACTIVATE_RECORD"

.field private static final TSM_PACKAGE:Ljava/lang/String; = "com.miui.tsmclient"

.field private static final XIAOMI_ESE_ROUTING:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

.field private static final XIAOMI_NFC_CLIENTS:[Ljava/lang/String;

.field private static final XIAOMI_SE_CLIENTS:[Ljava/lang/String;

.field private static volatile lastStartTransferInOrderId:Ljava/lang/String;

.field private static volatile lastTsmAuthPh:Ljava/lang/String;

.field private static volatile lastValidTsmAccountInfo:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 54
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->POWER_WALLET_GESTURES:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    .line 60
    new-instance v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-direct {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;-><init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;)V

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_ESE_ROUTING:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    .line 69
    const-string v0, "com.xiaomi.payment"

    const-string v1, "com.unionpay.tsmservice.mi"

    const-string v2, "com.miui.tsmclient"

    const-string v3, "com.mipay.wallet"

    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_SE_CLIENTS:[Ljava/lang/String;

    .line 75
    filled-new-array {v2}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_NFC_CLIENTS:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$1000(Ljava/lang/Object;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->launchXiaomiCardUi(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1100(Ljava/lang/Object;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->launchGoogleWallet(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1200()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;
    .locals 1

    .line 41
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_ESE_ROUTING:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    return-object v0
.end method

.method static synthetic access$200()Z
    .locals 1

    .line 41
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isPowerGestureHookDisabled()Z

    move-result v0

    return v0
.end method

.method static synthetic access$2800(Ljava/lang/Object;)Landroid/os/Bundle;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->asBundle(Ljava/lang/Object;)Landroid/os/Bundle;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$2900(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeObject(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$300()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;
    .locals 1

    .line 41
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->POWER_WALLET_GESTURES:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$PowerWalletGestureController;

    return-object v0
.end method

.method static synthetic access$3000(Ljava/lang/ClassLoader;Ljava/lang/Object;Landroid/accounts/Account;Landroid/os/Bundle;)Z
    .locals 0

    .line 41
    invoke-static {p0, p1, p2, p3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->injectOwnAccountPh(Ljava/lang/ClassLoader;Ljava/lang/Object;Landroid/accounts/Account;Landroid/os/Bundle;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$3100(Ljava/lang/String;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$3200()Ljava/lang/String;
    .locals 1

    .line 41
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastTsmAuthPh:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$3202(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    sput-object p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastTsmAuthPh:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$3300()Ljava/lang/Object;
    .locals 1

    .line 41
    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastValidTsmAccountInfo:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$3302(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 41
    sput-object p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastValidTsmAccountInfo:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic access$3400(Ljava/lang/ClassLoader;)Ljava/lang/Object;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->readStaticTsmAccountInfo(Ljava/lang/ClassLoader;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$3500(Ljava/lang/Object;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isValidAccountInfo(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$3600(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->readXiaomiAccountUserDataPh(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$3700()Ljava/lang/String;
    .locals 1

    .line 41
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->readTsmAuthPhCache()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$3800(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeAccountInfoValidity(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$3900(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeRequestParams(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$400(Ljava/lang/Throwable;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4000(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeCardInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4100(Ljava/lang/Object;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isStartTransferInRequest(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$4200(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->normalizeStartTransferParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4302(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    sput-object p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastStartTransferInOrderId:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$4400(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->sanitizeStartTransferParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4500(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeCommonResponse(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4600(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeOrderResponse(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4700(Ljava/lang/Object;)V
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->repairShenzhenTransferConfirm(Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$4800(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeConfirmBizStatus(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$4900(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeModelResult(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$500(Ljava/lang/String;)V
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$5000(Ljava/lang/Object;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isConfirmBizStatusRequest(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$5100(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->sanitizeConfirmParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5200(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeBizStatusResponse(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5300(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describePayableCardInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5400(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeCallbackPayableCard(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5500(Ljava/lang/String;)Z
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isXiaomiSeClient(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$5600(Ljava/lang/Object;)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->getTerminalName(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5700(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->createAllowedChannelAccess(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5800([B)Ljava/lang/String;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->toHex([B)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$5900(Ljava/lang/ClassLoader;)Ljava/lang/Object;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->createNoOpSeConnectedListener(Ljava/lang/ClassLoader;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$6000(Ljava/lang/ClassLoader;Landroid/content/Context;)Ljava/lang/Object;
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->createMiNfcAdapterProxy(Ljava/lang/ClassLoader;Landroid/content/Context;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$6100(Ljava/lang/Object;I)V
    .locals 0

    .line 41
    invoke-static {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->rearmTsmNfcForegroundDispatch(Ljava/lang/Object;I)V

    return-void
.end method

.method static synthetic access$6200(Landroid/app/Activity;)V
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->disableTsmNfcReaderMode(Landroid/app/Activity;)V

    return-void
.end method

.method static synthetic access$6300(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 0

    .line 41
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->defaultValue(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;
    .locals 3

    .line 2349
    array-length v0, p0

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    .line 2350
    const/4 v1, 0x0

    array-length v2, p0

    invoke-static {p0, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 2351
    array-length p0, p0

    aput-object p1, v0, p0

    .line 2352
    return-object v0
.end method

.method private static appendObjectField(Ljava/lang/StringBuilder;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 2571
    :try_start_0
    invoke-static {p1, p2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    .line 2572
    const-string p2, ", "

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const/16 p2, 0x3d

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {p1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2574
    goto :goto_0

    .line 2573
    :catchall_0
    move-exception p0

    .line 2575
    :goto_0
    return-void
.end method

.method private static asBundle(Ljava/lang/Object;)Landroid/os/Bundle;
    .locals 1

    .line 1161
    instance-of v0, p0, Landroid/os/Bundle;

    if-eqz v0, :cond_0

    check-cast p0, Landroid/os/Bundle;

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return-object p0
.end method

.method private static createAllowedChannelAccess(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Object;
    .locals 1

    .line 2120
    const-string v0, "com.android.se.security.ChannelAccess"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 2122
    nop

    .line 2123
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {p1, v0}, [Ljava/lang/Object;

    move-result-object p1

    .line 2122
    const-string v0, "getPrivilegeAccess"

    invoke-static {p0, v0, p1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static createMiNfcAdapterProxy(Ljava/lang/ClassLoader;Landroid/content/Context;)Ljava/lang/Object;
    .locals 3

    .line 2035
    :try_start_0
    const-string v0, "com.xiaomi.nfc.IMiNfcAdapter"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 2037
    nop

    .line 2038
    invoke-virtual {p0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;

    invoke-direct {p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$36;-><init>(Landroid/content/Context;)V

    .line 2037
    invoke-static {v0, v1, p0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2082
    :catchall_0
    move-exception p0

    .line 2083
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "MI NFC adapter proxy failed: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2084
    const/4 p0, 0x0

    return-object p0
.end method

.method private static createNoOpSeConnectedListener(Ljava/lang/ClassLoader;)Ljava/lang/Object;
    .locals 3

    .line 2015
    :try_start_0
    const-string v0, "android.se.omapi.SEService$OnConnectedListener"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 2017
    nop

    .line 2018
    invoke-virtual {p0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    aput-object p0, v1, v2

    new-instance p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$35;

    invoke-direct {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$35;-><init>()V

    .line 2017
    invoke-static {v0, v1, p0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2026
    :catchall_0
    move-exception p0

    .line 2027
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MI NFC listener shim failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2028
    const/4 p0, 0x0

    return-object p0
.end method

.method private static defaultValue(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 2089
    sget-object v0, Ljava/lang/Void;->TYPE:Ljava/lang/Class;

    const/4 v1, 0x0

    if-ne p0, v0, :cond_0

    .line 2090
    return-object v1

    .line 2092
    :cond_0
    sget-object v0, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const/4 v2, 0x0

    if-ne p0, v0, :cond_1

    .line 2093
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p0

    return-object p0

    .line 2095
    :cond_1
    sget-object v0, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_2

    .line 2096
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    return-object p0

    .line 2098
    :cond_2
    sget-object v0, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_3

    .line 2099
    const-wide/16 v0, 0x0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    return-object p0

    .line 2101
    :cond_3
    sget-object v0, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_4

    .line 2102
    const/4 p0, 0x0

    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0

    return-object p0

    .line 2104
    :cond_4
    sget-object v0, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_5

    .line 2105
    const-wide/16 v0, 0x0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0

    return-object p0

    .line 2107
    :cond_5
    sget-object v0, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_6

    .line 2108
    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p0

    return-object p0

    .line 2110
    :cond_6
    sget-object v0, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_7

    .line 2111
    invoke-static {v2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p0

    return-object p0

    .line 2113
    :cond_7
    sget-object v0, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    if-ne p0, v0, :cond_8

    .line 2114
    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object p0

    return-object p0

    .line 2116
    :cond_8
    return-object v1
.end method

.method private static describeAccountInfoValidity(Ljava/lang/Object;)Ljava/lang/String;
    .locals 7

    .line 2586
    if-nez p0, :cond_0

    .line 2587
    const-string p0, "null"

    return-object p0

    .line 2590
    :cond_0
    :try_start_0
    const-string v0, "a"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 2591
    const-string v2, "f"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 2592
    const-string v3, "d"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 2593
    const-string v4, "e"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {p0, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 2594
    const-string v5, "c"

    new-array v6, v1, [Ljava/lang/Object;

    invoke-static {p0, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 2595
    const-string v6, "g"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v6, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2596
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "valid="

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ", authToken="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 2597
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->present(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", serviceToken="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 2598
    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->present(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", security="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 2599
    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->present(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", userId="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 2600
    invoke-static {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->present(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", ph="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 2601
    invoke-static {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->present(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2596
    return-object p0

    .line 2602
    :catchall_0
    move-exception p0

    .line 2603
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "probeFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeBizStatusResponse(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .line 2518
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "needWait="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "needWait"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", failed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "isFailed"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2519
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", message="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getMessage"

    new-array v2, v2, [Ljava/lang/Object;

    .line 2520
    invoke-static {p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2518
    return-object p0

    .line 2521
    :catchall_0
    move-exception p0

    .line 2522
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "bizResponseFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeCallbackPayableCard(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .line 2483
    :try_start_0
    const-string v0, "a"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describePayableCardInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2484
    :catchall_0
    move-exception p0

    .line 2485
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "callbackCardFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeCardInfo(Ljava/lang/Object;)Ljava/lang/String;
    .locals 2

    .line 2424
    if-nez p0, :cond_0

    .line 2425
    const-string p0, "null"

    return-object p0

    .line 2428
    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mCardType"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", name="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mCardName"

    .line 2429
    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2428
    return-object p0

    .line 2430
    :catchall_0
    move-exception p0

    .line 2431
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "cardFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeCommonResponse(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .line 2491
    :try_start_0
    const-string v0, "getErrorCode"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 2492
    const-string v2, "getErrorDesc"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 2493
    const-string v3, "isSuccess"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2494
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "success="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ", errCode="

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", errDesc="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2495
    :catchall_0
    move-exception p0

    .line 2496
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "responseFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeConfirmBizStatus(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .line 2527
    if-nez p0, :cond_0

    .line 2528
    const-string p0, "null"

    return-object p0

    .line 2531
    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{orderId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getOrderId"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", cardName="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getCardName"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2532
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", businessId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getBusinessId"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2533
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", sessionId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getSessionId"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2534
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->presentValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", cardCategory="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getCardCategory"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2535
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", actionType="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getActionType"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2536
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", result="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getResult"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2537
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", errorCode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getErrorCode"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2538
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", errorDesc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getErrorDesc"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2539
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", coreOperation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getCoreOperation"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2540
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", extra="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getExtra"

    new-array v3, v2, [Ljava/lang/Object;

    .line 2541
    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->presentValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", orderSource="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getOrderSource"

    new-array v2, v2, [Ljava/lang/Object;

    .line 2542
    invoke-static {p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const/16 v0, 0x7d

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2531
    return-object p0

    .line 2544
    :catchall_0
    move-exception p0

    .line 2545
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "confirmInfoFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeModelResult(Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .line 2550
    if-nez p0, :cond_0

    .line 2551
    const-string p0, "null"

    return-object p0

    .line 2554
    :cond_0
    const/16 v0, 0x7d

    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeObject(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "{success="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "c"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    .line 2555
    invoke-static {p0, v2, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", code="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "a"

    new-array v4, v3, [Ljava/lang/Object;

    .line 2556
    invoke-static {p0, v2, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", message="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "b"

    new-array v3, v3, [Ljava/lang/Object;

    .line 2557
    invoke-static {p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2554
    return-object p0

    .line 2559
    :catchall_0
    move-exception v1

    .line 2560
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeObject(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v2, "{modelResultFailed="

    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeObject(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .line 2356
    if-nez p0, :cond_0

    .line 2357
    const-string p0, "null"

    return-object p0

    .line 2359
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    .line 2360
    const-string v1, "com.xiaomi.accountsdk.account.data.MiLoginResult"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2362
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "{code="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "u"

    invoke-static {p0, v2}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, "}"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2363
    :catchall_0
    move-exception p0

    .line 2364
    return-object v0

    .line 2367
    :cond_1
    return-object v0
.end method

.method private static describeOrderResponse(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .line 2502
    :try_start_0
    const-string v0, "getOrderInfo"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2503
    if-nez p0, :cond_0

    .line 2504
    const-string p0, "null"

    return-object p0

    .line 2506
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeObject(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 2507
    const-string v1, "mOrderId"

    const-string v2, "orderId"

    invoke-static {v0, p0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendObjectField(Ljava/lang/StringBuilder;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;)V

    .line 2508
    const-string v1, "mOrderStatus"

    const-string v2, "status"

    invoke-static {v0, p0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendObjectField(Ljava/lang/StringBuilder;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;)V

    .line 2509
    const-string v1, "mOrderType"

    const-string v2, "type"

    invoke-static {v0, p0, v1, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendObjectField(Ljava/lang/StringBuilder;Ljava/lang/Object;Ljava/lang/String;Ljava/lang/String;)V

    .line 2510
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2511
    :catchall_0
    move-exception p0

    .line 2512
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "orderFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describePayableCardInfo(Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .line 2436
    if-nez p0, :cond_0

    .line 2437
    const-string p0, "null"

    return-object p0

    .line 2439
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 2441
    :try_start_0
    const-string v1, "type="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mCardType"

    invoke-static {p0, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2444
    goto :goto_0

    .line 2442
    :catchall_0
    move-exception v1

    .line 2443
    const-string v1, "type=?"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2446
    :goto_0
    :try_start_1
    const-string v1, ", name="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "mCardName"

    invoke-static {p0, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 2448
    goto :goto_1

    .line 2447
    :catchall_1
    move-exception v1

    .line 2450
    :goto_1
    const/4 v1, 0x0

    :try_start_2
    const-string v2, ", orderId="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "getOrderId"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 2452
    goto :goto_2

    .line 2451
    :catchall_2
    move-exception v2

    .line 2454
    :goto_2
    :try_start_3
    const-string v2, ", transferOutToken="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "getTransferOutToken"

    new-array v4, v1, [Ljava/lang/Object;

    .line 2455
    invoke-static {p0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->presentValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 2457
    goto :goto_3

    .line 2456
    :catchall_3
    move-exception v2

    .line 2459
    :goto_3
    :try_start_4
    const-string v2, "getUnfinishTransferOutInfo"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2460
    const-string v1, ", unfinishTransferOut="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeTransferOutOrderInfo(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    .line 2463
    goto :goto_4

    .line 2461
    :catchall_4
    move-exception p0

    .line 2462
    const-string v1, ", unfinishTransferOutFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2464
    :goto_4
    const/16 p0, 0x7d

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 2465
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeRequestParams(Ljava/lang/Object;)Ljava/lang/String;
    .locals 5

    .line 2372
    :try_start_0
    const-string v0, "n"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2373
    instance-of v0, p0, Ljava/util/Map;

    if-nez v0, :cond_0

    .line 2374
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeObject(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 2376
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "{"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 2377
    check-cast p0, Ljava/util/Map;

    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 2378
    check-cast v1, Ljava/util/Map$Entry;

    .line 2379
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    const/4 v3, 0x1

    if-le v2, v3, :cond_1

    .line 2380
    const-string v2, ", "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2382
    :cond_1
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 2383
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 2384
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0x3d

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v2, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->sanitizeStartTransferParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2385
    goto :goto_0

    .line 2386
    :cond_2
    const/16 p0, 0x7d

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 2387
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 2388
    :catchall_0
    move-exception p0

    .line 2389
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "paramsFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;
    .locals 3

    .line 2578
    if-nez p0, :cond_0

    .line 2579
    const-string p0, "null"

    return-object p0

    .line 2581
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 2582
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    if-nez v0, :cond_1

    const-string v0, ""

    goto :goto_0

    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static describeTransferOutOrderInfo(Ljava/lang/Object;)Ljava/lang/String;
    .locals 4

    .line 2469
    if-nez p0, :cond_0

    .line 2470
    const-string p0, "null"

    return-object p0

    .line 2473
    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "{orderId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getOrderId"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", token="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "getTransferOutToken"

    new-array v2, v2, [Ljava/lang/Object;

    .line 2474
    invoke-static {p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->presentValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const/16 v0, 0x7d

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2473
    return-object p0

    .line 2476
    :catchall_0
    move-exception p0

    .line 2477
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "transferOutInfoFailed="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static disableTsmNfcReaderMode(Landroid/app/Activity;)V
    .locals 2

    .line 2003
    :try_start_0
    invoke-static {p0}, Landroid/nfc/NfcAdapter;->getDefaultAdapter(Landroid/content/Context;)Landroid/nfc/NfcAdapter;

    move-result-object v0

    .line 2004
    if-eqz v0, :cond_0

    .line 2005
    invoke-virtual {v0, p0}, Landroid/nfc/NfcAdapter;->disableReaderMode(Landroid/app/Activity;)V

    .line 2006
    const-string p0, "TSM NFC reader mode disarmed"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2010
    :cond_0
    goto :goto_0

    .line 2008
    :catchall_0
    move-exception p0

    .line 2009
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "TSM NFC reader mode disarm failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2011
    :goto_0
    return-void
.end method

.method private static enableTsmNfcReaderMode(Landroid/app/Activity;Ljava/lang/Object;)V
    .locals 3

    .line 1969
    :try_start_0
    invoke-static {p0}, Landroid/nfc/NfcAdapter;->getDefaultAdapter(Landroid/content/Context;)Landroid/nfc/NfcAdapter;

    move-result-object v0

    .line 1970
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/nfc/NfcAdapter;->isEnabled()Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 1974
    :cond_0
    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;

    invoke-direct {v1, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$34;-><init>(Ljava/lang/Object;)V

    const/16 p1, 0x81

    const/4 v2, 0x0

    invoke-virtual {v0, p0, v1, p1, v2}, Landroid/nfc/NfcAdapter;->enableReaderMode(Landroid/app/Activity;Landroid/nfc/NfcAdapter$ReaderCallback;ILandroid/os/Bundle;)V

    .line 1994
    const-string p0, "TSM NFC reader mode armed"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1998
    goto :goto_1

    .line 1971
    :cond_1
    :goto_0
    const-string p0, "TSM NFC reader mode unavailable: adapter disabled"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1972
    return-void

    .line 1995
    :catchall_0
    move-exception p0

    .line 1996
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM NFC reader mode arm failed: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1997
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1999
    :goto_1
    return-void
.end method

.method private static getTerminalName(Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .line 2128
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "mTerminal"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 2129
    if-nez p0, :cond_0

    .line 2130
    return-object v0

    .line 2132
    :cond_0
    const-string v1, "getName"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2133
    if-nez p0, :cond_1

    goto :goto_0

    :cond_1
    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    return-object v0

    .line 2134
    :catchall_0
    move-exception p0

    .line 2135
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SE terminal lookup failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2136
    return-object v0
.end method

.method private static varargs hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V
    .locals 2

    .line 2300
    const-string v0, "."

    :try_start_0
    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$37;

    invoke-direct {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$37;-><init>()V

    invoke-static {p4, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p4

    .line 2306
    invoke-static {p1, p0, p2, p4}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 2307
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "hooked "

    invoke-virtual {p0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p4, " -> no-op"

    invoke-virtual {p0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2311
    goto :goto_1

    .line 2308
    :catchall_0
    move-exception p0

    .line 2309
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p3, :cond_0

    const-string p3, "critical "

    goto :goto_0

    :cond_0
    const-string p3, "optional "

    :goto_0
    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, "hook failed: "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2310
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 2312
    :goto_1
    return-void
.end method

.method private static varargs hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V
    .locals 2

    .line 2321
    const-string v0, "."

    :try_start_0
    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$38;

    invoke-direct {v1, p1, p2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$38;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p4, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p4

    .line 2340
    invoke-static {p1, p0, p2, p4}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 2341
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "probe hooked "

    invoke-virtual {p0, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2345
    goto :goto_1

    .line 2342
    :catchall_0
    move-exception p0

    .line 2343
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p3, :cond_0

    const-string p3, "critical "

    goto :goto_0

    :cond_0
    const-string p3, "optional "

    :goto_0
    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, "probe failed: "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2344
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 2346
    :goto_1
    return-void
.end method

.method private static varargs hookReturnBoolean(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/Object;)V
    .locals 2

    .line 2284
    const-string v0, "."

    :try_start_0
    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v1}, Lde/robv/android/xposed/XC_MethodReplacement;->returnConstant(Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodReplacement;

    move-result-object v1

    invoke-static {p5, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p5

    .line 2285
    invoke-static {p1, p0, p2, p5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 2286
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "hooked "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p5, " -> "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2290
    goto :goto_1

    .line 2287
    :catchall_0
    move-exception p0

    .line 2288
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p4, :cond_0

    const-string p4, "critical "

    goto :goto_0

    :cond_0
    const-string p4, "optional "

    :goto_0
    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, "hook failed: "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2289
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 2291
    :goto_1
    return-void
.end method

.method private static varargs hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V
    .locals 2

    .line 2250
    const-string v0, "."

    :try_start_0
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v1}, Lde/robv/android/xposed/XC_MethodReplacement;->returnConstant(Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodReplacement;

    move-result-object v1

    invoke-static {p5, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p5

    .line 2251
    invoke-static {p1, p0, p2, p5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 2252
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "hooked "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p5, " -> "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2256
    goto :goto_1

    .line 2253
    :catchall_0
    move-exception p0

    .line 2254
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p4, :cond_0

    const-string p4, "critical "

    goto :goto_0

    :cond_0
    const-string p4, "optional "

    :goto_0
    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, "hook failed: "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2255
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 2257
    :goto_1
    return-void
.end method

.method private static varargs hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V
    .locals 2

    .line 2267
    const-string v0, "."

    :try_start_0
    invoke-static {p3}, Lde/robv/android/xposed/XC_MethodReplacement;->returnConstant(Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodReplacement;

    move-result-object v1

    invoke-static {p5, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->appendCallback([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p5

    .line 2268
    invoke-static {p1, p0, p2, p5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 2269
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "hooked "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p5, " -> "

    invoke-virtual {p0, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {p3}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2273
    goto :goto_1

    .line 2270
    :catchall_0
    move-exception p0

    .line 2271
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p4, :cond_0

    const-string p4, "critical "

    goto :goto_0

    :cond_0
    const-string p4, "optional "

    :goto_0
    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string p4, "hook failed: "

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 2272
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 2274
    :goto_1
    return-void
.end method

.method private static injectOwnAccountPh(Ljava/lang/ClassLoader;Ljava/lang/Object;Landroid/accounts/Account;Landroid/os/Bundle;)Z
    .locals 3

    .line 1132
    const-string v0, "ph"

    invoke-virtual {p3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 1133
    const-string p0, "Xiaomi Account own tsm-auth already has ph"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1134
    return v2

    .line 1137
    :cond_0
    :try_start_0
    const-string v1, "c"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    .line 1138
    instance-of v1, p1, Landroid/content/Context;

    if-eqz v1, :cond_3

    if-nez p2, :cond_1

    goto :goto_0

    .line 1142
    :cond_1
    const-string v1, "com.xiaomi.passport.accountmanager.i"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 1144
    const-string v1, "x"

    check-cast p1, Landroid/content/Context;

    .line 1145
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 1144
    invoke-static {p0, v1, p1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 1146
    const-string p1, "getUserData"

    const-string v1, "tsm-auth_ph"

    filled-new-array {p2, v1}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/String;

    .line 1147
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 1148
    const-string p0, "Xiaomi Account own tsm-auth_ph missing in userData"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1149
    return v2

    .line 1151
    :cond_2
    invoke-virtual {p3, v0, p0}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 1152
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Xiaomi Account own tsm-auth ph injected, length="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1153
    const/4 p0, 0x1

    return p0

    .line 1139
    :cond_3
    :goto_0
    const-string p0, "Xiaomi Account own tsm-auth ph skipped: no context/account"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1140
    return v2

    .line 1154
    :catchall_0
    move-exception p0

    .line 1155
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "Xiaomi Account own tsm-auth ph injection failed: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1156
    return v2
.end method

.method private static installConfirmBizStatusDiagnostics(Ljava/lang/ClassLoader;)V
    .locals 5

    .line 1421
    const-string v0, "com.miui.tsmclient.entity.ConfirmBizStatusInfo"

    :try_start_0
    const-string v1, "upload"

    const-class v2, Landroid/content/Context;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$18;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$18;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1445
    const-string v1, "hooked TSM confirm upload diagnostics"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1449
    goto :goto_0

    .line 1446
    :catchall_0
    move-exception v1

    .line 1447
    const-string v2, "optional TSM confirm upload diagnostics failed"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1448
    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1452
    :goto_0
    :try_start_1
    const-string v1, "n6.e"

    const-class v2, Landroid/content/Context;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$19;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$19;-><init>()V

    filled-new-array {v2, v0, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, p0, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookConstructor(Ljava/lang/String;Ljava/lang/ClassLoader;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1465
    const-string v0, "hooked TSM confirm request constructor diagnostics"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1469
    goto :goto_1

    .line 1466
    :catchall_1
    move-exception v0

    .line 1467
    const-string v1, "optional TSM confirm request constructor diagnostics failed"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1468
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1472
    :goto_1
    :try_start_2
    const-string v0, "h5.a"

    const-string v1, "e"

    const-class v2, Ljava/lang/String;

    const-class v3, Ljava/lang/String;

    new-instance v4, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$20;

    invoke-direct {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$20;-><init>()V

    filled-new-array {v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1493
    const-string v0, "hooked TSM confirm param diagnostics"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1497
    goto :goto_2

    .line 1494
    :catchall_2
    move-exception v0

    .line 1495
    const-string v1, "optional TSM confirm param diagnostics failed"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1496
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1500
    :goto_2
    :try_start_3
    const-string v0, "h5.f$a"

    const-string v1, "d"

    const-string v2, "c5.a"

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$21;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$21;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1517
    const-string p0, "hooked TSM confirm response diagnostics"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 1521
    goto :goto_3

    .line 1518
    :catchall_3
    move-exception p0

    .line 1519
    const-string v0, "optional TSM confirm response diagnostics failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1520
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1522
    :goto_3
    return-void
.end method

.method private static installLoginProbes(Ljava/lang/ClassLoader;)V
    .locals 14

    .line 2179
    nop

    .line 2180
    nop

    .line 2182
    const-class v0, Ljava/lang/String;

    const-class v1, Ljava/lang/String;

    const-class v2, Ljava/lang/String;

    const-class v3, Ljava/lang/String;

    const-class v4, Ljava/lang/String;

    filled-new-array {v0, v1, v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "com.xiaomi.account.ui.s"

    const-string v2, "K"

    const/4 v3, 0x0

    invoke-static {p0, v1, v2, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2184
    const-string v0, "com.xiaomi.passport.uicontroller.a$d"

    const-string v1, "com.xiaomi.accountsdk.account.data.PasswordLoginParams"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "com.xiaomi.passport.uicontroller.b"

    const-string v4, "f"

    invoke-static {p0, v2, v4, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2186
    new-array v0, v3, [Ljava/lang/Object;

    const-string v2, "m6.b"

    const-string v5, "b"

    invoke-static {p0, v2, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2187
    const-class v0, Landroid/content/ComponentName;

    const-class v6, Landroid/os/IBinder;

    filled-new-array {v0, v6}, [Ljava/lang/Object;

    move-result-object v0

    const-string v6, "onServiceConnected"

    invoke-static {p0, v2, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2189
    const-class v0, Landroid/content/ComponentName;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v6, "onNullBinding"

    invoke-static {p0, v2, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2190
    const-class v0, Landroid/content/ComponentName;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v6, "onBindingDied"

    invoke-static {p0, v2, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2191
    const-class v0, Landroid/content/ComponentName;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v6, "onServiceDisconnected"

    invoke-static {p0, v2, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2192
    const-string v0, "l"

    new-array v2, v3, [Ljava/lang/Object;

    const-string v6, "com.xiaomi.passport.uicontroller.b$a"

    invoke-static {p0, v6, v0, v3, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2193
    const-string v0, "loginByPassword"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v2

    const-string v6, "com.xiaomi.passport.MiPassportUIControllerService$a"

    invoke-static {p0, v6, v0, v3, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2195
    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "com.xiaomi.passport.utils.a"

    const-string v6, "n"

    invoke-static {p0, v2, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2197
    new-array v0, v3, [Ljava/lang/Object;

    const-string v7, "d"

    invoke-static {p0, v2, v7, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2198
    const-string v0, "J"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "com.xiaomi.accountsdk.account.f"

    invoke-static {p0, v2, v0, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2200
    const-string v0, "r6.k"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p0, v2, v6, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2202
    const-class v1, Ljava/lang/String;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v6, "a"

    invoke-static {p0, v2, v6, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2204
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v2, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2206
    const-string v0, "s"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v2, v0, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2207
    const-class v0, Ljava/lang/String;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "r6.g"

    const-string v2, "e"

    invoke-static {p0, v1, v2, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2208
    const-string v0, "g"

    new-array v1, v3, [Ljava/lang/Object;

    const-string v8, "r6.m0"

    invoke-static {p0, v8, v0, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2209
    const-class v0, Landroid/content/Context;

    const-string v1, "f5.b"

    const-class v8, [Ljava/lang/String;

    filled-new-array {v0, v1, v8}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "f5.a"

    const-string v8, "c"

    invoke-static {p0, v1, v8, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2211
    const-string v0, "b6.u"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v5, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2212
    const-class v0, Landroid/content/Context;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "i4.c$b"

    invoke-static {p0, v1, v8, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2213
    const-class v0, Landroid/content/Context;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "i4.c"

    invoke-static {p0, v1, v7, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2214
    const-string v0, "p6.k"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v5, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2215
    const-string v0, "p6.j"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v6, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2216
    const-string v0, "p6.n$b"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, v0, v6, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2217
    const-class v7, Ljava/lang/String;

    const-class v8, Ljava/util/Map;

    const-class v9, Ljava/util/Map;

    const-class v10, Ljava/util/Map;

    const-class v11, Ljava/util/Map;

    sget-object v12, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-class v13, Ljava/lang/Integer;

    filled-new-array/range {v7 .. v13}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "p6.s"

    const-string v5, "k"

    invoke-static {p0, v1, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2220
    const-class v0, Ljava/lang/String;

    const-class v1, Ljava/util/Map;

    const-class v5, Ljava/util/Map;

    const-class v6, Ljava/lang/Integer;

    filled-new-array {v0, v1, v5, v6}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "p6.r"

    const-string v5, "r"

    invoke-static {p0, v1, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2222
    const-class v6, Ljava/lang/String;

    const-class v7, Ljava/util/Map;

    const-class v8, Ljava/util/Map;

    const-class v9, Ljava/util/Map;

    const-class v10, Ljava/util/Map;

    sget-object v11, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-class v12, Ljava/lang/Integer;

    filled-new-array/range {v6 .. v12}, [Ljava/lang/Object;

    move-result-object v0

    const-string v5, "u"

    invoke-static {p0, v1, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2225
    new-array v0, v3, [Ljava/lang/Object;

    const-string v1, "com.android.okhttp.internal.huc.HttpURLConnectionImpl"

    const-string v5, "connect"

    invoke-static {p0, v1, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2226
    new-array v0, v3, [Ljava/lang/Object;

    const-string v6, "getResponseCode"

    invoke-static {p0, v1, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2227
    new-array v0, v3, [Ljava/lang/Object;

    const-string v7, "getOutputStream"

    invoke-static {p0, v1, v7, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2228
    new-array v0, v3, [Ljava/lang/Object;

    const-string v8, "getInputStream"

    invoke-static {p0, v1, v8, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2229
    new-array v0, v3, [Ljava/lang/Object;

    const-string v1, "com.android.okhttp.internal.huc.HttpsURLConnectionImpl"

    invoke-static {p0, v1, v5, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2230
    new-array v0, v3, [Ljava/lang/Object;

    invoke-static {p0, v1, v6, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2231
    new-array v0, v3, [Ljava/lang/Object;

    invoke-static {p0, v1, v7, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2232
    new-array v0, v3, [Ljava/lang/Object;

    invoke-static {p0, v1, v8, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2233
    const-class v0, Ljava/lang/Object;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "m6.a"

    invoke-static {p0, v1, v2, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2234
    const-class v0, Ljava/lang/Throwable;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v1, v4, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2235
    const-string v0, "done"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-static {p0, v1, v0, v3, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2236
    const-string v0, "h"

    const-string v1, "com.xiaomi.accountsdk.account.data.MiLoginResult"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "com.xiaomi.passport.uicontroller.a$c"

    invoke-static {p0, v2, v0, v3, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2238
    const-class v0, Ljava/util/concurrent/ExecutionException;

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "i"

    invoke-static {p0, v2, v1, v3, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookProbe(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 2240
    return-void
.end method

.method private static installSecureElementHook(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 1750
    const-class v0, [B

    :try_start_0
    const-string v1, "com.android.se.security.AccessControlEnforcer"

    const-string v2, "setUpChannelAccess"

    const-class v3, Ljava/lang/String;

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$27;

    invoke-direct {v5, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$27;-><init>(Ljava/lang/ClassLoader;)V

    filled-new-array {v0, v3, v0, v4, v5}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, p0, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1783
    const-string p0, "hooked com.android.se.security.AccessControlEnforcer.setUpChannelAccess"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1787
    goto :goto_0

    .line 1784
    :catchall_0
    move-exception p0

    .line 1785
    const-string v0, "critical SE hook failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1786
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1788
    :goto_0
    return-void
.end method

.method private static installStartTransferInDiagnostics(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 1315
    const-string v0, "n6.f2"

    :try_start_0
    const-class v1, Landroid/content/Context;

    const-string v2, "com.miui.tsmclient.entity.PayableCardInfo"

    const-string v3, "e5.i"

    new-instance v4, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$14;

    invoke-direct {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$14;-><init>()V

    filled-new-array {v1, v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookConstructor(Ljava/lang/String;Ljava/lang/ClassLoader;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1329
    const-string v1, "hooked TSM startTransferIn constructor diagnostics"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1333
    goto :goto_0

    .line 1330
    :catchall_0
    move-exception v1

    .line 1331
    const-string v2, "optional TSM startTransferIn constructor diagnostics failed"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1332
    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1336
    :goto_0
    :try_start_1
    const-string v1, "h5.a"

    const-string v2, "e"

    const-class v3, Ljava/lang/String;

    const-class v4, Ljava/lang/String;

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$15;

    invoke-direct {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$15;-><init>()V

    filled-new-array {v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1360
    const-string v1, "hooked TSM startTransferIn param diagnostics"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1364
    goto :goto_1

    .line 1361
    :catchall_1
    move-exception v1

    .line 1362
    const-string v2, "optional TSM startTransferIn param diagnostics failed"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1363
    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1367
    :goto_1
    :try_start_2
    const-string v1, "b"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$16;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$16;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1384
    const-string v0, "hooked TSM startTransferIn extra-param diagnostics"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1388
    goto :goto_2

    .line 1385
    :catchall_2
    move-exception v0

    .line 1386
    const-string v1, "optional TSM startTransferIn extra-param diagnostics failed"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1387
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1391
    :goto_2
    :try_start_3
    const-string v0, "h5.f$a"

    const-string v1, "d"

    const-string v2, "c5.a"

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$17;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$17;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1408
    const-string p0, "hooked TSM startTransferIn response diagnostics"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 1412
    goto :goto_3

    .line 1409
    :catchall_3
    move-exception p0

    .line 1410
    const-string v0, "optional TSM startTransferIn response diagnostics failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1411
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1413
    :goto_3
    return-void
.end method

.method private static installSystemPowerWalletGestureHook(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 137
    const-string v0, "com.android.server.GestureLauncherService"

    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isPowerGestureHookDisabled()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 138
    const-string p0, "system power wallet hook disabled by safety switch or legacy script conflict"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 139
    return-void

    .line 142
    :cond_0
    :try_start_0
    const-string v1, "handleWalletGesture"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$1;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 166
    const-string v1, "interceptPowerKeyDown"

    const-string v2, "android.view.KeyEvent"

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    const-string v4, "android.util.MutableBoolean"

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$2;

    invoke-direct {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$2;-><init>()V

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 227
    const-string p0, "hooked system power gestures: double=Xiaomi cards, triple=Google Wallet"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 231
    goto :goto_0

    .line 228
    :catchall_0
    move-exception p0

    .line 229
    const-string v0, "critical system power wallet gesture hook failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 230
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 232
    :goto_0
    return-void
.end method

.method private static installTransferCardModelDiagnostics(Ljava/lang/ClassLoader;)V
    .locals 7

    .line 1555
    const-string v0, "com.miui.tsmclient.entity.OrderResponseInfo"

    const-string v1, "com.miui.tsmclient.model.e1$a"

    const-string v2, "com.miui.tsmclient.entity.PayableCardInfo"

    const-string v3, "com.miui.tsmclient.model.e1"

    :try_start_0
    const-string v4, "o"

    const-string v5, "e5.i"

    new-instance v6, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$22;

    invoke-direct {v6}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$22;-><init>()V

    filled-new-array {v2, v5, v6}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, p0, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1579
    const-string v4, "hooked TSM transfer model o diagnostics"

    invoke-static {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1583
    goto :goto_0

    .line 1580
    :catchall_0
    move-exception v4

    .line 1581
    const-string v5, "optional TSM transfer model o diagnostics failed"

    invoke-static {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1582
    invoke-static {v4}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1586
    :goto_0
    :try_start_1
    const-string v4, "p"

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$23;

    invoke-direct {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$23;-><init>()V

    filled-new-array {v2, v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, p0, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1609
    const-string v4, "hooked TSM transfer model p diagnostics"

    invoke-static {v4}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1613
    goto :goto_1

    .line 1610
    :catchall_1
    move-exception v4

    .line 1611
    const-string v5, "optional TSM transfer model p diagnostics failed"

    invoke-static {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1612
    invoke-static {v4}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1616
    :goto_1
    :try_start_2
    const-string v4, "q"

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$24;

    invoke-direct {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$24;-><init>()V

    filled-new-array {v2, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v3, p0, v4, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1639
    const-string v2, "hooked TSM transfer model q diagnostics"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1643
    goto :goto_2

    .line 1640
    :catchall_2
    move-exception v2

    .line 1641
    const-string v3, "optional TSM transfer model q diagnostics failed"

    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1642
    invoke-static {v2}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1646
    :goto_2
    :try_start_3
    const-string v2, "c"

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v4, Ljava/lang/String;

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$25;

    invoke-direct {v5}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$25;-><init>()V

    filled-new-array {v3, v4, v0, v5}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1662
    const-string v2, "d"

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$26;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$26;-><init>()V

    filled-new-array {v0, v3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, p0, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1675
    const-string p0, "hooked TSM transfer callback diagnostics"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 1679
    goto :goto_3

    .line 1676
    :catchall_3
    move-exception p0

    .line 1677
    const-string v0, "optional TSM transfer callback diagnostics failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1678
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1680
    :goto_3
    return-void
.end method

.method private static installTsmAccountPhHook(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 1166
    :try_start_0
    const-string v0, "w4.d$b"

    const-string v1, "run"

    const-class v2, Landroid/accounts/AccountManagerFuture;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$11;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$11;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1204
    const-string v0, "w4.d"

    const-string v1, "h"

    const-class v2, Landroid/content/Context;

    const-class v3, Ljava/lang/String;

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    new-instance v5, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$12;

    invoke-direct {v5, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$12;-><init>(Ljava/lang/ClassLoader;)V

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1264
    const-string p0, "hooked TSM account ph compatibility"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1268
    goto :goto_0

    .line 1265
    :catchall_0
    move-exception p0

    .line 1266
    const-string v0, "critical TSM account ph hook failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1267
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1269
    :goto_0
    return-void
.end method

.method private static installTsmAccountValidationProbe(Ljava/lang/ClassLoader;)V
    .locals 4

    .line 1287
    :try_start_0
    const-string v0, "n6.e"

    const-string v1, "L"

    const-class v2, Landroid/content/Context;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$13;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$13;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1306
    const-string p0, "hooked TSM BizStatus account validation probe"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1310
    goto :goto_0

    .line 1307
    :catchall_0
    move-exception p0

    .line 1308
    const-string v0, "optional TSM BizStatus validation probe failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1309
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1311
    :goto_0
    return-void
.end method

.method private static installTsmNfcForegroundDispatchFix(Ljava/lang/ClassLoader;)V
    .locals 4

    .line 1835
    const-string v0, "com.miui.tsmclient.ui.BaseActivity"

    :try_start_0
    const-string v1, "com.tsmclient.smartcard.handler.TagReader"

    const-string v2, "startPoll"

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$29;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$29;-><init>()V

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v1, p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1855
    const-string v1, "hooked TSM legacy NFC dispatch suppression"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1859
    goto :goto_0

    .line 1856
    :catchall_0
    move-exception v1

    .line 1857
    const-string v2, "critical TSM legacy NFC dispatch suppression hook failed"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1858
    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1862
    :goto_0
    :try_start_1
    const-string v1, "onResume"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$30;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$30;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1876
    const-string v1, "hooked TSM NFC foreground dispatch lifecycle"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1880
    goto :goto_1

    .line 1877
    :catchall_1
    move-exception v1

    .line 1878
    const-string v2, "critical TSM NFC foreground dispatch hook failed"

    invoke-static {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1879
    invoke-static {v1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1883
    :goto_1
    :try_start_2
    const-string v1, "onPause"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$31;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$31;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1896
    const-string v0, "hooked TSM NFC reader-mode lifecycle"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 1900
    goto :goto_2

    .line 1897
    :catchall_2
    move-exception v0

    .line 1898
    const-string v1, "critical TSM NFC reader-mode lifecycle hook failed"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1899
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1903
    :goto_2
    :try_start_3
    const-string v0, "com.miui.tsmclient.ui.d9"

    const-string v1, "r4"

    const-class v2, Landroid/content/Intent;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$32;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$32;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1920
    const-string p0, "hooked TSM NFC tag delivery diagnostics"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 1924
    goto :goto_3

    .line 1921
    :catchall_3
    move-exception p0

    .line 1922
    const-string v0, "optional TSM NFC tag delivery diagnostics failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1923
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1925
    :goto_3
    return-void
.end method

.method private static installXiaomiAccountTsmPhHook(Ljava/lang/ClassLoader;)V
    .locals 7

    .line 1038
    :try_start_0
    const-string v0, "com.xiaomi.passport.accountmanager.e"

    const-string v1, "h"

    const-string v2, "com.xiaomi.accounts.AccountAuthenticatorResponse"

    const-class v3, Landroid/accounts/Account;

    const-class v4, Ljava/lang/String;

    const-class v5, Landroid/os/Bundle;

    new-instance v6, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$9;

    invoke-direct {v6, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$9;-><init>(Ljava/lang/ClassLoader;)V

    filled-new-array {v2, v3, v4, v5, v6}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1063
    const-string v0, "hooked Xiaomi Account own tsm-auth ph injection"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1067
    goto :goto_0

    .line 1064
    :catchall_0
    move-exception v0

    .line 1065
    const-string v1, "critical Xiaomi Account own tsm-auth ph hook failed"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1066
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1070
    :goto_0
    :try_start_1
    const-string v0, "v3.c"

    const-string v1, "getAuthToken"

    const-class v2, Landroid/accounts/AccountAuthenticatorResponse;

    const-class v3, Landroid/accounts/Account;

    const-class v4, Ljava/lang/String;

    const-class v5, Landroid/os/Bundle;

    new-instance v6, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$10;

    invoke-direct {v6}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$10;-><init>()V

    filled-new-array {v2, v3, v4, v5, v6}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1120
    const-string p0, "hooked Xiaomi Account tsm-auth ph injection"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1124
    goto :goto_1

    .line 1121
    :catchall_1
    move-exception p0

    .line 1122
    const-string v0, "critical Xiaomi Account tsm-auth ph hook failed"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1123
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1125
    :goto_1
    return-void
.end method

.method private static installXiaomiEseRoutingHook(Ljava/lang/ClassLoader;)V
    .locals 4

    .line 399
    const-string v0, "com.android.nfc.cardemulation.CardEmulationManager"

    :try_start_0
    const-string v1, "com.android.nfc.NfcService"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    .line 401
    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$3;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$3;-><init>()V

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedBridge;->hookAllConstructors(Ljava/lang/Class;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 412
    const-string v1, "onNfcEnabled"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$4;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$4;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 423
    const-string v1, "onNfcDisabled"

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$5;

    invoke-direct {v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$5;-><init>()V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 434
    const-string v1, "onRoutingChangeCompleted"

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v3, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$6;

    invoke-direct {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$6;-><init>()V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 446
    const-string v0, "com.android.nfc.cardemulation.RoutingOptionManager"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 448
    const-string v0, "recoverOverridedRoutingTable"

    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$7;

    invoke-direct {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$7;-><init>()V

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 457
    const-string v0, "overwriteRoutingTable"

    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$8;

    invoke-direct {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$8;-><init>()V

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookAllMethods(Ljava/lang/Class;Ljava/lang/String;Lde/robv/android/xposed/XC_MethodHook;)Ljava/util/Set;

    .line 466
    const-string p0, "hooked Android 16 Xiaomi eSE routing controller"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 470
    goto :goto_0

    .line 467
    :catchall_0
    move-exception p0

    .line 468
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "critical Android 16 eSE routing hook failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 469
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 471
    :goto_0
    return-void
.end method

.method private static installXiaomiNfcHook(Ljava/lang/ClassLoader;Ljava/lang/String;)V
    .locals 14

    .line 1791
    new-instance v0, Ljava/io/File;

    const-string v1, "/data/local/tmp/disable-xiaomi-nfc-hook"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1792
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "MI NFC hook disabled by /data/local/tmp/disable-xiaomi-nfc-hook for "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1793
    return-void

    .line 1797
    :cond_0
    :try_start_0
    const-string v0, "com.xiaomi.nfc.MiNfcAdapter"

    const-class v1, Landroid/content/Context;

    new-instance v2, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$28;

    invoke-direct {v2, p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$28;-><init>(Ljava/lang/ClassLoader;Ljava/lang/String;)V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, p0, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookConstructor(Ljava/lang/String;Ljava/lang/ClassLoader;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1819
    const-string v3, "com.xiaomi.nfc.MiNfcAdapter"

    const-string v4, "getSeRouting"

    const/4 v0, 0x0

    new-array v7, v0, [Ljava/lang/Object;

    const/4 v5, 0x1

    const/4 v6, 0x1

    move-object v2, p0

    invoke-static/range {v2 .. v7}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    move-object v8, v2

    .line 1820
    const-string v9, "com.xiaomi.nfc.MiNfcAdapter"

    const-string v10, "getVersion"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v11, 0x1

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    .line 1821
    const-string v9, "com.xiaomi.nfc.MiNfcAdapter"

    const-string v10, "getChipId"

    const-string v11, "0xa4"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 1822
    const-string v9, "com.xiaomi.nfc.MiNfcAdapter"

    const-string v10, "getChipName"

    const-string v11, "NXP-SN100T"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 1823
    const-string v9, "com.xiaomi.nfc.MiNfcAdapter"

    const-string v10, "getFwVersion"

    const-string v11, "NXP.01.01"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 1824
    const-string v9, "s6.e"

    const-string v10, "a"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v11, 0x1

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnBoolean(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;ZZ[Ljava/lang/Object;)V

    .line 1825
    const-string v9, "s6.e"

    const-string v10, "j"

    new-array v13, v0, [Ljava/lang/Object;

    const/4 v11, 0x1

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    .line 1826
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "hooked MI NFC compatibility for "

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1830
    goto :goto_0

    .line 1827
    :catchall_0
    move-exception v0

    move-object p0, v0

    .line 1828
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "critical MI NFC hook failed for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1829
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1831
    :goto_0
    return-void
.end method

.method private static isActivityAvailable(Landroid/content/Context;Landroid/content/ComponentName;)Z
    .locals 3

    .line 286
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p0

    invoke-virtual {p0, p1, v0}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object p0

    .line 287
    iget-boolean v1, p0, Landroid/content/pm/ActivityInfo;->enabled:Z

    if-eqz v1, :cond_0

    iget-object v1, p0, Landroid/content/pm/ActivityInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    if-eqz v1, :cond_0

    iget-object p0, p0, Landroid/content/pm/ActivityInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-boolean p0, p0, Landroid/content/pm/ApplicationInfo;->enabled:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p0, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 288
    :catchall_0
    move-exception p0

    .line 289
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "power gesture component validation failed component="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " error="

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 290
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 289
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 291
    return v0
.end method

.method private static isConfirmBizStatusRequest(Ljava/lang/Object;)Z
    .locals 1

    .line 1525
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    const-string v0, "n6.e"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static isEmpty(Ljava/lang/String;)Z
    .locals 0

    .line 2624
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    if-nez p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method private static isPowerGestureHookDisabled()Z
    .locals 2

    .line 235
    new-instance v0, Ljava/io/File;

    const-string v1, "/data/local/tmp/disable-xiaomi-power-wallet-hook"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Ljava/io/File;

    const-string v1, "/data/adb/service.d/94-wallet-button-shortcuts.sh"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 236
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 235
    :goto_1
    return v0
.end method

.method private static isStartTransferInRequest(Ljava/lang/Object;)Z
    .locals 1

    .line 1416
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    const-string v0, "n6.f2"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method private static isValidAccountInfo(Ljava/lang/Object;)Z
    .locals 3

    .line 2608
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 2609
    return v0

    .line 2612
    :cond_0
    :try_start_0
    const-string v1, "g"

    new-array v2, v0, [Ljava/lang/Object;

    invoke-static {p0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 2613
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v1, p0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p0

    .line 2614
    :catchall_0
    move-exception p0

    .line 2615
    return v0
.end method

.method private static isXiaomiNfcClient(Ljava/lang/String;)Z
    .locals 5

    .line 2153
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 2154
    return v0

    .line 2156
    :cond_0
    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_NFC_CLIENTS:[Ljava/lang/String;

    array-length v2, v1

    move v3, v0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v1, v3

    .line 2157
    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 2158
    const/4 p0, 0x1

    return p0

    .line 2156
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2161
    :cond_2
    return v0
.end method

.method private static isXiaomiSeClient(Ljava/lang/String;)Z
    .locals 5

    .line 2141
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 2142
    return v0

    .line 2144
    :cond_0
    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->XIAOMI_SE_CLIENTS:[Ljava/lang/String;

    array-length v2, v1

    move v3, v0

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v1, v3

    .line 2145
    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 2146
    const/4 p0, 0x1

    return p0

    .line 2144
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 2149
    :cond_2
    return v0
.end method

.method private static launchGoogleWallet(Ljava/lang/Object;)Z
    .locals 4

    .line 263
    const-string v0, "mContext"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    .line 264
    const-string v1, "mUserId"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p0

    .line 265
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.google.android.apps.walletnfcrel"

    const-string v3, "com.google.commerce.tapandpay.android.wallet.WalletActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 268
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.MAIN"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 269
    const-string v3, "android.intent.category.LAUNCHER"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 270
    invoke-virtual {v2, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 271
    const/high16 v3, 0x34000000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 274
    invoke-static {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isActivityAvailable(Landroid/content/Context;Landroid/content/ComponentName;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 275
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "power gesture target unavailable action=google_wallet component="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 276
    const/4 p0, 0x0

    return p0

    .line 278
    :cond_0
    invoke-static {v0, v2, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->startActivityAsUser(Landroid/content/Context;Landroid/content/Intent;I)V

    .line 279
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "power gesture committed action=google_wallet user="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " component="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 281
    const/4 p0, 0x1

    return p0
.end method

.method private static launchXiaomiCardUi(Ljava/lang/Object;)Z
    .locals 4

    .line 240
    const-string v0, "mContext"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    .line 241
    const-string v1, "mUserId"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p0

    .line 242
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.miui.tsmclient"

    const-string v3, "com.miui.tsmclient.ui.quick.DoubleClickActivity"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 245
    new-instance v2, Landroid/content/Intent;

    const-string v3, "com.miui.intent.action.DOUBLE_CLICK"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 246
    const-string v3, "android.intent.category.DEFAULT"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 247
    invoke-virtual {v2, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 248
    const/high16 v3, 0x34800000

    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 252
    invoke-static {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isActivityAvailable(Landroid/content/Context;Landroid/content/ComponentName;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 253
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "power gesture target unavailable action=xiaomi_cards component="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 254
    const/4 p0, 0x0

    return p0

    .line 256
    :cond_0
    invoke-static {v0, v2, p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->startActivityAsUser(Landroid/content/Context;Landroid/content/Intent;I)V

    .line 257
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "power gesture committed action=xiaomi_cards user="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, " component="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 259
    const/4 p0, 0x1

    return p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 2628
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "XiaomiAccountMiuiIntentFix: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 2629
    return-void
.end method

.method private static normalizeStartTransferParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 1683
    const-string v0, "miuiRomType"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v1, "OTHER"

    if-eqz v0, :cond_1

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1684
    :cond_0
    const-string p0, "STABLE"

    return-object p0

    .line 1686
    :cond_1
    const-string v0, "romType"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1687
    :cond_2
    const-string p0, "MIUI"

    return-object p0

    .line 1689
    :cond_3
    const-string v0, "hyperOSVersion"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_4

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_4

    .line 1690
    const-string p0, "OS3.0.2.0.WMCCNXM"

    return-object p0

    .line 1692
    :cond_4
    return-object p1
.end method

.method private static present(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 2620
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "empty"

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "len="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :goto_0
    return-object p0
.end method

.method private static presentValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 2565
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string p0, "empty"

    goto :goto_0

    .line 2566
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "len="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 2565
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ",prefix="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 2566
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0x8

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 2565
    :goto_0
    return-object p0
.end method

.method private static readStaticTsmAccountInfo(Ljava/lang/ClassLoader;)Ljava/lang/Object;
    .locals 2

    .line 1273
    :try_start_0
    const-string v0, "w4.d"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 1274
    const-string v0, "a"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 1275
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isValidAccountInfo(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1276
    const-string v0, "TSM AccountInfo loaded from w4.d static cache"

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1277
    return-object p0

    .line 1281
    :cond_0
    goto :goto_0

    .line 1279
    :catchall_0
    move-exception p0

    .line 1280
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "TSM static AccountInfo read failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1282
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static readTsmAuthPhCache()Ljava/lang/String;
    .locals 5

    .line 1720
    nop

    .line 1722
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    const-string v2, "/data/local/tmp/xiaomi-tsm-auth-ph"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 1723
    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-nez v2, :cond_0

    .line 1724
    const-string v1, "TSM ph cache missing: /data/local/tmp/xiaomi-tsm-auth-ph"

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1725
    nop

    .line 1739
    nop

    .line 1725
    return-object v0

    .line 1727
    :cond_0
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, v1}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 1728
    :try_start_1
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v1

    .line 1729
    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 1730
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "TSM ph loaded from root-synced cache, length="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1732
    :cond_1
    const-string v3, "TSM ph cache is empty"

    invoke-static {v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1734
    :goto_0
    nop

    .line 1739
    nop

    .line 1741
    :try_start_2
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 1743
    goto :goto_1

    .line 1742
    :catchall_0
    move-exception v0

    .line 1734
    :goto_1
    return-object v1

    .line 1735
    :catchall_1
    move-exception v1

    goto :goto_2

    :catchall_2
    move-exception v1

    move-object v2, v0

    .line 1736
    :goto_2
    :try_start_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "TSM ph cache read failed: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_4

    .line 1737
    nop

    .line 1739
    if-eqz v2, :cond_2

    .line 1741
    :try_start_4
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 1743
    goto :goto_3

    .line 1742
    :catchall_3
    move-exception v1

    .line 1737
    :cond_2
    :goto_3
    return-object v0

    .line 1739
    :catchall_4
    move-exception v0

    if-eqz v2, :cond_3

    .line 1741
    :try_start_5
    invoke-virtual {v2}, Ljava/io/BufferedReader;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_5

    .line 1743
    goto :goto_4

    .line 1742
    :catchall_5
    move-exception v1

    .line 1745
    :cond_3
    :goto_4
    throw v0
.end method

.method private static readXiaomiAccountUserDataPh(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .line 1696
    const-string v0, "_ph"

    const/4 v1, 0x0

    if-eqz p0, :cond_4

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    goto/16 :goto_2

    .line 1700
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object p0

    .line 1701
    const-string v2, "com.xiaomi"

    invoke-virtual {p0, v2}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v2

    .line 1702
    if-eqz v2, :cond_3

    array-length v3, v2

    if-nez v3, :cond_1

    goto :goto_1

    .line 1706
    :cond_1
    const/4 v3, 0x0

    aget-object v2, v2, v3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Landroid/accounts/AccountManager;->getUserData(Landroid/accounts/Account;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 1707
    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 1708
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM cached ph loaded from AccountManager userData, length="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1710
    :cond_2
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TSM cached ph missing in AccountManager userData key="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1712
    :goto_0
    return-object p0

    .line 1703
    :cond_3
    :goto_1
    const-string p0, "TSM cached ph lookup skipped: no Xiaomi account"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1704
    return-object v1

    .line 1713
    :catchall_0
    move-exception p0

    .line 1714
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM cached ph lookup failed: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1715
    return-object v1

    .line 1697
    :cond_4
    :goto_2
    return-object v1
.end method

.method private static rearmTsmNfcForegroundDispatch(Ljava/lang/Object;I)V
    .locals 4

    .line 1929
    :try_start_0
    move-object v0, p0

    check-cast v0, Landroid/app/Activity;

    .line 1930
    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_4

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 1934
    :cond_0
    const-string v1, "y"

    invoke-static {p0, v1}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    .line 1935
    if-nez v1, :cond_1

    .line 1936
    const/4 v2, 0x0

    goto :goto_0

    .line 1937
    :cond_1
    const-string v2, "Y"

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 1938
    :goto_0
    if-eqz v2, :cond_2

    .line 1944
    const-string p0, "resetBlockPoll"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, p0, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 1945
    invoke-static {v0, v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->enableTsmNfcReaderMode(Landroid/app/Activity;Ljava/lang/Object;)V

    .line 1946
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM NFC reader mode re-armed after onResume attempt="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1947
    return-void

    .line 1950
    :cond_2
    const/16 v0, 0x8

    if-lt p1, v0, :cond_3

    .line 1951
    const-string p0, "TSM NFC foreground dispatch retry skipped: presenter not ready"

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1952
    return-void

    .line 1955
    :cond_3
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;

    invoke-direct {v1, p0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$33;-><init>(Ljava/lang/Object;I)V

    const-wide/16 p0, 0xfa

    invoke-virtual {v0, v1, p0, p1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1964
    goto :goto_2

    .line 1931
    :cond_4
    :goto_1
    return-void

    .line 1961
    :catchall_0
    move-exception p0

    .line 1962
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM NFC foreground dispatch retry failed: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1963
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 1965
    :goto_2
    return-void
.end method

.method private static repairShenzhenTransferConfirm(Ljava/lang/Object;)V
    .locals 5

    .line 1529
    if-nez p0, :cond_0

    .line 1530
    return-void

    .line 1533
    :cond_0
    :try_start_0
    const-string v0, "getCardName"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 1534
    const-string v2, "getActionType"

    new-array v3, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v3}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 1535
    const-string v3, "getCoreOperation"

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {p0, v3, v4}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 1536
    const-string v4, "getOrderId"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v4, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 1537
    const-string v4, "SZT_MOT"

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "TRANSFER_IN"

    .line 1538
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "pretransferIn"

    .line 1539
    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1540
    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastStartTransferInOrderId:Ljava/lang/String;

    .line 1541
    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    .line 1544
    :cond_1
    const-string v0, "mOrderId"

    sget-object v1, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastStartTransferInOrderId:Ljava/lang/String;

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V

    .line 1545
    const-string v0, "mCoreOperation"

    const-string v1, "transferIn"

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V

    .line 1546
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "TSM repaired SZT_MOT confirm orderId="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    sget-object v0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->lastStartTransferInOrderId:Ljava/lang/String;

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ", coreOperation=transferIn"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1550
    goto :goto_1

    .line 1542
    :cond_2
    :goto_0
    return-void

    .line 1548
    :catchall_0
    move-exception p0

    .line 1549
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "TSM SZT_MOT confirm repair failed: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->describeThrowable(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 1551
    :goto_1
    return-void
.end method

.method private static sanitizeConfirmParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 2404
    const-string v0, "null"

    if-eqz p1, :cond_3

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto/16 :goto_1

    .line 2407
    :cond_0
    const-string v0, "orderId"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2408
    const-string v0, "cardName"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2409
    const-string v0, "businessId"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2410
    const-string v0, "sessionId"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2411
    const-string v0, "cardCategory"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2412
    const-string v0, "actionType"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2413
    const-string v0, "result"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2414
    const-string v0, "errorCode"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2415
    const-string v0, "errorDesc"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2416
    const-string v0, "coreOperation"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2417
    const-string v0, "orderSource"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    goto :goto_0

    .line 2420
    :cond_1
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "len="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ",prefix="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const/16 v0, 0x8

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 2418
    :cond_2
    :goto_0
    return-object p1

    .line 2405
    :cond_3
    :goto_1
    return-object v0
.end method

.method private static sanitizeStartTransferParam(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 2394
    const-string v0, "null"

    if-eqz p1, :cond_3

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    .line 2397
    :cond_0
    const-string v0, "orderId"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "deviceModel"

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_1

    goto :goto_0

    .line 2400
    :cond_1
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "len="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, ",prefix="

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const/16 v0, 0x8

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 2398
    :cond_2
    :goto_0
    return-object p1

    .line 2395
    :cond_3
    :goto_1
    return-object v0
.end method

.method private static startActivityAsUser(Landroid/content/Context;Landroid/content/Intent;I)V
    .locals 2

    .line 296
    const-class v0, Landroid/os/UserHandle;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object p2

    const-string v1, "of"

    invoke-static {v0, v1, p2}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    .line 297
    const-string v0, "startActivityAsUser"

    filled-new-array {p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {p0, v0, p1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 298
    return-void
.end method

.method private static toHex([B)Ljava/lang/String;
    .locals 6

    .line 2165
    if-nez p0, :cond_0

    .line 2166
    const-string p0, "null"

    return-object p0

    .line 2168
    :cond_0
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v0, v0, [C

    .line 2169
    const-string v1, "0123456789abcdef"

    invoke-virtual {v1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 2170
    const/4 v2, 0x0

    :goto_0
    array-length v3, p0

    if-ge v2, v3, :cond_1

    .line 2171
    aget-byte v3, p0, v2

    and-int/lit16 v3, v3, 0xff

    .line 2172
    mul-int/lit8 v4, v2, 0x2

    ushr-int/lit8 v5, v3, 0x4

    aget-char v5, v1, v5

    aput-char v5, v0, v4

    .line 2173
    add-int/lit8 v4, v4, 0x1

    and-int/lit8 v3, v3, 0xf

    aget-char v3, v1, v3

    aput-char v3, v0, v4

    .line 2170
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 2175
    :cond_1
    new-instance p0, Ljava/lang/String;

    invoke-direct {p0, v0}, Ljava/lang/String;-><init>([C)V

    return-object p0
.end method


# virtual methods
.method public handleLoadPackage(Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;)V
    .locals 19

    .line 81
    move-object/from16 v0, p1

    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    const-string v2, "android"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    .line 82
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 83
    iget-object v0, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installSystemPowerWalletGestureHook(Ljava/lang/ClassLoader;)V

    .line 84
    return-void

    .line 86
    :cond_0
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    const-string v2, "com.android.nfc"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    .line 87
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 88
    iget-object v0, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installXiaomiEseRoutingHook(Ljava/lang/ClassLoader;)V

    .line 89
    return-void

    .line 91
    :cond_1
    const-string v1, "com.android.se"

    iget-object v2, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 92
    iget-object v0, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installSecureElementHook(Ljava/lang/ClassLoader;)V

    .line 93
    return-void

    .line 95
    :cond_2
    const-string v1, "com.miui.tsmclient"

    iget-object v2, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 96
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installTsmAccountPhHook(Ljava/lang/ClassLoader;)V

    .line 97
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installTsmAccountValidationProbe(Ljava/lang/ClassLoader;)V

    .line 98
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installStartTransferInDiagnostics(Ljava/lang/ClassLoader;)V

    .line 99
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installConfirmBizStatusDiagnostics(Ljava/lang/ClassLoader;)V

    .line 100
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installTransferCardModelDiagnostics(Ljava/lang/ClassLoader;)V

    .line 101
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installTsmNfcForegroundDispatchFix(Ljava/lang/ClassLoader;)V

    .line 103
    :cond_3
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->isXiaomiNfcClient(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 104
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    iget-object v0, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    invoke-static {v1, v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installXiaomiNfcHook(Ljava/lang/ClassLoader;Ljava/lang/String;)V

    .line 105
    return-void

    .line 107
    :cond_4
    const-string v1, "com.xiaomi.account"

    iget-object v2, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    .line 108
    return-void

    .line 111
    :cond_5
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "loaded for process="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->log(Ljava/lang/String;)V

    .line 113
    iget-object v2, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v1, Landroid/content/Intent;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v7

    const-string v3, "b6.h0"

    const-string v4, "a"

    const/4 v5, 0x0

    const/4 v6, 0x1

    invoke-static/range {v2 .. v7}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    .line 114
    iget-object v8, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v1, Landroid/content/Intent;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v13

    const-string v9, "b6.m1"

    const-string v10, "b"

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-static/range {v8 .. v13}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    .line 115
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v2, Landroid/content/Intent;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v6

    const-string v2, "pa.c"

    const-string v3, "a"

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnInt(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;IZ[Ljava/lang/Object;)V

    .line 116
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v2, Landroid/content/Intent;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "b6.m1"

    const-string v4, "a"

    invoke-static {v1, v3, v4, v5, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 121
    iget-object v6, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v9

    const/4 v10, 0x0

    new-array v11, v5, [Ljava/lang/Object;

    const-string v7, "com.xiaomi.security.devicecredential.c"

    const-string v8, "c"

    invoke-static/range {v6 .. v11}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 122
    iget-object v12, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const/16 v16, 0x0

    new-array v1, v5, [Ljava/lang/Object;

    const-string v13, "com.xiaomi.security.devicecredential.c"

    const-string v14, "a"

    const-string v15, ""

    move-object/from16 v17, v1

    invoke-static/range {v12 .. v17}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 123
    iget-object v6, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    new-array v9, v5, [B

    const-class v1, [B

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v11

    const-string v7, "com.xiaomi.security.devicecredential.c"

    const-string v8, "g"

    invoke-static/range {v6 .. v11}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 124
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-string v2, "d"

    new-array v3, v5, [Ljava/lang/Object;

    const-string v6, "com.xiaomi.security.devicecredential.c"

    invoke-static {v1, v6, v2, v5, v3}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 129
    iget-object v7, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v1, Landroid/content/Context;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v12

    const-string v8, "i4.c$b"

    const-string v9, "c"

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-static/range {v7 .. v12}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 130
    iget-object v13, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v1, Landroid/content/Context;

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v18

    const-string v14, "i4.c"

    const-string v15, "d"

    const/16 v16, 0x0

    const/16 v17, 0x0

    invoke-static/range {v13 .. v18}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookReturnObject(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Z[Ljava/lang/Object;)V

    .line 131
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v2, Landroid/content/Context;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "i4.c$b"

    invoke-static {v1, v3, v4, v5, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 132
    iget-object v1, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    const-class v2, Landroid/content/Context;

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "i4.c"

    invoke-static {v1, v3, v4, v5, v2}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V

    .line 133
    iget-object v0, v0, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {v0}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installXiaomiAccountTsmPhHook(Ljava/lang/ClassLoader;)V

    .line 134
    return-void
.end method
