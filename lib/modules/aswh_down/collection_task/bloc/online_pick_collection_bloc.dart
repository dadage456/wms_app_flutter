import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/services/error_handler.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/custom_extension.dart';
import 'package:meta/meta.dart';

import 'online_pick_collection_event.dart';
import 'online_pick_collection_state.dart';

class OnlinePickCollectionBloc
    extends Bloc<OnlinePickCollectionEvent, OnlinePickCollectionState> {
  OnlinePickCollectionBloc({
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  })  : _collectionService = collectionService,
        _userManager = userManager,
        super(const OnlinePickCollectionState()) {
    on<OnlinePickCollectionInitialized>(_onInitialized);
    on<OnlinePickCollectionScanSubmitted>(_onScanSubmitted);
    on<OnlinePickCollectionStocksSynced>(_onStocksSynced);
    on<OnlinePickCollectionStocksDeleted>(_onStocksDeleted);
    on<OnlinePickCollectionTabChanged>(_onTabChanged);
    on<OnlinePickCollectionStatusResetRequested>(_onStatusResetRequested);
    on<OnlinePickCollectionFocusRequested>(_onFocusRequested);
    on<OnlinePickCollectionInventoryRecorded>(_onInventoryRecorded);
    on<OnlinePickCollectionModeChanged>(_onModeChanged);
    on<OnlinePickCollectionCommitRequested>(_onCommitRequested);
  }

  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;

  final Uuid _uuid = const Uuid();

  OnlinePickTask? _task;
  int _userId = 0;
  Box<OnlinePickCollectionCacheSnapshot>? _cacheBox;
  final Map<String, double> _manualInventoryMap = {};

  Future<void> _onInitialized(
    OnlinePickCollectionInitialized event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    _task = event.task;
    _userId = _userManager.userInfo?.userId ?? 0;

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      await _openCacheBox();
      await _restoreSnapshot(emit);

      final query = OnlinePickCollectionQuery(
        outTaskNo: event.task.outTaskNo,
        storeRoomNo: event.task.storeRoomNo ?? '',
        forceSite: event.task.forceSite ?? '',
        forceBatch: event.task.forceBatch ?? '',
        taskComment: event.task.taskComment ?? '',
        finishFlag: '0',
        roomTag: '1',
        workStation: event.task.workStation ?? '',
        collector: _userId,
      );

      final items = await _collectionService.fetchCollectionTaskItems(
        query: query,
      );

      final collectingItems = items
          .where((item) => (item.collectedQty ?? 0) > 0)
          .toList(growable: false);

      emit(
        state.copyWith(
          status: CollectionStatus.success(),
          taskItems: items,
          collectingItems: collectingItems,
          expectedErpStore:
              state.expectedErpStore ?? event.task.storeRoomNo ?? '',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _openCacheBox() async {
    if (_task == null) return;
    if (_cacheBox != null && _cacheBox!.isOpen) {
      return;
    }
    _cacheBox = await Hive.openBox<OnlinePickCollectionCacheSnapshot>(
      'aswh_down_collect_${_task!.outTaskId}',
    );
  }

  Future<void> _restoreSnapshot(
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final box = _cacheBox;
    if (box == null) return;
    final snapshot = box.get('snapshot');
    if (snapshot == null) return;

    _manualInventoryMap
      ..clear()
      ..addAll(snapshot.dicInvMtlQty);

    final normalizedMaterialMap = _normalizeMaterialQtyMap(
      Map<String, List<double>>.from(snapshot.dicMtlQty),
      snapshot.stocks,
    );

    emit(
      state.copyWith(
        collectedStocks: snapshot.stocks,
        serialMap: Map<String, String>.from(snapshot.dicSeq),
        materialQtyMap: normalizedMaterialMap,
        inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
        barcodeContent: snapshot.lastBarcode,
        pendingQuantity: snapshot.pendingQuantity,
        currentLocation: snapshot.location,
        currentTray: snapshot.trayNo,
        expectedErpStore:
            snapshot.expectedErpStore.isEmpty ? null : snapshot.expectedErpStore,
        currentMode: OnlinePickCollectionMode(
          code: snapshot.mode,
          label: _modeLabelFrom(snapshot.mode),
          type: _modeTypeFrom(snapshot.mode),
        ),
      ),
    );
  }

  String _modeLabelFrom(String mode) {
    switch (mode) {
      case 'inventory':
        return '库存核对';
      case 'exception':
        return '异常处理';
      default:
        return '正常出库';
    }
  }

  OnlinePickCollectionModeType _modeTypeFrom(String mode) {
    switch (mode) {
      case 'inventory':
        return OnlinePickCollectionModeType.inventory;
      case 'exception':
        return OnlinePickCollectionModeType.exception;
      default:
        return OnlinePickCollectionModeType.outbound;
    }
  }

  Future<void> _onScanSubmitted(
    OnlinePickCollectionScanSubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final raw = event.code.trim();
    if (raw.isEmpty) {
      return;
    }

    try {
      switch (_detectCodeType(raw)) {
        case _ScanCodeType.location:
          emit(
            state.copyWith(
              currentLocation: raw,
              currentStep: OnlinePickCollectionStep.tray,
              placeholder: '请扫描托盘',
              isScannerFocused: true,
              status: CollectionStatus.success('库位已选择'),
            ),
          );
          await _persistSnapshot();
          break;
        case _ScanCodeType.tray:
          emit(
            state.copyWith(
              currentTray: raw,
              currentStep: OnlinePickCollectionStep.material,
              placeholder: '请扫描物料二维码',
              isScannerFocused: true,
              status: CollectionStatus.success('托盘已锁定'),
            ),
          );
          await _persistSnapshot();
          break;
        case _ScanCodeType.quantity:
          final quantity = num.tryParse(raw) ?? 0;
          emit(
            state.copyWith(
              pendingQuantity: quantity,
              currentStep: OnlinePickCollectionStep.review,
              placeholder: '请确认并提交',
              isScannerFocused: true,
              status: CollectionStatus.success('数量已录入'),
            ),
          );
          await _finalizeCollection(emit);
          break;
        case _ScanCodeType.material:
          final barcode =
              await _collectionService.getMaterialInfoByQr(raw.trim());
          emit(
            state.copyWith(
              barcodeContent: barcode,
              currentStep: OnlinePickCollectionStep.quantity,
              placeholder: '请录入数量',
              isScannerFocused: true,
              status: CollectionStatus.success('物料已识别'),
            ),
          );
          await _persistSnapshot();
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _finalizeCollection(
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final quantity = state.pendingQuantity;
    final barcode = state.barcodeContent;
    if (quantity == null || quantity <= 0 || barcode == null) {
      return;
    }

    final location = state.currentLocation;
    final tray = state.currentTray;
    final matchedItem = state.taskItems.firstWhere(
      (item) =>
          (item.storeSiteNo ?? '').toUpperCase() == location.toUpperCase() &&
          (item.materialCode ?? '').toUpperCase() ==
              (barcode.materialCode ?? '').toUpperCase(),
      orElse: () => const OnlinePickTaskItem(outTaskItemId: 0, outTaskId: 0),
    );

    final stock = OnlinePickCollectionStock(
      stockId: _uuid.v4(),
      materialCode: barcode.materialCode ?? '',
      batchNo: barcode.batchNo,
      serialNumber: barcode.serialNumber,
      taskQty: matchedItem.taskQty,
      collectQty: quantity,
      outTaskItemId: matchedItem.outTaskItemId.toString(),
      taskId: (_task?.outTaskId ?? 0).toString(),
      storeRoom: matchedItem.storeRoomNo ?? _task?.storeRoomNo,
      storeSite: location.isEmpty ? matchedItem.storeSiteNo : location,
      erpStore: matchedItem.subInventoryCode,
      trayNo: tray.isEmpty ? null : tray,
    );

    final updatedStocks = List<OnlinePickCollectionStock>.from(
      state.collectedStocks,
    )..add(stock);

    final aggregations = _buildAggregations(updatedStocks);

    emit(
      state.copyWith(
        collectedStocks: updatedStocks,
        serialMap: aggregations.serialMap,
        materialQtyMap: aggregations.materialQtyMap,
        inventoryQtyMap: aggregations.inventoryQtyMap,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('采集记录已添加'),
        collectingItems: _deriveCollectingItems(
          updatedStocks,
          state.taskItems,
        ),
        currentStep: OnlinePickCollectionStep.location,
        placeholder: '请扫描库位',
        currentLocation: '',
        currentTray: '',
        clearBarcodeContent: true,
        clearPendingQuantity: true,
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onStocksSynced(
    OnlinePickCollectionStocksSynced event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final stocks = event.payload
        .map((item) => _mapToStock(item))
        .where((element) => element != null)
        .cast<OnlinePickCollectionStock>()
        .toList(growable: false);

    if (stocks.isEmpty) {
      return;
    }

    final updatedStocks = event.shouldReplace
        ? stocks
        : List<OnlinePickCollectionStock>.from(state.collectedStocks)
      ..addAll(stocks);

    final aggregations = _buildAggregations(updatedStocks);

    emit(
      state.copyWith(
        collectedStocks: updatedStocks,
        serialMap: aggregations.serialMap,
        materialQtyMap: aggregations.materialQtyMap,
        inventoryQtyMap: aggregations.inventoryQtyMap,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('采集结果已同步'),
        collectingItems: _deriveCollectingItems(
          updatedStocks,
          state.taskItems,
        ),
        clearBarcodeContent: true,
        clearPendingQuantity: true,
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onStocksDeleted(
    OnlinePickCollectionStocksDeleted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (event.deletedStocks.isEmpty) {
      return;
    }

    final ids = event.deletedStocks.map((e) => e.stockId).toSet();
    final updatedStocks = state.collectedStocks
        .where((stock) => !ids.contains(stock.stockId))
        .toList(growable: false);

    final aggregations = _buildAggregations(updatedStocks);

    emit(
      state.copyWith(
        collectedStocks: updatedStocks,
        serialMap: aggregations.serialMap,
        materialQtyMap: aggregations.materialQtyMap,
        inventoryQtyMap: aggregations.inventoryQtyMap,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('已删除选中记录'),
        collectingItems: _deriveCollectingItems(
          updatedStocks,
          state.taskItems,
        ),
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onInventoryRecorded(
    OnlinePickCollectionInventoryRecorded event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final key = _inventoryKeyFromComponents(
      storeSite: event.storeSite,
      materialCode: event.materialCode,
      batchNo: event.batchNo,
      trayNo: event.trayNo,
    );

    _manualInventoryMap[key] = event.quantity.toDouble();

    emit(
      state.copyWith(
        inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
        status: CollectionStatus.success('库存核对已更新'),
      ),
    );

    await _persistSnapshot();
  }

  void _onTabChanged(
    OnlinePickCollectionTabChanged event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onModeChanged(
    OnlinePickCollectionModeChanged event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(
      state.copyWith(
        currentMode: event.mode,
        placeholder: _placeholderForMode(event.mode),
        status: CollectionStatus.success('已切换至${event.mode.label}'),
      ),
    );
  }

  String _placeholderForMode(OnlinePickCollectionMode mode) {
    switch (mode.type) {
      case OnlinePickCollectionModeType.inventory:
        return '请输入该物料在当前库位的结余数量';
      case OnlinePickCollectionModeType.exception:
        return '请扫描异常处理条码';
      case OnlinePickCollectionModeType.outbound:
      default:
        return '请扫描库位';
    }
  }

  void _onStatusResetRequested(
    OnlinePickCollectionStatusResetRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  void _onFocusRequested(
    OnlinePickCollectionFocusRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(isScannerFocused: event.focused));
  }

  Future<void> _onCommitRequested(
    OnlinePickCollectionCommitRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (_task == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('缺少任务上下文，无法提交'),
        ),
      );
      return;
    }

    if (state.collectedStocks.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('本次无采集明细，请确认！'),
        ),
      );
      return;
    }

    final requiredInventoryKeys = state.collectedStocks
        .map(_inventoryKeyForStock)
        .whereType<String>()
        .toSet();

    if (requiredInventoryKeys.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('未识别到库存核对目标，请检查采集数据'),
        ),
      );
      return;
    }

    final missingInventoryKeys = requiredInventoryKeys
        .where((key) => !_manualInventoryMap.containsKey(key))
        .toList(growable: false);
    if (missingInventoryKeys.isNotEmpty) {
      final firstMissing = _splitInventoryKey(missingInventoryKeys.first);
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '库位【${firstMissing['storeSite']}】物料【${firstMissing['materialCode']}】未录入结余数量',
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final downShelvesInfos = state.collectedStocks.map((stock) {
        return {
          'taskNo': _task!.outTaskNo,
          'matCode': stock.materialCode,
          'batchNo': stock.batchNo ?? '',
          'sn': stock.serialNumber ?? '',
          'taskQty': stock.taskQty.toFormatString(),
          'collectQty': stock.collectQty.toFormatString(),
          'storeRoomNo': stock.storeRoom ?? '',
          'storeSiteNo': stock.storeSite ?? '',
          'taskid': stock.taskId,
          'outTaskItemid': stock.outTaskItemId,
          'erpStore': stock.erpStore ?? '',
          'trayNo': stock.trayNo ?? '',
        };
      }).toList(growable: false);

      final normalizedMaterialMap =
          _normalizeMaterialQtyMap(state.materialQtyMap, state.collectedStocks);

      final itemListInfos = normalizedMaterialMap.entries.map((entry) {
        final taskItem = state.taskItems.firstWhere(
          (item) => item.outTaskItemId.toString() == entry.key,
          orElse: () => const OnlinePickTaskItem(
            outTaskItemId: 0,
            outTaskId: 0,
          ),
        );

        return {
          'mtlQty': entry.value.map((e) => e.toFormatString()).toList(),
          'outTaskItemid': entry.key,
          'mtlCode': taskItem.materialCode ?? '',
        };
      }).toList(growable: false);

      if (itemListInfos.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('本次无采集明细，请确认！'),
          ),
        );
        return;
      }

      final inventoryCheckInfos = _manualInventoryMap.entries.map((entry) {
        final segments = _splitInventoryKey(entry.key);
        return {
          'matCode': segments['materialCode'],
          'storeSite': segments['storeSite'],
          'trayNo': segments['trayNo'],
          'batchNo': segments['batchNo'],
          'quantity': entry.value.toFormatString(),
        };
      }).toList(growable: false);

      final response = await _collectionService.commitAswhDownShelves(
        downShelvesInfos: downShelvesInfos,
        itemListInfos: itemListInfos,
        inventoryCheckInfos: inventoryCheckInfos,
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message = response['msg']?.toString() ??
          (success ? '提交成功' : '提交失败');

      if (success) {
        await _clearSnapshot();
        emit(
          state.copyWith(
            status: CollectionStatus.success(message),
            collectedStocks: const [],
            serialMap: const {},
            materialQtyMap: const {},
            inventoryQtyMap: const {},
            collectingItems: const [],
            currentLocation: '',
            currentTray: '',
            expectedErpStore: null,
            clearBarcodeContent: true,
            clearPendingQuantity: true,
            placeholder: '请扫描库位',
            currentStep: OnlinePickCollectionStep.location,
          ),
        );
      } else {
        emit(state.copyWith(status: CollectionStatus.error(message)));
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  _AggregationsResult _buildAggregations(
    List<OnlinePickCollectionStock> stocks,
  ) {
    final serialMap = <String, String>{};
    final materialQtyMap = <String, List<double>>{};
    final remainingInventoryKeys = <String>{};
    String? expectedErpStore;

    for (final stock in stocks) {
      final serialKey =
          '${stock.materialCode}@${stock.serialNumber ?? ''}'.trim();
      if (stock.serialNumber != null && stock.serialNumber!.isNotEmpty) {
        serialMap[serialKey] = stock.stockId;
      }

      final materialKey = stock.outTaskItemId;
      final materialEntry = materialQtyMap[materialKey];
      final plannedQty = max(
        (materialEntry?.first ?? 0.0),
        stock.taskQty.toDouble(),
      );
      final collectedTotal =
          (materialEntry == null ? 0.0 : materialEntry.last) +
              stock.collectQty.toDouble();
      materialQtyMap[materialKey] = [plannedQty, collectedTotal];

      final inventoryKey = _inventoryKeyForStock(stock);
      if (inventoryKey != null) {
        remainingInventoryKeys.add(inventoryKey);
      }

      expectedErpStore ??= stock.erpStore;
    }

    _manualInventoryMap.removeWhere(
      (key, _) => !remainingInventoryKeys.contains(key),
    );

    return _AggregationsResult(
      serialMap: serialMap,
      materialQtyMap: materialQtyMap,
      inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
      expectedErpStore: expectedErpStore,
    );
  }

  String? _inventoryKeyForStock(OnlinePickCollectionStock stock) {
    final site = stock.storeSite ?? '';
    final material = stock.materialCode;
    if (site.isEmpty || material.isEmpty) {
      return null;
    }
    final batch = stock.batchNo ?? '';
    final tray = stock.trayNo ?? '';
    return _inventoryKeyFromComponents(
      storeSite: site,
      materialCode: material,
      batchNo: batch,
      trayNo: tray,
    );
  }

  String _inventoryKeyFromComponents({
    required String storeSite,
    required String materialCode,
    String? batchNo,
    String? trayNo,
  }) {
    return '${storeSite.toUpperCase()}|${materialCode.toUpperCase()}|${(batchNo ?? '').toUpperCase()}|${(trayNo ?? '').toUpperCase()}';
  }

  Map<String, String> _splitInventoryKey(String key) {
    final segments = key.split('|');
    return {
      'storeSite': segments.isNotEmpty ? segments[0] : '',
      'materialCode': segments.length > 1 ? segments[1] : '',
      'batchNo': segments.length > 2 ? segments[2] : '',
      'trayNo': segments.length > 3 ? segments[3] : '',
    };
  }

  Map<String, List<double>> _normalizeMaterialQtyMap(
    Map<String, List<double>> rawMap,
    List<OnlinePickCollectionStock> stocks,
  ) {
    final hasLegacyKey = rawMap.keys.any((key) => key.contains('|'));
    if (!hasLegacyKey) {
      return rawMap;
    }

    final normalized = <String, List<double>>{};
    for (final stock in stocks) {
      final legacyKey =
          '${stock.materialCode}|${stock.batchNo ?? ''}|${stock.storeSite ?? ''}|${stock.trayNo ?? ''}';
      final values = rawMap[legacyKey];
      if (values == null) {
        continue;
      }

      final existing = normalized[stock.outTaskItemId];
      final plannedQty = max(existing?.first ?? 0.0, values.first);
      final collectedTotal =
          (existing == null ? 0.0 : existing.last) + values.last;
      normalized[stock.outTaskItemId] = [plannedQty, collectedTotal];
    }

    return normalized.isEmpty ? rawMap : normalized;
  }

  List<OnlinePickTaskItem> _deriveCollectingItems(
    List<OnlinePickCollectionStock> stocks,
    List<OnlinePickTaskItem> taskItems,
  ) {
    if (stocks.isEmpty) {
      return const [];
    }
    final ids = stocks
        .map((stock) => int.tryParse(stock.outTaskItemId))
        .whereType<int>()
        .toSet();
    if (ids.isEmpty) {
      return const [];
    }
    return taskItems
        .where((item) => ids.contains(item.outTaskItemId))
        .toList(growable: false);
  }

  OnlinePickCollectionStock? _mapToStock(dynamic item) {
    if (item is OnlinePickCollectionStock) {
      return item;
    }
    if (item is Map<String, dynamic>) {
      return OnlinePickCollectionStock.fromJson(item);
    }
    if (item is Map) {
      return OnlinePickCollectionStock.fromJson(
        Map<String, dynamic>.from(item as Map),
      );
    }
    return null;
  }

  _ScanCodeType _detectCodeType(String code) {
    if (code.contains(r'$KW$')) {
      return _ScanCodeType.location;
    }
    if (code.contains(r'$TP$')) {
      return _ScanCodeType.tray;
    }
    if (RegExp('^[0-9]+(\.[0-9]+)?\$').hasMatch(code)) {
      return _ScanCodeType.quantity;
    }
    return _ScanCodeType.material;
  }

  Future<void> _persistSnapshot() async {
    final box = _cacheBox;
    if (box == null) return;

    final snapshot = OnlinePickCollectionCacheSnapshot(
      stocks: state.collectedStocks,
      dicSeq: state.serialMap,
      dicMtlQty: state.materialQtyMap,
      dicInvMtlQty: state.inventoryQtyMap,
      lastBarcode: state.barcodeContent,
      location: state.currentLocation,
      trayNo: state.currentTray,
      userId: _userId,
      pendingQuantity: state.pendingQuantity,
      mode: state.currentMode.type.name,
      expectedErpStore: state.expectedErpStore ?? '',
    );

    await box.put('snapshot', snapshot);
  }

  @visibleForTesting
  void seedForTest({
    OnlinePickTask? task,
    int? userId,
    List<OnlinePickCollectionStock>? stocks,
    Map<String, double>? inventoryMap,
    Map<String, List<double>>? materialQtyMap,
    List<OnlinePickTaskItem>? taskItems,
  }) {
    if (task != null) {
      _task = task;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (inventoryMap != null) {
      _manualInventoryMap
        ..clear()
        ..addAll(
          inventoryMap.map(
            (key, value) => MapEntry(key.toUpperCase(), value.toDouble()),
          ),
        );
    }

    final effectiveTaskItems = taskItems ?? state.taskItems;

    if (stocks != null) {
      final aggregations = _buildAggregations(stocks);
      emit(
        state.copyWith(
          collectedStocks: stocks,
          serialMap: aggregations.serialMap,
          materialQtyMap: materialQtyMap ?? aggregations.materialQtyMap,
          inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
          collectingItems: _deriveCollectingItems(
            stocks,
            effectiveTaskItems,
          ),
          taskItems: taskItems ?? state.taskItems,
        ),
      );
    } else if (materialQtyMap != null) {
      emit(
        state.copyWith(
          materialQtyMap: materialQtyMap,
          inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
          taskItems: taskItems ?? state.taskItems,
        ),
      );
    } else if (taskItems != null) {
      emit(state.copyWith(taskItems: taskItems));
    }
  }

  Future<void> _clearSnapshot() async {
    _manualInventoryMap.clear();
    final box = _cacheBox;
    if (box != null) {
      await box.delete('snapshot');
    }
  }

  @override
  Future<void> close() async {
    await _cacheBox?.close();
    return super.close();
  }
}

class _AggregationsResult {
  const _AggregationsResult({
    required this.serialMap,
    required this.materialQtyMap,
    required this.inventoryQtyMap,
    this.expectedErpStore,
  });

  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final String? expectedErpStore;
}

enum _ScanCodeType { location, tray, material, quantity }
