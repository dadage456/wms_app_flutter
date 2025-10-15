import 'package:equatable/equatable.dart';

class AswhUpTaskDetailItem extends Equatable {
  const AswhUpTaskDetailItem({
    required this.inTaskItemId,
    required this.inTaskId,
    required this.materialCode,
    this.materialName,
    this.storeSiteNo,
    this.storeRoomNo,
    this.subInventoryCode,
    this.batchNo,
    this.serialNo,
    this.planQty = 0,
    this.collectedQty = 0,
    this.repertoryQty = 0,
    this.unit,
    this.expireDays,
    this.productionDate,
    this.proType,
    this.erpStore,
    this.supplierName,
    this.inTaskNo,
    this.taskComment,
    this.oldMaterialCode,
    this.inboundOrderNo,
  });

  final int inTaskItemId;
  final int inTaskId;
  final String materialCode;
  final String? materialName;
  final String? storeSiteNo;
  final String? storeRoomNo;
  final String? subInventoryCode;
  final String? batchNo;
  final String? serialNo;
  final double planQty;
  final double collectedQty;
  final double repertoryQty;
  final String? unit;
  final int? expireDays;
  final String? productionDate;
  final String? proType;
  final String? erpStore;
  final String? supplierName;
  final String? inTaskNo;
  final String? taskComment;
  final String? oldMaterialCode;
  final String? inboundOrderNo;

  factory AswhUpTaskDetailItem.fromJson(Map<String, dynamic> json) {
    double _parseDouble(Object? value) {
      if (value is num) return value.toDouble();
      if (value is String && value.isNotEmpty) {
        return double.tryParse(value) ?? 0;
      }
      return 0;
    }

    int? _parseInt(Object? value) {
      if (value is num) return value.toInt();
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value);
      }
      return null;
    }

    return AswhUpTaskDetailItem(
      inTaskItemId: _parseInt(json['intaskitemid']) ?? 0,
      inTaskId: _parseInt(json['intaskid']) ?? 0,
      materialCode: (json['matcode'] ?? '').toString(),
      materialName: json['matname']?.toString(),
      storeSiteNo: json['storesiteno']?.toString(),
      storeRoomNo: json['storeroomno']?.toString(),
      subInventoryCode: json['subinventoryCode']?.toString(),
      batchNo: json['batchno']?.toString(),
      serialNo: json['sn']?.toString(),
      planQty: _parseDouble(json['qty']),
      collectedQty: _parseDouble(json['collectedqty']),
      repertoryQty: _parseDouble(json['repqty']),
      unit: json['unit']?.toString(),
      expireDays: _parseInt(json['vdays']),
      productionDate: json['pdate']?.toString(),
      proType: json['protype']?.toString(),
      erpStore: json['erpstore']?.toString(),
      supplierName: json['suppliername']?.toString(),
      inTaskNo: json['intaskno']?.toString(),
      taskComment: json['taskcomment']?.toString(),
      oldMaterialCode: json['matinnercode']?.toString(),
      inboundOrderNo: json['orderno']?.toString(),
    );
  }

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
      'qty': planQty,
      'collectedqty': collectedQty,
      'repqty': repertoryQty,
      'unit': unit,
      'vdays': expireDays,
      'pdate': productionDate,
      'protype': proType,
      'erpstore': erpStore,
      'suppliername': supplierName,
      'intaskno': inTaskNo,
      'taskcomment': taskComment,
      'matinnercode': oldMaterialCode,
      'orderno': inboundOrderNo,
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
        planQty,
        collectedQty,
        repertoryQty,
        unit,
        expireDays,
        productionDate,
        proType,
        erpStore,
        supplierName,
        inTaskNo,
        taskComment,
        oldMaterialCode,
        inboundOrderNo,
      ];
}

class AswhUpTaskDetailListData {
  const AswhUpTaskDetailListData({
    required this.total,
    required this.rows,
  });

  final int total;
  final List<AswhUpTaskDetailItem> rows;

  factory AswhUpTaskDetailListData.fromJson(Map<String, dynamic> json) {
    final total = (json['total'] as num?)?.toInt() ?? 0;
    final rows = (json['rows'] as List<dynamic>? ?? const [])
        .map((item) => AswhUpTaskDetailItem.fromJson(
              Map<String, dynamic>.from(item as Map),
            ))
        .toList();
    return AswhUpTaskDetailListData(total: total, rows: rows);
  }
}

class AswhUpTaskDetailQuery {
  AswhUpTaskDetailQuery({
    required this.inTaskId,
    required this.userId,
    this.workStation,
    this.searchKey = '',
    this.roomTag = '1',
    this.pageIndex = 1,
    this.pageSize = 100,
  });

  final int inTaskId;
  final String userId;
  final String? workStation;
  String searchKey;
  String roomTag;
  int pageIndex;
  int pageSize;

  Map<String, dynamic> toJson() {
    return {
      'intaskid': inTaskId,
      'userId': userId,
      if (workStation != null) 'workstation': workStation,
      if (searchKey.isNotEmpty) 'searchKey': searchKey,
      'roomtag': roomTag,
      'PageIndex': pageIndex.toString(),
      'PageSize': pageSize.toString(),
    };
  }

  AswhUpTaskDetailQuery copyWith({
    String? searchKey,
    int? pageIndex,
    int? pageSize,
  }) {
    final query = AswhUpTaskDetailQuery(
      inTaskId: inTaskId,
      userId: userId,
      workStation: workStation,
      searchKey: searchKey ?? this.searchKey,
      roomTag: roomTag,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
    return query;
  }
}
