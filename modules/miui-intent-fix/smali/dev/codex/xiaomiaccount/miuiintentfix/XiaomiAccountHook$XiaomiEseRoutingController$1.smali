.class Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$1;
.super Ljava/lang/Object;
.source "XiaomiAccountHook.java"

# interfaces
.implements Ljava/util/concurrent/ThreadFactory;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;->attach(Landroid/content/Context;Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;


# direct methods
.method constructor <init>(Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;)V
    .locals 0

    .line 499
    iput-object p1, p0, Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController$1;->this$0:Ldev/codex/xiaomiaccount/miuiintentfix/XiaomiAccountHook$XiaomiEseRoutingController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .locals 2

    .line 502
    new-instance v0, Ljava/lang/Thread;

    const-string v1, "XiaomiEseRouting"

    invoke-direct {v0, p1, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 503
    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 504
    return-object v0
.end method
