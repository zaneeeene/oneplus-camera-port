.class Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "CameraUnitImpl.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/CameraUnitImpl$2;->onDisconnected(Landroid/hardware/camera2/CameraDevice;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;

.field private final synthetic val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;

.method constructor <init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
  .registers 3
  .line 187
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;->this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;
    iput-object p2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .registers 2
  .line 190
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$2;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { v0 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onCameraDisconnected()V
  .line 191
    return-void
.end method
