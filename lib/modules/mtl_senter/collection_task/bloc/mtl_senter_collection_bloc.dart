import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/page_status.dart';
import '../models/mtl_senter_models.dart';
import '../services/mtl_senter_service.dart';
import 'mtl_senter_collection_event.dart';
import 'mtl_senter_collection_state.dart';

class MtlSenterCollectionBloc
    extends Bloc<MtlSenterCollectionEvent, MtlSenterCollectionState> {
  MtlSenterCollectionBloc({required MtlSenterService service})
      : _service = service,
        super(const MtlSenterCollectionState()) {
    on<MtlSenterCollectionStarted>(_onStarted);
    on<MtlSenterBarcodeScanned>(_onBarcodeScanned);
    on<MtlSenterDeleteSelected>(_onDeleteSelected);
    on<MtlSenterToggleSelection>(_onToggleSelection);
    on<MtlSenterSelectionChanged>(_onSelectionChanged);
    on<MtlSenterSubmitRequested>(_onSubmit);
    on<MtlSenterResetStatus>(_onResetStatus);
    on<MtlSenterClearCurrentInput>(_onClearCurrentInput);
    on<MtlSenterFocusConsumed>(_onFocusConsumed);
  }

  final MtlSenterService _service;
  final Uuid _uuid = const Uuid();

  FutureOr<void> _onStarted(
    MtlSenterCollectionStarted event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    emit(
      state.copyWith(
        task: event.task,
        operatorId: event.operatorId,
        status: CollectionStatus.normal(),
        scanStep: MtlSenterScanStep.location,
        currentLocation: null,
        currentMaterial: null,
        currentQuantity: null,
        availableQty: 0,
        minPackageQty: null,
        defaultDeliveryQty: null,
        stocks: const [],
        selectedIds: const {},
        collectedQtyMap: const {},
        focus: false,
      ),
    );
  }

  FutureOr<void> _onResetStatus(
    MtlSenterResetStatus event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    if (!state.status.isNormal) {
      emit(state.copyWith(status: CollectionStatus.normal()));
    }
  }

  FutureOr<void> _onClearCurrentInput(
    MtlSenterClearCurrentInput event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    emit(
      state.copyWith(
        currentMaterial: null,
        currentQuantity: null,
        availableQty: state.currentLocation != null ? state.availableQty : 0,
        minPackageQty: null,
        defaultDeliveryQty: null,
        scanStep: state.currentLocation != null
            ? MtlSenterScanStep.material
            : MtlSenterScanStep.location,
        focus: state.currentLocation != null,
      ),
    );
  }

  FutureOr<void> _onFocusConsumed(
    MtlSenterFocusConsumed event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    if (state.focus) {
      emit(state.copyWith(focus: false));
    }
  }

  Future<void> _onBarcodeScanned(
    MtlSenterBarcodeScanned event,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    final barcode = event.barcode.trim();
    if (barcode.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集内容为空，请重新采集'),
          focus: state.scanStep == MtlSenterScanStep.quantity,
        ),
      );
      return;
    }

    try {
      final step = _determineStep(barcode);
      if (step == null) {
        throw Exception('采集内容不合法，请确认条码格式');
      }

      switch (step) {
        case MtlSenterScanStep.location:
          await _handleLocationScan(barcode, emit);
          break;
        case MtlSenterScanStep.material:
          await _handleMaterialScan(barcode, emit);
          break;
        case MtlSenterScanStep.quantity:
          await _handleQuantityInput(barcode, emit);
          break;
        case MtlSenterScanStep.idle:
          break;
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(_normalizeErrorMessage(e)),
          focus: state.scanStep == MtlSenterScanStep.quantity,
        ),
      );
    }
  }

  Future<void> _handleLocationScan(
    String barcode,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    final parsed = _parseLocation(barcode);
    if (parsed == null) {
      throw Exception('库位条码识别失败，请重试');
    }

    var availableQty = state.availableQty;
    if (state.currentMaterial != null) {
      availableQty = await _loadInventoryQty(
        location: parsed,
        materialCode: state.currentMaterial!.materialCode,
      );
    }

    emit(
      state.copyWith(
        currentLocation: parsed,
        scanStep: state.currentMaterial == null
            ? MtlSenterScanStep.material
            : MtlSenterScanStep.quantity,
        availableQty: availableQty,
        status: CollectionStatus.normal(),
        focus: state.currentMaterial != null,
      ),
    );
  }

  Future<void> _handleMaterialScan(
    String barcode,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.loading()));

    final material = await _service.fetchMaterialByQr(barcode);

    double availableQty = state.availableQty;
    if (state.currentLocation != null) {
      availableQty = await _loadInventoryQty(
        location: state.currentLocation!,
        materialCode: material.materialCode,
      );
    }

    final qtyInfo = await _service.fetchMtlQty(
      materialCode: material.materialCode,
      siteNo: state.currentLocation,
    );

    emit(
      state.copyWith(
        status: CollectionStatus.normal(),
        currentMaterial: material,
        availableQty: availableQty,
        minPackageQty: qtyInfo?.minPackageQty ?? material.minPackageQty,
        defaultDeliveryQty:
            qtyInfo?.defaultDeliveryQty ?? material.defaultDeliveryQty,
        scanStep: state.currentLocation == null
            ? MtlSenterScanStep.location
            : MtlSenterScanStep.quantity,
        focus: state.currentLocation != null,
      ),
    );
  }

  Future<void> _handleQuantityInput(
    String barcode,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    if (state.currentLocation == null) {
      throw Exception('请先扫描库位');
    }
    if (state.currentMaterial == null) {
      throw Exception('请先扫描物料二维码');
    }

    final qty = double.tryParse(barcode);
    if (qty == null || qty <= 0) {
      throw Exception('数量格式不正确，请输入正数');
    }

    final key = _itemKey(
      materialCode: state.currentMaterial!.materialCode,
      location: state.currentLocation!,
    );

    final aggregated = state.collectedQtyMap[key] ?? 0;
    final newTotal = aggregated + qty;

    if (state.availableQty > 0 && newTotal > state.availableQty + 1e-6) {
      throw Exception('累计数量超过当前库存，请确认');
    }

    final existingItem = state.stocks
        .firstWhereOrNull((item) => _itemKey(
              materialCode: item.materialCode,
              location: item.storeSiteNo,
            ) ==
            key);

    List<MtlSenterCollectItem> updatedStocks;
    if (existingItem != null) {
      updatedStocks = state.stocks
          .map(
            (item) => item.id == existingItem.id
                ? item.copyWith(quantity: item.quantity + qty)
                : item,
          )
          .toList();
    } else {
      final newItem = MtlSenterCollectItem(
        id: _uuid.v4(),
        storeSiteNo: state.currentLocation!,
        storeRoomNo: state.currentMaterial?.storeRoomNo,
        materialCode: state.currentMaterial!.materialCode,
        materialName: state.currentMaterial!.materialName,
        batchNo: state.currentMaterial!.batchNo,
        serialNo: state.currentMaterial!.serialNo,
        quantity: qty,
        availableQty: state.availableQty,
        minPackageQty: state.minPackageQty,
        defaultDeliveryQty: state.defaultDeliveryQty,
      );
      updatedStocks = [...state.stocks, newItem];
    }

    final updatedMap = Map<String, double>.from(state.collectedQtyMap)
      ..[key] = newTotal;

    emit(
      state.copyWith(
        stocks: updatedStocks,
        collectedQtyMap: updatedMap,
        currentMaterial: null,
        currentQuantity: null,
        minPackageQty: null,
        defaultDeliveryQty: null,
        status: CollectionStatus.success('采集已记录'),
        scanStep: MtlSenterScanStep.material,
        focus: true,
      ),
    );
  }

  Future<void> _onDeleteSelected(
    MtlSenterDeleteSelected event,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    if (state.selectedIds.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请至少选择一条记录'),
        ),
      );
      return;
    }

    final updatedStocks =
        state.stocks.where((item) => !state.selectedIds.contains(item.id)).toList();

    final updatedMap = Map<String, double>.from(state.collectedQtyMap);
    for (final item in state.stocks) {
      if (!state.selectedIds.contains(item.id)) continue;
      final key = _itemKey(
        materialCode: item.materialCode,
        location: item.storeSiteNo,
      );
      final current = updatedMap[key] ?? 0;
      final nextValue = current - item.quantity;
      if (nextValue <= 0) {
        updatedMap.remove(key);
      } else {
        updatedMap[key] = nextValue;
      }
    }

    emit(
      state.copyWith(
        stocks: updatedStocks,
        selectedIds: const {},
        collectedQtyMap: updatedMap,
        status: CollectionStatus.success('已删除选中记录'),
      ),
    );
  }

  FutureOr<void> _onToggleSelection(
    MtlSenterToggleSelection event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    final updated = Set<String>.from(state.selectedIds);
    if (updated.contains(event.id)) {
      updated.remove(event.id);
    } else {
      updated.add(event.id);
    }

    emit(state.copyWith(selectedIds: updated));
  }

  FutureOr<void> _onSelectionChanged(
    MtlSenterSelectionChanged event,
    Emitter<MtlSenterCollectionState> emit,
  ) {
    emit(state.copyWith(selectedIds: event.ids));
  }

  Future<void> _onSubmit(
    MtlSenterSubmitRequested event,
    Emitter<MtlSenterCollectionState> emit,
  ) async {
    if (state.stocks.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('本次无采集明细，请确认'),
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final request = MtlSenterSubmitRequest(
        mtlSenderInfos: state.stocks,
        taskNo: state.task?.taskId,
        operatorId: state.operatorId,
      );
      await _service.commitSender(request: request);

      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          stocks: const [],
          selectedIds: const {},
          collectedQtyMap: const {},
          currentMaterial: null,
          currentQuantity: null,
          availableQty: state.currentLocation != null ? state.availableQty : 0,
          minPackageQty: null,
          defaultDeliveryQty: null,
          scanStep: state.currentLocation != null
              ? MtlSenterScanStep.material
              : MtlSenterScanStep.location,
          focus: state.currentLocation != null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(_normalizeErrorMessage(e)),
        ),
      );
    }
  }

  Future<double> _loadInventoryQty({
    required String location,
    required String materialCode,
  }) async {
    final result = await _service.fetchInventoryByLocation(
      storeSite: location,
      materialCode: materialCode,
    );
    return result ?? 0;
  }

  static MtlSenterScanStep? _determineStep(String barcode) {
    final normalized = barcode.trim();
    if (normalized.isEmpty) {
      return null;
    }
    if (_isQuantity(normalized)) {
      return MtlSenterScanStep.quantity;
    }
    if (normalized.contains(r'$KW$')) {
      return MtlSenterScanStep.location;
    }
    if (normalized.toUpperCase().contains('MC')) {
      return MtlSenterScanStep.material;
    }
    return null;
  }

  static bool _isQuantity(String source) {
    final regex = RegExp(r'^[0-9]+([.][0-9]+)?$');
    return regex.hasMatch(source);
  }

  String? _parseLocation(String barcode) {
    final parts = barcode.split(r'$');
    if (parts.length >= 3) {
      return parts[2].trim();
    }
    return null;
  }

  String _itemKey({required String materialCode, required String location}) {
    return '$materialCode@$location';
  }

  String _normalizeErrorMessage(Object error) {
    final text = error.toString();
    return text.replaceFirst('Exception: ', '');
  }
}
