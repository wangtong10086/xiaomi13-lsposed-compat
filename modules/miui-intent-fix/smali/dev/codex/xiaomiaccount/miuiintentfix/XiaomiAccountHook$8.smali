.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$8;
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

    .line 460
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 463
    invoke-static {}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->access$1200()Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    move-result-object p1

    invoke-virtual {p1}, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->onFrameworkRoutingOptionsOverwritten()V

    .line 464
    return-void
.end method
