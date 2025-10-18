// Run `flutter pub run build_runner build --delete-conflicting-outputs`
// after modifying the declarations in this file.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_collection_models.freezed.dart';
part 'transfer_collection_models.g.dart';

/// 采集步骤
///
/// 按照 uni-app 页面逻辑依次扫描：来源库位 -> 目标库位 -> 物料码 -> 数量
enum TransferScanStep { sourceSite, targetSite, material, quantity }

extension TransferScanStepX on TransferScanStep {
  String get label {
    switch (this) {
      case TransferScanStep.sourceSite:
        return '来源库位';
      case TransferScanStep.targetSite:
        return '目标库位';
      case TransferScanStep.material:
        return '物料条码';
      case TransferScanStep.quantity:
        return '数量';
    }
  }
}

/// 移库模式
enum TransferMode { moveOut, moveIn }

extension TransferModeX on TransferMode {
  String get label => this == TransferMode.moveOut ? '移出' : '移入';

  TransferMode toggle() => this == TransferMode.moveOut
      ? TransferMode.moveIn
      : TransferMode.moveOut;
}

/// 扫描上下文状态
@freezed
class TransferScanContext with _$TransferScanContext {
  const factory TransferScanContext({
    @Default(TransferMode.moveOut) TransferMode mode,
    @Default(TransferScanStep.sourceSite) TransferScanStep step,
    @Default('') String storeRoom,
    @Default('') String erpStoreRoom,
    @Default('') String sourceSite,
    @Default('') String targetSite,
    @Default('') String materialCode,
    @Default('') String materialName,
    @Default('') String batchNo,
    @Default('') String serialNo,
    @Default('') String supplier,
    @Default('') String projectNumber,
    double? quantity,
    @Default('请扫描来源库位') String placeholder,
    @Default(true) bool focus,
    @Default(false) bool isFrozenSite,
    TransferInventoryRow? currentInventory,
  }) = _TransferScanContext;

  const TransferScanContext._();

  bool get isReadyForQuantity =>
      sourceSite.isNotEmpty &&
      targetSite.isNotEmpty &&
      materialCode.isNotEmpty;

  bool get isComplete =>
      isReadyForQuantity && (quantity ?? 0) > 0 &&
      (batchNo.isNotEmpty || serialNo.isNotEmpty || supplier.isNotEmpty);

  TransferScanContext resetForNext({
    TransferMode? keepMode,
    String? presetSource,
    String? presetTarget,
  }) {
    final modeToUse = keepMode ?? mode;
    final nextStep = modeToUse == TransferMode.moveOut
        ? TransferScanStep.sourceSite
        : TransferScanStep.targetSite;
    return copyWith(
      mode: modeToUse,
      step: nextStep,
      sourceSite: presetSource ??
          (modeToUse == TransferMode.moveIn ? '${storeRoom}MOVESITE' : ''),
      targetSite: presetTarget ??
          (modeToUse == TransferMode.moveOut ? '${storeRoom}MOVESITE' : ''),
      materialCode: '',
      materialName: '',
      batchNo: '',
      serialNo: '',
      quantity: null,
      supplier: '',
      projectNumber: '',
      placeholder: _buildPlaceholder(
        modeToUse,
        nextStep,
        hasSource: (presetSource ?? '').isNotEmpty,
        hasTarget: (presetTarget ?? '').isNotEmpty,
      ),
      focus: true,
    );
  }

  TransferScanContext updatePlaceholder() {
    final placeholderText = _buildPlaceholder(
      mode,
      step,
      hasSource: sourceSite.isNotEmpty,
      hasTarget: targetSite.isNotEmpty,
      materialReady: materialCode.isNotEmpty,
      hasQuantity: (quantity ?? 0) > 0,
    );
    return copyWith(placeholder: placeholderText, focus: true);
  }

