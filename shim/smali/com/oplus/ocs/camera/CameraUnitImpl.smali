.class public Lcom/oplus/ocs/camera/CameraUnitImpl;
.super Ljava/lang/Object;
.implements Lcom/oplus/ocs/camera/appinterface/CameraUnitInterface;
.source "CameraUnitImpl.java"

.field private final static CAMERA_TYPES:Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
.end field

.field private final static TAG:Ljava/lang/String; = "OcsCameraUnit"

.field private mCameraManager:Landroid/hardware/camera2/CameraManager;

.field private mContext:Landroid/content/Context;

.field private final mDevices:Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Lcom/oplus/ocs/camera/OcsCamera2Device;",
      ">;"
    }
  .end annotation
.end field

.field private mMainHandler:Landroid/os/Handler;

.method static constructor <clinit>()V
  .registers 2
  .line 42
    nop
  .line 43
    const-string v0, "rear_main"
    const-string v1, "front_main"
    filled-new-array { v0, v1 }, [Ljava/lang/String;
    move-result-object v0
    invoke-static { v0 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    sput-object v0, Lcom/oplus/ocs/camera/CameraUnitImpl;->CAMERA_TYPES:Ljava/util/List;
    return-void
.end method

.method public constructor <init>()V
  .registers 3
  .line 51
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
  .line 47
    nop
  .line 48
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    iput-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mDevices:Ljava/util/Map;
  .line 52
    const-string v0, "OcsCameraUnit"
    const-string v1, "CameraUnitImpl constructed"
    invoke-static { v0, v1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 53
    return-void
.end method

.method private static cameraIdForType(Ljava/lang/String;)Ljava/lang/String;
  .registers 2
  .line 251
    const-string v0, "front_main"
    invoke-virtual { v0, p0 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :L0
    const-string p0, "1"
    return-object p0
  :L0
  .line 252
    const-string v0, "rear_wide"
    invoke-virtual { v0, p0 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :L1
    const-string p0, "2"
    return-object p0
  :L1
  .line 253
    const-string v0, "rear_macro"
    invoke-virtual { v0, p0 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :L2
    const-string p0, "4"
    return-object p0
  :L2
  .line 254
    const-string v0, "rear_tele"
    invoke-virtual { v0, p0 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result p0
    if-eqz p0, :L3
    const-string p0, "3"
    return-object p0
  :L3
  .line 255
    const-string p0, "0"
    return-object p0
.end method

.method private declared-synchronized handler(Landroid/os/Handler;)Landroid/os/Handler;
  .catchall { :L0 .. :L2 } :L3
  .catchall { :L4 .. :L5 } :L3
  .registers 3
    monitor-enter p0
  .line 56
    if-eqz p1, :L0
    monitor-exit p0
    return-object p1
  :L0
  .line 57
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mMainHandler:Landroid/os/Handler;
    if-nez p1, :L1
  .line 58
    new-instance p1, Landroid/os/Handler;
    invoke-static { }, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v0
    invoke-direct { p1, v0 }, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mMainHandler:Landroid/os/Handler;
  :L1
  .line 60
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mMainHandler:Landroid/os/Handler;
  :L2
    monitor-exit p0
    return-object p1
  :L3
  .line 55
    move-exception p1
  :L4
    monitor-exit p0
  :L5
    throw p1
.end method

.method private static normalizeType(Ljava/lang/String;)Ljava/lang/String;
  .registers 4
  .line 238
    const-string v0, "rear_main"
    if-nez p0, :L0
    return-object v0
  :L0
  .line 239
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-virtual { p0, v1 }, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;
    move-result-object p0
  .line 240
    const-string v1, "0"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :L1
    return-object v0
  :L1
  .line 241
    const-string v1, "1"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    const-string v2, "front_main"
    if-eqz v1, :L2
    return-object v2
  :L2
  .line 242
    const-string v1, "front"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L3
    return-object v2
  :L3
  .line 243
    const-string v1, "wide"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-nez v1, :L8
    const-string v1, "ultra"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L4
    goto :L8
  :L4
  .line 244
    const-string v1, "macro"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L5
    const-string p0, "rear_macro"
    return-object p0
  :L5
  .line 245
    const-string v1, "tele"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L6
    const-string p0, "rear_tele"
    return-object p0
  :L6
  .line 246
    const-string v1, "rear"
    invoke-virtual { p0, v1 }, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result p0
    if-eqz p0, :L7
    return-object v0
  :L7
  .line 247
    return-object v0
  :L8
  .line 243
    const-string p0, "rear_wide"
    return-object p0
.end method

.method public addDeferJobParam(Landroid/media/ImageReader;Landroid/media/Image;Landroid/hardware/camera2/CaptureResult;Ljava/util/Map;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Landroid/media/ImageReader;",
      "Landroid/media/Image;",
      "Landroid/hardware/camera2/CaptureResult;",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)V"
    }
  .end annotation
  .registers 5
  .line 306
    return-void
.end method

.method public addDeferJobParam(Landroid/media/ImageReader;Landroid/media/Image;Ljava/util/Map;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Landroid/media/ImageReader;",
      "Landroid/media/Image;",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/Object;",
      ">;)V"
    }
  .end annotation
  .registers 4
  .line 310
    return-void
.end method

.method public addSnapShotBuffer(Ljava/util/Map;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/Object;",
      ">;)V"
    }
  .end annotation
  .registers 2
  .line 314
    return-void
.end method

.method public checkAuthenticationPermission(Landroid/content/Context;Ljava/lang/String;I)Z
  .registers 5
  .line 100
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v0, "checkAuthenticationPermission -> true, client="
    invoke-direct { p1, v0 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string p2, " version="
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1, p3 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string p2, "OcsCameraUnit"
    invoke-static { p2, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 101
    const/4 p1, 1
    return p1
.end method

.method public collectFluencyData()Ljava/lang/String;
  .registers 2
  .line 287
    const-string v0, ""
    return-object v0
.end method

.method public discardFreeBuffersImageReader()V
  .registers 1
  .line 318
    return-void
.end method

.method public executeDeferJob(ILjava/util/Map;)Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(I",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
  .registers 3
  .line 282
    new-instance p1, Ljava/util/HashMap;
    invoke-direct { p1 }, Ljava/util/HashMap;-><init>()V
    return-object p1
.end method

.method public getAllSupportCameraMode()Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;>;"
    }
  .end annotation
  .registers 6
  .line 122
    new-instance v0, Ljava/util/LinkedHashMap;
    invoke-direct { v0 }, Ljava/util/LinkedHashMap;-><init>()V
  .line 123
    const-string v1, "photo_mode"
    const-string v2, "video_mode"
    filled-new-array { v1, v2 }, [Ljava/lang/String;
    move-result-object v3
    invoke-static { v3 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v3
    const-string v4, "rear_main"
    invoke-interface { v0, v4, v3 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  .line 124
    filled-new-array { v1, v2 }, [Ljava/lang/String;
    move-result-object v1
    invoke-static { v1 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v1
    const-string v2, "front_main"
    invoke-interface { v0, v2, v1 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  .line 125
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "getAllSupportCameraMode -> "
    invoke-direct { v1, v2 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual { v1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "OcsCameraUnit"
    invoke-static { v2, v1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 126
    return-object v0
.end method

.method public getAllSupportCameraType()Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
  .registers 3
  .line 116
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "getAllSupportCameraType -> "
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    sget-object v1, Lcom/oplus/ocs/camera/CameraUnitImpl;->CAMERA_TYPES:Ljava/util/List;
    invoke-virtual { v0, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual { v0 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "OcsCameraUnit"
    invoke-static { v1, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 117
    new-instance v0, Ljava/util/ArrayList;
    sget-object v1, Lcom/oplus/ocs/camera/CameraUnitImpl;->CAMERA_TYPES:Ljava/util/List;
    invoke-direct { v0, v1 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    return-object v0
.end method

.method public getCameraDeviceInfo(Ljava/lang/String;Ljava/lang/String;)Lcom/oplus/ocs/camera/appinterface/CameraDeviceInfoInterface;
  .registers 6
  .line 131
    invoke-static { p1 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->normalizeType(Ljava/lang/String;)Ljava/lang/String;
    move-result-object p1
  .line 132
    invoke-static { p1 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->cameraIdForType(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
  .line 133
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "getCameraDeviceInfo type="
    invoke-direct { v1, v2 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v1, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, " mode="
    invoke-virtual { v1, v2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual { v1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, " id="
    invoke-virtual { v1, v2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual { v1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual { v1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "OcsCameraUnit"
    invoke-static { v2, v1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 134
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
    if-nez v1, :L0
  .line 135
    const-string p1, "getCameraDeviceInfo before initialize"
    invoke-static { v2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 136
    const/4 p1, 0
    return-object p1
  :L0
  .line 138
    new-instance v1, Lcom/oplus/ocs/camera/OcsCamera2Info;
    iget-object v2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
    invoke-direct { v1, v2, v0, p1, p2 }, Lcom/oplus/ocs/camera/OcsCamera2Info;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-object v1
.end method

.method public getRequestedPreviewResult()Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter$PreviewResult;
  .registers 2
  .line 260
    const/4 v0, 0
    return-object v0
.end method

.method public getRuntimeInputMemSizeInMb()J
  .registers 3
  .line 292
    const-wide/16 v0, 0
    return-wide v0
.end method

.method public initialize(Landroid/content/Context;)V
  .registers 3
  .line 65
    const/4 v0, 0
    invoke-virtual { p0, p1, v0 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->initialize(Landroid/content/Context;Lcom/oplus/ocs/camera/appinterface/ApsStateCallback;)V
  .line 66
    return-void
.end method

.method public declared-synchronized initialize(Landroid/content/Context;Lcom/oplus/ocs/camera/appinterface/ApsStateCallback;)V
  .catchall { :L0 .. :L1 } :L16
  .catchall { :L1 .. :L2 } :L3
  .catchall { :L4 .. :L5 } :L16
  .catchall { :L5 .. :L6 } :L7
  .catchall { :L8 .. :L10 } :L16
  .catch Ljava/lang/Exception; { :L11 .. :L12 } :L13
  .catchall { :L11 .. :L12 } :L16
  .catchall { :L14 .. :L15 } :L16
  .catchall { :L17 .. :L18 } :L16
  .registers 5
    monitor-enter p0
  :L0
  .line 70
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
  .line 71
    if-eqz p1, :L9
  .line 72
    const-string p2, "camera"
    invoke-virtual { p1, p2 }, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object p2
    check-cast p2, Landroid/hardware/camera2/CameraManager;
    iput-object p2, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
  :L1
  .line 77
    invoke-static { p1 }, Lcom/oplus/ocs/camera/producer/info/CameraConfigHelper;->initialize(Landroid/content/Context;)V
  .line 78
    const-string p2, "OcsCameraUnit"
    const-string v0, "CameraConfigHelper.initialize done"
    invoke-static { p2, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  :L2
  .line 79
    goto :L5
  :L3
    move-exception p2
  :L4
  .line 80
    const-string v0, "OcsCameraUnit"
    const-string v1, "CameraConfigHelper.initialize failed"
    invoke-static { v0, v1, p2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L5
  .line 83
    invoke-static { }, Lcom/oplus/ocs/camera/producer/info/CameraCharacteristicsWrapper;->initCameraCharacteristicsGetterThread()V
  :L6
  .line 84
    goto :L9
  :L7
    move-exception p2
  :L8
  .line 85
    const-string v0, "OcsCameraUnit"
    const-string v1, "CameraCharacteristicsWrapper init failed"
    invoke-static { v0, v1, p2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L9
  .line 88
    const-string p2, "OcsCameraUnit"
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "initialize context="
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v0, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v0, " manager="
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { p2, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 89
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
  :L10
    if-eqz p1, :L15
  :L11
  .line 91
    const-string p1, "OcsCameraUnit"
    new-instance p2, Ljava/lang/StringBuilder;
    const-string v0, "camera ids="
    invoke-direct { p2, v0 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
    invoke-virtual { v0 }, Landroid/hardware/camera2/CameraManager;->getCameraIdList()[Ljava/lang/String;
    move-result-object v0
    invoke-static { v0 }, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual { p2, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p2
    invoke-virtual { p2 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p2
    invoke-static { p1, p2 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  :L12
  .line 92
    goto :L15
  :L13
    move-exception p1
  :L14
  .line 93
    const-string p2, "OcsCameraUnit"
    const-string v0, "getCameraIdList"
    invoke-static { p2, v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L15
  .line 96
    monitor-exit p0
    return-void
  :L16
  .line 69
    move-exception p1
  :L17
    monitor-exit p0
  :L18
    throw p1
.end method

.method public isAuthedClient(Landroid/content/Context;)Z
  .registers 2
  .line 106
    const/4 p1, 1
    return p1
.end method

.method public declared-synchronized openCamera(Ljava/lang/String;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Landroid/os/Handler;)V
  .catchall { :L0 .. :L2 } :L33
  .catch Landroid/hardware/camera2/CameraAccessException; { :L2 .. :L3 } :L26
  .catch Ljava/lang/SecurityException; { :L2 .. :L3 } :L23
  .catch Ljava/lang/Exception; { :L2 .. :L3 } :L19
  .catchall { :L2 .. :L3 } :L33
  .catch Landroid/hardware/camera2/CameraAccessException; { :L4 .. :L5 } :L18
  .catch Ljava/lang/SecurityException; { :L4 .. :L5 } :L17
  .catch Ljava/lang/Exception; { :L4 .. :L5 } :L16
  .catchall { :L4 .. :L5 } :L33
  .catch Landroid/hardware/camera2/CameraAccessException; { :L6 .. :L7 } :L15
  .catch Ljava/lang/SecurityException; { :L6 .. :L7 } :L14
  .catch Ljava/lang/Exception; { :L6 .. :L7 } :L13
  .catchall { :L6 .. :L7 } :L37
  .catch Landroid/hardware/camera2/CameraAccessException; { :L8 .. :L9 } :L12
  .catch Ljava/lang/SecurityException; { :L8 .. :L9 } :L11
  .catch Ljava/lang/Exception; { :L8 .. :L9 } :L10
  .catchall { :L8 .. :L9 } :L37
  .catchall { :L22 .. :L29 } :L37
  .catchall { :L31 .. :L32 } :L37
  .catchall { :L35 .. :L36 } :L37
  .registers 14
    monitor-enter p0
  :L0
  .line 144
    invoke-static { p1 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->normalizeType(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
  .line 145
    invoke-static { v3 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->cameraIdForType(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v2
  .line 146
    invoke-direct { p0, p3 }, Lcom/oplus/ocs/camera/CameraUnitImpl;->handler(Landroid/os/Handler;)Landroid/os/Handler;
    move-result-object v5
  .line 147
    const-string p3, "OcsCameraUnit"
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "openCamera "
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v0, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v0, " -> type="
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1, v3 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v0, " id="
    invoke-virtual { p1, v0 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1, v2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { p3, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 148
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
    if-eqz p1, :L30
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
    if-nez p1, :L1
    move-object v4, p2
    move-object v8, v5
    move-object v5, p0
    goto/16 :L31
  :L1
  .line 159
    new-instance v0, Lcom/oplus/ocs/camera/OcsCamera2Device;
    iget-object v1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
    move-object v4, p2
    invoke-direct/range { v0 .. v5 }, Lcom/oplus/ocs/camera/OcsCamera2Device;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Landroid/os/Handler;)V
  .line 160
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mDevices:Ljava/util/Map;
    invoke-interface { p1, v3, v0 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  :L2
  .line 163
    iget-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mCameraManager:Landroid/hardware/camera2/CameraManager;
  :L3
    move-object v9, v4
  :L4
    new-instance v4, Lcom/oplus/ocs/camera/CameraUnitImpl$2;
  :L5
    move-object v7, v0
    move-object v6, v2
    move-object v8, v5
    move-object v5, p0
  :L6
    invoke-direct/range { v4 .. v9 }, Lcom/oplus/ocs/camera/CameraUnitImpl$2;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Ljava/lang/String;Lcom/oplus/ocs/camera/OcsCamera2Device;Landroid/os/Handler;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
  :L7
    move-object p2, v4
    move-object v4, v9
  .line 209
    nop
  :L8
  .line 163
    invoke-virtual { p1, v2, p2, v8 }, Landroid/hardware/camera2/CameraManager;->openCamera(Ljava/lang/String;Landroid/hardware/camera2/CameraDevice$StateCallback;Landroid/os/Handler;)V
  :L9
  .line 210
    goto/16 :L29
  :L10
  .line 226
    move-exception v0
    goto :L21
  :L11
  .line 218
    move-exception v0
    goto :L25
  :L12
  .line 210
    move-exception v0
    goto :L28
  :L13
  .line 226
    move-exception v0
    move-object v4, v9
    goto :L21
  :L14
  .line 218
    move-exception v0
    move-object v4, v9
    goto :L25
  :L15
  .line 210
    move-exception v0
    move-object v4, v9
    goto :L28
  :L16
  .line 226
    move-exception v0
    move-object v8, v5
    move-object v4, v9
    goto :L20
  :L17
  .line 218
    move-exception v0
    move-object v8, v5
    move-object v4, v9
    goto :L24
  :L18
  .line 210
    move-exception v0
    move-object v8, v5
    move-object v4, v9
    goto :L27
  :L19
  .line 226
    move-exception v0
    move-object v8, v5
  :L20
    move-object v5, p0
  :L21
    move-object p1, v0
  :L22
  .line 227
    const-string p2, "OcsCameraUnit"
    const-string p3, "openCamera unexpected"
    invoke-static { p2, p3, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 228
    new-instance p1, Lcom/oplus/ocs/camera/CameraUnitImpl$5;
    invoke-direct { p1, p0, v4 }, Lcom/oplus/ocs/camera/CameraUnitImpl$5;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { v8, p1 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    goto :L29
  :L23
  .line 218
    move-exception v0
    move-object v8, v5
  :L24
    move-object v5, p0
  :L25
    move-object p1, v0
  .line 219
    const-string p2, "OcsCameraUnit"
    const-string p3, "openCamera security"
    invoke-static { p2, p3, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 220
    new-instance p1, Lcom/oplus/ocs/camera/CameraUnitImpl$4;
    invoke-direct { p1, p0, v4 }, Lcom/oplus/ocs/camera/CameraUnitImpl$4;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { v8, p1 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    goto :L29
  :L26
  .line 210
    move-exception v0
    move-object v8, v5
  :L27
    move-object v5, p0
  :L28
    move-object p1, v0
  .line 211
    const-string p2, "OcsCameraUnit"
    const-string p3, "openCamera access"
    invoke-static { p2, p3, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 212
    new-instance p1, Lcom/oplus/ocs/camera/CameraUnitImpl$3;
    invoke-direct { p1, p0, v4 }, Lcom/oplus/ocs/camera/CameraUnitImpl$3;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { v8, p1 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
  :L29
  .line 235
    monitor-exit p0
    return-void
  :L30
  .line 148
    move-object v4, p2
    move-object v8, v5
    move-object v5, p0
  :L31
  .line 149
    const-string p1, "OcsCameraUnit"
    const-string p2, "openCamera before initialize"
    invoke-static { p1, p2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 150
    new-instance p1, Lcom/oplus/ocs/camera/CameraUnitImpl$1;
    invoke-direct { p1, p0, v4 }, Lcom/oplus/ocs/camera/CameraUnitImpl$1;-><init>(Lcom/oplus/ocs/camera/CameraUnitImpl;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;)V
    invoke-virtual { v8, p1 }, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
  :L32
  .line 156
    monitor-exit p0
    return-void
  :L33
  .line 143
    move-exception v0
    move-object v5, p0
  :L34
    move-object p1, v0
  :L35
    monitor-exit p0
  :L36
    throw p1
  :L37
    move-exception v0
    goto :L34
.end method

.method public preOpenCamera(Landroid/content/Context;)V
  .registers 3
  .line 111
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
    if-nez v0, :L0
    iput-object p1, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mContext:Landroid/content/Context;
  :L0
  .line 112
    return-void
.end method

.method public registerCaptureDeferPictureCallback(Lcom/oplus/ocs/camera/appinterface/CameraPictureCallbackAdapter;Landroid/os/Handler;)Z
  .registers 3
  .line 265
    const/4 p1, 0
    return p1
.end method

.method public declared-synchronized release()V
  .catchall { :L0 .. :L2 } :L8
  .catchall { :L3 .. :L4 } :L8
  .catch Ljava/lang/Exception; { :L5 .. :L6 } :L7
  .catchall { :L5 .. :L6 } :L8
  .catchall { :L9 .. :L10 } :L8
  .registers 4
    monitor-enter p0
  :L0
  .line 270
    const-string v0, "OcsCameraUnit"
    const-string v1, "release"
    invoke-static { v0, v1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 271
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mDevices:Ljava/util/Map;
    invoke-interface { v0 }, Ljava/util/Map;->values()Ljava/util/Collection;
    move-result-object v0
    invoke-interface { v0 }, Ljava/util/Collection;->iterator()Ljava/util/Iterator;
    move-result-object v0
  :L1
    invoke-interface { v0 }, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-nez v1, :L3
  .line 277
    iget-object v0, p0, Lcom/oplus/ocs/camera/CameraUnitImpl;->mDevices:Ljava/util/Map;
    invoke-interface { v0 }, Ljava/util/Map;->clear()V
  :L2
  .line 278
    monitor-exit p0
    return-void
  :L3
  .line 271
    invoke-interface { v0 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/oplus/ocs/camera/OcsCamera2Device;
  :L4
  .line 273
    const/4 v2, 1
  :L5
    invoke-virtual { v1, v2 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->close(Z)V
  :L6
  .line 274
    goto :L1
  :L7
    move-exception v1
    goto :L6
  :L8
  .line 269
    move-exception v0
  :L9
    monitor-exit p0
  :L10
    throw v0
.end method

.method public setPreCaptureParams(Landroid/os/Bundle;)V
  .registers 2
  .line 297
    return-void
.end method

.method public updateRequestedDecisionResultLockState(Z)V
  .registers 2
  .line 301
    return-void
.end method
