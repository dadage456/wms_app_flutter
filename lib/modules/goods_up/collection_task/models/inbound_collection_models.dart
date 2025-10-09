import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

/// 入库上架任务明细（采集视图）
class InboundCollectTaskItem extends HiveObject with EquatableMixin {
  InboundCollectTaskItem({
    required this.inTaskItemId,
    required this.inTaskId,
    required this.materialCode,
    this.materialName,
    this.storeSiteNo,
    this.storeRoomNo,
    this.subInventoryCode,
    this.batchNo,
    this.serialNo,
    this.unit,
    this.planQty = 0,
    this.collectedQty = 0,
    this.repertoryQty = 0,
    this.expireDays,
    this.productionDate,
  });

  factory InboundCollectTaskItem.fromJson(Map<String, dynamic> json) {
    return InboundCollectTaskItem(
      inTaskItemId: _parseInt(json['intaskitemid']),
      inTaskId: _parseInt(json['intaskid']),
      materialCode: (json['matcode'] ?? '').toString(),
      materialName: json['matname']?.toString(),
      storeSiteNo: json['storesiteno']?.toString(),
      storeRoomNo: json['storeroomno']?.toString(),
      subInventoryCode: json['subinventoryCode']?.toString(),
      batchNo: json['batchno']?.toString(),
      serialNo: json['sn']?.toString(),
      unit: json['unit']?.toString(),
      planQty: _parseDouble(json['qty']),
      collectedQty: _parseDouble(json['collectedqty']),
      repertoryQty: _parseDouble(json['repqty']),
      expireDays: _parseIntNullable(json['vdays']),
      productionDate: json['pdate']?.toString(),
    );
  }

  final int inTaskItemId;
  final int inTaskId;
  final String materialCode;
  final String? materialName;
  final String? storeSiteNo;
  final String? storeRoomNo;
  final String? subInventoryCode;
  final String? batchNo;
  final String? serialNo;
  final String? unit;
  final double planQty;
  double collectedQty;
  final double repertoryQty;
  final int? expireDays;
  final String? productionDate;

  Map<String, dynamic> toJson() {
    return {
      'intaskitemid': inTaskItemId,
      'intaskid': inTaskId,
      'matcode': materialCode,
      'matname': materialName,
      'storesiteno': storeSiteNo,
      'storeroomno': storeRoomNo,
      'subinventoryCode': subInventoryCode,
      'batchno': batchNo,
      'sn': serialNo,
      'unit': unit,
      'qty': planQty,
      'collectedqty': collectedQty,
      'repqty': repertoryQty,
      'vdays': expireDays,
      'pdate': productionDate,
    };
  }

  @override
  List<Object?> get props => [
    inTaskItemId,
    inTaskId,
    materialCode,
    materialName,
    storeSiteNo,
    storeRoomNo,
    subInventoryCode,
    batchNo,
    serialNo,
    unit,
    planQty,
    collectedQty,
    repertoryQty,
    expireDays,
    productionDate,
  ];
}

/// 扫码解析内容
class InboundBarcodeContent extends HiveObject with EquatableMixin {
  InboundBarcodeContent({
    this.materialCode,
    this.materialName,
    this.batchNo,
    this.serialNo,
    this.seqCtrl,
    required this.quantity,
    this.expireDays,
    this.productionDate,
  });

  factory InboundBarcodeContent.fromJson(Map<String, dynamic> json) {
    return InboundBarcodeContent(
      materialCode: json['matcode']?.toString(),
      materialName: json['matname']?.toString(),
      batchNo: json['batchno']?.toString(),
      serialNo: json['sn']?.toString(),
      seqCtrl: json['seqctrl']?.toString(),
      quantity: _parseDouble(json['qty']),
      expireDays: _parseIntNullable(json['vdays']),
      productionDate: json['pdate']?.toString(),
    );
  }

  final String? materialCode;
  final String? materialName;
  final String? batchNo;
  final String? serialNo;
  final String? seqCtrl;
  final double quantity;
  final int? expireDays;
  final String? productionDate;

