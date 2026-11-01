.class Lcom/oplus/ocs/camera/CameraUnitImpl$2;
.super Landroid/hardware/camera2/CameraDevice$StateCallback;
.source "CameraUnitImpl.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/CameraUnitImpl;->openCamera(Ljava/lang/String;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Landroid/os/Handler;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$0:Lcom/oplus/ocs/camera/CameraUnitImpl;

.field private final synthetic val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;

.field private final synthetic val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;

.field private final synthetic val$h:Landroid/os/Handler;

.field private final synthetic val$id:Ljava/lang/String;

.method constructor <init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Ljava/lang/String;Lcom/oplus/ocs/camera/OcsCamera2Device;Landroid/os/Handler;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
  .registers 6
  .line 163
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->this$0:Lcom/oplus/ocs/camera/CameraUnitImpl;
    iput-object p2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$id:Ljava/lang/String;
    iput-object p3, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;
    iput-object p4, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$h:Landroid/os/Handler;
    iput-object p5, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-direct { p0 }, Landroid/hardware/camera2/CameraDevice$StateCallback;-><init>()V
    return-void
.end method

.method public onDisconnected(Landroid/hardware/camera2/CameraDevice;)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 4
  .line 182
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "Camera2 disconnected id="
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$id:Ljava/lang/String;
    invoke-virtual { v0, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual { v0 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "OcsCameraUnit"
    invoke-static { v1, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  :L0
  .line 184
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L1
  .line 185
    goto :L3
  :L2
    move-exception p1
    goto :L1
  :L3
  .line 187
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$h:Landroid/os/Handler;
    new-instance v0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-direct { v0, p0, v1 }, Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { p1, v0 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
  .line 193
    return-void
.end method

.method public onError(Landroid/hardware/camera2/CameraDevice;I)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 5
  .line 197
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "Camera2 error id="
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$id:Ljava/lang/String;
    invoke-virtual { v0, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, " error="
    invoke-virtual { v0, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual { v0, p2 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p2
    invoke-virtual { p2 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p2
    const-string v0, "OcsCameraUnit"
    invoke-static { v0, p2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  :L0
  .line 199
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L1
  .line 200
    goto :L3
  :L2
    move-exception p1
    goto :L1
  :L3
  .line 202
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$h:Landroid/os/Handler;
    new-instance p2, Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-direct { p2, p0, v0 }, Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { p1, p2 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
  .line 208
    return-void
.end method

.method public onOpened(Landroid/hardware/camera2/CameraDevice;)V
  .registers 5
  .line 166
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "Camera2 opened id="
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$id:Ljava/lang/String;
    invoke-virtual { v0, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual { v0 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "OcsCameraUnit"
    invoke-static { v1, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 167
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-virtual { v0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setCameraDevice(Landroid/hardware/camera2/CameraDevice;)V
  .line 168
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$h:Landroid/os/Handler;
    new-instance v0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    iget-object v2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2;->val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { v0, p0, v1, v2 }, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Lcom/oplus/ocs/camera/OcsCamera2Device;)V
    invoke-virtual { p1, v0 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
  .line 178
    return-void
.end method
