// GENERATED CODE - MANUAL IMPLEMENTATION

part of 'inbound_collection_models.dart';

class InboundCollectTaskItemAdapter
    extends TypeAdapter<InboundCollectTaskItem> {
  @override
  final int typeId = 3;

  @override
  InboundCollectTaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundCollectTaskItem(
      inTaskItemId: fields[0] as int,
      inTaskId: fields[1] as int,
      inTaskNo: fields[2] as String?,
      materialCode: fields[3] as String?,
      materialName: fields[4] as String?,
      oldMaterialCode: fields[5] as String?,
      planQty: (fields[6] as num?)?.toDouble() ?? 0,
      collectedQty: (fields[7] as num?)?.toDouble() ?? 0,
      batchNo: fields[8] as String?,
      serialNumber: fields[9] as String?,
      subInventoryCode: fields[10] as String?,
      storeRoomNo: fields[11] as String?,
      storeSiteNo: fields[12] as String?,
      inboundOrderNo: fields[13] as String?,
      taskComment: fields[14] as String?,
      repertoryQty: (fields[15] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, InboundCollectTaskItem obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.planQty)
      ..writeByte(7)
      ..write(obj.collectedQty)
      ..writeByte(8)
      ..write(obj.batchNo)
      ..writeByte(9)
      ..write(obj.serialNumber)
      ..writeByte(10)
      ..write(obj.subInventoryCode)
      ..writeByte(11)
      ..write(obj.storeRoomNo)
      ..writeByte(12)
      ..write(obj.storeSiteNo)
      ..writeByte(13)
      ..write(obj.inboundOrderNo)
      ..writeByte(14)
      ..write(obj.taskComment)
      ..writeByte(15)
      ..write(obj.repertoryQty);
  }
}

class InboundBarcodeContentAdapter
    extends TypeAdapter<InboundBarcodeContent> {
  @override
  final int typeId = 4;

  @override
  InboundBarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundBarcodeContent(
      materialCode: fields[0] as String?,
      materialName: fields[1] as String?,
      batchNo: fields[2] as String?,
      serialNumber: fields[3] as String?,
      quantity: (fields[4] as num?)?.toDouble(),
      seqCtrl: fields[5] as String?,
      idOld: fields[6] as String?,
      productionDate: fields[7] as String?,
      expireDays: fields[8] as int?,
      dgFlag: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InboundBarcodeContent obj) {
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
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.seqCtrl)
      ..writeByte(6)
      ..write(obj.idOld)
      ..writeByte(7)
      ..write(obj.productionDate)
      ..writeByte(8)
      ..write(obj.expireDays)
      ..writeByte(9)
      ..write(obj.dgFlag);
  }
}

class InboundCollectionStockAdapter
    extends TypeAdapter<InboundCollectionStock> {
  @override
  final int typeId = 5;

  @override
  InboundCollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundCollectionStock(
      stockId: fields[0] as String,
      materialCode: fields[1] as String,
      batchNo: fields[2] as String,
      serialNumber: fields[3] as String,
      planQty: (fields[4] as num).toDouble(),
      collectQty: (fields[5] as num).toDouble(),
      inTaskItemId: fields[6] as String,
      taskId: fields[7] as String,
      storeRoom: fields[8] as String,
      storeSite: fields[9] as String,
      productionDate: fields[10] as String?,
      expireDays: fields[11] as int?,
      taskNo: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InboundCollectionStock obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.stockId)
      ..writeByte(1)
      ..write(obj.materialCode)
      ..writeByte(2)
      ..write(obj.batchNo)
      ..writeByte(3)
      ..write(obj.serialNumber)
      ..writeByte(4)
      ..write(obj.planQty)
      ..writeByte(5)
      ..write(obj.collectQty)
      ..writeByte(6)
      ..write(obj.inTaskItemId)
      ..writeByte(7)
      ..write(obj.taskId)
      ..writeByte(8)
      ..write(obj.storeRoom)
      ..writeByte(9)
      ..write(obj.storeSite)
      ..writeByte(10)
      ..write(obj.productionDate)
      ..writeByte(11)
      ..write(obj.expireDays)
      ..writeByte(12)
      ..write(obj.taskNo);
  }
}
