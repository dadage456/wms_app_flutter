import 'package:equatable/equatable.dart';

class GoodsUpTask extends Equatable {
  const GoodsUpTask({
    required this.inTaskId,
    required this.inTaskNo,
    this.inboundOrderNo,
    this.sourceOrderNo,
    this.storeRoomNo,
    this.workStation,
    this.partnerName,
    this.taskComment,
    this.taskQty = 0,
    this.finishQty = 0,
  });

  final int inTaskId;
  final String inTaskNo;
  final String? inboundOrderNo;
  final String? sourceOrderNo;
  final String? storeRoomNo;
  final String? workStation;
  final String? partnerName;
  final String? taskComment;
  final num taskQty;
  final num finishQty;

  factory GoodsUpTask.fromJson(Map<String, dynamic> json) {
    return GoodsUpTask(
      inTaskId: _parseInt(json['intaskid']),
      inTaskNo: (json['intaskno'] ?? '').toString(),
      inboundOrderNo: json['data2']?.toString(),
      sourceOrderNo: json['data3']?.toString(),
      storeRoomNo: json['storeroomno']?.toString(),
      workStation: json['workstation']?.toString(),
      partnerName: json['parname']?.toString(),
      taskComment: json['taskcomment']?.toString(),
      taskQty: _parseNum(json['taskqty']),
      finishQty: _parseNum(json['finishqty']),
    );
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

  Map<String, dynamic> toJson() {
    return {
      'intaskid': inTaskId,
      'intaskno': inTaskNo,
      'data2': inboundOrderNo,
      'data3': sourceOrderNo,
      'storeroomno': storeRoomNo,
      'workstation': workStation,
      'parname': partnerName,
      'taskcomment': taskComment,
      'taskqty': taskQty,
      'finishqty': finishQty,
    };
  }

  @override
  List<Object?> get props => [
    inTaskId,
    inTaskNo,
    inboundOrderNo,
    sourceOrderNo,
    storeRoomNo,
    workStation,
    partnerName,
    taskComment,
    taskQty,
    finishQty,
  ];
}

class GoodsUpTaskListData extends Equatable {
  const GoodsUpTaskListData({
    this.total = 0,
    this.rows = const <GoodsUpTask>[],
  });

  final int total;
  final List<GoodsUpTask> rows;

  factory GoodsUpTaskListData.fromJson(Map<String, dynamic> json) {
    final rowsJson = json['rows'] as List<dynamic>? ?? const [];
    return GoodsUpTaskListData(
      total: GoodsUpTask._parseInt(json['total']),
      rows: rowsJson
          .map((e) => GoodsUpTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'rows': rows.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [total, rows];
}

class GoodsUpTaskQuery extends Equatable {
  const GoodsUpTaskQuery({
    this.sortType = '',
    this.sortColumn = '',
    this.searchKey = '',
    required this.userId,
    required this.roleOrUserId,
    this.roomTag = '0',
    this.batchFlag = '0',
    this.transferType = '0',
    this.beatFlag = 'N',
    this.pageIndex = 1,
    this.pageSize = 100,
    this.finishFlag = '0',
  });

  final String sortType;
  final String sortColumn;
  final String searchKey;
  final String userId;
  final String roleOrUserId;
  final String roomTag;
  final String batchFlag;
  final String transferType;
  final String beatFlag;
  final int pageIndex;
  final int pageSize;
  final String finishFlag;

  GoodsUpTaskQuery copyWith({
    String? sortType,
    String? sortColumn,
    String? searchKey,
    String? userId,
    String? roleOrUserId,
    String? roomTag,
    String? batchFlag,
    String? transferType,
    String? beatFlag,
    int? pageIndex,
    int? pageSize,
    String? finishFlag,
  }) {
    return GoodsUpTaskQuery(
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
      searchKey: searchKey ?? this.searchKey,
      userId: userId ?? this.userId,
      roleOrUserId: roleOrUserId ?? this.roleOrUserId,
      roomTag: roomTag ?? this.roomTag,
      batchFlag: batchFlag ?? this.batchFlag,
      transferType: transferType ?? this.transferType,
      beatFlag: beatFlag ?? this.beatFlag,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      finishFlag: finishFlag ?? this.finishFlag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'sortType': sortType,
      // 'sortColumn': sortColumn,
      'searchKey': searchKey,
      'userId': userId,
      'roleoRuserId': roleOrUserId,
      'roomtag': roomTag,
      'batchflag': batchFlag,
      'transferType': transferType,
      'beatflag': beatFlag,
      'PageIndex': pageIndex.toString(),
      'PageSize': pageSize.toString(),
      'finshFlg': finishFlag,
    };
  }

  @override
  List<Object?> get props => [
    sortType,
    sortColumn,
    searchKey,
    userId,
    roleOrUserId,
    roomTag,
    batchFlag,
    transferType,
    beatFlag,
    pageIndex,
    pageSize,
    finishFlag,
  ];
}
