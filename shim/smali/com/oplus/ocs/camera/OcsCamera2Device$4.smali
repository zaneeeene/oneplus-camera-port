.class Lcom/oplus/ocs/camera/OcsCamera2Device$4;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "OcsCamera2Device.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/OcsCamera2Device;->startPreview(Ljava/util/Map;Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;Landroid/os/Handler;Lcom/oplus/ocs/camera/appinterface/CameraPreviewAssistCallbackAdapter;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;

.method constructor <init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 2
  .line 156
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$4;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .registers 2
  .line 159
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$4;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$7(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 160
    return-void
.end method
