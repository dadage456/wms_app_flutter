import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'outbound_collect_models.freezed.dart';
part 'outbound_collect_models.g.dart';

/// 扫码步骤枚举
enum ScanStep {
  /// 库位扫描步骤
  site,
  /// 物料二维码扫描步骤
  material,
  /// 数量确认步骤
  quantity,
}

/// 物料控制模式枚举
enum MaterialControlMode {
  /// 检查物料
  material,
  /// 物料+批号
  materialBatch,
  /// 物料+库位
  materialSite,
  /// 物料+批号+库位
  materialBatchSite,
}

/// 采集记录模型
@freezed
class CollectRecord with _$CollectRecord {
  const factory CollectRecord({
    /// 物料编码
    @JsonKey(name: 'matcode') required String matCode,
    /// 物料名称
    @JsonKey(name: 'matname') required String matName,
    /// 库位编号
    @JsonKey(name: 'storesiteno') required String storeSiteNo,
    /// 采集数量
    @JsonKey(name: 'qty') required int qty,
    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,
    /// 序列号
    @JsonKey(name: 'sn') String? sn,
    /// 生产日期
    @JsonKey(name: 'pdate') String? pdate,
    /// 保质期
    @JsonKey(name: 'vdays') String? vdays,
    /// 控制方式
    @JsonKey(name: 'seqctrl') String? seqCtrl,
    /// 编码方式
    @JsonKey(name: 'id_old') String? idOld,
    /// 任务明细ID
    @JsonKey(name: 'outtaskitemid') int? outTaskItemId,
    /// 采集时间
    @JsonKey(name: 'collecttime') String? collectTime,
  }) = _CollectRecord;

  factory CollectRecord.fromJson(Map<String, dynamic> json) =>
      _$CollectRecordFromJson(json);
}

/// 库存信息模型
@freezed
class InventoryInfo with _$InventoryInfo {
  const factory InventoryInfo({
    /// 物料编码
    @JsonKey(name: 'matcode') required String matCode,
    /// 物料名称
    @JsonKey(name: 'matname') required String matName,
    /// 库位编号
    @JsonKey(name: 'storesiteno') required String storeSiteNo,
    /// 库存数量
    @JsonKey(name: 'qty') required int qty,
    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,
    /// 序列号
    @JsonKey(name: 'sn') String? sn,
    /// 库房编号
    @JsonKey(name: 'storeroomno') String? storeRoomNo,
    /// 子库编码
    @JsonKey(name: 'subinventorycode') String? subInventoryCode,
  }) = _InventoryInfo;

  factory InventoryInfo.fromJson(Map<String, dynamic> json) =>
      _$InventoryInfoFromJson(json);
}

/// 库存查询参数
@freezed
class InventoryQuery with _$InventoryQuery {
  const factory InventoryQuery({
    /// 库位编号
    @JsonKey(name: 'storesite') required String storeSite,
    /// 物料编码
    @JsonKey(name: 'matcode') String? matCode,
    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,
    /// 序列号
    @JsonKey(name: 'sn') String? sn,
  }) = _InventoryQuery;

  factory InventoryQuery.fromJson(Map<String, dynamic> json) =>
      _$InventoryQueryFromJson(json);
}

/// 库存查询响应
@freezed
class InventoryResponse with _$InventoryResponse {
  const factory InventoryResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,
    /// 响应消息
    @JsonKey(name: 'msg') required String message,
    /// 库存信息列表
    @JsonKey(name: 'data') required List<InventoryInfo> data,
  }) = _InventoryResponse;

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      _$InventoryResponseFromJson(json);
}

/// 扫码内容解析结果
@freezed
class BarcodeContent with _$BarcodeContent {
  const factory BarcodeContent({
    /// 物料编码
    required String matCode,
    /// 批次号
    String? batchNo,
    /// 序列号
    String? sn,
    /// 生产日期
    String? pdate,
    /// 保质期
    String? vdays,
    /// 原始扫码内容
    required String originalContent,
    /// 是否需要API解析
    @Default(false) bool needsApiParsing,
  }) = _BarcodeContent;

