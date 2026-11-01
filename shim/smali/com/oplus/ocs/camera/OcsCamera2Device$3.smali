.class Lcom/oplus/ocs/camera/OcsCamera2Device$3;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;
.source "OcsCamera2Device.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
  value = Lcom/oplus/ocs/camera/OcsCamera2Device;->configure(Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;)V
.end annotation
.annotation system Ldalvik/annotation/InnerClass;
  accessFlags = 0
  name = null
.end annotation

.field final synthetic this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;

.method constructor <init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 2
  .line 125
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$3;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .registers 2
  .line 128
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$3;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$7(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 129
    return-void
.end method
