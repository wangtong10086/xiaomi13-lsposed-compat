.class final Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "ApplyRoutingResult"
.end annotation


# instance fields
.field final originalDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

.field final recoverySucceeded:Z

.field final success:Z


# direct methods
.method constructor <init>(ZZLdev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;)V
    .locals 0

    .line 957
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 958
    iput-boolean p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->success:Z

    .line 959
    iput-boolean p2, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->recoverySucceeded:Z

    .line 960
    iput-object p3, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$ApplyRoutingResult;->originalDefaults:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$RoutingDefaultsSnapshot;

    .line 961
    return-void
.end method
