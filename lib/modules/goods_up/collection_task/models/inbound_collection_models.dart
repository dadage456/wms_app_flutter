import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'inbound_collection_models.g.dart';

@HiveType(typeId: 3)
class InboundCollectTaskItem extends HiveObject with EquatableMixin {
  InboundCollectTaskItem({
    required this.inTaskItemId,
    required this.inTaskId,
    this.inTaskNo,
    this.materialCode,
    this.materialName,
    this.oldMaterialCode,
    this.planQty = 0,
    this.collectedQty = 0,
    this.batchNo,
    this.serialNumber,
    this.subInventoryCode,
    this.storeRoomNo,
    this.storeSiteNo,
    this.inboundOrderNo,
    this.taskComment,
    this.repertoryQty = 0,
  });

  @HiveField(0)
  final int inTaskItemId;
  @HiveField(1)
  final int inTaskId;
  @HiveField(2)
  final String? inTaskNo;
  @HiveField(3)
  final String? materialCode;
  @HiveField(4)
  final String? materialName;
  @HiveField(5)
  final String? oldMaterialCode;
  @HiveField(6)
  final double planQty;
  @HiveField(7)
  final double collectedQty;
  @HiveField(8)
  final String? batchNo;
  @HiveField(9)
  final String? serialNumber;
  @HiveField(10)
  final String? subInventoryCode;
  @HiveField(11)
  final String? storeRoomNo;
  @HiveField(12)
  final String? storeSiteNo;
  @HiveField(13)
  final String? inboundOrderNo;
  @HiveField(14)
  final String? taskComment;
  @HiveField(15)
  final double repertoryQty;

  double get remainingQty => planQty - collectedQty;

  InboundCollectTaskItem copyWith({
    double? planQty,
    double? collectedQty,
  }) {
    return InboundCollectTaskItem(
      inTaskItemId: inTaskItemId,
      inTaskId: inTaskId,
      inTaskNo: inTaskNo,
      materialCode: materialCode,
      materialName: materialName,
      oldMaterialCode: oldMaterialCode,
      planQty: planQty ?? this.planQty,
      collectedQty: collectedQty ?? this.collectedQty,
      batchNo: batchNo,
      serialNumber: serialNumber,
      subInventoryCode: subInventoryCode,
      storeRoomNo: storeRoomNo,
      storeSiteNo: storeSiteNo,
      inboundOrderNo: inboundOrderNo,
      taskComment: taskComment,
      repertoryQty: repertoryQty,
    );
  }

