.class Lcom/oplus/camera/Camera2PreviewBridge$1;
.super Landroid/hardware/camera2/CameraDevice$StateCallback;
.source "Camera2PreviewBridge.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/camera/Camera2PreviewBridge;->start(Landroid/content/Context;Landroid/graphics/SurfaceTexture;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.method constructor <init>()V
  .registers 1
  .line 40
    invoke-direct { p0 }, Landroid/hardware/camera2/CameraDevice$StateCallback;-><init>()V
    return-void
.end method

.method public onDisconnected(Landroid/hardware/camera2/CameraDevice;)V
  .catchall { :L0 .. :L1 } :L2
  .registers 4
  .line 71
    const-string v0, "Cam2PreviewBridge"
    const-string v1, "camera disconnected"
    invoke-static { v0, v1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  :L0
  .line 72
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L1
    goto :L3
  :L2
    move-exception p1
  :L3
  .line 73
    const/4 p1, 0
    invoke-static { p1 }, Lcom/oplus/camera/Camera2PreviewBridge;->access$0(Landroid/hardware/camera2/CameraDevice;)V
  .line 74
    return-void
.end method

.method public onError(Landroid/hardware/camera2/CameraDevice;I)V
  .catchall { :L0 .. :L1 } :L2
  .registers 5
  .line 76
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "camera error "
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v0, p2 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p2
    invoke-virtual { p2 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p2
    const-string v0, "Cam2PreviewBridge"
    invoke-static { v0, p2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  :L0
  .line 77
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L1
    goto :L3
  :L2
    move-exception p1
  :L3
  .line 78
    const/4 p1, 0
    invoke-static { p1 }, Lcom/oplus/camera/Camera2PreviewBridge;->access$0(Landroid/hardware/camera2/CameraDevice;)V
  .line 79
    return-void
.end method

.method public onOpened(Landroid/hardware/camera2/CameraDevice;)V
  .catchall { :L0 .. :L1 } :L2
  .registers 6
  .line 42
    const-string v0, "camera opened"
    const-string v1, "Cam2PreviewBridge"
    invoke-static { v1, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 43
    invoke-static { p1 }, Lcom/oplus/camera/Camera2PreviewBridge;->access$0(Landroid/hardware/camera2/CameraDevice;)V
  .line 45
    const/4 v0, 1
  :L0
    new-array v0, v0, [Landroid/view/Surface;
    invoke-static { }, Lcom/oplus/camera/Camera2PreviewBridge;->access$1()Landroid/view/Surface;
    move-result-object v2
    const/4 v3, 0
    aput-object v2, v0, v3
    invoke-static { v0 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    new-instance v2, Lcom/oplus/camera/Camera2PreviewBridge$1$1;
    invoke-direct { v2, p0, p1 }, Lcom/oplus/camera/Camera2PreviewBridge$1$1;-><init>(Lcom/oplus/camera/Camera2PreviewBridge$1;Landroid/hardware/camera2/CameraDevice;)V
  .line 65
    invoke-static { }, Lcom/oplus/camera/Camera2PreviewBridge;->access$3()Landroid/os/Handler;
    move-result-object v3
  .line 45
    invoke-virtual { p1, v0, v2, v3 }, Landroid/hardware/camera2/CameraDevice;->createCaptureSession(Ljava/util/List;Landroid/hardware/camera2/CameraCaptureSession$StateCallback;Landroid/os/Handler;)V
  :L1
  .line 66
    goto :L3
  :L2
    move-exception p1
  .line 67
    const-string v0, "createCaptureSession"
    invoke-static { v1, v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 69
    return-void
.end method
