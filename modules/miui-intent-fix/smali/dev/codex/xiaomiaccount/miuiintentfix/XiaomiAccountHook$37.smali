.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$37;
.super Lde/robv/android/xposed/XC_MethodReplacement;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook;->hookNoOp(Ljava/lang/ClassLoader;Ljava/lang/String;Ljava/lang/String;Z[Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 2300
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodReplacement;-><init>()V

    return-void
.end method


# virtual methods
.method protected replaceHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)Ljava/lang/Object;
    .locals 0

    .line 2303
    const/4 p1, 0x0

    return-object p1
.end method
