// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aswh_up_task_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AswhUpTaskItemAdapter extends TypeAdapter<AswhUpTaskItem> {
  @override
  final int typeId = 21;

  @override
  AswhUpTaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AswhUpTaskItem(
      inTaskItemId: fields[0] as int,
      inTaskId: fields[1] as int,
      materialCode: fields[2] as String,
      materialName: fields[3] as String?,
      storeSiteNo: fields[4] as String?,
      storeRoomNo: fields[5] as String?,
      subInventoryCode: fields[6] as String?,
      batchNo: fields[7] as String?,
      serialNo: fields[8] as String?,
      planQty: fields[9] as double,
      collectedQty: fields[10] as double,
      repertoryQty: fields[11] as double,
      unit: fields[12] as String?,
      expireDays: fields[13] as int?,
      productionDate: fields[14] as String?,
      proType: fields[15] as String?,
      erpStore: fields[16] as String?,
      supplierName: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AswhUpTaskItem obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.inTaskItemId)
      ..writeByte(1)
      ..write(obj.inTaskId)
      ..writeByte(2)
      ..write(obj.materialCode)
      ..writeByte(3)
      ..write(obj.materialName)
      ..writeByte(4)
      ..write(obj.storeSiteNo)
      ..writeByte(5)
      ..write(obj.storeRoomNo)
      ..writeByte(6)
      ..write(obj.subInventoryCode)
      ..writeByte(7)
      ..write(obj.batchNo)
      ..writeByte(8)
      ..write(obj.serialNo)
      ..writeByte(9)
      ..write(obj.planQty)
      ..writeByte(10)
      ..write(obj.collectedQty)
      ..writeByte(11)
      ..write(obj.repertoryQty)
      ..writeByte(12)
      ..write(obj.unit)
      ..writeByte(13)
      ..write(obj.expireDays)
      ..writeByte(14)
      ..write(obj.productionDate)
      ..writeByte(15)
      ..write(obj.proType)
      ..writeByte(16)
      ..write(obj.erpStore)
      ..writeByte(17)
      ..write(obj.supplierName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AswhUpTaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AswhUpTaskItemImpl _$$AswhUpTaskItemImplFromJson(Map<String, dynamic> json) =>
    _$AswhUpTaskItemImpl(
      inTaskItemId: (json['intaskitemid'] as num?)?.toInt() ?? 0,
      inTaskId: (json['intaskid'] as num?)?.toInt() ?? 0,
      materialCode: json['matcode'] as String? ?? '',
      materialName: json['matname'] as String?,
      storeSiteNo: json['storesiteno'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      subInventoryCode: json['subinventoryCode'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      planQty: (json['qty'] as num?)?.toDouble() ?? 0.0,
      collectedQty: (json['collectedqty'] as num?)?.toDouble() ?? 0.0,
      repertoryQty: (json['repqty'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String?,
      expireDays: (json['vdays'] as num?)?.toInt(),
      productionDate: json['pdate'] as String?,
      proType: json['protype'] as String?,
      erpStore: json['erpstore'] as String?,
      supplierName: json['suppliername'] as String?,
    );

Map<String, dynamic> _$$AswhUpTaskItemImplToJson(
        _$AswhUpTaskItemImpl instance) =>
    <String, dynamic>{
      'intaskitemid': instance.inTaskItemId,
      'intaskid': instance.inTaskId,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'storesiteno': instance.storeSiteNo,
      'storeroomno': instance.storeRoomNo,
      'subinventoryCode': instance.subInventoryCode,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'qty': instance.planQty,
      'collectedqty': instance.collectedQty,
      'repqty': instance.repertoryQty,
      'unit': instance.unit,
      'vdays': instance.expireDays,
      'pdate': instance.productionDate,
      'protype': instance.proType,
      'erpstore': instance.erpStore,
      'suppliername': instance.supplierName,
    };
