class GoodsUpCollectTaskItemQuery {
  GoodsUpCollectTaskItemQuery({
    required this.inTaskNo,
    required this.inTaskId,
    required this.storeRoomNo,
    this.forceSite = '',
    this.forceBatch = '',
    this.taskComment = '',
    this.taskFinishFlag = '0',
    this.roomTag = '0',
    this.workStation,
    this.sortType = '',
    this.sortColumn = '',
    this.searchKey = '',
    required this.userId,
  });

  final String inTaskNo;
  final int inTaskId;
  final String storeRoomNo;
  final String forceSite;
  final String forceBatch;
  final String taskComment;
  final String taskFinishFlag;
  final String roomTag;
  final String? workStation;
  final String sortType;
  final String sortColumn;
  final String searchKey;
  final String userId;

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
      if (workStation != null) 'workstation': workStation,
      'sortType': sortType,
      'sortColumn': sortColumn,
      'searchKey': searchKey,
      'userId': userId,
    };
  }
}

class InboundCommitRequest {
  InboundCommitRequest({
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
