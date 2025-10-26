import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_pick_task_models.freezed.dart';
part 'online_pick_task_models.g.dart';

/// 自动化仓库出库任务（在线拣选）列表数据模型。
@freezed
class OnlinePickTask with _$OnlinePickTask {
  const factory OnlinePickTask({
    /// 任务唯一标识
    @JsonKey(name: 'outtaskid') required int outTaskId,

    /// 任务号
    @JsonKey(name: 'outtaskno') required String outTaskNo,

    /// 出库单号
    @JsonKey(name: 'orderno') String? orderNo,

    /// 来源单号
    @JsonKey(name: 'po_number') String? poNumber,

    /// 库房号
    @JsonKey(name: 'storeroomno') String? storeRoomNo,

    /// 工位
    @JsonKey(name: 'workstation') String? workStation,

    /// 凭证号
    @JsonKey(name: 'taskcomment') String? taskComment,

    /// 紧急补单标识
    @JsonKey(name: 'wip_supplement_flag') String? urgentFlag,

    /// 班组名称
    @JsonKey(name: 'schedule_group_name') String? scheduleGroupName,

    /// 强制校验库位标志
    @JsonKey(name: 'forcesite') String? forceSite,

    /// 强制校验批次标志
    @JsonKey(name: 'forcebatch') String? forceBatch,

    /// 完成标记（0：采集中，1：全部）
    @JsonKey(name: 'finshFlg') String? finishFlag,

    /// 创建时间
    @JsonKey(name: 'createtime') String? createTime,

    /// 任务数量
    @JsonKey(name: 'taskqty') @Default(0) num taskQty,

    /// 完成数量
    @JsonKey(name: 'finishqty') @Default(0) num finishQty,
  }) = _OnlinePickTask;

  factory OnlinePickTask.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskFromJson(json);
}

/// 任务列表响应体。
@freezed
class OnlinePickTaskListData with _$OnlinePickTaskListData {
  const factory OnlinePickTaskListData({
    @JsonKey(name: 'rows') @Default([]) List<OnlinePickTask> rows,
    @JsonKey(name: 'total') @Default(0) int total,
  }) = _OnlinePickTaskListData;

  factory OnlinePickTaskListData.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskListDataFromJson(json);
}

/// 任务列表接口响应。
@freezed
class OnlinePickTaskListResponse with _$OnlinePickTaskListResponse {
  const factory OnlinePickTaskListResponse({
    @JsonKey(name: 'code') required String code,
    @JsonKey(name: 'msg') required String message,
    @JsonKey(name: 'data') required OnlinePickTaskListData data,
  }) = _OnlinePickTaskListResponse;

  factory OnlinePickTaskListResponse.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskListResponseFromJson(json);
}

/// 在线拣选任务查询参数（与后端字段对齐）。
@freezed
class OnlinePickTaskQuery with _$OnlinePickTaskQuery {
  const factory OnlinePickTaskQuery({
    @Default('') @JsonKey(includeToJson: false) String sortType,
    @Default('') @JsonKey(includeToJson: false) String sortColumn,
    @Default('') @JsonKey(name: 'searchKey') String searchKey,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'roleoRuserId') required String roleOrUserId,
    @JsonKey(name: 'roomTag') @Default('1') String roomTag,
    @JsonKey(name: 'batchflag') @Default('0') String batchFlag,
    @JsonKey(name: 'transferType') @Default('0') String transferType,
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,
    @JsonKey(name: 'PageSize') @Default(100) int pageSize,
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,
  }) = _OnlinePickTaskQuery;

  factory OnlinePickTaskQuery.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTaskQueryFromJson(json);
}

extension OnlinePickTaskQueryX on OnlinePickTaskQuery {
  Map<String, dynamic> toQueryParameters() {
    final map = toJson();
    map['PageIndex'] = pageIndex.toString();
    map['PageSize'] = pageSize.toString();
    return map;
  }
}
