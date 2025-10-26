import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_pick_task_item_models.freezed.dart';
part 'online_pick_task_item_models.g.dart';

/// 在线拣选任务明细模型。
@freezed
class OnlinePickTaskItem with _$OnlinePickTaskItem {
  const factory OnlinePickTaskItem({
    @JsonKey(name: 'outtaskitemid') required int outTaskItemId,
    @JsonKey(name: 'outtaskid') required int outTaskId,
    @JsonKey(name: 'outtaskno') String? outTaskNo,
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'matinnercode') String? oldMaterialCode,
    @JsonKey(name: 'storesiteno') String? storeSiteNo,
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
    @JsonKey(name: 'orderno') String? orderNo,
    @JsonKey(name: 'taskcomment') String? taskComment,
    @JsonKey(name: 'palletno') String? palletNo,
    @JsonKey(name: 'hintqty') @Default(0) num taskQty,
    @JsonKey(name: 'collectedqty') @Default(0) num collectedQty,
    @JsonKey(name: 'repqty') @Default(0) num repositoryQty,
    @JsonKey(name: 'hintbatchno') String? hintBatchNo,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNumber,
    @JsonKey(name: 'wcsstate') String? wcsState,
  }) = _OnlinePickTaskItem;

  factory OnlinePickTaskItem.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskItemFromJson(json);
}

@freezed
class OnlinePickTaskItemListData with _$OnlinePickTaskItemListData {
  const factory OnlinePickTaskItemListData({
    @JsonKey(name: 'rows') @Default([]) List<OnlinePickTaskItem> rows,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _OnlinePickTaskItemListData;

  factory OnlinePickTaskItemListData.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskItemListDataFromJson(json);
}

/// 任务明细查询参数。
@freezed
class OnlinePickTaskItemQuery with _$OnlinePickTaskItemQuery {
  const factory OnlinePickTaskItemQuery({
    @JsonKey(name: 'outtaskid') required int outTaskId,
    @JsonKey(name: 'outtaskno') String? outTaskNo,
    @JsonKey(name: 'workstation') String? workStation,
    @JsonKey(name: 'roomTag') @Default('1') String roomTag,
    @JsonKey(name: 'roleoRuserId') required String roleOrUserId,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(includeToJson: false) @Default('') String sortType,
    @JsonKey(includeToJson: false) @Default('') String sortColumn,
    @JsonKey(name: 'searchKey') @Default('') String searchKey,
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,
    @JsonKey(name: 'PageSize') @Default(100) int pageSize,
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,
    @JsonKey(name: 'forcesite') String? forceSite,
    @JsonKey(name: 'forcebatch') String? forceBatch,
  }) = _OnlinePickTaskItemQuery;

  factory OnlinePickTaskItemQuery.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskItemQueryFromJson(json);
}

extension OnlinePickTaskItemQueryX on OnlinePickTaskItemQuery {
  Map<String, dynamic> toQueryParameters() {
    final map = toJson();
    map['PageIndex'] = pageIndex.toString();
    map['PageSize'] = pageSize.toString();
    return map;
  }
}
