import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_request.freezed.dart';
part 'collection_request.g.dart';

/// 采集任务明细查询入参（与后端示例键名完全对齐）
@freezed
class CollectionTaskItemQuery with _$CollectionTaskItemQuery {
  const factory CollectionTaskItemQuery({
    /// 任务号（示例字段）
    @JsonKey(name: 'outtaskno') @Default('') String outTaskNo,

    /// 库房编号
    @JsonKey(name: 'storeroomno') @Default('') String storeRoomNo,

    /// 强制库位标志/参数（示例字段）
    @JsonKey(name: 'forcesite') @Default('') String forceSite,

    /// 强制批次标志/参数（示例字段）
    @JsonKey(name: 'forcebatch') @Default('') String forceBatch,

    /// 凭证/备注
    @JsonKey(name: 'taskcomment') @Default('') String taskComment,

    /// 任务完成标志（示例字段）
    @JsonKey(name: 'taskFinishFlag') @Default('0') String taskFinishFlag,

    /// 库房标签（示例为 roomtag）
    @JsonKey(name: 'roomtag') @Default('0') String roomTag,

    /// 工作站
    @JsonKey(name: 'workstation') @Default('') String workStation,

    /// 完成标志（示例字段）
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,

    /// 排序类型
    @JsonKey(name: 'sortType') @Default('') String sortType,

    /// 排序字段
    @JsonKey(name: 'sortColumn') @Default('') String sortColumn,

    /// 搜索关键字
    @JsonKey(name: 'searchKey') @Default('') String searchKey,

    /// 节拍标志
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,

    /// 采集人（示例为 this.$store.state.userid）
    @JsonKey(name: 'collecter') @Default(0) int collecter,
  }) = _CollectionTaskItemQuery;

  factory CollectionTaskItemQuery.fromJson(Map<String, dynamic> json) =>
      _$CollectionTaskItemQueryFromJson(json);
}