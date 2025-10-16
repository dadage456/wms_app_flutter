import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_collect_models.freezed.dart';
part 'inventory_collect_models.g.dart';

DateTime? _dateTimeFromJson(String? value) =>
    value == null ? null : DateTime.tryParse(value);
String? _dateTimeToJson(DateTime? value) => value?.toIso8601String();

/// 盘点任务明细行数据
@freezed
class InventoryTaskItem with _$InventoryTaskItem {
  const factory InventoryTaskItem({
    /// 明细主键
    @JsonKey(name: 'co_checkitemid') int? checkItemId,

    /// 任务ID
    @JsonKey(name: 'checktaskid') int? checkTaskId,

    /// 任务号
    @JsonKey(name: 'checktaskno') String? checkTaskNo,

    /// 盘库单号
    @JsonKey(name: 'taskcomment') String? taskComment,

    /// 库房编码
    @JsonKey(name: 'storeroomno') String? storeRoomNo,

    /// 库房名称
    @JsonKey(name: 'storeroomname') String? storeRoomName,

    /// 库位编码
    @JsonKey(name: 'storesiteno') String? storeSiteNo,

    /// 库位描述
    @JsonKey(name: 'storesite') String? storeSiteName,

    /// 托盘号
    @JsonKey(name: 'palletno') String? palletNo,

    /// 物料编码
    @JsonKey(name: 'matcode2') String? materialCode,

    /// 物料名称
    @JsonKey(name: 'matname') String? materialName,

    /// 计划数量
    @JsonKey(name: 'qty') @Default(0) double planQty,

    /// 已采集数量
    @JsonKey(name: 'collectdataqty') @Default(0) double collectedQty,

    /// 盘点类型
    @JsonKey(name: 'checkmethod_nm') String? checkMethodName,

    /// 批次号
    @JsonKey(name: 'batchno') String? batchNo,

    /// 序列号
    @JsonKey(name: 'sn') String? serialNo,

    /// 供应商编码
    @JsonKey(name: 'suppliercode') String? supplierCode,

    /// 拣选位置/终点地址
    @JsonKey(name: 'endaddr') String? endAddr,

    /// ERP 子库
    @JsonKey(name: 'erpstoreroom') String? erpStoreRoom,

    /// ERP 库位
    @JsonKey(name: 'erpstoresite') String? erpStoreSite,

    /// 物料控制标识
    @JsonKey(name: 'matcontrolflag') String? materialControlFlag,

    /// 是否完成
    @JsonKey(name: 'isfinish') @Default(false) bool isFinished,
  }) = _InventoryTaskItem;

  const InventoryTaskItem._();

  factory InventoryTaskItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskItemFromJson(json);
}

/// 采集中/已提交的采集记录
@freezed
class InventoryCollectingRecord with _$InventoryCollectingRecord {
  const factory InventoryCollectingRecord({
    /// 盘库单号
    @JsonKey(name: 'TaskComment') required String taskComment,

    /// 任务明细 ID
    @JsonKey(name: 'invTaskItemid') required String taskItemId,

    /// 物料编码
    @JsonKey(name: 'matCode') required String materialCode,

    /// 物料主数据 ID
    @JsonKey(name: 'materialId') String? materialId,

    /// 库房编码
    @JsonKey(name: 'storeRoomNo') required String storeRoomNo,

    /// 库位编码
    @JsonKey(name: 'storeSiteNo') required String storeSiteNo,

    /// 采集数量
    @JsonKey(name: 'collectQty') @Default(0) double collectQty,

    /// 批次号
    @JsonKey(name: 'batchNo') String? batchNo,

    /// 序列号
    @JsonKey(name: 'sn') String? serialNo,

    /// 托盘号
    @JsonKey(name: 'trayNo') String? trayNo,

    /// 采集时间
    @JsonKey(
      name: 'collectedAt',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson,
    )
    DateTime? collectedAt,
  }) = _InventoryCollectingRecord;

  factory InventoryCollectingRecord.fromJson(Map<String, dynamic> json) =>
      _$InventoryCollectingRecordFromJson(json);
}

/// WCS 指令动作类型
enum InventoryCollectCommandAction {
  inventoryDown,
  inventoryReset,
  emptyTray,
}

/// WCS 指令请求参数
@freezed
class InventoryCollectCommand with _$InventoryCollectCommand {
  const factory InventoryCollectCommand({
    /// 任务 ID
    @JsonKey(name: 'taskId') required String taskId,

    /// 任务号
    @JsonKey(name: 'taskNo') required String taskNo,

    /// 托盘号
    @JsonKey(name: 'trayNo') required String trayNo,

    /// 起始地址
    @JsonKey(name: 'startAddr') required String startAddr,

    /// 目标地址
    @JsonKey(name: 'endAddr') required String endAddr,

    /// 单托盘标识
    @JsonKey(name: 'singleFlag') @Default('0') String singleFlag,

    /// 指令类型（用于区分调用的接口）
    @JsonKey(name: 'action')
    @Default(InventoryCollectCommandAction.inventoryDown)
    InventoryCollectCommandAction action,
  }) = _InventoryCollectCommand;

  factory InventoryCollectCommand.fromJson(Map<String, dynamic> json) =>
      _$InventoryCollectCommandFromJson(json);
}

