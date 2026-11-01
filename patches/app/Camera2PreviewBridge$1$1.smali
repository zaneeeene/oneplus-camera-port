.class Lcom/oplus/camera/Camera2PreviewBridge$1$1;
.super Landroid/hardware/camera2/CameraCaptureSession$StateCallback;
.source "Camera2PreviewBridge.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/camera/Camera2PreviewBridge$1;->onOpened(Landroid/hardware/camera2/CameraDevice;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$1:Lcom/oplus/camera/Camera2PreviewBridge$1;

.field private final synthetic val$camera:Landroid/hardware/camera2/CameraDevice;

.method constructor <init>(Lcom/oplus/camera/Camera2PreviewBridge$1;Landroid/hardware/camera2/CameraDevice;)V
  .registers 3
  .line 45
    iput-object p1, p0, Lcom/oplus/camera/Camera2PreviewBridge$1$1;->this$1:Lcom/oplus/camera/Camera2PreviewBridge$1;
    iput-object p2, p0, Lcom/oplus/camera/Camera2PreviewBridge$1$1;->val$camera:Landroid/hardware/camera2/CameraDevice;
    invoke-direct { p0 }, Landroid/hardware/camera2/CameraCaptureSession$StateCallback;-><init>()V
    return-void
.end method

.method public onConfigureFailed(Landroid/hardware/camera2/CameraCaptureSession;)V
  .registers 3
  .line 63
    const-string p1, "Cam2PreviewBridge"
    const-string v0, "session configure failed"
    invoke-static { p1, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 64
    return-void
.end method

.method public onConfigured(Landroid/hardware/camera2/CameraCaptureSession;)V
  .catchall { :L0 .. :L1 } :L2
  .registers 7
  .line 47
    const-string v0, "session configured"
    const-string v1, "Cam2PreviewBridge"
    invoke-static { v1, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 48
    invoke-static { p1 }, Lcom/oplus/camera/Camera2PreviewBridge;->access$2(Landroid/hardware/camera2/CameraCaptureSession;)V
  :L0
  .line 50
    iget-object v0, p0, Lcom/oplus/camera/Camera2PreviewBridge$1$1;->val$camera:Landroid/hardware/camera2/CameraDevice;
    const/4 v2, 1
    invoke-virtual { v0, v2 }, Landroid/hardware/camera2/CameraDevice;->createCaptureRequest(I)Landroid/hardware/camera2/CaptureRequest$Builder;
    move-result-object v0
  .line 51
    invoke-static { }, Lcom/oplus/camera/Camera2PreviewBridge;->access$1()Landroid/view/Surface;
    move-result-object v3
    invoke-virtual { v0, v3 }, Landroid/hardware/camera2/CaptureRequest$Builder;->addTarget(Landroid/view/Surface;)V
  .line 52
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-virtual { v0, v3, v4 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 53
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    const/4 v4, 4
    invoke-static { v4 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-virtual { v0, v3, v4 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 54
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-virtual { v0, v3, v4 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 55
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    invoke-virtual { v0, v3, v2 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 56
    invoke-virtual { v0 }, Landroid/hardware/camera2/CaptureRequest$Builder;->build()Landroid/hardware/camera2/CaptureRequest;
    move-result-object v0
    invoke-static { }, Lcom/oplus/camera/Camera2PreviewBridge;->access$3()Landroid/os/Handler;
    move-result-object v2
    const/4 v3, 0
    invoke-virtual { p1, v0, v3, v2 }, Landroid/hardware/camera2/CameraCaptureSession;->setRepeatingRequest(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/os/Handler;)I
  .line 57
    const-string p1, "repeating preview started"
    invoke-static { v1, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  :L1
  .line 58
    goto :L3
  :L2
    move-exception p1
  .line 59
    const-string v0, "start repeating"
    invoke-static { v1, v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 61
    return-void
.end method
