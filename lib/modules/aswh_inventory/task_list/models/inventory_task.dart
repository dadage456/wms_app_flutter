import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_task.freezed.dart';
part 'inventory_task.g.dart';

/// 盘点任务查询参数
@freezed
class InventoryTaskFilter with _$InventoryTaskFilter {
  const factory InventoryTaskFilter({
    /// 排序方向
    @JsonKey(name: 'sortType') @Default('desc') String sortType,

    /// 排序字段
    @JsonKey(name: 'sortColumn') @Default('createdate') String sortColumn,

    /// 搜索关键字（支持扫码输入任务号/盘库单号）
    @JsonKey(name: 'searchKey') @Default('') String searchKey,

    /// 用户ID（字符串，兼容接口入参）
    @JsonKey(name: 'userId') required String userId,

    /// 角色或用户ID（接口字段名为 roleoRuserId）
    @JsonKey(name: 'roleoRuserId') required String roleOrUserId,

    /// 库房标签（1 表示立库）
    @JsonKey(name: 'roomTag') @Default('1') String roomTag,

    /// 完成标识（0-未完成，1-全部）
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,

    /// 当前页码（接口使用 PageIndex 字段，1 开始）
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,

    /// 每页条目数量
    @JsonKey(name: 'PageSize') @Default(100) int pageSize,
  }) = _InventoryTaskFilter;

  factory InventoryTaskFilter.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskFilterFromJson(json);
}

/// 盘点任务汇总信息
@freezed
class InventoryTaskSummary with _$InventoryTaskSummary {
  const factory InventoryTaskSummary({
    /// 盘库单号
    @JsonKey(name: 'taskcomment') required String taskComment,

    /// 库房号
    @JsonKey(name: 'storeroomno') required String storeRoomNo,

    /// 库房名称
    @JsonKey(name: 'storeroomname') required String storeRoomName,

    /// 任务号
    @JsonKey(name: 'checktaskno') required String checkTaskNo,

    /// 任务ID
    @JsonKey(name: 'checktaskid') int? checkTaskId,

    /// 状态描述
    @JsonKey(name: 'status') String? status,

    /// 工位/拣选位
    @JsonKey(name: 'workstation') String? workStation,
  }) = _InventoryTaskSummary;

  factory InventoryTaskSummary.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskSummaryFromJson(json);
}

/// 盘点任务列表响应数据
@freezed
class InventoryTaskListData with _$InventoryTaskListData {
  const factory InventoryTaskListData({
    @JsonKey(name: 'rows')
    @Default(<InventoryTaskSummary>[])
    List<InventoryTaskSummary> rows,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _InventoryTaskListData;

  factory InventoryTaskListData.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskListDataFromJson(json);
}
