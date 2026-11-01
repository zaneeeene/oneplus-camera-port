.class public final Lcom/oplus/ocs/camera/OcsCamera2Info;
.super Ljava/lang/Object;
.implements Lcom/oplus/ocs/camera/appinterface/CameraDeviceInfoInterface;
.source "OcsCamera2Info.java"

.field private final mCameraId:Ljava/lang/String;

.field private final mCameraType:Ljava/lang/String;

.field private final mChars:Landroid/hardware/camera2/CameraCharacteristics;

.field private final mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;

.field private final mModeName:Ljava/lang/String;

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
  .catch Ljava/lang/Exception; { :L2 .. :L3 } :L7
  .catch Ljava/lang/Exception; { :L3 .. :L4 } :L5
  .registers 7
  .line 34
    invoke-direct { p0 }, Ljava/lang/Object;-><init>()V
  .line 35
    iput-object p2, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mCameraId:Ljava/lang/String;
  .line 36
    if-nez p3, :L0
    const-string p3, "rear_main"
  :L0
    iput-object p3, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mCameraType:Ljava/lang/String;
  .line 37
    if-nez p4, :L1
    const-string p4, "photo_mode"
  :L1
    iput-object p4, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mModeName:Ljava/lang/String;
  .line 38
    nop
  .line 39
    nop
  .line 41
    const/4 p3, 0
  :L2
    const-string p4, "camera"
    invoke-virtual { p1, p4 }, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Landroid/hardware/camera2/CameraManager;
  .line 42
    if-eqz p1, :L6
  .line 43
    invoke-virtual { p1, p2 }, Landroid/hardware/camera2/CameraManager;->getCameraCharacteristics(Ljava/lang/String;)Landroid/hardware/camera2/CameraCharacteristics;
    move-result-object p1
  :L3
  .line 44
    sget-object p4, Landroid/hardware/camera2/CameraCharacteristics;->SCALER_STREAM_CONFIGURATION_MAP:Landroid/hardware/camera2/CameraCharacteristics$Key;
    invoke-virtual { p1, p4 }, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;
    move-result-object p4
    check-cast p4, Landroid/hardware/camera2/params/StreamConfigurationMap;
  :L4
  .line 46
    move-object p3, p1
    goto :L9
  :L5
    move-exception p4
    goto :L8
  :L6
  .line 42
    move-object p4, p3
    goto :L9
  :L7
  .line 46
    move-exception p4
    move-object p1, p3
  :L8
  .line 47
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "getCameraCharacteristics "
    invoke-direct { v0, v1 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v0, p2 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p2
    invoke-virtual { p2 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p2
    const-string v0, "OcsCamera2Info"
    invoke-static { v0, p2, p4 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    move-object p4, p3
    move-object p3, p1
  :L9
  .line 49
    iput-object p3, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mChars:Landroid/hardware/camera2/CameraCharacteristics;
  .line 50
    iput-object p4, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
  .line 51
    return-void
.end method

.method public get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "<T:",
      "Ljava/lang/Object;",
      ">(",
      "Landroid/hardware/camera2/CameraCharacteristics$Key<",
      "TT;>;)TT;"
    }
  .end annotation
  .catch Ljava/lang/IllegalArgumentException; { :L0 .. :L1 } :L3
  .catch Ljava/lang/Exception; { :L0 .. :L1 } :L2
  .registers 7
  .line 55
    const-string v0, "OcsCamera2Info"
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mChars:Landroid/hardware/camera2/CameraCharacteristics;
    const/4 v2, 0
    if-eqz v1, :L4
    if-nez p1, :L0
    goto :L4
  :L0
  .line 57
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mChars:Landroid/hardware/camera2/CameraCharacteristics;
    invoke-virtual { v1, p1 }, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;
    move-result-object p1
  :L1
    return-object p1
  :L2
  .line 64
    move-exception v1
  .line 65
    new-instance v3, Ljava/lang/StringBuilder;
    const-string v4, "get "
    invoke-direct { v3, v4 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraCharacteristics$Key;->getName()Ljava/lang/String;
    move-result-object p1
    invoke-virtual { v3, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { v0, p1, v1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  .line 66
    return-object v2
  :L3
  .line 58
    move-exception v1
  .line 62
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v3, "missing key "
    invoke-direct { v1, v3 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { p1 }, Landroid/hardware/camera2/CameraCharacteristics$Key;->getName()Ljava/lang/String;
    move-result-object p1
    invoke-virtual { v1, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { v0, p1 }, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
  .line 63
    return-object v2
  :L4
  .line 55
    return-object v2
.end method

.method public getCameraCharacteristics()Landroid/hardware/camera2/CameraCharacteristics;
  .registers 2
  .line 72
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mChars:Landroid/hardware/camera2/CameraCharacteristics;
    return-object v0
.end method

.method public getConfigureListByParameter(Lcom/oplus/ocs/camera/metadata/RequestKey;)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Lcom/oplus/ocs/camera/metadata/RequestKey;",
      ")",
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 77
    invoke-static { }, Ljava/util/Collections;->emptyList()Ljava/util/List;
    move-result-object p1
    return-object p1
.end method

.method public getConfigureParameterRange(Ljava/lang/String;)Ljava/lang/Object;
  .registers 2
  .line 82
    const/4 p1, 0
    return-object p1
.end method

.method public getConfigureParameterRangeMap()Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/Object;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 87
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    return-object v0
.end method

.method public getConflictParameter()Ljava/util/Map;
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
  .annotation runtime Ljava/lang/Deprecated;
  .end annotation
  .registers 2
  .line 93
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    return-object v0
.end method

.method public getConflictParameter(Ljava/lang/String;Ljava/lang/String;)Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ")",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;>;"
    }
  .end annotation
  .registers 3
  .line 98
    new-instance p1, Ljava/util/HashMap;
    invoke-direct { p1 }, Ljava/util/HashMap;-><init>()V
    return-object p1
.end method

.method public getCustomInfoMap()Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 103
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    return-object v0
.end method

.method public getPhysicalCameraTypeList()Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/List<",
      "Ljava/lang/String;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 108
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mCameraType:Ljava/lang/String;
    invoke-static { v0 }, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    return-object v0
.end method

.method public getPreviewMappingSizesFromConfig(Ljava/lang/String;Ljava/util/Map;)Ljava/util/Hashtable;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/lang/String;",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/Hashtable<",
      "Landroid/util/Size;",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .registers 3
  .line 113
    new-instance p1, Ljava/util/Hashtable;
    invoke-direct { p1 }, Ljava/util/Hashtable;-><init>()V
    return-object p1
.end method

.method public getPreviewParameterRange(Ljava/lang/String;)Ljava/lang/Object;
  .registers 2
  .line 118
    const/4 p1, 0
    return-object p1
.end method

.method public getPreviewParameterRangeMap()Ljava/util/Map;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/Object;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 123
    new-instance v0, Ljava/util/HashMap;
    invoke-direct { v0 }, Ljava/util/HashMap;-><init>()V
    return-object v0
.end method

.method public getSupportPictureFormat()Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/List<",
      "Ljava/lang/Integer;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 128
    const/16 v0, 256
    invoke-static { v0 }, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v0
    invoke-static { v0 }, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    return-object v0
.end method

.method public getSupportPictureFormat(Ljava/util/Map;)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/List<",
      "Ljava/lang/Integer;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 133
    invoke-virtual { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Info;->getSupportPictureFormat()Ljava/util/List;
    move-result-object p1
    return-object p1
.end method

.method public getSupportPictureSize()Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .catch Ljava/lang/Exception; { :L1 .. :L2 } :L3
  .registers 4
  .line 138
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    if-nez v0, :L0
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct { v0 }, Ljava/util/ArrayList;-><init>()V
    return-object v0
  :L0
  .line 139
    nop
  :L1
  .line 141
    iget-object v0, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    const/16 v1, 256
    invoke-virtual { v0, v1 }, Landroid/hardware/camera2/params/StreamConfigurationMap;->getOutputSizes(I)[Landroid/util/Size;
    move-result-object v0
  :L2
  .line 142
    goto :L4
  :L3
    move-exception v0
  .line 143
    const-string v1, "OcsCamera2Info"
    const-string v2, "JPEG sizes"
    invoke-static { v1, v2, v0 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    const/4 v0, 0
  :L4
  .line 145
    if-nez v0, :L5
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct { v0 }, Ljava/util/ArrayList;-><init>()V
    goto :L6
  :L5
    new-instance v1, Ljava/util/ArrayList;
    invoke-static { v0 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v0
    invoke-direct { v1, v0 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    move-object v0, v1
  :L6
    return-object v0
.end method

.method public getSupportPictureSize(Ljava/util/Map;)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 150
    invoke-virtual { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Info;->getSupportPictureSize()Ljava/util/List;
    move-result-object p1
    return-object p1
.end method

.method public getSupportPreviewSize(I)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(I)",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .catch Ljava/lang/Exception; { :L2 .. :L3 } :L4
  .catch Ljava/lang/Exception; { :L6 .. :L7 } :L8
  .registers 6
  .line 155
    const-string v0, "OcsCamera2Info"
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    if-nez v1, :L0
    new-instance p1, Ljava/util/ArrayList;
    invoke-direct { p1 }, Ljava/util/ArrayList;-><init>()V
    return-object p1
  :L0
  .line 156
    invoke-static { p1 }, Lcom/oplus/ocs/camera/common/surface/SurfaceWrapper;->getSurfaceClass(I)Ljava/lang/Class;
    move-result-object p1
  .line 157
    if-nez p1, :L1
    const-class p1, Landroid/graphics/SurfaceTexture;
  :L1
  .line 158
    nop
  :L2
  .line 160
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    invoke-virtual { v1, p1 }, Landroid/hardware/camera2/params/StreamConfigurationMap;->getOutputSizes(Ljava/lang/Class;)[Landroid/util/Size;
    move-result-object p1
  :L3
  .line 161
    goto :L5
  :L4
    move-exception v1
  .line 162
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "preview sizes for "
    invoke-direct { v2, v3 }, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual { v2, p1 }, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object p1
    invoke-virtual { p1 }, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-static { v0, p1, v1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    const/4 p1, 0
  :L5
  .line 164
    if-eqz p1, :L6
    array-length v1, p1
    if-nez v1, :L9
  :L6
  .line 166
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    const-class v2, Landroid/graphics/SurfaceTexture;
    invoke-virtual { v1, v2 }, Landroid/hardware/camera2/params/StreamConfigurationMap;->getOutputSizes(Ljava/lang/Class;)[Landroid/util/Size;
    move-result-object p1
  :L7
  .line 167
    goto :L9
  :L8
    move-exception v1
  .line 168
    const-string v2, "fallback preview sizes"
    invoke-static { v0, v2, v1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L9
  .line 171
    if-nez p1, :L10
    new-instance p1, Ljava/util/ArrayList;
    invoke-direct { p1 }, Ljava/util/ArrayList;-><init>()V
    goto :L11
  :L10
    new-instance v0, Ljava/util/ArrayList;
    invoke-static { p1 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object p1
    invoke-direct { v0, p1 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    move-object p1, v0
  :L11
    return-object p1
.end method

.method public getSupportPreviewSize(ILjava/util/Map;)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(I",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .registers 3
  .line 176
    invoke-virtual { p0, p1 }, Lcom/oplus/ocs/camera/OcsCamera2Info;->getSupportPreviewSize(I)Ljava/util/List;
    move-result-object p1
    return-object p1
.end method

.method public getSupportVideoSize()Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "()",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .catch Ljava/lang/Exception; { :L1 .. :L2 } :L3
  .catch Ljava/lang/Exception; { :L5 .. :L6 } :L7
  .registers 5
  .line 181
    const-string v0, "OcsCamera2Info"
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    if-nez v1, :L0
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct { v0 }, Ljava/util/ArrayList;-><init>()V
    return-object v0
  :L0
  .line 182
    nop
  :L1
  .line 184
    iget-object v1, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    const-class v2, Landroid/media/MediaRecorder;
    invoke-virtual { v1, v2 }, Landroid/hardware/camera2/params/StreamConfigurationMap;->getOutputSizes(Ljava/lang/Class;)[Landroid/util/Size;
    move-result-object v1
  :L2
  .line 185
    goto :L4
  :L3
    move-exception v1
  .line 186
    const-string v2, "video sizes"
    invoke-static { v0, v2, v1 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    const/4 v1, 0
  :L4
  .line 188
    if-eqz v1, :L5
    array-length v2, v1
    if-nez v2, :L8
  :L5
  .line 190
    iget-object v2, p0, Lcom/oplus/ocs/camera/OcsCamera2Info;->mMap:Landroid/hardware/camera2/params/StreamConfigurationMap;
    const-class v3, Landroid/view/SurfaceHolder;
    invoke-virtual { v2, v3 }, Landroid/hardware/camera2/params/StreamConfigurationMap;->getOutputSizes(Ljava/lang/Class;)[Landroid/util/Size;
    move-result-object v1
  :L6
  .line 191
    goto :L8
  :L7
    move-exception v2
  .line 192
    const-string v3, "fallback video sizes"
    invoke-static { v0, v3, v2 }, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
  :L8
  .line 195
    new-instance v0, Ljava/util/ArrayList;
    if-nez v1, :L9
    invoke-direct { v0 }, Ljava/util/ArrayList;-><init>()V
    goto :L10
  :L9
    invoke-static { v1 }, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;
    move-result-object v1
    invoke-direct { v0, v1 }, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
  :L10
    return-object v0
.end method

.method public getSupportVideoSize(Ljava/util/Map;)Ljava/util/List;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Ljava/util/List<",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .registers 2
  .line 200
    invoke-virtual { p0 }, Lcom/oplus/ocs/camera/OcsCamera2Info;->getSupportVideoSize()Ljava/util/List;
    move-result-object p1
    return-object p1
.end method

.method public getVideoMappingSizesFromConfig(Ljava/lang/String;Ljava/util/Map;)Landroid/util/Pair;
  .annotation system Ldalvik/annotation/Signature;
    value = {
      "(",
      "Ljava/lang/String;",
      "Ljava/util/Map<",
      "Ljava/lang/String;",
      "Ljava/lang/String;",
      ">;)",
      "Landroid/util/Pair<",
      "Landroid/util/Size;",
      "Landroid/util/Size;",
      ">;"
    }
  .end annotation
  .registers 3
  .line 205
    const/4 p1, 0
    return-object p1
.end method

.method public isPreviewAlgoDisable(I)Z
  .registers 2
  .line 210
    const/4 p1, 0
    return p1
.end method

.method public isSupportConfigureParameter(Ljava/lang/String;)Z
  .registers 2
  .line 215
    const/4 p1, 0
    return p1
.end method

.method public isSupportPreviewParameter(Ljava/lang/String;)Z
  .registers 2
  .line 220
    const/4 p1, 0
    return p1
.end method
