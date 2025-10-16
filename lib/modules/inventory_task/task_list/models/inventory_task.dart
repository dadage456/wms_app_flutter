import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_task.freezed.dart';
part 'inventory_task.g.dart';

/// 平库盘点任务查询参数
@freezed
class InventoryTaskQuery with _$InventoryTaskQuery {
  const factory InventoryTaskQuery({
    /// 排序方向
    @JsonKey(name: 'sortType') @Default('desc') String sortType,

    /// 排序字段
    @JsonKey(name: 'sortColumn') @Default('createdate') String sortColumn,

    /// 搜索关键字
    @JsonKey(name: 'searchKey') @Default('') String searchKey,

    /// 用户ID
    @JsonKey(name: 'userId') required String userId,

    /// 角色或用户ID
    @JsonKey(name: 'roleoRuserId') required String roleOrUserId,

    /// 库房标签（0-平库、1-立库）
    @JsonKey(name: 'roomTag') @Default('0') String roomTag,

    /// 完成标识：0-未完成，1-全部
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,

    /// 当前页码（1 开始）
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,

    /// 每页条目数
    @JsonKey(name: 'PageSize') @Default(100) int pageSize,
  }) = _InventoryTaskQuery;

  factory InventoryTaskQuery.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskQueryFromJson(json);
}

/// 平库盘点任务摘要
@freezed
class InventoryTask with _$InventoryTask {
  const factory InventoryTask({
    /// 盘库单号
    @JsonKey(name: 'taskcomment') required String taskComment,

    /// 库房号
    @JsonKey(name: 'storeroomno') required String storeRoomNo,

    /// 库房名称
    @JsonKey(name: 'storeroomname') required String storeRoomName,

    /// 任务号
    @JsonKey(name: 'checktaskno') required String checkTaskNo,

    /// 任务主键
    @JsonKey(name: 'checktaskid') int? checkTaskId,

    /// 当前状态
    @JsonKey(name: 'status') String? status,

    /// 工位/拣选位
    @JsonKey(name: 'workstation') String? workStation,

    /// 任务备注
    @JsonKey(name: 'memo') String? memo,
  }) = _InventoryTask;

  factory InventoryTask.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskFromJson(json);
}

/// 平库盘点任务列表响应
@freezed
class InventoryTaskListResponse with _$InventoryTaskListResponse {
  const factory InventoryTaskListResponse({
    @JsonKey(name: 'rows')
    @Default(<InventoryTask>[])
    List<InventoryTask> rows,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _InventoryTaskListResponse;

  factory InventoryTaskListResponse.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskListResponseFromJson(json);
}
