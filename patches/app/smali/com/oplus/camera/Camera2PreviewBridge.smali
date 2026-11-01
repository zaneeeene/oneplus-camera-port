.class public final Lcom/oplus/camera/Camera2PreviewBridge;
.super Ljava/lang/Object;
.source "Camera2PreviewBridge.java"

.field private final static TAG:Ljava/lang/String; = "Cam2PreviewBridge"

.field private static sDevice:Landroid/hardware/camera2/CameraDevice;

.field private static sHandler:Landroid/os/Handler;

.field private static sManager:Landroid/hardware/camera2/CameraManager;

.field private static sSession:Landroid/hardware/camera2/CameraCaptureSession;

.field private static sSurface:Landroid/view/Surface;

.field private static sThread:Landroid/os/HandlerThread;

.method public constructor <init>()V
  .registers 1
  .line 17
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method static synthetic access$0(Landroid/hardware/camera2/CameraDevice;)V
  .registers 1
  .line 20
    sput-object p0, Lcom/oplus/camera/Camera2PreviewBridge;->sDevice:Landroid/hardware/camera2/CameraDevice;
    return-void
.end method

.method static synthetic access$1()Landroid/view/Surface;
  .registers 1
  .line 22
    sget-object v0, Lcom/oplus/camera/Camera2PreviewBridge;->sSurface:Landroid/view/Surface;
    return-object v0
.end method

.method static synthetic access$2(Landroid/hardware/camera2/CameraCaptureSession;)V
  .registers 1
  .line 21
    sput-object p0, Lcom/oplus/camera/Camera2PreviewBridge;->sSession:Landroid/hardware/camera2/CameraCaptureSession;
    return-void
.end method

.method static synthetic access$3()Landroid/os/Handler;
  .registers 1
  .line 24
    sget-object v0, Lcom/oplus/camera/Camera2PreviewBridge;->sHandler:Landroid/os/Handler;
    return-object v0
.end method

