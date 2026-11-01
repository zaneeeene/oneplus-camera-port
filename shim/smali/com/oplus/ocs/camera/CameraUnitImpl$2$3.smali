.class Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "CameraUnitImpl.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/CameraUnitImpl$2;->onError(Landroid/hardware/camera2/CameraDevice;I)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;

.field private final synthetic val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;

.method constructor <init>(Lcom/oplus/ocs/camera/CameraUnitImpl$2;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
  .registers 3
  .line 202
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;->this$1:Lcom/oplus/ocs/camera/CameraUnitImpl$2;
    iput-object p2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .registers 3
  .line 205
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl$2$3;->val$callback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    sget-object v1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->ILLEGAL_STATE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-virtual { v0, v1 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onCameraError(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .line 206
    return-void
.end method
