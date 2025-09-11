import 'package:freezed_annotation/freezed_annotation.dart';

part 'outbound_task_item.freezed.dart';
part 'outbound_task_item.g.dart';

/// 出库任务明细模型
@freezed
class OutboundTaskItem with _$OutboundTaskItem {
  const factory OutboundTaskItem({
    /// 任务明细ID
    @JsonKey(name: 'outtaskitemid') required int outTaskItemId,

    /// 物料编码
    @JsonKey(name: 'matcode') required String matCode,

    /// 物料名称
    @JsonKey(name: 'matname') required String matName,

    /// 物料旧编码
    @JsonKey(name: 'matinnercode') String? matInnerCode,

    /// 库位编号
    @JsonKey(name: 'storesiteno') required String storeSiteNo,

    /// 库房编号
    @JsonKey(name: 'storeroomno') required String storeRoomNo,

    /// 子库编码
    @JsonKey(name: 'subinventoryCode') required String subInventoryCode,

    /// 任务数量
    @JsonKey(name: 'hintqty') required int hintQty,

    /// 批次号
    @JsonKey(name: 'hintbatchno') String? hintBatchNo,

    /// 序列号
    @JsonKey(name: 'sn') String? sn,

    /// 出库单号
    @JsonKey(name: 'orderno') required String orderNo,
  }) = _OutboundTaskItem;

  factory OutboundTaskItem.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskItemFromJson(json);
}

/// 出库任务明细查询参数
@freezed
class OutboundTaskItemQuery with _$OutboundTaskItemQuery {
  const factory OutboundTaskItemQuery({
    /// 出库任务ID（必填）
    @JsonKey(name: 'outtaskid') required String outTaskId,

    /// 工作站（必填）
    @JsonKey(name: 'workstation') required String workStation,

    /// 搜索关键字（物料编码）
    @JsonKey(name: 'searchKey') @Default('') String searchKey,

    /// 用户ID
    @JsonKey(name: 'userId') required int userId,

    /// 角色或用户ID
    @JsonKey(name: 'roleoRuserId') required int roleOrUserId,

    /// 库房标签
    @JsonKey(name: 'roomTag') @Default('0') String roomTag,

    /// 批次标志
    @JsonKey(name: 'batchflag') @Default('0') String batchFlag,

    /// 转移类型
    @JsonKey(name: 'transferType') @Default('0') String transferType,

    /// 节拍标志
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,

    /// 页码
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,

    /// 页面大小
    @JsonKey(name: 'PageSize') @Default(100) int pageSize,
  }) = _OutboundTaskItemQuery;

  factory OutboundTaskItemQuery.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskItemQueryFromJson(json);
}

/// 出库任务明细列表响应数据
@freezed
class OutboundTaskItemListData with _$OutboundTaskItemListData {
  const factory OutboundTaskItemListData({
    /// 明细列表
    @JsonKey(name: 'rows') required List<OutboundTaskItem> rows,

    /// 总记录数
    @JsonKey(name: 'total') required int total,
  }) = _OutboundTaskItemListData;

  factory OutboundTaskItemListData.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskItemListDataFromJson(json);
}

/// 出库任务明细列表响应
@freezed
class OutboundTaskItemListResponse with _$OutboundTaskItemListResponse {
  const factory OutboundTaskItemListResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,

    /// 响应消息
    @JsonKey(name: 'msg') required String message,

    /// 响应数据
    @JsonKey(name: 'data') required OutboundTaskItemListData data,
  }) = _OutboundTaskItemListResponse;

  factory OutboundTaskItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$OutboundTaskItemListResponseFromJson(json);
}

/// 物料信息查询响应
@freezed
class MaterialInfoResponse with _$MaterialInfoResponse {
  const factory MaterialInfoResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,

    /// 响应消息
    @JsonKey(name: 'msg') required String message,

    /// 物料信息
    @JsonKey(name: 'data') required MaterialInfo data,
  }) = _MaterialInfoResponse;

  factory MaterialInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoResponseFromJson(json);
}

/// 物料信息
@freezed
class MaterialInfo with _$MaterialInfo {
  const factory MaterialInfo({
    /// 物料编码
    @JsonKey(name: 'matcode') required String matCode,
  }) = _MaterialInfo;

  factory MaterialInfo.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoFromJson(json);
}

/// 撤销操作响应
@freezed
class CancelTaskResponse with _$CancelTaskResponse {
  const factory CancelTaskResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,

    /// 响应消息
    @JsonKey(name: 'msg') required String message,
  }) = _CancelTaskResponse;

  factory CancelTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelTaskResponseFromJson(json);
}
