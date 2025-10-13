import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_up_request.freezed.dart';
part 'goods_up_request.g.dart';

/// 入库上架任务明细查询入参
@freezed
class GoodsUpTaskItemQueryRequest with _$GoodsUpTaskItemQueryRequest {
  const factory GoodsUpTaskItemQueryRequest({
    /// 入库任务号
    @JsonKey(name: 'intaskno') @Default('') String inTaskNo,

    /// 库房编号
    @JsonKey(name: 'storeroomno') @Default('') String storeRoomNo,

    /// 强制库位标志
    @JsonKey(name: 'forcesite') @Default('') String forceSite,

    /// 强制批次标志
    @JsonKey(name: 'forcebatch') @Default('') String forceBatch,

    /// 任务备注
    @JsonKey(name: 'taskcomment') @Default('') String taskComment,

    /// 完成标志
    @JsonKey(name: 'taskFinishFlag') @Default('0') String taskFinishFlag,

    /// 库房标签
    @JsonKey(name: 'roomtag') @Default('0') String roomTag,

    /// 工作站
    @JsonKey(name: 'workstation') @Default('') String workStation,

    /// 完成标志（兼容字段）
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,

    /// 排序类型
    @JsonKey(name: 'sortType') @Default('') String sortType,

    /// 排序字段
    @JsonKey(name: 'sortColumn') @Default('') String sortColumn,

    /// 搜索关键字
    @JsonKey(name: 'searchKey') @Default('') String searchKey,

    /// 节拍标志
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,

    /// 采集人
    @JsonKey(name: 'collecter') @Default(0) int collecter,
  }) = _GoodsUpTaskItemQueryRequest;

  factory GoodsUpTaskItemQueryRequest.fromJson(Map<String, dynamic> json) =>
      _$GoodsUpTaskItemQueryRequestFromJson(json);
}
