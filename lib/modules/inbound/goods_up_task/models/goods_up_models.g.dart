// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_up_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InTaskItemAdapter extends TypeAdapter<InTaskItem> {
  @override
  final int typeId = 3;

  @override
  InTaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InTaskItem(
      inTaskItemId: fields[0] as int,
      inTaskId: fields[1] as int,
      inTaskNo: fields[2] as String?,
      materialCode: fields[3] as String?,
      materialName: fields[4] as String?,
      oldMaterialCode: fields[5] as String?,
      storeRoomNo: fields[6] as String?,
      storeSiteNo: fields[7] as String?,
      quantity: fields[8] as double,
      collectedQuantity: fields[9] as double,
      batchNo: fields[10] as String?,
      serialNumber: fields[11] as String?,
      subInventoryCode: fields[12] as String?,
      inboundOrderNo: fields[13] as String?,
      taskComment: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InTaskItem obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.inTaskItemId)
      ..writeByte(1)
      ..write(obj.inTaskId)
      ..writeByte(2)
      ..write(obj.inTaskNo)
      ..writeByte(3)
      ..write(obj.materialCode)
      ..writeByte(4)
      ..write(obj.materialName)
      ..writeByte(5)
      ..write(obj.oldMaterialCode)
      ..writeByte(6)
      ..write(obj.storeRoomNo)
      ..writeByte(7)
      ..write(obj.storeSiteNo)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.collectedQuantity)
      ..writeByte(10)
      ..write(obj.batchNo)
      ..writeByte(11)
      ..write(obj.serialNumber)
      ..writeByte(12)
      ..write(obj.subInventoryCode)
      ..writeByte(13)
      ..write(obj.inboundOrderNo)
      ..writeByte(14)
      ..write(obj.taskComment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InTaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UpBarcodeContentAdapter extends TypeAdapter<UpBarcodeContent> {
  @override
  final int typeId = 4;

  @override
  UpBarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpBarcodeContent(
      materialCode: fields[0] as String?,
      materialName: fields[1] as String?,
      batchNo: fields[2] as String?,
      serialNumber: fields[3] as String?,
      seqctrl: fields[4] as String?,
      idOld: fields[5] as String?,
      quantity: fields[6] as double?,
      productionDate: fields[7] as String?,
      validDays: fields[8] as String?,
      dgFlag: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UpBarcodeContent obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.materialCode)
      ..writeByte(1)
      ..write(obj.materialName)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNumber)
      ..writeByte(4)
      ..write(obj.seqctrl)
      ..writeByte(5)
      ..write(obj.idOld)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.productionDate)
      ..writeByte(8)
      ..write(obj.validDays)
      ..writeByte(9)
      ..write(obj.dgFlag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpBarcodeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UpCollectionStockAdapter extends TypeAdapter<UpCollectionStock> {
  @override
  final int typeId = 5;

  @override
  UpCollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UpCollectionStock(
      stockId: fields[0] as String,
      materialCode: fields[1] as String,
      batchNo: fields[2] as String?,
      serialNumber: fields[3] as String?,
      taskQuantity: fields[4] as double?,
      collectedQuantity: fields[5] as double?,
      taskNo: fields[6] as String?,
      taskId: fields[7] as String?,
      storeRoom: fields[8] as String?,
      storeSite: fields[9] as String?,
      productionDate: fields[10] as String?,
      validDays: fields[11] as String?,
      erpStore: fields[12] as String?,
      trayNo: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UpCollectionStock obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.stockId)
      ..writeByte(1)
      ..write(obj.materialCode)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNumber)
      ..writeByte(4)
      ..write(obj.taskQuantity)
      ..writeByte(5)
      ..write(obj.collectedQuantity)
      ..writeByte(6)
      ..write(obj.taskNo)
      ..writeByte(7)
      ..write(obj.taskId)
      ..writeByte(8)
      ..write(obj.storeRoom)
      ..writeByte(9)
      ..write(obj.storeSite)
      ..writeByte(10)
      ..write(obj.productionDate)
      ..writeByte(11)
      ..write(obj.validDays)
      ..writeByte(12)
      ..write(obj.erpStore)
      ..writeByte(13)
      ..write(obj.trayNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpCollectionStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InTaskItemImpl _$$InTaskItemImplFromJson(Map<String, dynamic> json) =>
    _$InTaskItemImpl(
      inTaskItemId: (json['intaskitemid'] as num).toInt(),
      inTaskId: (json['intaskid'] as num).toInt(),
      inTaskNo: json['intaskno'] as String?,
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      oldMaterialCode: json['matinnercode'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      storeSiteNo: json['storesiteno'] as String?,
      quantity: (json['qty'] as num).toDouble(),
      collectedQuantity: (json['collectedqty'] as num).toDouble(),
      batchNo: json['batchno'] as String?,
      serialNumber: json['sn'] as String?,
      subInventoryCode: json['subinventoryCode'] as String?,
      inboundOrderNo: json['orderno'] as String?,
      taskComment: json['taskcomment'] as String?,
    );

Map<String, dynamic> _$$InTaskItemImplToJson(_$InTaskItemImpl instance) =>
    <String, dynamic>{
      'intaskitemid': instance.inTaskItemId,
      'intaskid': instance.inTaskId,
      'intaskno': instance.inTaskNo,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'matinnercode': instance.oldMaterialCode,
      'storeroomno': instance.storeRoomNo,
      'storesiteno': instance.storeSiteNo,
      'qty': instance.quantity,
      'collectedqty': instance.collectedQuantity,
      'batchno': instance.batchNo,
      'sn': instance.serialNumber,
      'subinventoryCode': instance.subInventoryCode,
      'orderno': instance.inboundOrderNo,
      'taskcomment': instance.taskComment,
    };

_$UpBarcodeContentImpl _$$UpBarcodeContentImplFromJson(
  Map<String, dynamic> json,
) => _$UpBarcodeContentImpl(
  materialCode: json['matcode'] as String?,
  materialName: json['matname'] as String?,
  batchNo: json['batchno'] as String?,
  serialNumber: json['sn'] as String?,
  seqctrl: json['seqctrl'] as String?,
  idOld: json['idOld'] as String?,
  quantity: (json['qty'] as num?)?.toDouble(),
  productionDate: json['pdate'] as String?,
  validDays: json['vdays'] as String?,
  dgFlag: json['dgFlg'] as String?,
);

Map<String, dynamic> _$$UpBarcodeContentImplToJson(
  _$UpBarcodeContentImpl instance,
) => <String, dynamic>{
  'matcode': instance.materialCode,
  'matname': instance.materialName,
  'batchno': instance.batchNo,
  'sn': instance.serialNumber,
  'seqctrl': instance.seqctrl,
  'idOld': instance.idOld,
  'qty': instance.quantity,
  'pdate': instance.productionDate,
  'vdays': instance.validDays,
  'dgFlg': instance.dgFlag,
};

_$UpCollectionStockImpl _$$UpCollectionStockImplFromJson(
  Map<String, dynamic> json,
) => _$UpCollectionStockImpl(
  stockId: json['stockid'] as String,
  materialCode: json['matcode'] as String,
  batchNo: json['batchno'] as String?,
  serialNumber: json['sn'] as String?,
  taskQuantity: (json['taskQty'] as num?)?.toDouble(),
  collectedQuantity: (json['collectQty'] as num?)?.toDouble(),
  taskNo: json['taskNo'] as String?,
  taskId: json['taskid'] as String?,
  storeRoom: json['storeRoom'] as String?,
  storeSite: json['storeSite'] as String?,
  productionDate: json['pdate'] as String?,
  validDays: json['vdays'] as String?,
  erpStore: json['erpStore'] as String?,
  trayNo: json['trayNo'] as String?,
);

Map<String, dynamic> _$$UpCollectionStockImplToJson(
  _$UpCollectionStockImpl instance,
) => <String, dynamic>{
  'stockid': instance.stockId,
  'matcode': instance.materialCode,
  'batchno': instance.batchNo,
  'sn': instance.serialNumber,
  'taskQty': instance.taskQuantity,
  'collectQty': instance.collectedQuantity,
  'taskNo': instance.taskNo,
  'taskid': instance.taskId,
  'storeRoom': instance.storeRoom,
  'storeSite': instance.storeSite,
  'pdate': instance.productionDate,
  'vdays': instance.validDays,
  'erpStore': instance.erpStore,
  'trayNo': instance.trayNo,
};
