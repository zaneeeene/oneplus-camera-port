.class Lcom/oplus/ocs/camera/OcsCamera2Device$1;
.super Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
.source "OcsCamera2Device.java"

.annotation system Ldalvik/annotation/EnclosingClass;
  value = Lcom/oplus/ocs/camera/OcsCamera2Device;
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;

.method constructor <init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 2
  .line 299
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { p0 }, Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;-><init>()V
    return-void
.end method

.method public onCaptureCompleted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/TotalCaptureResult;)V
  .catch Ljava/lang/Exception; { :L0 .. :L2 } :L3
  .catch Ljava/lang/Exception; { :L5 .. :L6 } :L7
  .registers 6
  .line 316
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$2(Lcom/oplus/ocs/camera/OcsCamera2Device;)Z
    move-result p1
    const-string v0, "OcsCamera2Device"
    if-nez p1, :L4
  .line 317
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    const/4 v1, 1
    invoke-static { p1, v1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$3(Lcom/oplus/ocs/camera/OcsCamera2Device;Z)V
  .line 318
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v1, "first preview frame type="
    invoke-direct { p1, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$4(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { v0, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  :L0
  .line 320
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    if-eqz p1, :L1
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;->onFirstMetaArrived()V
  :L1
  .line 321
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$5(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    move-result-object p1
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onReady()V
  :L2
  .line 322
    goto :L4
  :L3
    move-exception p1
  .line 323
    const-string v1, "first frame callbacks"
    invoke-static { v0, v1, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L4
  .line 326
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    if-eqz p1, :L8
  :L5
  .line 328
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    invoke-virtual { p1, p2, p3 }, Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;->onPreviewCaptureProgressed(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureResult;)V
  :L6
  .line 329
    goto :L8
  :L7
    move-exception p1
  .line 330
    const-string p2, "onPreviewCaptureProgressed"
    invoke-static { v0, p2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L8
  .line 333
    return-void
.end method

.method public onCaptureFailed(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 5
  .line 337
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v0, "preview capture failed reason="
    invoke-direct { p1, v0 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { p3 }, Landroid/hardware/camera2/CaptureFailure;->getReason()I
    move-result v0
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string v0, "OcsCamera2Device"
    invoke-static { v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 338
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    if-eqz p1, :L3
  :L0
  .line 340
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    invoke-virtual { p1, p2, p3 }, Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;->onPreviewCaptureFailed(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CaptureFailure;)V
  :L1
  .line 341
    goto :L3
  :L2
    move-exception p1
  .line 342
    const-string p2, "onPreviewCaptureFailed"
    invoke-static { v0, p2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 345
    return-void
.end method

.method public onCaptureStarted(Landroid/hardware/camera2/CameraCaptureSession;Landroid/hardware/camera2/CaptureRequest;JJ)V
  .catch Ljava/lang/Exception; { :L1 .. :L2 } :L3
  .registers 13
  .line 302
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    if-eqz p1, :L0
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$1(Lcom/oplus/ocs/camera/OcsCamera2Device;)Z
    move-result p1
    if-nez p1, :L0
  .line 303
    return-void
  :L0
  .line 305
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object p1
    if-eqz p1, :L4
  :L1
  .line 307
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    move-result-object v0
    move-object v1, p2
    move-wide v2, p3
    move-wide v4, p5
    invoke-virtual/range { v0 .. v5 }, Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;->onPreviewCaptureStarted(Landroid/hardware/camera2/CaptureRequest;JJ)V
  :L2
  .line 308
    goto :L4
  :L3
    move-exception v0
    move-object p1, v0
  .line 309
    const-string p2, "OcsCamera2Device"
    const-string p3, "onPreviewCaptureStarted"
    invoke-static { p2, p3, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L4
  .line 312
    return-void
.end method
