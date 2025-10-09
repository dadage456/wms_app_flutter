import 'package:equatable/equatable.dart';

class GoodsUpTaskItem extends Equatable {
  const GoodsUpTaskItem({
    required this.inTaskItemId,
    required this.inTaskId,
    this.inTaskNo,
    this.materialCode,
    this.materialName,
    this.oldMaterialCode,
    this.quantity = 0,
    this.collectedQuantity = 0,
    this.batchNo,
    this.serialNumber,
    this.subInventoryCode,
    this.storeRoomNo,
    this.storeSiteNo,
    this.inboundOrderNo,
    this.taskComment,
  });

  final int inTaskItemId;
  final int inTaskId;
  final String? inTaskNo;
  final String? materialCode;
  final String? materialName;
  final String? oldMaterialCode;
  final num quantity;
  final num collectedQuantity;
  final String? batchNo;
  final String? serialNumber;
  final String? subInventoryCode;
  final String? storeRoomNo;
  final String? storeSiteNo;
  final String? inboundOrderNo;
  final String? taskComment;

  factory GoodsUpTaskItem.fromJson(Map<String, dynamic> json) {
    return GoodsUpTaskItem(
      inTaskItemId: _parseInt(json['intaskitemid']),
      inTaskId: _parseInt(json['intaskid']),
      inTaskNo: json['intaskno']?.toString(),
      materialCode: json['matcode']?.toString(),
      materialName: json['matname']?.toString(),
      oldMaterialCode: json['matinnercode']?.toString(),
      quantity: _parseNum(json['qty']),
      collectedQuantity: _parseNum(json['collectedqty']),
      batchNo: json['batchno']?.toString(),
      serialNumber: json['sn']?.toString(),
      subInventoryCode: json['subinventoryCode']?.toString(),
      storeRoomNo: json['storeroomno']?.toString(),
      storeSiteNo: json['storesiteno']?.toString(),
      inboundOrderNo: json['orderno']?.toString(),
      taskComment: json['taskcomment']?.toString(),
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
      'qty': quantity,
      'collectedqty': collectedQuantity,
      'batchno': batchNo,
      'sn': serialNumber,
      'subinventoryCode': subInventoryCode,
      'storeroomno': storeRoomNo,
      'storesiteno': storeSiteNo,
      'orderno': inboundOrderNo,
      'taskcomment': taskComment,
    };
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String && value.isNotEmpty) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }

  static num _parseNum(dynamic value) {
    if (value is num) return value;
    if (value is String && value.isNotEmpty) {
      return num.tryParse(value) ?? 0;
    }
    return 0;
  }

  @override
  List<Object?> get props => [
    inTaskItemId,
    inTaskId,
    inTaskNo,
    materialCode,
    materialName,
    oldMaterialCode,
    quantity,
    collectedQuantity,
    batchNo,
    serialNumber,
    subInventoryCode,
    storeRoomNo,
    storeSiteNo,
    inboundOrderNo,
    taskComment,
  ];
}

class GoodsUpTaskItemListData extends Equatable {
  const GoodsUpTaskItemListData({
    this.total = 0,
    this.rows = const <GoodsUpTaskItem>[],
  });

  final int total;
  final List<GoodsUpTaskItem> rows;

  factory GoodsUpTaskItemListData.fromJson(Map<String, dynamic> json) {
    final rows = json['rows'] as List<dynamic>? ?? const [];
    return GoodsUpTaskItemListData(
      total: GoodsUpTaskItem._parseInt(json['total']),
      rows: rows
          .map((e) => GoodsUpTaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'rows': rows.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [total, rows];
}

class GoodsUpTaskItemQuery extends Equatable {
  const GoodsUpTaskItemQuery({
    required this.inTaskId,
    required this.userId,
    this.workStation,
    this.searchKey = '',
    this.sortType = '',
    this.sortColumn = '',
    this.pageIndex = 1,
    this.pageSize = 100,
    this.roomtag = '0',
  });

  final int inTaskId;
  final String userId;
  final String? workStation;
  final String searchKey;
  final String sortType;
  final String sortColumn;
  final int pageIndex;
  final int pageSize;
  final String roomtag;

  GoodsUpTaskItemQuery copyWith({
    int? inTaskId,
    String? userId,
    String? workStation,
    String? searchKey,
    String? sortType,
    String? sortColumn,
    int? pageIndex,
    int? pageSize,
  }) {
    return GoodsUpTaskItemQuery(
      inTaskId: inTaskId ?? this.inTaskId,
      userId: userId ?? this.userId,
      workStation: workStation ?? this.workStation,
      searchKey: searchKey ?? this.searchKey,
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'intaskid': inTaskId,
      'workstation': workStation,

      // 'sortType': sortType,
      // 'sortColumn': sortColumn,
      if (searchKey.isNotEmpty) 'searchKey': searchKey,
      'PageIndex': pageIndex.toString(),
      'PageSize': pageSize.toString(),
      'roomtag': roomtag,
    };
  }

  @override
  List<Object?> get props => [
    inTaskId,
    userId,
    workStation,
    searchKey,
    sortType,
    sortColumn,
    pageIndex,
    pageSize,
  ];
}
