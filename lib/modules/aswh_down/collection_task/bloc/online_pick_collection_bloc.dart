import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../services/aswh_down_collection_service.dart';
import '../../services/aswh_down_task_service.dart';
import 'online_pick_collection_event.dart';
import 'online_pick_collection_state.dart';

class OnlinePickCollectionBloc
    extends Bloc<OnlinePickCollectionEvent, OnlinePickCollectionState> {
  OnlinePickCollectionBloc({
    required AswhDownTaskService taskService,
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  })  :
        // ignore: unused_field
        _taskService = taskService,
        _collectionService = collectionService,
        _userManager = userManager,
        super(const OnlinePickCollectionState()) {
    on<OnlinePickCollectionStarted>(_onStarted);
    on<OnlinePickCollectionSubmitPressed>(_onSubmit);
    on<OnlinePickCollectionScanSubmitted>(_onScanSubmitted);
    on<OnlinePickCollectionStepResetRequested>(_onStepReset);
    on<OnlinePickCollectionLocationSelected>(_onLocationSelected);
    on<OnlinePickCollectionCacheCleared>(_onCacheCleared);
    on<OnlinePickCollectionModeChanged>(_onModeChanged);
    on<OnlinePickCollectionCommandSubmitted>(_onCommandSubmitted);
    on<OnlinePickCollectionReloadRequested>(_onReloadRequested);
    on<OnlinePickCollectionStocksSynced>(_onStocksSynced);
  }

  // ignore: unused_field
  final AswhDownTaskService _taskService;
  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;

  Box<dynamic>? _cacheBox;
  int? _collectorId;

  Future<void> _onStarted(
    OnlinePickCollectionStarted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    emit(_withStepInfo(
      state.copyWith(status: CollectionStatus.loading(), currentStepLabel: '初始化'),
    ));

    try {
      final payload = event.payload;
      final task = payload['task'];
      if (task is! OnlinePickTask) {
        throw Exception('缺少在线拣选任务数据');
      }

      _collectorId = _userManager.userInfo?.userId;
      await _openCacheBox(task);

      final locationType = _resolveLocationType(payload);
      final locationOptions = await _collectionService.fetchInOutLocations(
        locationType: locationType,
      );

      final initialLocation = payload['storeSite'] as String? ??
          payload['storesiteno'] as String?;
      final initialTray = payload['trayNo'] as String?;
      final initialMode = _resolveInitialMode(payload);
      final expectedErpStore = (payload['subinventoryCode'] ??
              payload['erpStore'] ??
              payload['expectedErpStore'])
          ?.toString()
          .trim();
      final finishFlag = (payload['finshFlg'] ??
              payload['finishFlag'] ??
              task.finishFlag ??
              '0')
          .toString();

      final collectionQuery = OnlinePickCollectionQuery(
        outTaskNo: task.outTaskNo,
        storeRoomNo: task.storeRoomNo ?? '',
        forceSite: task.forceSite ?? '',
        forceBatch: task.forceBatch ?? '',
        taskComment: task.taskComment ?? '',
        workStation: task.workStation ?? '',
        finishFlag: finishFlag,
        collector: _collectorId ?? 0,
      );

      final taskItems = await _collectionService.fetchCollectionTaskItems(
        query: collectionQuery,
      );

      final roomControlRaw =
          await _collectionService.getRoomMatControl(task.outTaskId.toString());
      final roomControl = _parseRoomMatControl(roomControlRaw);

      final baseCollected = _baselineCollectedMap(taskItems);
      final inventoryRecords = _buildInventoryRecords(taskItems, baseCollected);

      var nextState = state.copyWith(
        status: CollectionStatus.normal(),
        task: task,
        locationOptions: locationOptions,
        currentLocation: initialLocation,
        currentTrayNo: initialTray,
        currentMode: initialMode,
        expectedErpStore: expectedErpStore?.isNotEmpty == true
            ? expectedErpStore
            : state.expectedErpStore,
        taskItems: taskItems,
        collectedQtyByItemId: baseCollected,
        inventoryRecords: inventoryRecords,
        roomMatControl: roomControl.roomMatControl,
        forceSiteCheck:
            roomControl.forceSite ?? _isAffirmative(task.forceSite),
        forceBatchCheck:
            roomControl.forceBatch ?? _isAffirmative(task.forceBatch),
      );

      if ((roomControl.expectedErpStore?.isNotEmpty ?? false) &&
          (nextState.expectedErpStore.isEmpty ||
              !_equalsIgnoreCase(
                roomControl.expectedErpStore!,
                nextState.expectedErpStore,
              ))) {
        nextState = nextState.copyWith(
          expectedErpStore: roomControl.expectedErpStore,
        );
      }

      final restoredState = await _restoreCache(nextState);

      String successMessage;
      if (restoredState != null) {
        nextState = restoredState;
        successMessage = '已恢复上次采集进度';
      } else {
        successMessage = _collectorId != null
            ? '任务初始化成功（操作员 $_collectorId）'
            : '任务初始化成功';
      }

      final finalState = _withStepInfo(
        nextState,
        successMessage: successMessage,
        requestFocus: true,
      );
      emit(finalState);
      await _persistCache(finalState);
    } catch (e) {
      emit(
        _withStepInfo(
          state.copyWith(status: CollectionStatus.normal()),
          errorMessage: ErrorHandler.handleError(e),
        ),
      );
    }
  }

  Future<void> _openCacheBox(OnlinePickTask task) async {
    final boxName = 'aswh_down_collect_${task.outTaskId}';
    if (Hive.isBoxOpen(boxName)) {
      _cacheBox = Hive.box<dynamic>(boxName);
    } else {
      _cacheBox = await Hive.openBox<dynamic>(boxName);
    }
  }

  Future<OnlinePickCollectionState?> _restoreCache(
    OnlinePickCollectionState seed,
  ) async {
    if (_cacheBox == null) return null;
    final raw = _cacheBox!.get('snapshot');
    if (raw is! Map) return null;

    try {
      final snapshot = OnlinePickCollectionCacheSnapshot.fromJson(
        Map<String, dynamic>.from(raw),
      );

      final restored = seed.copyWith(
        collectedStocks: snapshot.stocks,
        serialMap: Map<String, String>.from(snapshot.dicSeq),
        materialQtyMap: Map<String, List<double>>.from(snapshot.dicMtlQty),
        inventoryQtyMap: Map<String, double>.from(snapshot.dicInvMtlQty),
        barcodeContent: snapshot.lastBarcode,
        pendingQuantity: snapshot.pendingQuantity,
        currentLocation: snapshot.location.isEmpty
            ? seed.currentLocation
            : snapshot.location,
        currentTrayNo: snapshot.trayNo.isEmpty
            ? seed.currentTrayNo
            : snapshot.trayNo,
        expectedErpStore: snapshot.expectedErpStore.isEmpty
            ? seed.expectedErpStore
            : snapshot.expectedErpStore,
        currentMode: _modeFromString(snapshot.mode),
      );
      return _syncProgressFromStocks(restored);
    } catch (_) {
      return null;
    }
  }

  Future<void> _persistCache(
    OnlinePickCollectionState snapshotState,
  ) async {
    if (_cacheBox == null) return;

    try {
      final snapshot = OnlinePickCollectionCacheSnapshot(
        stocks: snapshotState.collectedStocks,
        dicSeq: snapshotState.serialMap,
        dicMtlQty: snapshotState.materialQtyMap,
        dicInvMtlQty: snapshotState.inventoryQtyMap,
        lastBarcode: snapshotState.barcodeContent,
        location: snapshotState.currentLocation ?? '',
        trayNo: snapshotState.currentTrayNo ?? '',
        userId: _collectorId ?? 0,
        pendingQuantity: snapshotState.pendingQuantity,
        mode: snapshotState.currentMode.name,
        expectedErpStore: snapshotState.expectedErpStore,
      );
      await _cacheBox!.put('snapshot', snapshot.toJson());
    } catch (_) {
      // ignore cache persistence errors
    }
  }

  Future<void> _onSubmit(
    OnlinePickCollectionSubmitPressed event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final loadingState = _withStepInfo(
      state.copyWith(status: CollectionStatus.loading()),
    );
    emit(loadingState);

    final successState = _withStepInfo(
      loadingState.copyWith(status: CollectionStatus.normal()),
      successMessage: '采集数据已提交',
    );
    emit(successState);
    await _persistCache(successState);
  }

  Future<void> _onScanSubmitted(
    OnlinePickCollectionScanSubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final input = event.content.trim();
    if (input.isEmpty) {
      emit(
        _withStepInfo(
          state,
          errorMessage: '采集内容为空，请重新扫描',
          requestFocus: true,
        ),
      );
      return;
    }

    try {
      final scanResult = OnlinePickScannerParser.parse(input);
      switch (scanResult.type) {
        case OnlinePickScanType.location:
          await _handleLocationScan(scanResult, emit);
          break;
        case OnlinePickScanType.tray:
          await _handleTrayScan(scanResult, emit);
          break;
        case OnlinePickScanType.material:
          await _handleMaterialScan(scanResult, emit);
          break;
        case OnlinePickScanType.quantity:
          await _handleQuantityScan(scanResult, emit);
          break;
      }
    } on FormatException catch (e) {
      emit(
        _withStepInfo(
          state,
          errorMessage: e.message,
          requestFocus: true,
        ),
      );
    } catch (e) {
      emit(
        _withStepInfo(
          state,
          errorMessage: ErrorHandler.handleError(e),
          requestFocus: true,
        ),
      );
    }
  }

  Future<void> _handleLocationScan(
    OnlinePickScanResult scanResult,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final location = scanResult.normalizedValue;
    final nextState = state.copyWith(
      status: CollectionStatus.normal(),
      currentLocation: location.isEmpty ? null : location,
    );

    final updatedState = _withStepInfo(
      nextState,
      successMessage:
          location.isNotEmpty ? '库位 $location 已确认' : '库位已清空',
      requestFocus: true,
    );
    emit(updatedState);
    await _persistCache(updatedState);
  }

  Future<void> _handleTrayScan(
    OnlinePickScanResult scanResult,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final trayNo = scanResult.normalizedValue;
    final nextState = state.copyWith(
      status: CollectionStatus.normal(),
      currentTrayNo: trayNo.isEmpty ? null : trayNo,
    );

    final updatedState = _withStepInfo(
      nextState,
      successMessage: trayNo.isNotEmpty ? '托盘 $trayNo 已确认' : '托盘已清空',
      requestFocus: true,
    );
    emit(updatedState);
    await _persistCache(updatedState);
  }

  Future<void> _handleMaterialScan(
    OnlinePickScanResult scanResult,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final loadingState = state.copyWith(status: CollectionStatus.loading());
    emit(loadingState);

    try {
      _ensureLocationAndTray();

      final barcodeInfo =
          await _collectionService.getMaterialInfoByQr(scanResult.rawValue);

      final serialKey = _serialKeyFor(barcodeInfo);
      if (serialKey != null && state.serialMap.containsKey(serialKey)) {
        throw FormatException(
          '物料 ${barcodeInfo.materialCode ?? ''} 序列号 ${barcodeInfo.serialNumber ?? ''} 已采集，请勿重复扫描',
        );
      }

      final materialControl =
          await _loadMaterialControl(barcodeInfo) ?? _parseMaterialControl('',
              int.tryParse(barcodeInfo.sequenceControl ?? ''));

      final location = state.currentLocation ?? '';
      final trayNo = state.currentTrayNo ?? '';
      final matches =
          _findMatchingTaskItems(barcodeInfo, location, trayNo, materialControl);

      if (matches.isEmpty && state.forceSiteCheck) {
        throw FormatException(
          '当前库位【$location】未找到物料【${barcodeInfo.materialCode ?? ''}】任务明细，请核对',
        );
      }

      final updatedControlMap =
          Map<String, OnlinePickMaterialControl>.from(state.materialControls);
      final materialCode = barcodeInfo.materialCode?.trim();
      if (materialCode != null && materialCode.isNotEmpty) {
        updatedControlMap[materialCode] = materialControl;
      }

      var effectiveErpStore = state.expectedErpStore;
      if (effectiveErpStore.isEmpty && matches.isNotEmpty) {
        final candidate = matches.first.subInventoryCode;
        if (candidate != null && candidate.isNotEmpty) {
          effectiveErpStore = candidate;
        }
      }

      final nextState = loadingState.copyWith(
        status: CollectionStatus.normal(),
        barcodeContent: barcodeInfo,
        pendingQuantity: null,
        materialControls: updatedControlMap,
        currentMaterialControl: materialControl,
        expectedErpStore: effectiveErpStore,
      );

      final updatedState = _withStepInfo(
        nextState,
        successMessage:
            '物料 ${barcodeInfo.materialCode ?? ''} 已解析，请继续扫描数量',
        requestFocus: true,
      );
      emit(updatedState);
      await _persistCache(updatedState);
    } catch (e) {
      final errorState = _withStepInfo(
        loadingState.copyWith(status: CollectionStatus.normal()),
        errorMessage: ErrorHandler.handleError(e),
        requestFocus: true,
      );
      emit(errorState);
    }
  }

  Future<void> _handleQuantityScan(
    OnlinePickScanResult scanResult,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final qty = scanResult.quantity;
    if (qty == null || qty <= 0) {
      throw FormatException('采集数量必须大于0');
    }

    final barcode = state.barcodeContent;
    if (barcode == null || (barcode.materialCode ?? '').isEmpty) {
      throw FormatException('请先扫描物料二维码');
    }

    _ensureLocationAndTray();

    final storeSite = state.currentLocation ?? '';
    final trayNo = state.currentTrayNo ?? '';
    final materialControl = state.currentMaterialControl ??
        _parseMaterialControl('', int.tryParse(barcode.sequenceControl ?? ''));

    if (materialControl.isSerialControl && qty != 1) {
      throw const FormatException('序列号物料采集数量必须为1');
    }

    if (materialControl.isBatchControl &&
        ((barcode.batchNo ?? barcode.serialNumber)?.isEmpty ?? true)) {
      throw const FormatException('批次物料必须提供批次或序列信息');
    }

    final matches =
        _findMatchingTaskItems(barcode, storeSite, trayNo, materialControl);
    if (matches.isEmpty) {
      throw FormatException(
        '未找到物料【${barcode.materialCode ?? ''}】对应的任务明细，请确认',
      );
    }

    final allocationResult = _allocateQuantityToItems(
      requestedQty: qty.toDouble(),
      items: matches,
      currentMap: state.collectedQtyByItemId,
    );

    if (allocationResult.allocations.isEmpty) {
      throw const FormatException('当前任务明细已完成，无需继续采集');
    }

    if (allocationResult.remaining > 1e-6) {
      throw FormatException('采集数量超过任务需求，剩余 ${allocationResult.remaining}');
    }

    final inventoryResult = await _fetchAvailableQuantity(
      barcode: barcode,
      storeSite: storeSite,
    );
    final availableQty = inventoryResult.availableQty;

    final inventoryKey = _inventoryKey(barcode, storeSite);
    final usedQty = state.inventoryQtyMap[inventoryKey] ?? 0;
    if (availableQty != null && usedQty + qty > availableQty + 1e-6) {
      throw FormatException(
        '库位【$storeSite】物料【${barcode.materialCode ?? ''}】库存不足，剩余 ${availableQty - usedQty}',
      );
    }

    final erpStore = inventoryResult.erpStore;
    if (erpStore != null && erpStore.isNotEmpty) {
      if (state.expectedErpStore.isNotEmpty &&
          !_equalsIgnoreCase(erpStore, state.expectedErpStore)) {
        throw FormatException(
          '当前物料子库【$erpStore】与任务要求【${state.expectedErpStore}】不一致，请确认',
        );
      }
    }

    final serialKey = _serialKeyFor(barcode);
    final newSerialMap = Map<String, String>.from(state.serialMap);
    if (serialKey != null) {
      if (newSerialMap.containsKey(serialKey)) {
        throw FormatException(
          '物料 ${barcode.materialCode ?? ''} 序列号 ${barcode.serialNumber ?? ''} 已采集，请勿重复扫描',
        );
      }
      newSerialMap[serialKey] = serialKey;
    }

    final newInventoryQtyMap = Map<String, double>.from(state.inventoryQtyMap);
    newInventoryQtyMap[inventoryKey] = usedQty + qty.toDouble();

    final newMaterialQtyMap = Map<String, List<double>>.from(
      state.materialQtyMap,
    );
    final newStocks = List<OnlinePickCollectionStock>.from(
      state.collectedStocks,
    );

    for (final allocation in allocationResult.allocations) {
      final item = allocation.item;
      final stockKey = _stockKeyForItem(item, barcode, storeSite, trayNo);
      final currentPair = newMaterialQtyMap[stockKey] ?? <double>[];
      final double previous = currentPair.length > 1
          ? currentPair[1]
          : currentPair.isNotEmpty
              ? currentPair[0]
              : 0.0;
      final double updatedQuantity = previous + allocation.quantity;
      newMaterialQtyMap[stockKey] = <double>[previous, updatedQuantity];

      final erpCandidate =
          erpStore ?? item.subInventoryCode ?? state.expectedErpStore;
      final existingIndex = newStocks.indexWhere(
        (stock) => stock.stockId == stockKey,
      );
      if (existingIndex >= 0) {
        final existing = newStocks[existingIndex];
        newStocks[existingIndex] = existing.copyWith(
          collectQty: existing.collectQty + allocation.quantity,
          erpStore: erpCandidate ?? existing.erpStore,
        );
      } else {
        newStocks.add(
          OnlinePickCollectionStock(
            stockId: stockKey,
            materialCode: barcode.materialCode ?? '',
            batchNo: barcode.batchNo,
            serialNumber: barcode.serialNumber,
            collectQty: allocation.quantity,
            taskQty: item.taskQty,
            outTaskItemId: item.outTaskItemId.toString(),
            taskId: state.task?.outTaskId.toString() ?? '',
            storeRoom: state.task?.storeRoomNo,
            storeSite: storeSite,
            trayNo: trayNo,
            erpStore: erpCandidate,
          ),
        );
      }
    }

    final updatedTaskItems = state.taskItems
        .map((item) {
          final key = item.outTaskItemId.toString();
          final collected =
              allocationResult.collectedQtyByItemId[key] ?? item.collectedQty;
          return item.copyWith(collectedQty: collected);
        })
        .toList();

    final newInventoryRecords = _buildInventoryRecords(
      updatedTaskItems,
      allocationResult.collectedQtyByItemId,
    );

    final effectiveErpStore = state.expectedErpStore.isEmpty &&
            (erpStore?.isNotEmpty ?? false)
        ? erpStore!
        : state.expectedErpStore;

    final nextState = state.copyWith(
      status: CollectionStatus.normal(),
      pendingQuantity: null,
      barcodeContent: null,
      collectedStocks: newStocks,
      serialMap: newSerialMap,
      materialQtyMap: newMaterialQtyMap,
      inventoryQtyMap: newInventoryQtyMap,
      expectedErpStore: effectiveErpStore,
      collectedQtyByItemId: allocationResult.collectedQtyByItemId,
      taskItems: updatedTaskItems,
      inventoryRecords: newInventoryRecords,
    );

    final updatedState = _withStepInfo(
      nextState,
      successMessage: '数量 $qty 已录入',
      requestFocus: true,
    );
    emit(updatedState);
    await _persistCache(updatedState);
  }

  Future<void> _onStepReset(
    OnlinePickCollectionStepResetRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final resetState = state.copyWith(
      status: CollectionStatus.normal(),
      currentLocation: null,
      currentTrayNo: null,
      barcodeContent: null,
      pendingQuantity: null,
      collectedStocks: const [],
      serialMap: const {},
      materialQtyMap: const {},
      inventoryQtyMap: const {},
    );

    final syncedState = _syncProgressFromStocks(resetState);

    final updatedState = _withStepInfo(
      syncedState,
      successMessage: '采集步骤已重置',
      requestFocus: true,
    );
    emit(updatedState);
    await _persistCache(updatedState);
  }

  Future<void> _onLocationSelected(
    OnlinePickCollectionLocationSelected event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final location = event.locationCode.trim();
    final nextState = state.copyWith(
      status: CollectionStatus.normal(),
      currentLocation: location.isEmpty ? null : location,
    );

    final updatedState = _withStepInfo(
      nextState,
      successMessage:
          location.isEmpty ? '已清空库位' : '库位 $location 已选择',
      requestFocus: true,
    );
    emit(updatedState);
    await _persistCache(updatedState);
  }

  Future<void> _onCacheCleared(
    OnlinePickCollectionCacheCleared event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (_cacheBox != null) {
      await _cacheBox!.delete('snapshot');
    }

    final clearedBase = state.copyWith(
      status: CollectionStatus.normal(),
      barcodeContent: null,
      pendingQuantity: null,
      collectedStocks: const [],
      serialMap: const {},
      materialQtyMap: const {},
      inventoryQtyMap: const {},
    );

    final clearedState = _withStepInfo(
      _syncProgressFromStocks(clearedBase),
      successMessage: '缓存已清空',
      requestFocus: true,
    );
    emit(clearedState);
    await _persistCache(clearedState);
  }

  Future<void> _onModeChanged(
    OnlinePickCollectionModeChanged event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final updated = _withStepInfo(
      state.copyWith(currentMode: event.mode),
      successMessage: '已切换至${_modeLabel(event.mode)}模式',
      requestFocus: true,
    );
    emit(updated);
    await _persistCache(updated);
  }

  Future<void> _onCommandSubmitted(
    OnlinePickCollectionCommandSubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final task = state.task;
    if (task == null) {
      emit(
        _withStepInfo(
          state,
          errorMessage: '缺少任务信息，无法提交指令',
          requestFocus: false,
        ),
      );
      return;
    }

    final trayNo =
        (event.trayNo?.isNotEmpty ?? false) ? event.trayNo! : state.currentTrayNo ?? '';
    if (trayNo.isEmpty) {
      emit(
        _withStepInfo(
          state,
          errorMessage: '请先扫描或输入托盘号',
          requestFocus: true,
        ),
      );
      return;
    }

    final loadingState = state.copyWith(status: CollectionStatus.loading());
    emit(loadingState);

    try {
      Map<String, dynamic> response;
      switch (event.commandType) {
        case OnlinePickCommandType.downShelf:
          response = await _collectionService.commitDownWmsToWcs(
            taskId: task.outTaskId.toString(),
            taskNo: task.outTaskNo,
            trayNo: trayNo,
            startAddr: event.startAddress,
            endAddr: event.endAddress,
            singleFlag: event.singleFlag,
          );
          break;
        case OnlinePickCommandType.inventoryDownShelf:
          response = await _collectionService.commitDownWmsToWcs(
            taskId: task.outTaskId.toString(),
            taskNo: task.outTaskNo,
            trayNo: trayNo,
            startAddr: event.startAddress,
            endAddr: event.endAddress,
            singleFlag: event.singleFlag,
            isInventory: true,
          );
          break;
        case OnlinePickCommandType.emptyTray:
          response = await _collectionService.commitEmptyTrayWmsToWcs(
            taskId: task.outTaskId.toString(),
            taskNo: task.outTaskNo,
            trayNo: trayNo,
            startAddr: event.startAddress,
            endAddr: event.endAddress,
            singleFlag: event.singleFlag,
          );
          break;
        case OnlinePickCommandType.reset:
          response = await _collectionService.commitResetWmsToWcs(
            taskId: task.outTaskId.toString(),
            taskNo: task.outTaskNo,
            trayNo: trayNo,
            startAddr: event.startAddress,
            endAddr: event.endAddress,
          );
          break;
        case OnlinePickCommandType.inventoryReset:
          response = await _collectionService.commitResetWmsToWcs(
            taskId: task.outTaskId.toString(),
            taskNo: task.outTaskNo,
            trayNo: trayNo,
            startAddr: event.startAddress,
            endAddr: event.endAddress,
            isInventory: true,
          );
          break;
      }

      final message =
          _extractMessage(response) ?? _defaultCommandMessage(event.commandType);

      final successState = _withStepInfo(
        loadingState.copyWith(status: CollectionStatus.normal()),
        successMessage: message,
        requestFocus: false,
      );
      emit(successState);
    } catch (e) {
      final errorState = _withStepInfo(
        loadingState.copyWith(status: CollectionStatus.normal()),
        errorMessage: ErrorHandler.handleError(e),
        requestFocus: false,
      );
      emit(errorState);
    }
  }

  Future<void> _onReloadRequested(
    OnlinePickCollectionReloadRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final restored = await _restoreCache(state);
    if (restored == null) {
      emit(
        _withStepInfo(
          state,
          errorMessage: '暂无可同步的数据',
          requestFocus: false,
        ),
      );
      return;
    }

    final refreshed = _withStepInfo(
      restored,
      successMessage: '已同步最新采集数据',
      requestFocus: false,
    );
    emit(refreshed);
  }

  Future<void> _onStocksSynced(
    OnlinePickCollectionStocksSynced event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final stocks = event.stocks
        .map((map) => OnlinePickCollectionStock.fromJson(
              Map<String, dynamic>.from(map),
            ))
        .toList();

    final serialMap = <String, String>{};
    final materialQtyMap = <String, List<double>>{};
    final inventoryQtyMap = <String, double>{};
    var expectedErpStore = state.expectedErpStore;

    for (final stock in stocks) {
      final serialKey = _serialKeyFromStock(stock);
      if (serialKey != null) {
        serialMap[serialKey] = serialKey;
      }

      final inventoryKey = _inventoryKeyFromStock(stock);
      inventoryQtyMap[inventoryKey] =
          (inventoryQtyMap[inventoryKey] ?? 0) + stock.collectQty.toDouble();

      final materialKey = _materialKeyFromStock(stock);
      final currentPair = materialQtyMap[materialKey] ?? <double>[];
      final double previous = currentPair.length > 1
          ? currentPair[1]
          : currentPair.isNotEmpty
              ? currentPair[0]
              : 0.0;
      materialQtyMap[materialKey] = <double>[previous, previous + stock.collectQty.toDouble()];

      if (expectedErpStore.isEmpty && (stock.erpStore?.isNotEmpty ?? false)) {
        expectedErpStore = stock.erpStore!;
      }
    }

    var updatedState = state.copyWith(
      collectedStocks: stocks,
      serialMap: serialMap,
      materialQtyMap: materialQtyMap,
      inventoryQtyMap: inventoryQtyMap,
      expectedErpStore: expectedErpStore,
      pendingQuantity: null,
      barcodeContent: null,
    );

    updatedState = _syncProgressFromStocks(updatedState);

    emit(
      _withStepInfo(
        updatedState,
        successMessage: '采集结果已同步',
        requestFocus: false,
      ),
    );
    await _persistCache(updatedState);
  }

  void _ensureLocationAndTray() {
    if ((state.currentLocation ?? '').isEmpty) {
      throw const FormatException('请先扫描库位');
    }
    if ((state.currentTrayNo ?? '').isEmpty) {
      throw const FormatException('请先扫描托盘');
    }
  }

  Map<String, double> _baselineCollectedMap(List<OnlinePickTaskItem> items) {
    final map = <String, double>{};
    for (final item in items) {
      map[item.outTaskItemId.toString()] = item.collectedQty.toDouble();
    }
    return map;
  }

  List<OnlinePickInventoryRecord> _buildInventoryRecords(
    List<OnlinePickTaskItem> items,
    Map<String, double> collectedMap,
  ) {
    return items
        .map(
          (item) => OnlinePickInventoryRecord(
            outTaskItemId: item.outTaskItemId.toString(),
            materialCode: item.materialCode ?? '',
            materialName: item.materialName,
            storeSite: item.storeSiteNo,
            trayNo: item.palletNo,
            batchNo: item.hintBatchNo ?? item.batchNo,
            serialNumber: item.serialNumber,
            erpStore: item.subInventoryCode,
            taskQty: item.taskQty,
            collectedQty:
                collectedMap[item.outTaskItemId.toString()] ?? item.collectedQty,
          ),
        )
        .toList();
  }

  OnlinePickCollectionState _syncProgressFromStocks(
    OnlinePickCollectionState base,
  ) {
    if (base.taskItems.isEmpty) {
      return base.copyWith(
        collectedQtyByItemId: const {},
        inventoryRecords: const [],
      );
    }

    final baseline = _baselineCollectedMap(base.taskItems);
    final progress = Map<String, double>.from(baseline);

    for (final stock in base.collectedStocks) {
      final itemId = stock.outTaskItemId.trim();
      if (itemId.isEmpty) continue;
      progress[itemId] =
          (progress[itemId] ?? baseline[itemId] ?? 0) + stock.collectQty.toDouble();
    }

    final updatedItems = base.taskItems
        .map(
          (item) => item.copyWith(
            collectedQty:
                progress[item.outTaskItemId.toString()] ?? item.collectedQty,
          ),
        )
        .toList();

    final inventoryRecords = _buildInventoryRecords(updatedItems, progress);

    return base.copyWith(
      taskItems: updatedItems,
      collectedQtyByItemId: progress,
      inventoryRecords: inventoryRecords,
    );
  }

  bool _isAffirmative(String? value) {
    if (value == null) return false;
    return value.trim().toUpperCase() == 'Y';
  }

  Future<OnlinePickMaterialControl?> _loadMaterialControl(
    OnlinePickBarcodeContent barcode,
  ) async {
    final material = barcode.materialCode?.trim();
    if (material == null || material.isEmpty) {
      return null;
    }

    final cached = state.materialControls[material];
    final flag = int.tryParse(barcode.sequenceControl ?? '');
    if (cached != null) {
      if (flag != null && cached.controlFlag != flag) {
        return cached.copyWith(controlFlag: flag);
      }
      return cached;
    }

    try {
      final raw = await _collectionService.getMatControl(material);
      return _parseMaterialControl(raw, flag);
    } catch (_) {
      return _parseMaterialControl('', flag);
    }
  }

  OnlinePickMaterialControl _parseMaterialControl(
    String raw,
    int? controlFlag,
  ) {
    var sendControl = '0';
    if (raw.isNotEmpty) {
      final parts = raw.split('!');
      if (parts.length >= 5 && parts[4].trim().isNotEmpty) {
        sendControl = parts[4].trim();
      } else {
        final candidate = parts.isNotEmpty ? parts.last.trim() : '';
        if (candidate.isNotEmpty) {
          sendControl = candidate;
        }
      }
    }
    if (sendControl.isEmpty) {
      sendControl = '0';
    }
    return OnlinePickMaterialControl(
      controlFlag: controlFlag ?? -1,
      sendControl: sendControl,
    );
  }

  List<OnlinePickTaskItem> _findMatchingTaskItems(
    OnlinePickBarcodeContent barcode,
    String storeSite,
    String trayNo,
    OnlinePickMaterialControl control,
  ) {
    final material = (barcode.materialCode ?? '').trim().toUpperCase();
    final batchOrSerial =
        (barcode.batchNo ?? barcode.serialNumber ?? '').trim().toUpperCase();
    final requireBatch = state.forceBatchCheck || control.isBatchControl;
    final requireSite = state.forceSiteCheck;
    final normalizedSite = storeSite.trim().toUpperCase();
    final normalizedTray = trayNo.trim().toUpperCase();

    final matches = <OnlinePickTaskItem>[];
    for (final item in state.taskItems) {
      if ((item.materialCode ?? '').trim().toUpperCase() != material) {
        continue;
      }

      if (requireSite) {
        final itemSite = (item.storeSiteNo ?? '').trim().toUpperCase();
        if (itemSite.isNotEmpty && normalizedSite.isNotEmpty &&
            itemSite != normalizedSite) {
          continue;
        }
      }

      if (normalizedTray.isNotEmpty) {
        final itemTray = (item.palletNo ?? '').trim().toUpperCase();
        if (itemTray.isNotEmpty && itemTray != normalizedTray) {
          continue;
        }
      }

      if (requireBatch) {
        final itemBatch =
            (item.hintBatchNo ?? item.batchNo ?? '').trim().toUpperCase();
        if (itemBatch.isNotEmpty && batchOrSerial.isNotEmpty &&
            itemBatch != batchOrSerial) {
          continue;
        }
      }

      matches.add(item);
    }

    if (matches.isEmpty && !requireSite) {
      for (final item in state.taskItems) {
        if ((item.materialCode ?? '').trim().toUpperCase() != material) {
          continue;
        }
        if (requireBatch) {
          final itemBatch =
              (item.hintBatchNo ?? item.batchNo ?? '').trim().toUpperCase();
          if (itemBatch.isNotEmpty && batchOrSerial.isNotEmpty &&
              itemBatch != batchOrSerial) {
            continue;
          }
        }
        matches.add(item);
      }
    }

    return matches;
  }

  _AllocationResult _allocateQuantityToItems({
    required double requestedQty,
    required List<OnlinePickTaskItem> items,
    required Map<String, double> currentMap,
  }) {
    final updatedMap = Map<String, double>.from(currentMap);
    for (final item in items) {
      updatedMap.putIfAbsent(
        item.outTaskItemId.toString(),
        () => item.collectedQty.toDouble(),
      );
    }

    final allocations = <_ItemAllocation>[];
    var remaining = requestedQty;

    for (final item in items) {
      if (remaining <= 1e-6) {
        break;
      }
      final key = item.outTaskItemId.toString();
      final collected = updatedMap[key] ?? item.collectedQty.toDouble();
      final available = item.taskQty.toDouble() - collected;
      if (available <= 1e-6) {
        continue;
      }
      final used = remaining < available ? remaining : available;
      if (used > 0) {
        allocations.add(_ItemAllocation(item: item, quantity: used));
        updatedMap[key] = collected + used;
        remaining -= used;
      }
    }

    return _AllocationResult(
      allocations: allocations,
      remaining: remaining,
      collectedQtyByItemId: updatedMap,
    );
  }

  String _stockKeyForItem(
    OnlinePickTaskItem item,
    OnlinePickBarcodeContent barcode,
    String storeSite,
    String trayNo,
  ) {
    final material = (barcode.materialCode ?? '').toUpperCase();
    final batchOrSerial =
        (barcode.batchNo ?? barcode.serialNumber ?? '').toUpperCase();
    final site = storeSite.toUpperCase();
    final tray = trayNo.toUpperCase();
    final itemId = item.outTaskItemId.toString();
    return '$material|$batchOrSerial|$site|$tray|$itemId';
  }

  String? _serialKeyFor(OnlinePickBarcodeContent barcode) {
    final material = barcode.materialCode?.trim();
    if (material == null || material.isEmpty) {
      return null;
    }

    final seqCtrl = barcode.sequenceControl?.trim();
    final serial = barcode.serialNumber?.trim();
    if (seqCtrl == '0' && (serial?.isNotEmpty ?? false)) {
      return '${material.toUpperCase()}@${serial!.toUpperCase()}';
    }
    return null;
  }

  String _inventoryKey(OnlinePickBarcodeContent barcode, String storeSite) {
    return '${storeSite.toUpperCase()}|${(barcode.materialCode ?? '').toUpperCase()}|${barcode.batchNo ?? barcode.serialNumber ?? ''}';
  }

  String? _serialKeyFromStock(OnlinePickCollectionStock stock) {
    final material = stock.materialCode.trim();
    final serial = stock.serialNumber?.trim();
    if (serial == null || serial.isEmpty) {
      return null;
    }
    return '${material.toUpperCase()}@${serial.toUpperCase()}';
  }

  String _inventoryKeyFromStock(OnlinePickCollectionStock stock) {
    final storeSite = (stock.storeSite ?? '').toUpperCase();
    final material = stock.materialCode.toUpperCase();
    final batchOrSerial = stock.batchNo ?? stock.serialNumber ?? '';
    return '$storeSite|$material|$batchOrSerial';
  }

  String _materialKeyFromStock(OnlinePickCollectionStock stock) {
    final storeSite = (stock.storeSite ?? '').toUpperCase();
    final trayNo = (stock.trayNo ?? '').toUpperCase();
    final material = stock.materialCode.toUpperCase();
    final batchOrSerial = (stock.batchNo ?? stock.serialNumber ?? '').toUpperCase();
    final itemId = stock.outTaskItemId;
    return '$material|$batchOrSerial|$storeSite|$trayNo|$itemId';
  }

  Future<_InventoryCheckResult> _fetchAvailableQuantity({
    required OnlinePickBarcodeContent barcode,
    required String storeSite,
  }) async {
    try {
      Map<String, dynamic> data;
      if ((barcode.serialNumber?.isNotEmpty ?? false) ||
          (barcode.batchNo?.isNotEmpty ?? false) ||
          (barcode.sequenceControl == '0')) {
        data = await _collectionService.getRepertoryByStoreSiteSn(
          storeSiteNo: storeSite,
          materialCode: barcode.materialCode ?? '',
          batchNo: barcode.batchNo,
          serialNumber: barcode.serialNumber,
        );
      } else {
        data = await _collectionService.getRepertoryByStoreSite(
          storeSiteNo: storeSite,
          materialCode: barcode.materialCode ?? '',
        );
      }

      final available = _resolveAvailableQuantity(data);
      var erpStore = _resolveErpStore(data);

      if ((erpStore == null || erpStore.isEmpty) &&
          (barcode.materialCode?.isNotEmpty ?? false)) {
        try {
          final erpData = await _collectionService.getRepertoryByStoreSiteErp(
            storeSiteNo: storeSite,
            materialCode: barcode.materialCode ?? '',
          );
          erpStore = _resolveErpStore(erpData) ?? erpStore;
        } catch (_) {
          // keep previous
        }
      }

      return _InventoryCheckResult(availableQty: available, erpStore: erpStore);
    } catch (_) {
      return const _InventoryCheckResult();
    }
  }

  num? _resolveAvailableQuantity(Map<String, dynamic> data) {
    dynamic current = data;
    if (current is Map && current['data'] is Map) {
      current = current['data'];
    }

    if (current is! Map) {
      return null;
    }

    final candidates = [
      'repqty',
      'repQty',
      'qty',
      'quantity',
      'availableQty',
      'available',
      'remainQty',
      'stockQty',
    ];

    for (final key in candidates) {
      if (!current.containsKey(key)) continue;
      final value = current[key];
      if (value is num) return value;
      if (value is String) {
        final parsed = num.tryParse(value);
        if (parsed != null) return parsed;
      }
    }

    return null;
  }

  String? _resolveErpStore(Map<String, dynamic> data) {
    dynamic current = data;
    if (current is Map && current['data'] != null) {
      current = current['data'];
    }

    if (current is List && current.isNotEmpty) {
      current = current.first;
    }

    if (current is! Map) {
      return null;
    }

    final candidates = [
      'erpStoreroom',
      'erpStoreRoom',
      'erpStore',
      'subinventoryCode',
      'subInventoryCode',
    ];

    for (final key in candidates) {
      final value = current[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  OnlinePickCollectionModeType _resolveInitialMode(
    Map<String, dynamic> payload,
  ) {
    final value = payload['mode'] ??
        payload['modeCode'] ??
        payload['collectionMode'] ??
        payload['collection_mode'];
    if (value == null) {
      return OnlinePickCollectionModeType.outbound;
    }
    return _modeFromString(value.toString());
  }

  OnlinePickCollectionModeType _modeFromString(String value) {
    switch (value.toLowerCase()) {
      case 'inventory':
        return OnlinePickCollectionModeType.inventory;
      case 'exception':
        return OnlinePickCollectionModeType.exception;
      default:
        return OnlinePickCollectionModeType.outbound;
    }
  }

  String _modeLabel(OnlinePickCollectionModeType mode) {
    switch (mode) {
      case OnlinePickCollectionModeType.inventory:
        return '库存核对';
      case OnlinePickCollectionModeType.exception:
        return '异常采集';
      case OnlinePickCollectionModeType.outbound:
        return '出库采集';
    }
  }

  String? _extractMessage(Map<String, dynamic> response) {
    final msg = response['msg'] ?? response['message'];
    if (msg is String && msg.trim().isNotEmpty) {
      return msg.trim();
    }

    if (response['data'] is Map) {
      final Map data = response['data'] as Map;
      final dataMsg = data['msg'] ?? data['message'];
      if (dataMsg is String && dataMsg.trim().isNotEmpty) {
        return dataMsg.trim();
      }
    }
    return null;
  }

  String _defaultCommandMessage(OnlinePickCommandType type) {
    const messages = {
      OnlinePickCommandType.downShelf: '出库指令已下发',
      OnlinePickCommandType.inventoryDownShelf: '盘点出库指令已下发',
      OnlinePickCommandType.emptyTray: '空托盘指令已下发',
      OnlinePickCommandType.reset: '重置指令已下发',
      OnlinePickCommandType.inventoryReset: '盘点重置指令已下发',
    };
    return messages[type] ?? '指令已处理';
  }

  bool _equalsIgnoreCase(String a, String b) {
    return a.toLowerCase() == b.toLowerCase();
  }

  String _resolveLocationType(Map<String, dynamic> payload) {
    final value = payload['locationType'] ??
        payload['location_type'] ??
        payload['location_type_code'];
    if (value == null) {
      return 'OUT';
    }
    return value.toString();
  }

  _RoomControlInfo _parseRoomMatControl(String raw) {
    if (raw.isEmpty) {
      return const _RoomControlInfo(roomMatControl: '0');
    }

    final parts = raw.split('!');
    String control = '0';
    bool? forceSite;
    bool? forceBatch;
    String? expectedErp;

    if (parts.isNotEmpty) {
      final siteCandidate = parts[0].trim().toUpperCase();
      if (siteCandidate == 'Y' || siteCandidate == 'N') {
        forceSite = siteCandidate == 'Y';
      }
    }

    if (parts.length >= 2) {
      final batchCandidate = parts[1].trim().toUpperCase();
      if (batchCandidate == 'Y' || batchCandidate == 'N') {
        forceBatch = batchCandidate == 'Y';
      }
    }

    if (parts.length >= 3) {
      final erpCandidate = parts[2].trim();
      if (erpCandidate.isNotEmpty) {
        expectedErp = erpCandidate;
      }
    }

    if (parts.length >= 5) {
      control = parts[4].trim();
    } else {
      final last = parts.last.trim();
      if (last.isNotEmpty) {
        control = last;
      }
    }

    if (control.isEmpty) {
      control = '0';
    }

    return _RoomControlInfo(
      roomMatControl: control,
      forceSite: forceSite,
      forceBatch: forceBatch,
      expectedErpStore: expectedErp,
    );
  }

  OnlinePickCollectionState _withStepInfo(
    OnlinePickCollectionState baseState, {
    String? successMessage,
    String? errorMessage,
    bool requestFocus = false,
  }) {
    final nextStep = _determineNextStep(baseState);
    final status = errorMessage != null
        ? CollectionStatus.error(errorMessage)
        : successMessage != null
            ? CollectionStatus.success(successMessage)
            : baseState.status;

    final focusSequence = requestFocus
        ? baseState.focusSequence + 1
        : baseState.focusSequence;

    return baseState.copyWith(
      status: status,
      nextExpectedScanType: nextStep,
      scannerPlaceholder: _placeholderForStep(nextStep),
      currentStepLabel: _stepLabelForStep(nextStep),
      focusSequence: focusSequence,
    );
  }

  OnlinePickScanType _determineNextStep(OnlinePickCollectionState state) {
    if ((state.currentLocation ?? '').isEmpty) {
      return OnlinePickScanType.location;
    }
    if ((state.currentTrayNo ?? '').isEmpty) {
      return OnlinePickScanType.tray;
    }
    if (state.barcodeContent == null || state.barcodeContent!.isEmpty) {
      return OnlinePickScanType.material;
    }
    if (state.pendingQuantity == null) {
      return OnlinePickScanType.quantity;
    }
    return OnlinePickScanType.quantity;
  }

  String _placeholderForStep(OnlinePickScanType type) {
    switch (type) {
      case OnlinePickScanType.location:
        return '请扫描库位条码';
      case OnlinePickScanType.tray:
        return '请扫描托盘条码';
      case OnlinePickScanType.material:
        return '请扫描物料二维码';
      case OnlinePickScanType.quantity:
        return '请输入或扫描数量';
    }
  }

  String _stepLabelForStep(OnlinePickScanType type) {
    switch (type) {
      case OnlinePickScanType.location:
        return '步骤一：扫描库位';
      case OnlinePickScanType.tray:
        return '步骤二：扫描托盘';
      case OnlinePickScanType.material:
        return '步骤三：扫描物料二维码';
      case OnlinePickScanType.quantity:
        return '步骤四：录入数量';
    }
  }

  @override
  Future<void> close() async {
    if (_cacheBox?.isOpen ?? false) {
      await _cacheBox!.close();
    }
    _cacheBox = null;
    return super.close();
  }
}

class _InventoryCheckResult {
  const _InventoryCheckResult({this.availableQty, this.erpStore});

  final num? availableQty;
  final String? erpStore;
}

class _RoomControlInfo {
  const _RoomControlInfo({
    required this.roomMatControl,
    this.forceSite,
    this.forceBatch,
    this.expectedErpStore,
  });

  final String roomMatControl;
  final bool? forceSite;
  final bool? forceBatch;
  final String? expectedErpStore;
}

class _ItemAllocation {
  const _ItemAllocation({required this.item, required this.quantity});

  final OnlinePickTaskItem item;
  final double quantity;
}

class _AllocationResult {
  const _AllocationResult({
    required this.allocations,
    required this.remaining,
    required this.collectedQtyByItemId,
  });

  final List<_ItemAllocation> allocations;
  final double remaining;
  final Map<String, double> collectedQtyByItemId;

  double get totalAllocated => allocations.fold<double>(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );
}