/// 采集状态快照，用于本地缓存
@freezed
class InventoryCollectStateSnapshot with _$InventoryCollectStateSnapshot {
  const factory InventoryCollectStateSnapshot({
    /// 任务 ID
    @JsonKey(name: 'taskId') required String taskId,

    /// 盘库单号
    @JsonKey(name: 'taskComment') required String taskComment,

    /// 当前托盘号
    @JsonKey(name: 'activeTrayNo') String? activeTrayNo,

    /// 当前库位
    @JsonKey(name: 'activeStoreSiteNo') String? activeStoreSiteNo,

    /// 最近一次扫描内容
    @JsonKey(name: 'lastScannedCode') String? lastScannedCode,

    /// 采集中任务明细
    @JsonKey(name: 'taskItems')
    @Default(<InventoryTaskItem>[])
    List<InventoryTaskItem> taskItems,

    /// 已采集记录
    @JsonKey(name: 'collectedRecords')
    @Default(<InventoryCollectingRecord>[])
    List<InventoryCollectingRecord> collectedRecords,

    /// 快照更新时间
    @JsonKey(
      name: 'updatedAt',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson,
    )
    DateTime? updatedAt,
  }) = _InventoryCollectStateSnapshot;

  factory InventoryCollectStateSnapshot.fromJson(Map<String, dynamic> json) =>
      _$InventoryCollectStateSnapshotFromJson(json);
}

/// 库位库存信息
@freezed
class InventoryPalletInfo with _$InventoryPalletInfo {
  const factory InventoryPalletInfo({
    /// 托盘号
    @JsonKey(name: 'palletNo') String? palletNo,

    /// 库位编码
    @JsonKey(name: 'storeSite') String? storeSite,

    /// 库房编码
    @JsonKey(name: 'storeRoom') String? storeRoom,

    /// 物料编码
    @JsonKey(name: 'matCode') String? materialCode,

    /// 物料名称
    @JsonKey(name: 'matName') String? materialName,

    /// 库存数量
    @JsonKey(name: 'InventoryQty') @Default(0) double inventoryQty,

    /// ERP 子库
    @JsonKey(name: 'erpStoreRoom') String? erpStoreRoom,

    /// ERP 库位
    @JsonKey(name: 'erpStoreSite') String? erpStoreSite,

    /// 批次号
    @JsonKey(name: 'batchNo') String? batchNo,

    /// 序列号
    @JsonKey(name: 'sn') String? serialNo,
  }) = _InventoryPalletInfo;

  factory InventoryPalletInfo.fromJson(Map<String, dynamic> json) =>
      _$InventoryPalletInfoFromJson(json);
}

/// 物料控制参数
@freezed
class InventoryMatControl with _$InventoryMatControl {
  const factory InventoryMatControl({
    /// 物料编码
    @JsonKey(name: 'matCode') String? materialCode,

    /// 批次管控
    @JsonKey(name: 'batchFlag') @Default(true) bool batchRequired,

    /// 供应商校验
    @JsonKey(name: 'supplierFlag') @Default(true) bool supplierRequired,

    /// 序列号管控
    @JsonKey(name: 'snFlag') @Default(false) bool serialRequired,

    /// 有效期校验
    @JsonKey(name: 'validFlag') @Default(false) bool validityRequired,

    /// 控制标记
    @JsonKey(name: 'matControlFlag') String? controlFlag,
  }) = _InventoryMatControl;

  factory InventoryMatControl.fromJson(Map<String, dynamic> json) =>
      _$InventoryMatControlFromJson(json);
}

/// 拣选口位置
class InventoryPickLocation {
  const InventoryPickLocation({
    this.locationNo,
    this.locationName,
    this.text,
    this.value,
  });

  final String? locationNo;
  final String? locationName;
  final String? text;
  final String? value;

  String? get displayName => locationName ?? text ?? value;

  String? get code => locationNo ?? value ?? text ?? locationName;

  factory InventoryPickLocation.fromJson(Map<String, dynamic> json) {
    return InventoryPickLocation(
      locationNo: json['locationNo'] as String?,
      locationName: json['locationName'] as String?,
      text: json['text'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationNo': locationNo,
      'locationName': locationName,
      'text': text,
      'value': value,
    };
  }
}

/// 库位校验结果
@freezed
class InventorySiteInfo with _$InventorySiteInfo {
  const factory InventorySiteInfo({
    /// 库房编码
    @JsonKey(name: 'storeroomno') String? storeRoomNo,

    /// 库位编码
    @JsonKey(name: 'storesiteno') String? storeSiteNo,

    /// 库位名称
    @JsonKey(name: 'storesite') String? storeSiteName,

    /// 锁定状态（0-正常）
    @JsonKey(name: 'isfrozen') String? frozenFlag,

    /// ERP 库位
    @JsonKey(name: 'erpstoresite') String? erpStoreSite,

    /// 库位属性
    @JsonKey(name: 'siteflag') String? siteFlag,
  }) = _InventorySiteInfo;

  factory InventorySiteInfo.fromJson(Map<String, dynamic> json) =>
      _$InventorySiteInfoFromJson(json);
}

/// 盘点任务明细查询参数
@freezed
class InventoryTaskItemQuery with _$InventoryTaskItemQuery {
  const factory InventoryTaskItemQuery({
    @JsonKey(name: 'taskcomment') required String taskComment,
    @JsonKey(name: 'checktaskno') required String checkTaskNo,
    @JsonKey(name: 'checktaskid') String? checkTaskId,
    @JsonKey(name: 'roomTag') @Default('1') String roomTag,
    @JsonKey(name: 'sortType') String? sortType,
    @JsonKey(name: 'sortColumn') String? sortColumn,
    @JsonKey(name: 'searchKey') String? searchKey,
  }) = _InventoryTaskItemQuery;

  factory InventoryTaskItemQuery.fromJson(Map<String, dynamic> json) =>
      _$InventoryTaskItemQueryFromJson(json);
}
