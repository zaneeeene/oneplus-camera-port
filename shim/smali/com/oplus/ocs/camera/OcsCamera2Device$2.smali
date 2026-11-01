.class Lcom/oplus/ocs/camera/OcsCamera2Device$2;
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
  .line 113
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$2;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
  .registers 3
  .line 116
    const-string v0, "OcsCamera2Device"
    const-string v1, "configure: delayed onSessionConfigured"
    invoke-static { v0, v1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 117
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device$2;->this$0:Lcom/oplus/ocs/camera/OcsCamera2Device;
    invoke-static { v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->access$6(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 118
    return-void
.end method