  Map<String, dynamic> toJson() {
    return {
      'matcode': materialCode,
      'matname': materialName,
      'batchno': batchNo,
      'sn': serialNo,
      'seqctrl': seqCtrl,
      'qty': quantity,
      'vdays': expireDays,
      'pdate': productionDate,
    };
  }

  bool get isEmpty => (materialCode == null || materialCode!.isEmpty);

  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
    materialCode,
    materialName,
    batchNo,
    serialNo,
    seqCtrl,
    quantity,
    expireDays,
    productionDate,
  ];
}

/// 入库采集缓存记录
class InboundCollectionStock extends HiveObject with EquatableMixin {
  InboundCollectionStock({
    required this.stockId,
    required this.materialCode,
    this.materialName,
    this.batchNo,
    this.serialNo,
    this.taskQty = 0,
    this.collectQty = 0,
    required this.inTaskItemId,
    required this.inTaskId,
    this.storeRoom,
    this.storeSite,
    this.erpStore,
    this.trayNo,
    this.productionDate,
    this.expireDays,
  });

  factory InboundCollectionStock.fromJson(Map<String, dynamic> json) {
    return InboundCollectionStock(
      stockId: (json['stockid'] ?? '').toString(),
      materialCode: (json['matcode'] ?? '').toString(),
      materialName: json['matname']?.toString(),
      batchNo: json['batchno']?.toString(),
      serialNo: json['sn']?.toString(),
      taskQty: _parseDouble(json['taskQty']),
      collectQty: _parseDouble(json['collectQty']),
      inTaskItemId: (json['inTaskItemid'] ?? json['intaskitemid'] ?? '')
          .toString(),
      inTaskId: (json['taskid'] ?? json['intaskid'] ?? '').toString(),
      storeRoom: json['storeRoom']?.toString(),
      storeSite: json['storeSite']?.toString(),
      erpStore: json['erpStore']?.toString(),
      trayNo: json['trayNo']?.toString(),
      productionDate: json['pdate']?.toString(),
      expireDays: _parseIntNullable(json['vdays']),
    );
  }

  final String stockId;
  final String materialCode;
  final String? materialName;
  final String? batchNo;
  final String? serialNo;
  final double taskQty;
  double collectQty;
  final String inTaskItemId;
  final String inTaskId;
  final String? storeRoom;
  final String? storeSite;
  final String? erpStore;
  final String? trayNo;
  final String? productionDate;
  final int? expireDays;

  Map<String, dynamic> toJson() {
    return {
      'stockid': stockId,
      'matcode': materialCode,
      'matname': materialName,
      'batchno': batchNo,
      'sn': serialNo,
      'taskQty': taskQty,
      'collectQty': collectQty,
      'inTaskItemid': inTaskItemId,
      'taskid': inTaskId,
      'storeRoom': storeRoom,
      'storeSite': storeSite,
      'erpStore': erpStore,
      'trayNo': trayNo,
      'pdate': productionDate,
      'vdays': expireDays,
    };
  }

  @override
  List<Object?> get props => [
    stockId,
    materialCode,
    materialName,
    batchNo,
    serialNo,
    taskQty,
    collectQty,
    inTaskItemId,
    inTaskId,
    storeRoom,
    storeSite,
    erpStore,
    trayNo,
    productionDate,
    expireDays,
  ];
}

