// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutTaskItemAdapter extends TypeAdapter<OutTaskItem> {
  @override
  final int typeId = 0;

  @override
  OutTaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutTaskItem(
      outtaskitemid: fields[0] as int,
      matcode: fields[1] as String?,
      matname: fields[2] as String?,
      storesiteno: fields[3] as String?,
      hintqty: fields[4] as double,
      collectedqty: fields[5] as double,
      repqty: fields[6] as double,
      hintbatchno: fields[7] as String?,
      sn: fields[8] as String?,
      storeroomno: fields[9] as String?,
      subinventoryCode: fields[10] as String?,
      orderno: fields[11] as String?,
      matinnercode: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OutTaskItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.outtaskitemid)
      ..writeByte(1)
      ..write(obj.matcode)
      ..writeByte(2)
      ..write(obj.matname)
      ..writeByte(3)
      ..write(obj.storesiteno)
      ..writeByte(4)
      ..write(obj.hintqty)
      ..writeByte(5)
      ..write(obj.collectedqty)
      ..writeByte(6)
      ..write(obj.repqty)
      ..writeByte(7)
      ..write(obj.hintbatchno)
      ..writeByte(8)
      ..write(obj.sn)
      ..writeByte(9)
      ..write(obj.storeroomno)
      ..writeByte(10)
      ..write(obj.subinventoryCode)
      ..writeByte(11)
      ..write(obj.orderno)
      ..writeByte(12)
      ..write(obj.matinnercode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutTaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BarcodeContentAdapter extends TypeAdapter<BarcodeContent> {
  @override
  final int typeId = 1;

  @override
  BarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeContent(
      matcode: fields[0] as String,
      matname: fields[1] as String,
      batchno: fields[2] as String,
      sn: fields[3] as String,
      seqctrl: fields[4] as String,
      id_old: fields[5] as String,
      qty: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeContent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.matcode)
      ..writeByte(1)
      ..write(obj.matname)
      ..writeByte(2)
      ..write(obj.batchno)
      ..writeByte(3)
      ..write(obj.sn)
      ..writeByte(4)
      ..write(obj.seqctrl)
      ..writeByte(5)
      ..write(obj.id_old)
      ..writeByte(6)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CollectionStockAdapter extends TypeAdapter<CollectionStock> {
  @override
  final int typeId = 2;

  @override
  CollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionStock(
      stockid: fields[0] as String,
      matcode: fields[1] as String,
      batchno: fields[2] as String,
      sn: fields[3] as String,
      taskQty: fields[4] as double,
      collectQty: fields[5] as double,
      outtaskitemid: fields[6] as String,
      taskid: fields[7] as String,
      storeRoom: fields[8] as String,
      storeSite: fields[9] as String,
      erpStore: fields[10] as String,
      trayNo: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionStock obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.stockid)
      ..writeByte(1)
      ..write(obj.matcode)
      ..writeByte(2)
      ..write(obj.batchno)
      ..writeByte(3)
      ..write(obj.sn)
      ..writeByte(4)
      ..write(obj.taskQty)
      ..writeByte(5)
      ..write(obj.collectQty)
      ..writeByte(6)
      ..write(obj.outtaskitemid)
      ..writeByte(7)
      ..write(obj.taskid)
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
      other is CollectionStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutTaskItemImpl _$$OutTaskItemImplFromJson(Map<String, dynamic> json) =>
    _$OutTaskItemImpl(
      outtaskitemid: (json['outtaskitemid'] as num).toInt(),
      matcode: json['matcode'] as String?,
      matname: json['matname'] as String?,
      storesiteno: json['storesiteno'] as String?,
      hintqty: (json['hintqty'] as num).toDouble(),
      collectedqty: (json['collectedqty'] as num).toDouble(),
      repqty: (json['repqty'] as num).toDouble(),
      hintbatchno: json['hintbatchno'] as String?,
      sn: json['sn'] as String?,
      storeroomno: json['storeroomno'] as String?,
      subinventoryCode: json['subinventoryCode'] as String?,
      orderno: json['orderno'] as String?,
      matinnercode: json['matinnercode'] as String?,
    );

Map<String, dynamic> _$$OutTaskItemImplToJson(_$OutTaskItemImpl instance) =>
    <String, dynamic>{
      'outtaskitemid': instance.outtaskitemid,
      'matcode': instance.matcode,
      'matname': instance.matname,
      'storesiteno': instance.storesiteno,
      'hintqty': instance.hintqty,
      'collectedqty': instance.collectedqty,
      'repqty': instance.repqty,
      'hintbatchno': instance.hintbatchno,
      'sn': instance.sn,
      'storeroomno': instance.storeroomno,
      'subinventoryCode': instance.subinventoryCode,
      'orderno': instance.orderno,
      'matinnercode': instance.matinnercode,
    };

_$BarcodeContentImpl _$$BarcodeContentImplFromJson(Map<String, dynamic> json) =>
    _$BarcodeContentImpl(
      matcode: json['matcode'] as String,
      matname: json['matname'] as String,
      batchno: json['batchno'] as String,
      sn: json['sn'] as String,
      seqctrl: json['seqctrl'] as String,
      id_old: json['id_old'] as String,
      qty: (json['qty'] as num).toDouble(),
    );

Map<String, dynamic> _$$BarcodeContentImplToJson(
        _$BarcodeContentImpl instance) =>
    <String, dynamic>{
      'matcode': instance.matcode,
      'matname': instance.matname,
      'batchno': instance.batchno,
      'sn': instance.sn,
      'seqctrl': instance.seqctrl,
      'id_old': instance.id_old,
      'qty': instance.qty,
    };

_$CollectionStockImpl _$$CollectionStockImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectionStockImpl(
      stockid: json['stockid'] as String,
      matcode: json['matcode'] as String,
      batchno: json['batchno'] as String,
      sn: json['sn'] as String,
      taskQty: (json['taskQty'] as num).toDouble(),
      collectQty: (json['collectQty'] as num).toDouble(),
      outtaskitemid: json['outtaskitemid'] as String,
      taskid: json['taskid'] as String,
      storeRoom: json['storeRoom'] as String,
      storeSite: json['storeSite'] as String,
      erpStore: json['erpStore'] as String,
      trayNo: json['trayNo'] as String,
    );

Map<String, dynamic> _$$CollectionStockImplToJson(
        _$CollectionStockImpl instance) =>
    <String, dynamic>{
      'stockid': instance.stockid,
      'matcode': instance.matcode,
      'batchno': instance.batchno,
      'sn': instance.sn,
      'taskQty': instance.taskQty,
      'collectQty': instance.collectQty,
      'outtaskitemid': instance.outtaskitemid,
      'taskid': instance.taskid,
      'storeRoom': instance.storeRoom,
      'storeSite': instance.storeSite,
      'erpStore': instance.erpStore,
      'trayNo': instance.trayNo,
    };