  static String _buildPlaceholder(
    TransferMode mode,
    TransferScanStep step, {
    bool hasSource = false,
    bool hasTarget = false,
    bool materialReady = false,
    bool hasQuantity = false,
  }) {
    switch (step) {
      case TransferScanStep.sourceSite:
        return mode == TransferMode.moveOut || hasTarget
            ? '请扫描来源库位'
            : '请先扫描目标库位';
      case TransferScanStep.targetSite:
        return mode == TransferMode.moveIn || hasSource
            ? '请扫描目标库位'
            : '请先扫描来源库位';
      case TransferScanStep.material:
        return '请扫描物料条码';
      case TransferScanStep.quantity:
        return materialReady && !hasQuantity ? '请输入移库数量' : '请确认数量';
    }
  }
}

/// 采集明细模型
@freezed
class TransferCollectedItem with _$TransferCollectedItem {
  const factory TransferCollectedItem({
    required String id,
    required String sourceSite,
    required String targetSite,
    required String materialCode,
    String? materialName,
    String? batchNo,
    String? serialNo,
    required double quantity,
    String? supplier,
    String? erpRoom,
    String? projectNumber,
    String? ownerCode,
  }) = _TransferCollectedItem;

  factory TransferCollectedItem.fromJson(Map<String, dynamic> json) =>
      _$TransferCollectedItemFromJson(json);

  const TransferCollectedItem._();

  Map<String, dynamic> toSubmitMap() {
    return {
      'outSite': sourceSite,
      'inSite': targetSite,
      'materialCode': materialCode,
      'batchNo': batchNo ?? '',
      'sn': serialNo ?? '',
      'qty': quantity,
      'moveDesc': '',
      'supplier': supplier ?? ownerCode ?? '',
      'erpRoom': erpRoom ?? '',
      'projectNum': projectNumber ?? '',
    };
  }
}

/// 库存查询行
@freezed
class TransferInventoryRow with _$TransferInventoryRow {
  const factory TransferInventoryRow({
    @JsonKey(name: 'storesiteno') required String storeSiteNo,
    @JsonKey(name: 'matcode') required String materialCode,
    @JsonKey(name: 'repqty') @Default(0) double quantity,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'projectNum') String? projectNumber,
    @JsonKey(name: 'erpStoreroom') String? erpStoreRoom,
    @JsonKey(name: 'palletno') String? palletNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'storeroomname') String? storeRoomName,
    @JsonKey(name: 'erpOwnerCode') String? ownerCode,
  }) = _TransferInventoryRow;

  factory TransferInventoryRow.fromJson(Map<String, dynamic> json) =>
      _$TransferInventoryRowFromJson(json);
}

/// 移库提交单条记录
@freezed
class TransferSubmitEntry with _$TransferSubmitEntry {
  const factory TransferSubmitEntry({
    @JsonKey(name: 'outSite') required String outSite,
    @JsonKey(name: 'inSite') required String inSite,
    @JsonKey(name: 'materialCode') required String materialCode,
    @JsonKey(name: 'batchNo') String? batchNo,
    @JsonKey(name: 'sn') String? serialNo,
    @JsonKey(name: 'qty') required double quantity,
    @JsonKey(name: 'moveDesc') @Default('') String moveDesc,
    @JsonKey(name: 'supplier') String? supplier,
    @JsonKey(name: 'erpRoom') String? erpRoom,
    @JsonKey(name: 'projectNum') String? projectNumber,
  }) = _TransferSubmitEntry;

  factory TransferSubmitEntry.fromJson(Map<String, dynamic> json) =>
      _$TransferSubmitEntryFromJson(json);
}

/// 移库提交负载
@freezed
class TransferSubmitPayload with _$TransferSubmitPayload {
  const factory TransferSubmitPayload({
    @JsonKey(name: 'transferInfos') required List<TransferSubmitEntry> entries,
    @JsonKey(name: 'filter') @Default('') String filter,
  }) = _TransferSubmitPayload;

  factory TransferSubmitPayload.fromJson(Map<String, dynamic> json) =>
      _$TransferSubmitPayloadFromJson(json);

  const TransferSubmitPayload._();

}

/// 页面提示信息
@freezed
class TransferUiMessage with _$TransferUiMessage {
  const factory TransferUiMessage({
    required String title,
    required String message,
    @Default(false) bool isError,
  }) = _TransferUiMessage;

  factory TransferUiMessage.fromJson(Map<String, dynamic> json) =>
      _$TransferUiMessageFromJson(json);
}

