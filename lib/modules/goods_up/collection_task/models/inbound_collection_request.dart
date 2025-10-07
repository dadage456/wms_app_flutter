import 'package:equatable/equatable.dart';

/// 入库任务采集明细查询参数
class GoodsUpCollectTaskItemQuery extends Equatable {
  const GoodsUpCollectTaskItemQuery({
    this.inTaskNo = '',
    this.inTaskId = '',
    this.storeRoomNo = '',
    this.forceSite = '',
    this.forceBatch = '',
    this.taskComment = '',
    this.taskFinishFlag = '0',
    this.roomTag = '0',
    this.workStation = '',
    this.sortType = '',
    this.sortColumn = '',
    this.searchKey = '',
    this.userId,
    this.collecter,
    this.pageIndex = 1,
    this.pageSize = 200,
  });

  final String inTaskNo;
  final String inTaskId;
  final String storeRoomNo;
  final String forceSite;
  final String forceBatch;
  final String taskComment;
  final String taskFinishFlag;
  final String roomTag;
  final String workStation;
  final String sortType;
  final String sortColumn;
  final String searchKey;
  final int? userId;
  final int? collecter;
  final int pageIndex;
  final int pageSize;

  Map<String, dynamic> toJson() {
    return {
      'intaskno': inTaskNo,
      'intaskid': inTaskId,
      'storeroomno': storeRoomNo,
      'forcesite': forceSite,
      'forcebatch': forceBatch,
      'taskcomment': taskComment,
      'taskFinishFlag': taskFinishFlag,
      'roomtag': roomTag,
      'workstation': workStation,
      'sortType': sortType,
      'sortColumn': sortColumn,
      'searchKey': searchKey,
      if (userId != null) 'userId': userId,
      if (collecter != null) 'collecter': collecter,
      'PageIndex': pageIndex.toString(),
      'PageSize': pageSize.toString(),
    };
  }

  GoodsUpCollectTaskItemQuery copyWith({
    String? inTaskNo,
    String? inTaskId,
    String? storeRoomNo,
    String? forceSite,
    String? forceBatch,
    String? taskComment,
    String? taskFinishFlag,
    String? roomTag,
    String? workStation,
    String? sortType,
    String? sortColumn,
    String? searchKey,
    int? userId,
    int? collecter,
    int? pageIndex,
    int? pageSize,
  }) {
    return GoodsUpCollectTaskItemQuery(
      inTaskNo: inTaskNo ?? this.inTaskNo,
      inTaskId: inTaskId ?? this.inTaskId,
      storeRoomNo: storeRoomNo ?? this.storeRoomNo,
      forceSite: forceSite ?? this.forceSite,
      forceBatch: forceBatch ?? this.forceBatch,
      taskComment: taskComment ?? this.taskComment,
      taskFinishFlag: taskFinishFlag ?? this.taskFinishFlag,
      roomTag: roomTag ?? this.roomTag,
      workStation: workStation ?? this.workStation,
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
      searchKey: searchKey ?? this.searchKey,
      userId: userId ?? this.userId,
      collecter: collecter ?? this.collecter,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
        inTaskNo,
        inTaskId,
        storeRoomNo,
        forceSite,
        forceBatch,
        taskComment,
        taskFinishFlag,
        roomTag,
        workStation,
        sortType,
        sortColumn,
        searchKey,
        userId,
        collecter,
        pageIndex,
        pageSize,
      ];
}

/// 上架提交参数模型
class GoodsUpCommitRequest {
  GoodsUpCommitRequest({
    required this.upShelvesInfos,
    required this.itemListInfos,
    this.filter = '',
  });

  final List<Map<String, dynamic>> upShelvesInfos;
  final List<Map<String, dynamic>> itemListInfos;
  final String filter;

  Map<String, dynamic> toJson() {
    return {
      'upShelvesInfos': upShelvesInfos,
      'itemListInfos': itemListInfos,
      'filter': filter,
    };
  }
}

/// 上架转储请求
class GoodsUpTransferRequest {
  GoodsUpTransferRequest({
    required this.transferInfos,
    this.filter = '',
  });

  final List<Map<String, dynamic>> transferInfos;
  final String filter;

  Map<String, dynamic> toJson() {
    return {
      'transferInfos': transferInfos,
      'filter': filter,
    };
  }
}
