.class Lcom/oplus/ocs/camera/OcsCamera2Device$5;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.source "OcsCamera2Device.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/OcsCamera2Device;->ensureSession(Ljava/util/List;Ljava/lang/Runnable;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;

.field private final synthetic val$onReady:Ljava/lang/Runnable;

.field private final synthetic val$surfaces:Ljava/util/List;

.method constructor <init>(Lcom/oplus/ocs/camera/OcsCamera2Device;Ljava/util/List;Ljava/lang/Runnable;)V
  .registers 4
  .line 188
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    iput-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$surfaces:Ljava/util/List;
    iput-object p3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$onReady:Ljava/lang/Runnable;
    invoke-direct { p0 }, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V
    return-void
.end method

.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
  .registers 3
  .line 201
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v0, "session configure failed type="
    invoke-direct { p1, v0 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$4(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string v0, "OcsCamera2Device"
    invoke-static { v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 202
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    const/4 v0, 1
    invoke-static { p1, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$10(Lcom/oplus/ocs/camera/OcsCamera2Device;Z)V
  .line 203
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    sget-object v0, Lcom/oplus/ocs/camera/common/util/ErrorResult;->STREAM_SURFACE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-static { p1, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$11(Lcom/oplus/ocs/camera/OcsCamera2Device;Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .line 204
    return-void
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
  .registers 3
  .line 191
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$8(Lcom/oplus/ocs/camera/OcsCamera2Device;Landroid/hardware/camera2/CameraCaptureSession;)V
  .line 192
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$9(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/util/List;
    move-result-object p1
    invoke-interface { p1 }, Ljava/util/List;->clear()V
  .line 193
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$9(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/util/List;
    move-result-object p1
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$surfaces:Ljava/util/List;
    invoke-interface { p1, v0 }, Ljava/util/List;->addAll(Ljava/util/Collection;)Z
  .line 194
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v0, "session configured type="
    invoke-direct { p1, v0 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$4(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v0, " surfaces="
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$surfaces:Ljava/util/List;
    invoke-interface { v0 }, Ljava/util/List;->size()I
    move-result v0
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string v0, "OcsCamera2Device"
    invoke-static { v0, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 195
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$6(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 196
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$onReady:Ljava/lang/Runnable;
    if-eqz p1, :L0
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$5;->val$onReady:Ljava/lang/Runnable;
    invoke-interface { p1 }, Ljava/lang/Runnable;->run()V
  :L0
  .line 197
    return-void
.end method
