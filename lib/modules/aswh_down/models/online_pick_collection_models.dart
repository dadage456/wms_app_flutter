import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'online_pick_collection_models.freezed.dart';
part 'online_pick_collection_models.g.dart';

/// 拣选采集模式类型。
enum OnlinePickCollectionModeType {
  /// 正常出库采集。
  outbound,

  /// 盘点或库存核对模式。
  inventory,

  /// 异常采集或补录模式。
  exception,
}

/// 拣选采集步骤。
enum OnlinePickCollectionStep {
  location,
  tray,
  material,
  quantity,
  review,
}

/// 扫码解析后的条码信息。
@freezed
@HiveType(typeId: 40)
class OnlinePickBarcodeContent with _$OnlinePickBarcodeContent {
  const OnlinePickBarcodeContent._();

  const factory OnlinePickBarcodeContent({
    @HiveField(0) @JsonKey(name: 'matcode') String? materialCode,
    @HiveField(1) @JsonKey(name: 'matname') String? materialName,
    @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
    @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
    @HiveField(4) @JsonKey(name: 'seqctrl') String? sequenceControl,
    @HiveField(5) @JsonKey(name: 'id_old') String? legacyId,
    @HiveField(6) @JsonKey(name: 'qty') num? quantity,
  }) = _OnlinePickBarcodeContent;

  factory OnlinePickBarcodeContent.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickBarcodeContentFromJson(json);

  bool get isEmpty => (materialCode ?? '').isEmpty;
}

/// 采集产生的库存记录。
@freezed
@HiveType(typeId: 41)
class OnlinePickCollectionStock with _$OnlinePickCollectionStock {
  const factory OnlinePickCollectionStock({
    @HiveField(0) @JsonKey(name: 'stockid') required String stockId,
    @HiveField(1) @JsonKey(name: 'matcode') required String materialCode,
    @HiveField(2) @JsonKey(name: 'batchno') String? batchNo,
    @HiveField(3) @JsonKey(name: 'sn') String? serialNumber,
    @HiveField(4) @JsonKey(name: 'taskQty') @Default(0) num taskQty,
    @HiveField(5) @JsonKey(name: 'collectQty') @Default(0) num collectQty,
    @HiveField(6) @JsonKey(name: 'outtaskitemid') required String outTaskItemId,
    @HiveField(7) @JsonKey(name: 'taskid') required String taskId,
    @HiveField(8) @JsonKey(name: 'storeRoom') String? storeRoom,
    @HiveField(9) @JsonKey(name: 'storeSite') String? storeSite,
    @HiveField(10) @JsonKey(name: 'erpStore') String? erpStore,
    @HiveField(11) @JsonKey(name: 'trayNo') String? trayNo,
  }) = _OnlinePickCollectionStock;

  factory OnlinePickCollectionStock.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickCollectionStockFromJson(json);
}

/// 自动化仓库拣选模式。
@freezed
class OnlinePickCollectionMode with _$OnlinePickCollectionMode {
  const factory OnlinePickCollectionMode({
    required String code,
    required String label,
    @Default(OnlinePickCollectionModeType.outbound)
    OnlinePickCollectionModeType type,
  }) = _OnlinePickCollectionMode;
}

/// WMS/WCS 拣选位置选项。
@freezed
class OnlinePickLocationOption with _$OnlinePickLocationOption {
  const factory OnlinePickLocationOption({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'value') required String value,
  }) = _OnlinePickLocationOption;

  factory OnlinePickLocationOption.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickLocationOptionFromJson(json);
}

@freezed
class OnlinePickCollectionQuery with _$OnlinePickCollectionQuery {
  const factory OnlinePickCollectionQuery({
    @JsonKey(name: 'outtaskno') @Default('') String outTaskNo,
    @JsonKey(name: 'storeroomno') @Default('') String storeRoomNo,
    @JsonKey(name: 'forcesite') @Default('') String forceSite,
    @JsonKey(name: 'forcebatch') @Default('') String forceBatch,
    @JsonKey(name: 'taskcomment') @Default('') String taskComment,
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,
    @JsonKey(name: 'roomtag') @Default('1') String roomTag,
    @JsonKey(name: 'workstation') @Default('') String workStation,
    @JsonKey(name: 'sortType') @Default('') String sortType,
    @JsonKey(name: 'sortColumn') @Default('') String sortColumn,
    @JsonKey(name: 'searchKey') @Default('') String searchKey,
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,
    @JsonKey(name: 'collecter') @Default(0) int collector,
  }) = _OnlinePickCollectionQuery;

  factory OnlinePickCollectionQuery.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickCollectionQueryFromJson(json);
}

extension OnlinePickCollectionQueryX on OnlinePickCollectionQuery {
  Map<String, dynamic> toQueryParameters() => toJson();
}

/// 托盘数量确认信息。
@freezed
class OnlinePickTrayConfirm with _$OnlinePickTrayConfirm {
  const factory OnlinePickTrayConfirm({
    required String trayNo,
    @Default(0) num expectedQuantity,
    @Default(0) num confirmedQuantity,
    @Default('') String operatorId,
    DateTime? confirmedAt,
  }) = _OnlinePickTrayConfirm;

  factory OnlinePickTrayConfirm.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickTrayConfirmFromJson(json);
}

/// 采集缓存快照，用于 Hive 存储与恢复。
@freezed
@HiveType(typeId: 42)
class OnlinePickCollectionCacheSnapshot
    with _$OnlinePickCollectionCacheSnapshot {
  const factory OnlinePickCollectionCacheSnapshot({
    @HiveField(0) @Default(<OnlinePickCollectionStock>[])
    List<OnlinePickCollectionStock> stocks,
    @HiveField(1) @Default(<String, String>{}) Map<String, String> dicSeq,
    @HiveField(2) @Default(<String, List<double>>{})
    Map<String, List<double>> dicMtlQty,
    @HiveField(3) @Default(<String, double>{})
    Map<String, double> dicInvMtlQty,
    @HiveField(4) OnlinePickBarcodeContent? lastBarcode,
    @HiveField(5) @Default('') String location,
    @HiveField(6) @Default('') String trayNo,
    @HiveField(7) @Default(0) int userId,
    @HiveField(8) num? pendingQuantity,
    @HiveField(9) @Default('outbound') String mode,
    @HiveField(10) @Default('') String expectedErpStore,
  }) = _OnlinePickCollectionCacheSnapshot;

  factory OnlinePickCollectionCacheSnapshot.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$OnlinePickCollectionCacheSnapshotFromJson(json);
}
