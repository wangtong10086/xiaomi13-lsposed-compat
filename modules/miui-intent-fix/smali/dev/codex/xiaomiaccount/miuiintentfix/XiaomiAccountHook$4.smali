.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$4;
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

    .line 416
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 419
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$1200()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    move-result-object v0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-virtual {v0, p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->onNfcEnabled(Ljava/lang/Object;)V

    .line 420
    return-void
.end method