  factory BarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$BarcodeContentFromJson(json);
}

/// 采集任务查询参数
class CollectTaskQuery extends Equatable {
  const CollectTaskQuery({
    required this.outTaskNo,
    this.storeRoomNo = '',
    this.forceSite = '',
    this.forceBatch = '',
    this.taskComment = '',
    this.taskFinishFlag = '0',
    this.roomTag = '0',
    this.workStation = 'N',
    this.finishFlag = '0',
    this.sortType = '',
    this.sortColumn = '',
    this.searchKey = '',
    this.beatFlag = 'N',
    this.collecter = '',
  });

  /// 任务号
  final String outTaskNo;
  /// 库房编号
  final String storeRoomNo;
  /// 强制库位
  final String forceSite;
  /// 强制批次
  final String forceBatch;
  /// 任务备注
  final String taskComment;
  /// 任务完成标志
  final String taskFinishFlag;
  /// 库房标签
  final String roomTag;
  /// 工作站
  final String workStation;
  /// 完成标志
  final String finishFlag;
  /// 排序类型
  final String sortType;
  /// 排序字段
  final String sortColumn;
  /// 搜索关键字
  final String searchKey;
  /// 节拍标志
  final String beatFlag;
  /// 采集人员
  final String collecter;

  @override
  List<Object?> get props => [
    outTaskNo,
    storeRoomNo,
    forceSite,
    forceBatch,
    taskComment,
    taskFinishFlag,
    roomTag,
    workStation,
    finishFlag,
    sortType,
    sortColumn,
    searchKey,
    beatFlag,
    collecter,
  ];

  CollectTaskQuery copyWith({
    String? outTaskNo,
    String? storeRoomNo,
    String? forceSite,
    String? forceBatch,
    String? taskComment,
    String? taskFinishFlag,
    String? roomTag,
    String? workStation,
    String? finishFlag,
    String? sortType,
    String? sortColumn,
    String? searchKey,
    String? beatFlag,
    String? collecter,
  }) {
    return CollectTaskQuery(
      outTaskNo: outTaskNo ?? this.outTaskNo,
      storeRoomNo: storeRoomNo ?? this.storeRoomNo,
      forceSite: forceSite ?? this.forceSite,
      forceBatch: forceBatch ?? this.forceBatch,
      taskComment: taskComment ?? this.taskComment,
      taskFinishFlag: taskFinishFlag ?? this.taskFinishFlag,
      roomTag: roomTag ?? this.roomTag,
      workStation: workStation ?? this.workStation,
      finishFlag: finishFlag ?? this.finishFlag,
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
      searchKey: searchKey ?? this.searchKey,
      beatFlag: beatFlag ?? this.beatFlag,
      collecter: collecter ?? this.collecter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'outtaskno': outTaskNo,
      'storeroomno': storeRoomNo,
      'forcesite': forceSite,
      'forcebatch': forceBatch,
      'taskcomment': taskComment,
      'taskFinishFlag': taskFinishFlag,
      'roomtag': roomTag,
      'workstation': workStation,
      'finshFlg': finishFlag,
      'sortType': sortType,
      'sortColumn': sortColumn,
      'searchKey': searchKey,
      'beatflag': beatFlag,
      'collecter': collecter,
    };
  }
}

/// 提交采集数据响应
@freezed
class SubmitCollectResponse with _$SubmitCollectResponse {
  const factory SubmitCollectResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,
    /// 响应消息
    @JsonKey(name: 'msg') required String message,
    /// 响应数据
    @JsonKey(name: 'data') dynamic data,
  }) = _SubmitCollectResponse;

  factory SubmitCollectResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitCollectResponseFromJson(json);
}

/// 报缺响应
@freezed
class ReportShortageResponse with _$ReportShortageResponse {
  const factory ReportShortageResponse({
    /// 响应码
    @JsonKey(name: 'code') required String code,
    /// 响应消息
    @JsonKey(name: 'msg') required String message,
    /// 响应数据
    @JsonKey(name: 'data') dynamic data,
  }) = _ReportShortageResponse;

  factory ReportShortageResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportShortageResponseFromJson(json);
}