.class public final Lcom/oplus/camera/OcsPreloadRunnable;
.super Ljava/lang/Object;
.source "OcsPreloadRunnable.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static volatile sStarted:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    sget-boolean v0, Lcom/oplus/camera/OcsPreloadRunnable;->sStarted:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/oplus/camera/OcsPreloadRunnable;->sStarted:Z

    :try_start_0
    invoke-static {}, Lcom/oplus/camera/MyApplication;->j()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
