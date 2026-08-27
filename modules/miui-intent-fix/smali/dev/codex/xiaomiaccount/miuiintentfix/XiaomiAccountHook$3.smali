.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$3;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->installXiaomiEseRoutingHook(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 401
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 404
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    instance-of v0, v0, Landroid/content/Context;

    if-nez v0, :cond_0

    goto :goto_0

    .line 408
    :cond_0
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$1200()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    move-result-object v0

    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v2, v1

    check-cast v1, Landroid/content/Context;

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, v1, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->attach(Landroid/content/Context;Ljava/lang/Object;)V

    .line 409
    return-void

    .line 405
    :cond_1
    :goto_0
    const-string p1, "eSE routing controller attach skipped: NfcService context unavailable"

    invoke-static {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$500(Ljava/lang/String;)V

    .line 406
    return-void
.end method
