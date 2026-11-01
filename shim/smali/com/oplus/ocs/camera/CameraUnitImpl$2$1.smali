.class Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "CameraUnitImpl.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/CameraUnitImpl$2;->onOpened(Landroid/hardware/camera2/CameraDevice;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;

.field private final synthetic val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;

.field private final synthetic val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;

.method constructor <init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 4
  .line 168
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;->this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;
    iput-object p2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    iput-object p3, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;->val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 4
  :L0
  .line 172
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$1;->val$device:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-virtual { v0, v1 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onCameraOpened(Lcom/oplus/ocs/camera/appinterface/CameraDeviceInterface;)V
  :L1
  .line 173
    goto :L3
  :L2
    move-exception v0
  .line 174
    const-string v1, "OcsCameraUnit"
    const-string v2, "onCameraOpened callback"
    invoke-static { v1, v2, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 176
    return-void
.end method