/// Hive 适配器注册
class InboundCollectTaskItemAdapter
    extends TypeAdapter<InboundCollectTaskItem> {
  @override
  final int typeId = 3;

  @override
  InboundCollectTaskItem read(BinaryReader reader) {
    final fields = <int, dynamic>{};
    final fieldCount = reader.readByte();
    for (var i = 0; i < fieldCount; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundCollectTaskItem(
      inTaskItemId: fields[0] as int,
      inTaskId: fields[1] as int,
      materialCode: fields[2] as String,
      materialName: fields[3] as String?,
      storeSiteNo: fields[4] as String?,
      storeRoomNo: fields[5] as String?,
      subInventoryCode: fields[6] as String?,
      batchNo: fields[7] as String?,
      serialNo: fields[8] as String?,
      unit: fields[9] as String?,
      planQty: fields[10] as double,
      collectedQty: fields[11] as double,
      repertoryQty: fields[12] as double,
      expireDays: fields[13] as int?,
      productionDate: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InboundCollectTaskItem obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.unit)
      ..writeByte(10)
      ..write(obj.planQty)
      ..writeByte(11)
      ..write(obj.collectedQty)
      ..writeByte(12)
      ..write(obj.repertoryQty)
      ..writeByte(13)
      ..write(obj.expireDays)
      ..writeByte(14)
      ..write(obj.productionDate);
  }
}

class InboundBarcodeContentAdapter extends TypeAdapter<InboundBarcodeContent> {
  @override
  final int typeId = 4;

  @override
  InboundBarcodeContent read(BinaryReader reader) {
    final fields = <int, dynamic>{};
    final fieldCount = reader.readByte();
    for (var i = 0; i < fieldCount; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundBarcodeContent(
      materialCode: fields[0] as String?,
      materialName: fields[1] as String?,
      batchNo: fields[2] as String?,
      serialNo: fields[3] as String?,
      seqCtrl: fields[4] as String?,
      quantity: fields[5] as double,
      expireDays: fields[6] as int?,
      productionDate: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InboundBarcodeContent obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.expireDays)
      ..writeByte(7)
      ..write(obj.productionDate);
  }
}

class InboundCollectionStockAdapter
    extends TypeAdapter<InboundCollectionStock> {
  @override
  final int typeId = 5;

  @override
  InboundCollectionStock read(BinaryReader reader) {
    final fields = <int, dynamic>{};
    final fieldCount = reader.readByte();
    for (var i = 0; i < fieldCount; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return InboundCollectionStock(
      stockId: fields[0] as String,
      materialCode: fields[1] as String,
      materialName: fields[2] as String?,
      batchNo: fields[3] as String?,
      serialNo: fields[4] as String?,
      taskQty: fields[5] as double,
      collectQty: fields[6] as double,
      inTaskItemId: fields[7] as String,
      inTaskId: fields[8] as String,
      storeRoom: fields[9] as String?,
      storeSite: fields[10] as String?,
      erpStore: fields[11] as String?,
      trayNo: fields[12] as String?,
      productionDate: fields[13] as String?,
      expireDays: fields[14] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, InboundCollectionStock obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.stockId)
      ..writeByte(1)
      ..write(obj.materialCode)
      ..writeByte(2)
      ..write(obj.materialName)
      ..writeByte(3)
      ..write(obj.batchNo)
      ..writeByte(4)
      ..write(obj.serialNo)
      ..writeByte(5)
      ..write(obj.taskQty)
      ..writeByte(6)
      ..write(obj.collectQty)
      ..writeByte(7)
      ..write(obj.inTaskItemId)
      ..writeByte(8)
      ..write(obj.inTaskId)
      ..writeByte(9)
      ..write(obj.storeRoom)
      ..writeByte(10)
      ..write(obj.storeSite)
      ..writeByte(11)
      ..write(obj.erpStore)
      ..writeByte(12)
      ..write(obj.trayNo)
      ..writeByte(13)
      ..write(obj.productionDate)
      ..writeByte(14)
      ..write(obj.expireDays);
  }
}

int _parseInt(dynamic value) {
  if (value is int) return value;
  if (value is String && value.isNotEmpty) {
    return int.tryParse(value) ?? 0;
  }
  if (value is num) {
    return value.toInt();
  }
  return 0;
}

double _parseDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String && value.isNotEmpty) {
    return double.tryParse(value) ?? 0;
  }
  if (value is num) return value.toDouble();
  return 0;
}

int? _parseIntNullable(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String && value.isNotEmpty) {
    return int.tryParse(value);
  }
  if (value is num) {
    return value.toInt();
  }
  return null;
}