  factory InboundCollectTaskItem.fromJson(Map<String, dynamic> json) {
    return InboundCollectTaskItem(
      inTaskItemId: _parseInt(json['intaskitemid']),
      inTaskId: _parseInt(json['intaskid']),
      inTaskNo: json['intaskno']?.toString(),
      materialCode: json['matcode']?.toString(),
      materialName: json['matname']?.toString(),
      oldMaterialCode: json['matinnercode']?.toString(),
      planQty: _parseDouble(json['qty']),
      collectedQty: _parseDouble(json['collectedqty']),
      batchNo: json['batchno']?.toString(),
      serialNumber: json['sn']?.toString(),
      subInventoryCode: json['subinventoryCode']?.toString(),
      storeRoomNo: json['storeroomno']?.toString(),
      storeSiteNo: json['storesiteno']?.toString(),
      inboundOrderNo: json['orderno']?.toString(),
      taskComment: json['taskcomment']?.toString(),
      repertoryQty: _parseDouble(json['repqty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intaskitemid': inTaskItemId,
      'intaskid': inTaskId,
      'intaskno': inTaskNo,
      'matcode': materialCode,
      'matname': materialName,
      'matinnercode': oldMaterialCode,
      'qty': planQty,
      'collectedqty': collectedQty,
      'batchno': batchNo,
      'sn': serialNumber,
      'subinventoryCode': subInventoryCode,
      'storeroomno': storeRoomNo,
      'storesiteno': storeSiteNo,
      'orderno': inboundOrderNo,
      'taskcomment': taskComment,
      'repqty': repertoryQty,
    };
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    if (value is num) return value.toDouble();
    return 0;
  }

  @override
  List<Object?> get props => [
        inTaskItemId,
        inTaskId,
        inTaskNo,
        materialCode,
        planQty,
        collectedQty,
        batchNo,
        serialNumber,
        storeSiteNo,
      ];
}

@HiveType(typeId: 4)
class InboundBarcodeContent extends HiveObject with EquatableMixin {
  InboundBarcodeContent({
    this.materialCode,
    this.materialName,
    this.batchNo,
    this.serialNumber,
    this.quantity,
    this.seqCtrl,
    this.idOld,
    this.productionDate,
    this.expireDays,
    this.dgFlag,
  });

  @HiveField(0)
  final String? materialCode;
  @HiveField(1)
  final String? materialName;
  @HiveField(2)
  final String? batchNo;
  @HiveField(3)
  final String? serialNumber;
  @HiveField(4)
  final double? quantity;
  @HiveField(5)
  final String? seqCtrl;
  @HiveField(6)
  final String? idOld;
  @HiveField(7)
  final String? productionDate;
  @HiveField(8)
  final int? expireDays;
  @HiveField(9)
  final String? dgFlag;

  String get materialKey => (materialCode ?? '').trim();
  bool get isEmpty => materialKey.isEmpty;
  bool get isNotEmpty => !isEmpty;

  InboundBarcodeContent copyWith({
    String? productionDate,
    int? expireDays,
    double? quantity,
    bool resetProductionDate = false,
    bool resetExpireDays = false,
  }) {
    return InboundBarcodeContent(
      materialCode: materialCode,
      materialName: materialName,
      batchNo: batchNo,
      serialNumber: serialNumber,
      quantity: quantity ?? this.quantity,
      seqCtrl: seqCtrl,
      idOld: idOld,
      productionDate:
          resetProductionDate ? null : (productionDate ?? this.productionDate),
      expireDays: resetExpireDays ? null : (expireDays ?? this.expireDays),
      dgFlag: dgFlag,
    );
  }

  factory InboundBarcodeContent.fromJson(Map<String, dynamic> json) {
    return InboundBarcodeContent(
      materialCode: json['matcode']?.toString(),
      materialName: json['matname']?.toString(),
      batchNo: json['batchno']?.toString(),
      serialNumber: json['sn']?.toString(),
      quantity: InboundCollectTaskItem._parseDouble(json['qty']),
      seqCtrl: json['seqctrl']?.toString(),
      idOld: json['id_old']?.toString(),
      productionDate: json['pdate']?.toString(),
      expireDays: json['vdays'] == null
          ? null
          : InboundCollectTaskItem._parseInt(json['vdays']),
      dgFlag: json['dgFlg']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matcode': materialCode,
      'matname': materialName,
      'batchno': batchNo,
      'sn': serialNumber,
      'qty': quantity,
      'seqctrl': seqCtrl,
      'id_old': idOld,
      'pdate': productionDate,
      'vdays': expireDays,
      'dgFlg': dgFlag,
    };
  }

  @override
  List<Object?> get props => [
        materialCode,
        batchNo,
        serialNumber,
        quantity,
        productionDate,
        expireDays,
        dgFlag,
      ];
}

@HiveType(typeId: 5)
class InboundCollectionStock extends HiveObject with EquatableMixin {
  InboundCollectionStock({
    required this.stockId,
    required this.materialCode,
    required this.batchNo,
    required this.serialNumber,
    required this.planQty,
    required this.collectQty,
    required this.inTaskItemId,
    required this.taskId,
    required this.storeRoom,
    required this.storeSite,
    this.productionDate,
    this.expireDays,
    this.taskNo,
  });

  @HiveField(0)
  final String stockId;
  @HiveField(1)
  final String materialCode;
  @HiveField(2)
  final String batchNo;
  @HiveField(3)
  final String serialNumber;
  @HiveField(4)
  final double planQty;
  @HiveField(5)
  final double collectQty;
  @HiveField(6)
  final String inTaskItemId;
  @HiveField(7)
  final String taskId;
  @HiveField(8)
  final String storeRoom;
  @HiveField(9)
  final String storeSite;
  @HiveField(10)
  final String? productionDate;
  @HiveField(11)
  final int? expireDays;
  @HiveField(12)
  final String? taskNo;

  factory InboundCollectionStock.fromJson(Map<String, dynamic> json) {
    return InboundCollectionStock(
      stockId: json['stockid']?.toString() ?? '',
      materialCode: json['matcode']?.toString() ?? '',
      batchNo: json['batchno']?.toString() ?? '',
      serialNumber: json['sn']?.toString() ?? '',
      planQty: InboundCollectTaskItem._parseDouble(json['taskQty']),
      collectQty: InboundCollectTaskItem._parseDouble(json['collectQty']),
      inTaskItemId: json['inTaskItemid']?.toString() ?? '',
      taskId: json['taskid']?.toString() ?? '',
      storeRoom: json['storeRoom']?.toString() ?? '',
      storeSite: json['storeSite']?.toString() ?? '',
      productionDate: json['data1']?.toString(),
      expireDays: json['data2'] == null
          ? null
          : InboundCollectTaskItem._parseInt(json['data2']),
      taskNo: json['taskNo']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stockid': stockId,
      'matcode': materialCode,
      'batchno': batchNo,
      'sn': serialNumber,
      'taskQty': planQty,
      'collectQty': collectQty,
      'inTaskItemid': inTaskItemId,
      'taskid': taskId,
      'storeRoom': storeRoom,
      'storeSite': storeSite,
      'data1': productionDate,
      'data2': expireDays,
      'taskNo': taskNo,
    };
  }

  @override
  List<Object?> get props => [stockId, materialCode, batchNo, serialNumber];
}

enum InboundScanStep {
  site,
  material,
  quantity,
  dangerousSupplement,
}

class InboundCollectionQty extends Equatable {
  const InboundCollectionQty({
    required this.originalQty,
    required this.currentQty,
    required this.materialCode,
  });

  final double originalQty;
  final double currentQty;
  final String materialCode;

  InboundCollectionQty copyWith({
    double? originalQty,
    double? currentQty,
    String? materialCode,
  }) {
    return InboundCollectionQty(
      originalQty: originalQty ?? this.originalQty,
      currentQty: currentQty ?? this.currentQty,
      materialCode: materialCode ?? this.materialCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalQty': originalQty,
      'currentQty': currentQty,
      'materialCode': materialCode,
    };
  }

  factory InboundCollectionQty.fromJson(Map<String, dynamic> json) {
    return InboundCollectionQty(
      originalQty: InboundCollectTaskItem._parseDouble(json['originalQty']),
      currentQty: InboundCollectTaskItem._parseDouble(json['currentQty']),
      materialCode: json['materialCode']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [originalQty, currentQty, materialCode];
}