.method public static declared-synchronized start(Landroid/content/Context;Landroid/graphics/SurfaceTexture;)V
  .catchall { :L0 .. :L1 } :L10
  .catchall { :L2 .. :L4 } :L7
  .catchall { :L5 .. :L6 } :L7
  .catchall { :L8 .. :L9 } :L10
  .catchall { :L11 .. :L12 } :L10
  .registers 5
    const-class v0, Lcom/oplus/camera/Camera2PreviewBridge;
    monitor-enter v0
  .line 27
    if-eqz p0, :L13
    if-nez p1, :L0
    goto :L13
  :L0
  .line 28
    invoke-static { }, Lcom/oplus/camera/Camera2PreviewBridge;->stop()V
  :L1
  .line 30
    const/16 v1, 1440
    const/16 v2, 1080
  :L2
    invoke-virtual { p1, v1, v2 }, Landroid/graphics/SurfaceTexture;->setDefaultBufferSize(II)V
  .line 31
    new-instance v1, Landroid/view/Surface;
    invoke-direct { v1, p1 }, Landroid/view/Surface;-><init>(Landroid/graphics/SurfaceTexture;)V
    sput-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sSurface:Landroid/view/Surface;
  .line 32
    sget-object p1, Lcom/oplus/camera/Camera2PreviewBridge;->sThread:Landroid/os/HandlerThread;
    if-nez p1, :L3
  .line 33
    new-instance p1, Landroid/os/HandlerThread;
    const-string v1, "Cam2PreviewBridge"
    invoke-direct { p1, v1 }, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V
    sput-object p1, Lcom/oplus/camera/Camera2PreviewBridge;->sThread:Landroid/os/HandlerThread;
  .line 34
    sget-object p1, Lcom/oplus/camera/Camera2PreviewBridge;->sThread:Landroid/os/HandlerThread;
    invoke-virtual { p1 }, Landroid/os/HandlerThread;->start()V
  .line 35
    new-instance p1, Landroid/os/Handler;
    sget-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sThread:Landroid/os/HandlerThread;
    invoke-virtual { v1 }, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct { p1, v1 }, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    sput-object p1, Lcom/oplus/camera/Camera2PreviewBridge;->sHandler:Landroid/os/Handler;
  :L3
  .line 37
    const-string p1, "camera"
    invoke-virtual { p0, p1 }, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object p0
    check-cast p0, Landroid/hardware/camera2/CameraManager;
    sput-object p0, Lcom/oplus/camera/Camera2PreviewBridge;->sManager:Landroid/hardware/camera2/CameraManager;
  .line 38
    sget-object p0, Lcom/oplus/camera/Camera2PreviewBridge;->sManager:Landroid/hardware/camera2/CameraManager;
  :L4
    if-nez p0, :L5
    monitor-exit v0
    return-void
  :L5
  .line 39
    const-string p0, "Cam2PreviewBridge"
    const-string p1, "opening camera 0"
    invoke-static { p0, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 40
    sget-object p0, Lcom/oplus/camera/Camera2PreviewBridge;->sManager:Landroid/hardware/camera2/CameraManager;
    const-string p1, "0"
    new-instance v1, Lcom/oplus/camera/Camera2PreviewBridge$1;
    invoke-direct { v1 }, Lcom/oplus/camera/Camera2PreviewBridge$1;-><init>()V
  .line 80
    sget-object v2, Lcom/oplus/camera/Camera2PreviewBridge;->sHandler:Landroid/os/Handler;
  .line 40
    invoke-virtual { p0, p1, v1, v2 }, Landroid/hardware/camera2/CameraManager;->openCamera(Ljava/lang/String;Landroid/hardware/camera2/CameraDevice$StateCallback;Landroid/os/Handler;)V
  :L6
  .line 81
    goto :L9
  :L7
    move-exception p0
  :L8
  .line 82
    const-string p1, "Cam2PreviewBridge"
    const-string v1, "start"
    invoke-static { p1, v1, p0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L9
  .line 84
    monitor-exit v0
    return-void
  :L10
  .line 26
    move-exception p0
  :L11
    monitor-exit v0
  :L12
    throw p0
  :L13
  .line 27
    monitor-exit v0
    return-void
.end method

.method public static declared-synchronized stop()V
  .catchall { :L0 .. :L1 } :L2
  .catchall { :L4 .. :L5 } :L14
  .catchall { :L5 .. :L6 } :L7
  .catchall { :L8 .. :L9 } :L14
  .catchall { :L9 .. :L10 } :L11
  .catchall { :L12 .. :L13 } :L14
  .catchall { :L15 .. :L16 } :L14
  .registers 3
    const-class v0, Lcom/oplus/camera/Camera2PreviewBridge;
    monitor-enter v0
  :L0
  .line 87
    sget-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz v1, :L3
    sget-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CameraCaptureSession;->close()V
  :L1
    goto :L3
  :L2
    move-exception v1
  :L3
  .line 88
    const/4 v1, 0
  :L4
    sput-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sSession:Landroid/hardware/camera2/CameraCaptureSession;
  :L5
  .line 89
    sget-object v2, Lcom/oplus/camera/Camera2PreviewBridge;->sDevice:Landroid/hardware/camera2/CameraDevice;
    if-eqz v2, :L8
    sget-object v2, Lcom/oplus/camera/Camera2PreviewBridge;->sDevice:Landroid/hardware/camera2/CameraDevice;
    invoke-virtual { v2 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L6
    goto :L8
  :L7
    move-exception v2
  :L8
  .line 90
    sput-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sDevice:Landroid/hardware/camera2/CameraDevice;
  :L9
  .line 91
    sget-object v2, Lcom/oplus/camera/Camera2PreviewBridge;->sSurface:Landroid/view/Surface;
    if-eqz v2, :L12
    sget-object v2, Lcom/oplus/camera/Camera2PreviewBridge;->sSurface:Landroid/view/Surface;
    invoke-virtual { v2 }, Landroid/view/Surface;->release()V
  :L10
    goto :L12
  :L11
    move-exception v2
  :L12
  .line 92
    sput-object v1, Lcom/oplus/camera/Camera2PreviewBridge;->sSurface:Landroid/view/Surface;
  :L13
  .line 93
    monitor-exit v0
    return-void
  :L14
  .line 86
    move-exception v1
  :L15
    monitor-exit v0
  :L16
    throw v1
.end method
