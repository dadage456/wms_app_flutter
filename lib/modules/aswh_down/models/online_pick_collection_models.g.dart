// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_pick_collection_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OnlinePickBarcodeContentAdapter
    extends TypeAdapter<OnlinePickBarcodeContent> {
  @override
  final int typeId = 40;

  @override
  OnlinePickBarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnlinePickBarcodeContent(
      materialCode: fields[0] as String?,
      materialName: fields[1] as String?,
      batchNo: fields[2] as String?,
      serialNumber: fields[3] as String?,
      sequenceControl: fields[4] as String?,
      legacyId: fields[5] as String?,
      quantity: fields[6] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, OnlinePickBarcodeContent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.materialCode)
      ..writeByte(1)
      ..write(obj.materialName)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNumber)
      ..writeByte(4)
      ..write(obj.sequenceControl)
      ..writeByte(5)
      ..write(obj.legacyId)
      ..writeByte(6)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnlinePickBarcodeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OnlinePickCollectionStockAdapter
    extends TypeAdapter<OnlinePickCollectionStock> {
  @override
  final int typeId = 41;

  @override
  OnlinePickCollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnlinePickCollectionStock(
      stockId: fields[0] as String,
      materialCode: fields[1] as String,
      batchNo: fields[2] as String?,
      serialNumber: fields[3] as String?,
      taskQty: fields[4] as num,
      collectQty: fields[5] as num,
      outTaskItemId: fields[6] as String,
      taskId: fields[7] as String,
      storeRoom: fields[8] as String?,
      storeSite: fields[9] as String?,
      erpStore: fields[10] as String?,
      trayNo: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OnlinePickCollectionStock obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.stockId)
      ..writeByte(1)
      ..write(obj.materialCode)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNumber)
      ..writeByte(4)
      ..write(obj.taskQty)
      ..writeByte(5)
      ..write(obj.collectQty)
      ..writeByte(6)
      ..write(obj.outTaskItemId)
      ..writeByte(7)
      ..write(obj.taskId)
      ..writeByte(8)
      ..write(obj.storeRoom)
      ..writeByte(9)
      ..write(obj.storeSite)
      ..writeByte(10)
      ..write(obj.erpStore)
      ..writeByte(11)
      ..write(obj.trayNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnlinePickCollectionStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OnlinePickCollectionCacheSnapshotAdapter
    extends TypeAdapter<OnlinePickCollectionCacheSnapshot> {
  @override
  final int typeId = 42;

  @override
  OnlinePickCollectionCacheSnapshot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OnlinePickCollectionCacheSnapshot(
      stocks: (fields[0] as List).cast<OnlinePickCollectionStock>(),
      dicSeq: (fields[1] as Map).cast<String, String>(),
      dicMtlQty: (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<double>())),
      dicInvMtlQty: (fields[3] as Map).cast<String, double>(),
      lastBarcode: fields[4] as OnlinePickBarcodeContent?,
      location: fields[5] as String,
      trayNo: fields[6] as String,
      userId: fields[7] as int,
      pendingQuantity: fields[8] as num?,
      mode: fields[9] as String,
      expectedErpStore: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OnlinePickCollectionCacheSnapshot obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.stocks)
      ..writeByte(1)
      ..write(obj.dicSeq)
      ..writeByte(2)
      ..write(obj.dicMtlQty)
      ..writeByte(3)
      ..write(obj.dicInvMtlQty)
      ..writeByte(4)
      ..write(obj.lastBarcode)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.trayNo)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.pendingQuantity)
      ..writeByte(9)
      ..write(obj.mode)
      ..writeByte(10)
      ..write(obj.expectedErpStore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnlinePickCollectionCacheSnapshotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlinePickBarcodeContentImpl _$$OnlinePickBarcodeContentImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickBarcodeContentImpl(
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      batchNo: json['batchno'] as String?,
      serialNumber: json['sn'] as String?,
      sequenceControl: json['seqctrl'] as String?,
      legacyId: json['id_old'] as String?,
      quantity: json['qty'] as num?,
    );

Map<String, dynamic> _$$OnlinePickBarcodeContentImplToJson(
        _$OnlinePickBarcodeContentImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'batchno': instance.batchNo,
      'sn': instance.serialNumber,
      'seqctrl': instance.sequenceControl,
      'id_old': instance.legacyId,
      'qty': instance.quantity,
    };

_$OnlinePickCollectionStockImpl _$$OnlinePickCollectionStockImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickCollectionStockImpl(
      stockId: json['stockid'] as String,
      materialCode: json['matcode'] as String,
      batchNo: json['batchno'] as String?,
      serialNumber: json['sn'] as String?,
      taskQty: json['taskQty'] as num? ?? 0,
      collectQty: json['collectQty'] as num? ?? 0,
      outTaskItemId: json['outtaskitemid'] as String,
      taskId: json['taskid'] as String,
      storeRoom: json['storeRoom'] as String?,
      storeSite: json['storeSite'] as String?,
      erpStore: json['erpStore'] as String?,
      trayNo: json['trayNo'] as String?,
    );

Map<String, dynamic> _$$OnlinePickCollectionStockImplToJson(
        _$OnlinePickCollectionStockImpl instance) =>
    <String, dynamic>{
      'stockid': instance.stockId,
      'matcode': instance.materialCode,
      'batchno': instance.batchNo,
      'sn': instance.serialNumber,
      'taskQty': instance.taskQty,
      'collectQty': instance.collectQty,
      'outtaskitemid': instance.outTaskItemId,
      'taskid': instance.taskId,
      'storeRoom': instance.storeRoom,
      'storeSite': instance.storeSite,
      'erpStore': instance.erpStore,
      'trayNo': instance.trayNo,
    };

_$OnlinePickLocationOptionImpl _$$OnlinePickLocationOptionImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickLocationOptionImpl(
      label: json['label'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$OnlinePickLocationOptionImplToJson(
        _$OnlinePickLocationOptionImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

_$OnlinePickCollectionQueryImpl _$$OnlinePickCollectionQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickCollectionQueryImpl(
      outTaskNo: json['outtaskno'] as String? ?? '',
      storeRoomNo: json['storeroomno'] as String? ?? '',
      forceSite: json['forcesite'] as String? ?? '',
      forceBatch: json['forcebatch'] as String? ?? '',
      taskComment: json['taskcomment'] as String? ?? '',
      finishFlag: json['finshFlg'] as String? ?? '0',
      roomTag: json['roomtag'] as String? ?? '1',
      workStation: json['workstation'] as String? ?? '',
      sortType: json['sortType'] as String? ?? '',
      sortColumn: json['sortColumn'] as String? ?? '',
      searchKey: json['searchKey'] as String? ?? '',
      beatFlag: json['beatflag'] as String? ?? 'N',
      collector: (json['collecter'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OnlinePickCollectionQueryImplToJson(
        _$OnlinePickCollectionQueryImpl instance) =>
    <String, dynamic>{
      'outtaskno': instance.outTaskNo,
      'storeroomno': instance.storeRoomNo,
      'forcesite': instance.forceSite,
      'forcebatch': instance.forceBatch,
      'taskcomment': instance.taskComment,
      'finshFlg': instance.finishFlag,
      'roomtag': instance.roomTag,
      'workstation': instance.workStation,
      'sortType': instance.sortType,
      'sortColumn': instance.sortColumn,
      'searchKey': instance.searchKey,
      'beatflag': instance.beatFlag,
      'collecter': instance.collector,
    };

_$OnlinePickTrayConfirmImpl _$$OnlinePickTrayConfirmImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTrayConfirmImpl(
      trayNo: json['trayNo'] as String,
      expectedQuantity: json['expectedQuantity'] as num? ?? 0,
      confirmedQuantity: json['confirmedQuantity'] as num? ?? 0,
      operatorId: json['operatorId'] as String? ?? '',
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
    );

Map<String, dynamic> _$$OnlinePickTrayConfirmImplToJson(
        _$OnlinePickTrayConfirmImpl instance) =>
    <String, dynamic>{
      'trayNo': instance.trayNo,
      'expectedQuantity': instance.expectedQuantity,
      'confirmedQuantity': instance.confirmedQuantity,
      'operatorId': instance.operatorId,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
    };

_$OnlinePickCollectionCacheSnapshotImpl
    _$$OnlinePickCollectionCacheSnapshotImplFromJson(
            Map<String, dynamic> json) =>
        _$OnlinePickCollectionCacheSnapshotImpl(
          stocks: (json['stocks'] as List<dynamic>?)
                  ?.map((e) => OnlinePickCollectionStock.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const <OnlinePickCollectionStock>[],
          dicSeq: (json['dicSeq'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as String),
              ) ??
              const <String, String>{},
          dicMtlQty: (json['dicMtlQty'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(
                    k,
                    (e as List<dynamic>)
                        .map((e) => (e as num).toDouble())
                        .toList()),
              ) ??
              const <String, List<double>>{},
          dicInvMtlQty: (json['dicInvMtlQty'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const <String, double>{},
          lastBarcode: json['lastBarcode'] == null
              ? null
              : OnlinePickBarcodeContent.fromJson(
                  json['lastBarcode'] as Map<String, dynamic>),
          location: json['location'] as String? ?? '',
          trayNo: json['trayNo'] as String? ?? '',
          userId: (json['userId'] as num?)?.toInt() ?? 0,
          pendingQuantity: json['pendingQuantity'] as num?,
          mode: json['mode'] as String? ?? 'outbound',
          expectedErpStore: json['expectedErpStore'] as String? ?? '',
        );

Map<String, dynamic> _$$OnlinePickCollectionCacheSnapshotImplToJson(
        _$OnlinePickCollectionCacheSnapshotImpl instance) =>
    <String, dynamic>{
      'stocks': instance.stocks,
      'dicSeq': instance.dicSeq,
      'dicMtlQty': instance.dicMtlQty,
      'dicInvMtlQty': instance.dicInvMtlQty,
      'lastBarcode': instance.lastBarcode,
      'location': instance.location,
      'trayNo': instance.trayNo,
      'userId': instance.userId,
      'pendingQuantity': instance.pendingQuantity,
      'mode': instance.mode,
      'expectedErpStore': instance.expectedErpStore,
    };
