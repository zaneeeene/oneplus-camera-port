.class public final Lcom/oplus/ocs/camera/OcsCamera2Device;
.super Ljava/lang/Object;
.implements Lcom/oplus/ocs/camera/appinterface/CameraDeviceInterface;
.source "OcsCamera2Device.java"

.field private final static TAG:Ljava/lang/String; = "OcsCamera2Device"

.field private mCameraDevice:Landroid/hardware/camera2/CameraDevice;

.field private final mCameraId:Ljava/lang/String;

.field private final mCameraType:Ljava/lang/String;

.field private final mCaptureCallback:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;

.field private mConfiguredCallbackSent:Z

.field private final mContext:Landroid/content/Context;

.field private mFirstFrame:Z

.field private final mHandler:Landroid/os/Handler;

.field private mModeName:Ljava/lang/String;

.field private final mParameters:Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/Object;",
      ">;"
    }
  .end annotation
.end field

.field private final mPictureSurfaces:Ljava/util/LinkedHashSet;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/LinkedHashSet<",
      "Landroid/view/Surface;",
      ">;"
    }
  .end annotation
.end field

.field private mPreviewCallback:Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;

.field private final mPreviewSurfaces:Ljava/util/LinkedHashSet;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/LinkedHashSet<",
      "Landroid/view/Surface;",
      ">;"
    }
  .end annotation
.end field

.field private mPreviewing:Z

.field private mSession:Landroid/hardware/camera2/CameraCaptureSession;

.field private mSessionFailed:Z

.field private final mSessionSurfaces:Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "Ljava/util/List<",
      "Landroid/view/Surface;",
      ">;"
    }
  .end annotation
.end field

