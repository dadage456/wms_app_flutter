// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aswh_up_collection_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AswhUpBarcodeContentAdapter extends TypeAdapter<AswhUpBarcodeContent> {
  @override
  final int typeId = 22;

  @override
  AswhUpBarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AswhUpBarcodeContent(
      materialCode: fields[0] as String?,
      materialName: fields[1] as String?,
      batchNo: fields[2] as String?,
      serialNo: fields[3] as String?,
      seqCtrl: fields[4] as String?,
      idOld: fields[5] as String?,
      quantity: fields[6] as double,
      expireDays: fields[7] as String?,
      productionDate: fields[8] as String?,
      dangerousFlag: fields[9] as String?,
      supplierCode: fields[10] as String?,
      supplierName: fields[11] as String?,
      erpStore: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AswhUpBarcodeContent obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.materialCode)
      ..writeByte(1)
      ..write(obj.materialName)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNo)
      ..writeByte(4)
      ..write(obj.seqCtrl)
      ..writeByte(5)
      ..write(obj.idOld)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.expireDays)
      ..writeByte(8)
      ..write(obj.productionDate)
      ..writeByte(9)
      ..write(obj.dangerousFlag)
      ..writeByte(10)
      ..write(obj.supplierCode)
      ..writeByte(11)
      ..write(obj.supplierName)
      ..writeByte(12)
      ..write(obj.erpStore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AswhUpBarcodeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AswhUpCollectionStockAdapter extends TypeAdapter<AswhUpCollectionStock> {
  @override
  final int typeId = 23;

  @override
  AswhUpCollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AswhUpCollectionStock(
      stockId: fields[0] as String,
      trayNo: fields[1] as String,
      materialCode: fields[2] as String,
      materialName: fields[3] as String?,
      batchNo: fields[4] as String?,
      serialNo: fields[5] as String?,
      taskQty: fields[6] as double,
      collectQty: fields[7] as double,
      taskItemId: fields[8] as String,
      taskId: fields[9] as String,
      storeRoom: fields[10] as String?,
      storeSite: fields[11] as String?,
      erpStore: fields[12] as String?,
      supplierCode: fields[13] as String?,
      supplierName: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AswhUpCollectionStock obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.stockId)
      ..writeByte(1)
      ..write(obj.trayNo)
      ..writeByte(2)
      ..write(obj.materialCode)
      ..writeByte(3)
      ..write(obj.materialName)
      ..writeByte(4)
      ..write(obj.batchNo)
      ..writeByte(5)
      ..write(obj.serialNo)
      ..writeByte(6)
      ..write(obj.taskQty)
      ..writeByte(7)
      ..write(obj.collectQty)
      ..writeByte(8)
      ..write(obj.taskItemId)
      ..writeByte(9)
      ..write(obj.taskId)
      ..writeByte(10)
      ..write(obj.storeRoom)
      ..writeByte(11)
      ..write(obj.storeSite)
      ..writeByte(12)
      ..write(obj.erpStore)
      ..writeByte(13)
      ..write(obj.supplierCode)
      ..writeByte(14)
      ..write(obj.supplierName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AswhUpCollectionStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AswhUpDicSeqEntryAdapter extends TypeAdapter<AswhUpDicSeqEntry> {
  @override
  final int typeId = 24;

  @override
  AswhUpDicSeqEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AswhUpDicSeqEntry(
      taskItemId: fields[0] as int,
      serialNumbers: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AswhUpDicSeqEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.taskItemId)
      ..writeByte(1)
      ..write(obj.serialNumbers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AswhUpDicSeqEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AswhUpBarcodeContentImpl _$$AswhUpBarcodeContentImplFromJson(
        Map<String, dynamic> json) =>
    _$AswhUpBarcodeContentImpl(
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      seqCtrl: json['seqctrl'] as String?,
      idOld: json['id_old'] as String?,
      quantity: (json['qty'] as num?)?.toDouble() ?? 0.0,
      expireDays: json['vdays'] as String?,
      productionDate: json['pdate'] as String?,
      dangerousFlag: json['dgFlg'] as String?,
      supplierCode: json['suppliercode'] as String?,
      supplierName: json['suppliername'] as String?,
      erpStore: json['erpstore'] as String?,
    );

Map<String, dynamic> _$$AswhUpBarcodeContentImplToJson(
        _$AswhUpBarcodeContentImpl instance) =>
    <String, dynamic>{
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'seqctrl': instance.seqCtrl,
      'id_old': instance.idOld,
      'qty': instance.quantity,
      'vdays': instance.expireDays,
      'pdate': instance.productionDate,
      'dgFlg': instance.dangerousFlag,
      'suppliercode': instance.supplierCode,
      'suppliername': instance.supplierName,
      'erpstore': instance.erpStore,
    };

_$AswhUpCollectionStockImpl _$$AswhUpCollectionStockImplFromJson(
        Map<String, dynamic> json) =>
    _$AswhUpCollectionStockImpl(
      stockId: json['stockId'] as String? ?? '',
      trayNo: json['trayNo'] as String? ?? '',
      materialCode: json['materialCode'] as String? ?? '',
      materialName: json['materialName'] as String?,
      batchNo: json['batchNo'] as String?,
      serialNo: json['serialNo'] as String?,
      taskQty: (json['taskQty'] as num?)?.toDouble() ?? 0.0,
      collectQty: (json['collectQty'] as num?)?.toDouble() ?? 0.0,
      taskItemId: json['taskItemId'] as String? ?? '',
      taskId: json['taskId'] as String? ?? '',
      storeRoom: json['storeRoom'] as String?,
      storeSite: json['storeSite'] as String?,
      erpStore: json['erpStore'] as String?,
      supplierCode: json['supplierCode'] as String?,
      supplierName: json['supplierName'] as String?,
    );

Map<String, dynamic> _$$AswhUpCollectionStockImplToJson(
        _$AswhUpCollectionStockImpl instance) =>
    <String, dynamic>{
      'stockId': instance.stockId,
      'trayNo': instance.trayNo,
      'materialCode': instance.materialCode,
      'materialName': instance.materialName,
      'batchNo': instance.batchNo,
      'serialNo': instance.serialNo,
      'taskQty': instance.taskQty,
      'collectQty': instance.collectQty,
      'taskItemId': instance.taskItemId,
      'taskId': instance.taskId,
      'storeRoom': instance.storeRoom,
      'storeSite': instance.storeSite,
      'erpStore': instance.erpStore,
      'supplierCode': instance.supplierCode,
      'supplierName': instance.supplierName,
    };

_$AswhUpDicSeqEntryImpl _$$AswhUpDicSeqEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$AswhUpDicSeqEntryImpl(
      taskItemId: (json['taskItemId'] as num?)?.toInt() ?? 0,
      serialNumbers: (json['serialNumbers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$AswhUpDicSeqEntryImplToJson(
        _$AswhUpDicSeqEntryImpl instance) =>
    <String, dynamic>{
      'taskItemId': instance.taskItemId,
      'serialNumbers': instance.serialNumbers,
    };