.field private final mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;Landroid/os/Handler;)V
  .registers 7
  .line 67
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
  .line 55
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct { v0 }, Ljava/util/ArrayList;-><init>()V
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
  .line 56
    new-instance v0, Ljava/util/LinkedHashSet;
    invoke-direct { v0 }, Ljava/util/LinkedHashSet;-><init>()V
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
  .line 57
    new-instance v0, Ljava/util/LinkedHashSet;
    invoke-direct { v0 }, Ljava/util/LinkedHashSet;-><init>()V
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPictureSurfaces:Ljava/util/LinkedHashSet;
  .line 58
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mParameters:Ljava/util/Map;
  .line 61
    const-string v0, "photo_mode"
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mModeName:Ljava/lang/String;
  .line 299
    new-instance v0, Lcom/oplus/ocs/camera/OcsCamera2Device$1;
    invoke-direct { v0, p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device$1;-><init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCaptureCallback:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
  .line 69
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mContext:Landroid/content/Context;
  .line 70
    iput-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraId:Ljava/lang/String;
  .line 71
    if-nez p3, :L0
    const-string p3, "rear_main"
  :L0
    iput-object p3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
  .line 72
    iput-object p4, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
  .line 73
    iput-object p5, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mHandler:Landroid/os/Handler;
  .line 74
    new-instance p1, Ljava/lang/StringBuilder;
    const-string p2, "created type="
    invoke-direct { p1, p2 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string p2, " id="
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraId:Ljava/lang/String;
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string p2, "OcsCamera2Device"
    invoke-static { p2, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 75
    return-void
.end method

.method static synthetic access$0(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
  .registers 1
  .line 60
    iget-object p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewCallback:Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
    return-object p0
.end method

.method static synthetic access$1(Lcom/oplus/ocs/camera/OcsCamera2Device;)Z
  .registers 1
  .line 62
    iget-boolean p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewing:Z
    return p0
.end method

.method static synthetic access$10(Lcom/oplus/ocs/camera/OcsCamera2Device;Z)V
  .registers 2
  .line 65
    iput-boolean p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionFailed:Z
    return-void
.end method

.method static synthetic access$11(Lcom/oplus/ocs/camera/OcsCamera2Device;Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .registers 2
  .line 348
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
    return-void
.end method

.method static synthetic access$2(Lcom/oplus/ocs/camera/OcsCamera2Device;)Z
  .registers 1
  .line 63
    iget-boolean p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mFirstFrame:Z
    return p0
.end method

.method static synthetic access$3(Lcom/oplus/ocs/camera/OcsCamera2Device;Z)V
  .registers 2
  .line 63
    iput-boolean p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mFirstFrame:Z
    return-void
.end method

.method static synthetic access$4(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/lang/String;
  .registers 1
  .line 49
    iget-object p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    return-object p0
.end method

.method static synthetic access$5(Lcom/oplus/ocs/camera/OcsCamera2Device;)Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
  .registers 1
  .line 50
    iget-object p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    return-object p0
.end method

.method static synthetic access$6(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 1
  .line 215
    invoke-direct { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->notifySessionConfigured()V
    return-void
.end method

.method static synthetic access$7(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .registers 1
  .line 233
    invoke-direct { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->startRepeating()V
    return-void
.end method

.method static synthetic access$8(Lcom/oplus/ocs/camera/OcsCamera2Device;Landroid/hardware/camera2/CameraCaptureSession;)V
  .registers 2
  .line 54
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    return-void
.end method

.method static synthetic access$9(Lcom/oplus/ocs/camera/OcsCamera2Device;)Ljava/util/List;
  .registers 1
  .line 55
    iget-object p0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
    return-object p0
.end method

.method private applyParameters(Landroid/hardware/camera2/CaptureRequest$Builder;)V
  .catch Ljava/lang/Exception; { :L2 .. :L3 } :L4
  .registers 5
  .line 270
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mParameters:Ljava/util/Map;
    invoke-interface { v0 }, Ljava/util/Map;->entrySet()Ljava/util/Set;
    move-result-object v0
    invoke-interface { v0 }, Ljava/util/Set;->iterator()Ljava/util/Iterator;
    move-result-object v0
  :L0
    invoke-interface { v0 }, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-nez v1, :L1
  .line 282
    return-void
  :L1
  .line 270
    invoke-interface { v0 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Ljava/util/Map$Entry;
  :L2
  .line 275
    invoke-interface { v1 }, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    invoke-static { v2 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->keyForName(Ljava/lang/String;)Landroid/hardware/camera2/CaptureRequest$Key;
    move-result-object v2
  .line 276
    if-eqz v2, :L0
  .line 277
    invoke-interface { v1 }, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;
    move-result-object v1
    invoke-virtual { p1, v2, v1 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  :L3
    goto :L5
  :L4
  .line 279
    move-exception v1
  :L5
    goto :L0
.end method

.method private ensureSession(Ljava/util/List;Ljava/lang/Runnable;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/List<",
      "Landroid/view/Surface;",
      ">;",
      "Ljava/lang/Runnable;",
      ")V"
    }
  .end annotation
  .catch Ljava/lang/Exception; { :L4 .. :L5 } :L6
  .catch Landroid/hardware/camera2/CameraAccessException; { :L9 .. :L10 } :L12
  .catch Ljava/lang/Exception; { :L9 .. :L10 } :L11
  .registers 6
  .line 165
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
    const-string v1, "OcsCamera2Device"
    if-nez v0, :L0
  .line 166
    const-string p1, "ensureSession: camera device is null"
    invoke-static { v1, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 167
    sget-object p1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->ILLEGAL_STATE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .line 168
    return-void
  :L0
  .line 170
    if-eqz p1, :L14
    invoke-interface { p1 }, Ljava/util/List;->isEmpty()Z
    move-result v0
    if-eqz v0, :L1
    goto :L14
  :L1
  .line 174
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz v0, :L3
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->sameSurfaces(Ljava/util/List;)Z
    move-result v0
    if-eqz v0, :L3
  .line 175
    if-eqz p2, :L2
    invoke-interface { p2 }, Ljava/lang/Runnable;->run()V
  :L2
  .line 176
    return-void
  :L3
  .line 178
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz v0, :L8
  :L4
  .line 180
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { v0 }, Landroid/hardware/camera2/CameraCaptureSession;->close()V
  :L5
    goto :L7
  :L6
  .line 181
    move-exception v0
  :L7
    nop
  .line 183
    const/4 v0, 0
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
  .line 184
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
    invoke-interface { v0 }, Ljava/util/List;->clear()V
  :L8
  .line 186
    const/4 v0, 0
    iput-boolean v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionFailed:Z
  :L9
  .line 188
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
    new-instance v2, Lcom/oplus/ocs/camera/OcsCamera2Device$5;
    invoke-direct { v2, p0, p1, p2 }, Lcom/oplus/ocs/camera/OcsCamera2Device$5;-><init>(Lcom/oplus/ocs/camera/OcsCamera2Device;Ljava/util/List;Ljava/lang/Runnable;)V
  .line 205
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mHandler:Landroid/os/Handler;
  .line 188
    invoke-virtual { v0, p1, v2, p2 }, Landroid/hardware/camera2/CameraDevice;->createCaptureSession(Ljava/util/List;Landroid/hardware/camera2/CameraCaptureSession$StateCallback;Landroid/os/Handler;)V
  :L10
  .line 206
    goto :L13
  :L11
  .line 209
    move-exception p1
  .line 210
    const-string p2, "createCaptureSession unexpected"
    invoke-static { v1, p2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 211
    sget-object p1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->STREAM_SURFACE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
    goto :L13
  :L12
  .line 206
    move-exception p1
  .line 207
    const-string p2, "createCaptureSession"
    invoke-static { v1, p2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 208
    sget-object p1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->STREAM_SURFACE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  :L13
  .line 213
    return-void
  :L14
  .line 171
    sget-object p1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->PARAMETER_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .line 172
    return-void
.end method

.method private fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 4
  :L0
  .line 350
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { v0, p1 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onSessionConfigureFail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  :L1
  .line 351
    goto :L3
  :L2
    move-exception p1
  .line 352
    const-string v0, "OcsCamera2Device"
    const-string v1, "onSessionConfigureFail"
    invoke-static { v0, v1, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 354
    return-void
.end method

.method private static keyForName(Ljava/lang/String;)Landroid/hardware/camera2/CaptureRequest$Key;
  .registers 3
  .line 285
    const/4 v0, 0
    if-nez p0, :L0
    return-object v0
  :L0
  .line 286
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_EXPOSURE_COMPENSATION:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :L1
  .line 287
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_EXPOSURE_COMPENSATION:Landroid/hardware/camera2/CaptureRequest$Key;
    return-object p0
  :L1
  .line 288
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :L2
  .line 289
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    return-object p0
  :L2
  .line 290
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :L3
  .line 291
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    return-object p0
  :L3
  .line 292
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-eqz v1, :L4
  .line 293
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    return-object p0
  :L4
  .line 294
    sget-object v1, Landroid/hardware/camera2/CaptureRequest;->SCALER_CROP_REGION:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-virtual { v1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object v1
    invoke-virtual { p0, v1 }, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result p0
    if-eqz p0, :L5
  .line 295
    sget-object p0, Landroid/hardware/camera2/CaptureRequest;->SCALER_CROP_REGION:Landroid/hardware/camera2/CaptureRequest$Key;
    return-object p0
  :L5
  .line 296
    return-object v0
.end method

.method private notifySessionConfigured()V
  .catch Ljava/lang/Exception; { :L1 .. :L2 } :L3
  .registers 4
  .line 216
    iget-boolean v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mConfiguredCallbackSent:Z
    if-eqz v0, :L0
    return-void
  :L0
  .line 217
    const/4 v0, 1
    iput-boolean v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mConfiguredCallbackSent:Z
  :L1
  .line 219
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { v0 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onSessionConfigured()V
  :L2
  .line 220
    goto :L4
  :L3
    move-exception v0
  .line 221
    const-string v1, "OcsCamera2Device"
    const-string v2, "onSessionConfigured callback"
    invoke-static { v1, v2, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L4
  .line 223
    return-void
.end method

.method private sameSurfaces(Ljava/util/List;)Z
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/List<",
      "Landroid/view/Surface;",
      ">;)Z"
    }
  .end annotation
  .registers 6
  .line 226
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
    invoke-interface { v0 }, Ljava/util/List;->size()I
    move-result v0
    invoke-interface { p1 }, Ljava/util/List;->size()I
    move-result v1
    const/4 v2, 0
    if-eq v0, v1, :L0
    return v2
  :L0
  .line 227
    move v0, v2
  :L1
    invoke-interface { p1 }, Ljava/util/List;->size()I
    move-result v1
    if-lt v0, v1, :L2
  .line 230
    const/4 p1, 1
    return p1
  :L2
  .line 228
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
    invoke-interface { v1, v0 }, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v1
    invoke-interface { p1, v0 }, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object v3
    if-eq v1, v3, :L3
    return v2
  :L3
  .line 227
    add-int/lit8 v0, v0, 1
    goto :L1
.end method

.method private static setSafe(Landroid/hardware/camera2/CaptureRequest$Builder;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "<T:",
      "Ljava/lang/Object;",
      ">(",
      "Landroid/hardware/camera2/CaptureRequest$Builder;",
      "Landroid/hardware/camera2/CaptureRequest$Key<",
      "TT;>;TT;)V"
    }
  .end annotation
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 3
  :L0
  .line 264
    invoke-virtual { p0, p1, p2 }, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  :L1
  .line 265
    goto :L3
  :L2
    move-exception p0
    goto :L1
  :L3
  .line 267
    return-void
.end method

.method private startRepeating()V
  .catch Ljava/lang/Exception; { :L0 .. :L2 } :L8
  .catch Ljava/lang/Exception; { :L2 .. :L3 } :L4
  .catch Ljava/lang/Exception; { :L5 .. :L7 } :L8
  .registers 7
  .line 234
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    const-string v1, "OcsCamera2Device"
    if-nez v0, :L0
  .line 235
    const-string v0, "startRepeating without session"
    invoke-static { v1, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 236
    return-void
  :L0
  .line 239
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
    const/4 v2, 1
    invoke-virtual { v0, v2 }, Landroid/hardware/camera2/CameraDevice;->createCaptureRequest(I)Landroid/hardware/camera2/CaptureRequest$Builder;
    move-result-object v0
  .line 240
    iget-object v3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { v3 }, Ljava/util/LinkedHashSet;->iterator()Ljava/util/Iterator;
    move-result-object v3
  :L1
    invoke-interface { v3 }, Ljava/util/Iterator;->hasNext()Z
    move-result v4
    if-nez v4, :L6
  .line 243
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-static { v0, v3, v4 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setSafe(Landroid/hardware/camera2/CaptureRequest$Builder;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 244
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AF_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    const/4 v4, 4
    invoke-static { v4 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-static { v0, v3, v4 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setSafe(Landroid/hardware/camera2/CaptureRequest$Builder;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 245
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-static { v0, v3, v4 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setSafe(Landroid/hardware/camera2/CaptureRequest$Builder;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 246
    sget-object v3, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AWB_MODE:Landroid/hardware/camera2/CaptureRequest$Key;
    invoke-static { v2 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v4
    invoke-static { v0, v3, v4 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setSafe(Landroid/hardware/camera2/CaptureRequest$Builder;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 247
    invoke-direct { p0, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->applyParameters(Landroid/hardware/camera2/CaptureRequest$Builder;)V
  .line 248
    iget-object v3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { v0 }, Landroid/hardware/camera2/CaptureRequest$Builder;->build()Landroid/hardware/camera2/CaptureRequest;
    move-result-object v0
    iget-object v4, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCaptureCallback:Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;
    iget-object v5, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mHandler:Landroid/os/Handler;
    invoke-virtual { v3, v0, v4, v5 }, Landroid/hardware/camera2/CameraCaptureSession;->setRepeatingRequest(Landroid/hardware/camera2/CaptureRequest;Landroid/hardware/camera2/CameraCaptureSession$CaptureCallback;Landroid/os/Handler;)I
  .line 249
    iput-boolean v2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewing:Z
  .line 250
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v2, "repeating preview started type="
    invoke-direct { v0, v2 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    invoke-virtual { v0, v2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual { v0 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static { v1, v0 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  :L2
  .line 252
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { v0 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onActive()V
  :L3
  .line 253
    goto :L9
  :L4
    move-exception v0
  :L5
  .line 254
    const-string v2, "onActive"
    invoke-static { v1, v2, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 256
    goto :L9
  :L6
  .line 240
    invoke-interface { v3 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/view/Surface;
  .line 241
    invoke-virtual { v0, v4 }, Landroid/hardware/camera2/CaptureRequest$Builder;->addTarget(Landroid/view/Surface;)V
  :L7
    goto :L1
  :L8
  .line 256
    move-exception v0
  .line 257
    const-string v2, "setRepeatingRequest"
    invoke-static { v1, v2, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 258
    sget-object v0, Lcom/oplus/ocs/camera/common/util/ErrorResult;->ILLEGAL_STATE_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  :L9
  .line 260
    return-void
.end method

.method public abortCaptures()V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 2
  .line 420
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz v0, :L4
  :L0
  .line 422
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { v0 }, Landroid/hardware/camera2/CameraCaptureSession;->abortCaptures()V
  :L1
    goto :L3
  :L2
  .line 423
    move-exception v0
  :L3
    nop
  :L4
  .line 426
    return-void
.end method

.method public close(Z)V
  .registers 3
  .line 376
    const/4 v0, 1
    invoke-virtual { p0, p1, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->close(ZZ)V
  .line 377
    return-void
.end method

.method public close(ZZ)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .catch Ljava/lang/Exception; { :L5 .. :L6 } :L7
  .catch Ljava/lang/Exception; { :L10 .. :L11 } :L12
  .registers 4
  .line 381
    const/4 p1, 0
    iput-boolean p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewing:Z
  :L0
  .line 383
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz p1, :L4
  .line 384
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraCaptureSession;->close()V
  :L1
    goto :L3
  :L2
  .line 386
    move-exception p1
  :L3
    nop
  :L4
  .line 388
    const/4 p1, 0
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
  :L5
  .line 390
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
    if-eqz p2, :L9
  .line 391
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
    invoke-virtual { p2 }, Landroid/hardware/camera2/CameraDevice;->close()V
  :L6
    goto :L8
  :L7
  .line 393
    move-exception p2
  :L8
    nop
  :L9
  .line 395
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
  :L10
  .line 397
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onCameraClosed()V
  :L11
  .line 398
    goto :L13
  :L12
    move-exception p1
  .line 399
    const-string p2, "OcsCamera2Device"
    const-string v0, "onCameraClosed"
    invoke-static { p2, v0, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L13
  .line 401
    return-void
.end method

.method public closeSession()V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .catch Ljava/lang/Exception; { :L5 .. :L6 } :L7
  .registers 2
  :L0
  .line 406
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz v0, :L4
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { v0 }, Landroid/hardware/camera2/CameraCaptureSession;->close()V
  :L1
    goto :L3
  :L2
  .line 407
    move-exception v0
  :L3
    nop
  :L4
  .line 409
    const/4 v0, 0
    iput-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
  .line 410
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSessionSurfaces:Ljava/util/List;
    invoke-interface { v0 }, Ljava/util/List;->clear()V
  .line 411
    const/4 v0, 0
    iput-boolean v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mConfiguredCallbackSent:Z
  :L5
  .line 413
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mStateCallback:Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;
    invoke-virtual { v0 }, Lcom/oplus/ocs/camera/appinterface/CameraStateCallbackAdapter;->onSessionClosed()V
  :L6
    goto :L8
  :L7
  .line 414
    move-exception v0
  :L8
    nop
  .line 416
    return-void
.end method

.method public configure(Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;)V
  .catch Ljava/lang/Exception; { :L3 .. :L8 } :L9
  .registers 6
  .line 87
    const-string v0, "OcsCamera2Device"
    if-nez p1, :L0
    return-void
  :L0
  .line 88
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;->getModeName()Ljava/lang/String;
    move-result-object v1
    if-nez v1, :L1
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mModeName:Ljava/lang/String;
    goto :L2
  :L1
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;->getModeName()Ljava/lang/String;
    move-result-object v1
  :L2
    iput-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mModeName:Ljava/lang/String;
  :L3
  .line 90
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;->getPreviewSurfaces()Ljava/util/List;
    move-result-object v1
    invoke-interface { v1 }, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
  :L4
    invoke-interface { v1 }, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-nez v2, :L7
  .line 95
    invoke-virtual { p1 }, Lcom/oplus/ocs/camera/common/parameter/SdkCameraDeviceConfig;->getPictureSurfaces()Ljava/util/List;
    move-result-object p1
    invoke-interface { p1 }, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object p1
  :L5
    invoke-interface { p1 }, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-nez v1, :L6
  .line 100
    goto :L10
  :L6
  .line 95
    invoke-interface { p1 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;
  .line 96
    if-eqz v1, :L5
    invoke-virtual { v1 }, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;->getSurface()Landroid/view/Surface;
    move-result-object v2
    if-eqz v2, :L5
  .line 97
    iget-object v2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPictureSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { v1 }, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;->getSurface()Landroid/view/Surface;
    move-result-object v1
    invoke-virtual { v2, v1 }, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z
    goto :L5
  :L7
  .line 90
    invoke-interface { v1 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;
  .line 91
    if-eqz v2, :L4
    invoke-virtual { v2 }, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;->getSurface()Landroid/view/Surface;
    move-result-object v3
    if-eqz v3, :L4
  .line 92
    iget-object v3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { v2 }, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;->getSurface()Landroid/view/Surface;
    move-result-object v2
    invoke-virtual { v3, v2 }, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z
  :L8
    goto :L4
  :L9
  .line 100
    move-exception p1
  .line 101
    const-string v1, "configure surfaces"
    invoke-static { v0, v1, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L10
  .line 103
    new-instance p1, Ljava/lang/StringBuilder;
    const-string v1, "configure type="
    invoke-direct { p1, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v1, " mode="
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mModeName:Ljava/lang/String;
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
  .line 104
    const-string v1, " preview="
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { v1 }, Ljava/util/LinkedHashSet;->size()I
    move-result v1
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    const-string v1, " picture="
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPictureSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { v1 }, Ljava/util/LinkedHashSet;->size()I
    move-result v1
    invoke-virtual { p1, v1 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
  .line 103
    invoke-static { v0, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 105
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { p1 }, Ljava/util/LinkedHashSet;->isEmpty()Z
    move-result p1
    if-eqz p1, :L13
  .line 110
    const-string p1, "configure: no real preview surface yet, scheduling callback"
    invoke-static { v0, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 111
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mHandler:Landroid/os/Handler;
  .line 112
    if-eqz p1, :L11
  .line 113
    new-instance v0, Lcom/oplus/ocs/camera/OcsCamera2Device$2;
    invoke-direct { v0, p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device$2;-><init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 119
    nop
  .line 113
    const-wide/16 v1, 1000
    invoke-virtual { p1, v0, v1, v2 }, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
  .line 120
    goto :L12
  :L11
  .line 121
    invoke-direct { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->notifySessionConfigured()V
  :L12
  .line 123
    return-void
  :L13
  .line 125
    new-instance p1, Ljava/util/ArrayList;
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-direct { p1, v0 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    iget-boolean v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewing:Z
    if-eqz v0, :L14
    new-instance v0, Lcom/oplus/ocs/camera/OcsCamera2Device$3;
    invoke-direct { v0, p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device$3;-><init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
  .line 130
    goto :L15
  :L14
    const/4 v0, 0
  :L15
  .line 125
    invoke-direct { p0, p1, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->ensureSession(Ljava/util/List;Ljava/lang/Runnable;)V
  .line 131
    return-void
.end method

.method public getCameraDeviceInfo(Ljava/lang/String;Ljava/lang/String;)Lcom/oplus/ocs/camera/appinterface/CameraDeviceInfoInterface;
  .registers 6
  .line 430
    new-instance p1, Lcom/oplus/ocs/camera/OcsCamera2Info;
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mContext:Landroid/content/Context;
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraId:Ljava/lang/String;
    iget-object v2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    if-nez p2, :L0
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mModeName:Ljava/lang/String;
  :L0
    invoke-direct { p1, v0, v1, v2, p2 }, Lcom/oplus/ocs/camera/OcsCamera2Info;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-object p1
.end method

.method public getCameraType()Ljava/lang/String;
  .registers 2
  .line 82
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    return-object v0
.end method

.method public getVideoSurface()Landroid/view/Surface;
  .registers 2
  .line 435
    const/4 v0, 0
    return-object v0
.end method

.method public isPreviewProcessByAps()Z
  .registers 2
  .line 440
    const/4 v0, 0
    return v0
.end method

.method public notifyLastCaptureFrame()Z
  .registers 2
  .line 445
    const/4 v0, 0
    return v0
.end method

.method public onFirstPreviewFrameDrawn()V
  .registers 1
  .line 450
    return-void
.end method

.method public pauseRecording()V
  .registers 1
  .line 454
    return-void
.end method

.method public pauseRecordingToHal()V
  .registers 1
  .line 458
    return-void
.end method

.method public processBitmap(Landroid/graphics/Bitmap;Landroid/hardware/camera2/CaptureResult;III)Landroid/graphics/Bitmap;
  .registers 6
  .line 462
    return-object p1
.end method

.method public registerFlashCallback(Lcom/oplus/ocs/camera/appinterface/CameraFlashCallbackAdapter;Landroid/os/Handler;)V
  .registers 3
  .line 467
    return-void
.end method

.method public resumeRecording()V
  .registers 1
  .line 471
    return-void
.end method

.method public resumeRecordingToHal(Lcom/oplus/ocs/camera/appinterface/CameraRecordingCallbackAdapter;Landroid/os/Handler;)V
  .registers 3
  .line 475
    return-void
.end method

.method public setCameraDevice(Landroid/hardware/camera2/CameraDevice;)V
  .registers 2
  .line 78
    iput-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraDevice:Landroid/hardware/camera2/CameraDevice;
  .line 79
    return-void
.end method

.method public setDisablePreview(Z)V
  .registers 2
  .line 479
    return-void
.end method

.method public setParameter(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "<T:",
      "Ljava/lang/Object;",
      ">(",
      "Landroid/hardware/camera2/CaptureRequest$Key<",
      "TT;>;TT;)V"
    }
  .end annotation
  .registers 4
  .line 483
    if-eqz p1, :L0
  .line 484
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mParameters:Ljava/util/Map;
    invoke-virtual { p1 }, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;
    move-result-object p1
    invoke-interface { v0, p1, p2 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  :L0
  .line 486
    return-void
.end method

.method public setParameter(Ljava/lang/String;Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "<T:",
      "Ljava/lang/Object;",
      ">(",
      "Ljava/lang/String;",
      "Landroid/hardware/camera2/CaptureRequest$Key<",
      "TT;>;TT;)V"
    }
  .end annotation
  .registers 4
  .line 490
    invoke-virtual { p0, p2, p3 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->setParameter(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
  .line 491
    return-void
.end method

.method public setParameter(Ljava/lang/String;Ljava/lang/Object;)V
  .registers 4
  .line 495
    if-eqz p1, :L0
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mParameters:Ljava/util/Map;
    invoke-interface { v0, p1, p2 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  :L0
  .line 496
    return-void
.end method

.method public setParameter(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
  .registers 4
  .line 500
    if-eqz p2, :L0
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mParameters:Ljava/util/Map;
    invoke-interface { p1, p2, p3 }, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
  :L0
  .line 501
    return-void
.end method

.method public setStopPreviewAfterCapture(Z)V
  .registers 2
  .line 505
    return-void
.end method

.method public startPreview(Ljava/util/Map;Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;Landroid/os/Handler;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Landroid/view/Surface;",
      ">;",
      "Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;",
      "Landroid/os/Handler;",
      ")V"
    }
  .end annotation
  .registers 5
  .line 135
    const/4 v0, 0
    invoke-virtual { p0, p1, p2, p3, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->startPreview(Ljava/util/Map;Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;Landroid/os/Handler;Lcom/oplus/ocs/camera/appinterface/CameraPreviewAssistCallbackAdapter;)V
  .line 136
    return-void
.end method

.method public startPreview(Ljava/util/Map;Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;Landroid/os/Handler;Lcom/oplus/ocs/camera/appinterface/CameraPreviewAssistCallbackAdapter;)V
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Landroid/view/Surface;",
      ">;",
      "Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;",
      "Landroid/os/Handler;",
      "Lcom/oplus/ocs/camera/appinterface/CameraPreviewAssistCallbackAdapter;",
      ")V"
    }
  .end annotation
  .registers 5
  .line 141
    iput-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewCallback:Lcom/oplus/ocs/camera/appinterface/CameraPreviewCallbackAdapter;
  .line 142
    if-eqz p1, :L2
  .line 143
    invoke-interface { p1 }, Ljava/util/Map;->values()Ljava/util/Collection;
    move-result-object p2
    invoke-interface { p2 }, Ljava/util/Collection;->iterator()Ljava/util/Iterator;
    move-result-object p2
  :L0
    invoke-interface { p2 }, Ljava/util/Iterator;->hasNext()Z
    move-result p3
    if-nez p3, :L1
    goto :L2
  :L1
    invoke-interface { p2 }, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object p3
    check-cast p3, Landroid/view/Surface;
  .line 144
    if-eqz p3, :L0
  .line 145
    iget-object p4, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { p4, p3 }, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z
    goto :L0
  :L2
  .line 149
    new-instance p2, Ljava/lang/StringBuilder;
    const-string p3, "startPreview type="
    invoke-direct { p2, p3 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object p3, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    invoke-virtual { p2, p3 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p2
    const-string p3, " map="
    invoke-virtual { p2, p3 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p2
    if-nez p1, :L3
    const-string p1, "null"
    goto :L4
  :L3
    invoke-interface { p1 }, Ljava/util/Map;->size()I
    move-result p1
    invoke-static { p1 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object p1
  :L4
    invoke-virtual { p2, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object p1
  .line 150
    const-string p2, " surfaces="
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { p2 }, Ljava/util/LinkedHashSet;->size()I
    move-result p2
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
  .line 149
    const-string p2, "OcsCamera2Device"
    invoke-static { p2, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 151
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-virtual { p1 }, Ljava/util/LinkedHashSet;->isEmpty()Z
    move-result p1
    if-eqz p1, :L5
  .line 152
    const-string p1, "startPreview without a surface"
    invoke-static { p2, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
  .line 153
    sget-object p1, Lcom/oplus/ocs/camera/common/util/ErrorResult;->PARAMETER_ERROR:Lcom/oplus/ocs/camera/common/util/ErrorResult;
    invoke-direct { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->fail(Lcom/oplus/ocs/camera/common/util/ErrorResult;)V
  .line 154
    return-void
  :L5
  .line 156
    new-instance p1, Ljava/util/ArrayList;
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewSurfaces:Ljava/util/LinkedHashSet;
    invoke-direct { p1, p2 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    new-instance p2, Lcom/oplus/ocs/camera/OcsCamera2Device$4;
    invoke-direct { p2, p0 }, Lcom/oplus/ocs/camera/OcsCamera2Device$4;-><init>(Lcom/oplus/ocs/camera/OcsCamera2Device;)V
    invoke-direct { p0, p1, p2 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->ensureSession(Ljava/util/List;Ljava/lang/Runnable;)V
  .line 162
    return-void
.end method

.method public startRecording(Lcom/oplus/ocs/camera/appinterface/CameraRecordingCallbackAdapter;Landroid/os/Handler;)V
  .registers 3
  .line 509
    return-void
.end method

.method public stopPreview()V
  .registers 2
  .line 358
    const/4 v0, 0
    invoke-virtual { p0, v0 }, Lcom/oplus/ocs/camera/OcsCamera2Device;->stopPreview(Z)V
  .line 359
    return-void
.end method

.method public stopPreview(Z)V
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 4
  .line 363
    const/4 p1, 0
    iput-boolean p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mPreviewing:Z
  .line 364
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    if-eqz p1, :L3
  :L0
  .line 366
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraCaptureSession;->stopRepeating()V
  .line 367
    iget-object p1, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mSession:Landroid/hardware/camera2/CameraCaptureSession;
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraCaptureSession;->abortCaptures()V
  :L1
  .line 368
    goto :L3
  :L2
    move-exception p1
  .line 369
    const-string v0, "OcsCamera2Device"
    const-string v1, "stopPreview"
    invoke-static { v0, v1, p1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L3
  .line 372
    return-void
.end method

.method public stopRecording()V
  .registers 1
  .line 513
    return-void
.end method

.method public takePicture(Lcom/oplus/ocs/camera/appinterface/CameraPictureCallbackAdapter;Landroid/os/Handler;)V
  .registers 3
  .line 519
    new-instance p1, Ljava/lang/StringBuilder;
    const-string p2, "takePicture requested (not implemented yet) type="
    invoke-direct { p1, p2 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Device;->mCameraType:Ljava/lang/String;
    invoke-virtual { p1, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    const-string p2, "OcsCamera2Device"
    invoke-static { p2, p1 }, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
  .line 520
    return-void
.end method

.method public takePictureTouchDownStage2()V
  .registers 1
  .line 524
    return-void
.end method

.method public takePictureTouchDownStage2(I)V
  .registers 2
  .line 528
    return-void
.end method

.method public updateThumbnailMap(J)V
  .registers 3
  .line 532
    return-void
.end method
