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

import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/custom_extension.dart';
import 'package:meta/meta.dart';
import 'package:wms_app/utils/error_handler.dart';

import 'online_pick_collection_event.dart';
import 'online_pick_collection_state.dart';

class OnlinePickCollectionBloc
    extends Bloc<OnlinePickCollectionEvent, OnlinePickCollectionState> {
  OnlinePickCollectionBloc({
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  }) : _collectionService = collectionService,
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
    on<OnlinePickCollectionDestinationUpdated>(_onDestinationUpdated);
    on<OnlinePickCollectionEmptyTrayOutRequested>(_onEmptyTrayOutRequested);
    on<OnlinePickCollectionEmptyTrayInRequested>(_onEmptyTrayInRequested);
    on<OnlinePickCollectionSingleTrayRequested>(_onSingleTrayRequested);
    on<OnlinePickCollectionAllTrayRequested>(_onAllTrayRequested);
    on<OnlinePickCollectionReturnTrayRequested>(_onReturnTrayRequested);
  }

  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;

  final Uuid _uuid = const Uuid();

  OnlinePickTask? _task;
  int _userId = 0;
  Box<OnlinePickCollectionCacheSnapshot>? _cacheBox;
  final Map<String, double> _manualInventoryMap = {};
  final Map<String, OnlinePickInventoryCheckDetail> _inventoryCheckDetailMap =
      {};
  List<OnlinePickLocationOption> _locationOptions =
      const <OnlinePickLocationOption>[];
  final Map<String, String> _materialSendControlCache = {};
  String _roomMaterialControl = '0';
  String _currentMaterialSendControl = '0';

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

      await _loadRoomMaterialControl();
      await _loadLocationOptions();

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
          locationOptions: _locationOptions,
          selectedDestination: _normalizeDestination(state.selectedDestination),
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

  Future<void> _restoreSnapshot(Emitter<OnlinePickCollectionState> emit) async {
    final box = _cacheBox;
    if (box == null) return;
    final snapshot = box.get('snapshot');
    if (snapshot == null) return;

    _manualInventoryMap
      ..clear()
      ..addAll(
        snapshot.dicInvMtlQty.map(
          (key, value) => MapEntry(key.toUpperCase(), value),
        ),
      );

    _inventoryCheckDetailMap
      ..clear()
      ..addEntries(
        snapshot.inventoryChecks.map((entry) {
          final detail = OnlinePickInventoryCheckDetail.fromJson(
            Map<String, dynamic>.from(entry),
          );
          _manualInventoryMap[detail.key] = detail.quantity;
          return MapEntry(detail.key.toUpperCase(), detail);
        }),
      );

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
        inventoryCheckDetails: List<OnlinePickInventoryCheckDetail>.from(
          _inventoryCheckDetailMap.values,
        ),
        barcodeContent: snapshot.lastBarcode,
        pendingQuantity: snapshot.pendingQuantity,
        currentLocation: snapshot.location,
        currentTray: snapshot.trayNo,
        expectedErpStore: snapshot.expectedErpStore.isEmpty
            ? null
            : snapshot.expectedErpStore,
        selectedDestination: snapshot.destination,
        currentMode: OnlinePickCollectionMode(
          code: snapshot.mode,
          label: _modeLabelFrom(snapshot.mode),
          type: _modeTypeFrom(snapshot.mode),
        ),
      ),
    );
  }

  Future<void> _loadRoomMaterialControl() async {
    final taskId = _task?.outTaskId;
    if (taskId == null) {
      return;
    }

    try {
      final controlRaw = await _collectionService.getRoomMatControl(
        taskId.toString(),
      );
      final segments = controlRaw.split('!');
      if (segments.length > 4 && segments[4].isNotEmpty) {
        _roomMaterialControl = segments[4];
      } else {
        _roomMaterialControl = '0';
      }
    } catch (_) {
      _roomMaterialControl = '0';
    }
  }

  Future<void> _loadLocationOptions() async {
    try {
      final options = await _collectionService.fetchInOutLocations(
        locationType: '1',
      );
      _locationOptions = options;
    } catch (_) {
      _locationOptions = const <OnlinePickLocationOption>[];
    }
  }

  Future<String> _resolveMaterialSendControl(String materialCode) async {
    if (materialCode.isEmpty) {
      return '0';
    }

    final normalized = materialCode.toUpperCase();
    final cached = _materialSendControlCache[normalized];
    if (cached != null) {
      return cached;
    }

    try {
      final controlRaw = await _collectionService.getMatControl(
        materialCode.trim(),
      );
      final segments = controlRaw.split('!');
      final control = segments.length > 4 && segments[4].isNotEmpty
          ? segments[4]
          : '0';
      _materialSendControlCache[normalized] = control;
      return control;
    } catch (_) {
      _materialSendControlCache[normalized] = '0';
      return '0';
    }
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

  String _normalizeDestination(String current) {
    if (_locationOptions.isEmpty) {
      return '';
    }

    final normalized = current.trim().toUpperCase();
    final matched = _locationOptions.firstWhere(
      (option) => option.value.trim().toUpperCase() == normalized,
      orElse: () => _locationOptions.first,
    );
    return matched.value.trim();
  }

  String? _commandPrecheck({bool requireTray = true}) {
    if (state.collectedStocks.isNotEmpty) {
      return '采集数据未提交,不允许下达指令！';
    }
    if (_task == null || (_task?.outTaskNo ?? '').isEmpty) {
      return '凭证号为空，请确认';
    }
    if (_locationOptions.isEmpty) {
      return '立体库进出口相关位置未维护!';
    }
    if (state.selectedDestination.isEmpty) {
      return '拣选口位置不能为空';
    }
    if (requireTray && state.currentTray.trim().isEmpty) {
      return '请采集托盘号！';
    }
    return null;
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
          final normalizedLocation = raw.toUpperCase();
          final matchedItem = _findTaskItemByLocation(normalizedLocation);
          if (matchedItem == null) {
            emit(
              state.copyWith(
                status: CollectionStatus.error('任务明细中不存在库位【$raw】'),
              ),
            );
            break;
          }

          final trayMismatch =
              state.currentTray.isNotEmpty &&
              (matchedItem.palletNo ?? '').toUpperCase() !=
                  state.currentTray.toUpperCase();
          if (trayMismatch) {
            emit(
              state.copyWith(
                status: CollectionStatus.error(
                  '托盘【${state.currentTray}】所属库位为【${matchedItem.storeSiteNo ?? ''}】，请核对库位',
                ),
              ),
            );
            break;
          }

          emit(
            state.copyWith(
              currentLocation: matchedItem.storeSiteNo ?? normalizedLocation,
              currentStep: OnlinePickCollectionStep.tray,
              placeholder: '请扫描托盘',
              isScannerFocused: true,
              status: CollectionStatus.success('库位已选择'),
            ),
          );
          await _persistSnapshot();
          break;
        case _ScanCodeType.tray:
          final trayNo = _extractTrayNo(raw);
          if (trayNo.isEmpty) {
            emit(state.copyWith(status: CollectionStatus.error('托盘号不能为空!')));
            break;
          }

          final matchedItem = _findTaskItemByTray(trayNo);
          if (matchedItem == null) {
            emit(
              state.copyWith(
                status: CollectionStatus.error('任务明细中不存在托盘号【$trayNo】'),
              ),
            );
            break;
          }

          final location = matchedItem.storeSiteNo ?? '';
          final locationMismatch =
              state.currentLocation.isNotEmpty &&
              state.currentLocation.toUpperCase() != location.toUpperCase();
          if (locationMismatch) {
            emit(
              state.copyWith(
                status: CollectionStatus.error(
                  '托盘【$trayNo】应在库位【$location】采集，请核实后重试',
                ),
              ),
            );
            break;
          }

          emit(
            state.copyWith(
              currentTray: trayNo,
              currentLocation: location,
              currentStep: OnlinePickCollectionStep.material,
              placeholder: '请扫描物料二维码',
              isScannerFocused: true,
              status: CollectionStatus.success(
                location.isEmpty ? '托盘已锁定' : '托盘已锁定，库位已回填',
              ),
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
          final barcode = await _collectionService.getMaterialInfoByQr(
            raw.trim(),
          );
          _currentMaterialSendControl = await _resolveMaterialSendControl(
            barcode.materialCode ?? '',
          );
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
    OnlinePickTaskItem? matchedItem;
    final normalizedLocation = location.toUpperCase();
    final normalizedMaterial = (barcode.materialCode ?? '').toUpperCase();

    if (normalizedLocation.isNotEmpty) {
      for (final item in state.taskItems) {
        final itemLocation = (item.storeSiteNo ?? '').toUpperCase();
        final itemMaterial = (item.materialCode ?? '').toUpperCase();
        if (itemLocation == normalizedLocation &&
            itemMaterial == normalizedMaterial) {
          matchedItem = item;
          break;
        }
      }
    }

    matchedItem ??= _findTaskItemByTray(tray);
    matchedItem ??= state.taskItems.firstWhere(
      (item) => (item.materialCode ?? '').toUpperCase() == normalizedMaterial,
      orElse: () => const OnlinePickTaskItem(outTaskItemId: 0, outTaskId: 0),
    );

    final taskItem = matchedItem;

    if (taskItem.outTaskItemId == 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '物料【${barcode.materialCode ?? ''}】不在任务明细中，请核实',
          ),
          isScannerFocused: true,
        ),
      );
      return;
    }

    final storeSite = location.isEmpty
        ? (taskItem.storeSiteNo ?? '')
        : location;

    if (state.currentMode.type == OnlinePickCollectionModeType.outbound &&
        storeSite.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('当前托盘未识别到库位，请先扫描库位'),
          isScannerFocused: true,
        ),
      );
      return;
    }

    _InventoryValidationResult? inventoryValidation;
    if (state.currentMode.type == OnlinePickCollectionModeType.outbound) {
      try {
        inventoryValidation = await _performInventoryValidation(
          taskItem: taskItem,
          barcode: barcode,
          quantity: quantity,
          storeSite: storeSite,
        );
      } catch (error) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(error.toString()),
            isScannerFocused: true,
          ),
        );
        return;
      }

      final quantityError = _quantityValidationError(
        taskItem: taskItem,
        barcode: barcode,
        quantity: quantity,
        storeSite: storeSite,
        availableInventory: inventoryValidation.availableQuantity,
      );

      if (quantityError != null) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(quantityError),
            isScannerFocused: true,
          ),
        );
        return;
      }
    }

    final duplicateError = _duplicateCollectionError(
      barcode: barcode,
      storeSite: storeSite,
    );
    if (duplicateError != null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(duplicateError),
          isScannerFocused: true,
        ),
      );
      return;
    }

    final stock = OnlinePickCollectionStock(
      stockId: _uuid.v4(),
      materialCode: barcode.materialCode ?? '',
      batchNo: barcode.batchNo,
      serialNumber: barcode.serialNumber,
      taskQty: taskItem.taskQty,
      collectQty: quantity,
      outTaskItemId: taskItem.outTaskItemId.toString(),
      taskId: (_task?.outTaskId ?? 0).toString(),
      storeRoom: taskItem.storeRoomNo ?? _task?.storeRoomNo,
      storeSite: storeSite.isEmpty ? taskItem.storeSiteNo : storeSite,
      erpStore:
          inventoryValidation?.resolvedErpStore ??
          taskItem.subInventoryCode ??
          state.expectedErpStore,
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
        inventoryCheckDetails: aggregations.inventoryCheckDetails,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('采集记录已添加'),
        collectingItems: _deriveCollectingItems(updatedStocks, state.taskItems),
        currentStep: OnlinePickCollectionStep.tray,
        placeholder: '请扫描托盘',
        currentLocation: '',
        currentTray: '',
        clearBarcodeContent: true,
        clearPendingQuantity: true,
      ),
    );

    _currentMaterialSendControl = '0';
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

    final updatedStocks =
        event.shouldReplace
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
        inventoryCheckDetails: aggregations.inventoryCheckDetails,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('采集结果已同步'),
        collectingItems: _deriveCollectingItems(updatedStocks, state.taskItems),
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
        inventoryCheckDetails: aggregations.inventoryCheckDetails,
        expectedErpStore:
            aggregations.expectedErpStore ?? state.expectedErpStore,
        status: CollectionStatus.success('已删除选中记录'),
        collectingItems: _deriveCollectingItems(updatedStocks, state.taskItems),
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

    final detail = OnlinePickInventoryCheckDetail(
      key: key,
      storeSite: event.storeSite.toUpperCase(),
      materialCode: event.materialCode.toUpperCase(),
      batchNo: event.batchNo?.toUpperCase(),
      trayNo: event.trayNo?.toUpperCase(),
      quantity: event.quantity.toDouble(),
    );
    _inventoryCheckDetailMap[key.toUpperCase()] = detail;

    emit(
      state.copyWith(
        inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
        inventoryCheckDetails: List<OnlinePickInventoryCheckDetail>.from(
          _inventoryCheckDetailMap.values,
        ),
        status: CollectionStatus.success('库存核对已更新'),
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onDestinationUpdated(
    OnlinePickCollectionDestinationUpdated event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (_locationOptions.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('立体库进出口相关位置未维护!')));
      return;
    }

    final normalized = _normalizeDestination(event.destination);

    emit(
      state.copyWith(
        selectedDestination: normalized,
        status: CollectionStatus.success('拣选口已切换'),
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onEmptyTrayOutRequested(
    OnlinePickCollectionEmptyTrayOutRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final error = _commandPrecheck();
    if (error != null) {
      emit(state.copyWith(status: CollectionStatus.error(error)));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final response = await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: _task!.outTaskId.toString(),
        taskNo: _task!.outTaskNo,
        trayNo: state.currentTray.trim().toUpperCase(),
        startAddr: state.selectedDestination,
        endAddr: '1111',
        singleFlag: '1',
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message = response['msg']?.toString() ?? '空托盘出库成功,请等待';

      emit(
        state.copyWith(
          status: success
              ? CollectionStatus.success('空托盘出库成功,请等待')
              : CollectionStatus.error(
                  message.isEmpty ? '空托盘出库失败，请稍后重试' : message,
                ),
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

  Future<void> _onEmptyTrayInRequested(
    OnlinePickCollectionEmptyTrayInRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final error = _commandPrecheck();
    if (error != null) {
      emit(state.copyWith(status: CollectionStatus.error(error)));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final response = await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: _task!.outTaskId.toString(),
        taskNo: _task!.outTaskNo,
        trayNo: state.currentTray.trim().toUpperCase(),
        startAddr: state.selectedDestination,
        endAddr: '0000',
        singleFlag: '1',
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message = response['msg']?.toString() ?? '空托盘入库成功,请等待';

      emit(
        state.copyWith(
          status: success
              ? CollectionStatus.success('空托盘入库成功,请等待')
              : CollectionStatus.error(
                  message.isEmpty ? '空托盘入库失败，请稍后重试' : message,
                ),
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

  Future<void> _onSingleTrayRequested(
    OnlinePickCollectionSingleTrayRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final error = _commandPrecheck();
    if (error != null) {
      emit(state.copyWith(status: CollectionStatus.error(error)));
      return;
    }

    final tray = state.currentTray.toUpperCase();
    final taskItem = _findTaskItemByTray(tray);
    final startAddr = taskItem?.storeSiteNo ?? '';
    if (startAddr.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('目标地址为空，请核对托盘号')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final response = await _collectionService.commitDownWmsToWcs(
        taskId: _task!.outTaskId.toString(),
        taskNo: _task!.outTaskNo,
        trayNo: tray,
        startAddr: startAddr,
        endAddr: state.selectedDestination,
        singleFlag: '1',
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message = response['msg']?.toString() ?? '获取来料盘成功,请等待';

      emit(
        state.copyWith(
          status: success
              ? CollectionStatus.success('获取来料盘成功,请等待')
              : CollectionStatus.error(
                  message.isEmpty ? '获取来料盘失败，请稍后重试' : message,
                ),
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

  Future<void> _onReturnTrayRequested(
    OnlinePickCollectionReturnTrayRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final error = _commandPrecheck();
    if (error != null) {
      emit(state.copyWith(status: CollectionStatus.error(error)));
      return;
    }

    final tray = state.currentTray.toUpperCase();
    final taskItem = _findTaskItemByTray(tray);
    final endAddr = taskItem?.storeSiteNo ?? '';
    if (endAddr.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('目标地址为空，请核对托盘号')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final response = await _collectionService.commitResetWmsToWcs(
        taskId: _task!.outTaskId.toString(),
        taskNo: _task!.outTaskNo,
        trayNo: tray,
        startAddr: state.selectedDestination,
        endAddr: endAddr,
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message = response['msg']?.toString() ?? '托盘回库成功,请等待';

      emit(
        state.copyWith(
          status: success
              ? CollectionStatus.success('托盘回库成功,请等待')
              : CollectionStatus.error(
                  message.isEmpty ? '托盘回库失败，请稍后重试' : message,
                ),
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

  Future<void> _onAllTrayRequested(
    OnlinePickCollectionAllTrayRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final error = _commandPrecheck(requireTray: false);
    if (error != null) {
      emit(state.copyWith(status: CollectionStatus.error(error)));
      return;
    }

    if (event.limit <= 0) {
      emit(state.copyWith(status: CollectionStatus.error('获取来料盘数据不能为空！')));
      return;
    }

    final trayMap = <String, String>{};
    for (final item in state.taskItems) {
      final tray = (item.palletNo ?? '').trim().toUpperCase();
      final site = (item.storeSiteNo ?? '').trim();
      if (tray.isEmpty || site.isEmpty) {
        continue;
      }
      trayMap.putIfAbsent(tray, () => site);
    }

    if (trayMap.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('获取来料盘数据不能为空！')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    var remaining = event.limit;
    final failed = <String>[];
    final processed = <String>{};

    try {
      for (final entry in trayMap.entries) {
        if (remaining <= 0) {
          break;
        }
        if (processed.contains(entry.key)) {
          continue;
        }
        processed.add(entry.key);

        final response = await _collectionService.commitDownWmsToWcs(
          taskId: _task!.outTaskId.toString(),
          taskNo: _task!.outTaskNo,
          trayNo: entry.key,
          startAddr: entry.value,
          endAddr: state.selectedDestination,
          singleFlag: '0',
        );

        final code = response['code'];
        final success = code == 200 || code == '200';
        if (success) {
          remaining -= 1;
        } else {
          failed.add(entry.key);
        }
      }

      final completed = event.limit - remaining;
      if (completed > 0 && failed.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.success('获取来料托盘成功,请等待')));
      } else if (completed > 0 && failed.isNotEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.success(
              '部分托盘已下发，失败托盘：${failed.join('、')}',
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CollectionStatus.error(
              failed.isEmpty
                  ? '未找到可用托盘下发指令'
                  : '托盘【${failed.join('、')}】下发失败，请确认',
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
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
      emit(state.copyWith(status: CollectionStatus.error('缺少任务上下文，无法提交')));
      return;
    }

    if (state.collectedStocks.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('本次无采集明细，请确认！')));
      return;
    }

    final requiredInventoryKeys = state.collectedStocks
        .map(_inventoryKeyForStock)
        .whereType<String>()
        .toSet();

    if (requiredInventoryKeys.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请采集结余库存后再提交！')));
      return;
    }

    if (_inventoryCheckDetailMap.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请采集结余库存后再提交！')));
      return;
    }

    final missingInventoryKeys = requiredInventoryKeys
        .where((key) => !_inventoryCheckDetailMap.containsKey(key))
        .toList(growable: false);
    if (missingInventoryKeys.isNotEmpty) {
      final firstMissing = _splitInventoryKey(missingInventoryKeys.first);
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '物料【${firstMissing['materialCode']}】在库位【${firstMissing['storeSite']}】没有采集结余库存，请采集后提交！',
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final downShelvesInfos = state.collectedStocks
          .map((stock) {
            return {
              'taskNo': _task!.outTaskNo,
              'matCode': stock.materialCode,
              'batchNo': stock.batchNo ?? '',
              'sn': stock.serialNumber ?? '',
              'taskQty': stock.taskQty,
              'collectQty': stock.collectQty,
              'storeRoomNo': stock.storeRoom ?? '',
              'storeSiteNo': stock.storeSite ?? '',
              'taskid': stock.taskId,
              'outTaskItemid': stock.outTaskItemId,
              'erpStore': stock.erpStore ?? '',
              'trayNo': stock.trayNo ?? '',
            };
          })
          .toList(growable: false);

      final normalizedMaterialMap = _normalizeMaterialQtyMap(
        state.materialQtyMap,
        state.collectedStocks,
      );

      final itemListInfos = normalizedMaterialMap.entries
          .map((entry) {
            final taskItem = state.taskItems.firstWhere(
              (item) => item.outTaskItemId.toString() == entry.key,
              orElse: () =>
                  const OnlinePickTaskItem(outTaskItemId: 0, outTaskId: 0),
            );

            return {
              'mtlQty': entry.value.map((e) => e.toFormatString()).toList(),
              'outTaskItemid': entry.key,
              'mtlCode': taskItem.materialCode ?? '',
            };
          })
          .toList(growable: false);

      if (itemListInfos.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('本次无采集明细，请确认！')));
        return;
      }

      final inventoryCheckInfos = _inventoryCheckDetailMap.values
          .map((entry) {
            return {
              'matCode': entry.materialCode,
              'storeSite': entry.storeSite,
              'trayNo': entry.trayNo ?? '',
              'batchNo': entry.batchNo ?? '',
              'quantity': entry.quantity.toFormatString(),
            };
          })
          .toList(growable: false);

      final response = await _collectionService.commitAswhDownShelves(
        downShelvesInfos: downShelvesInfos,
        itemListInfos: itemListInfos,
        inventoryCheckInfos: inventoryCheckInfos,
      );

      final code = response['code'];
      final success = code == 200 || code == '200';
      final message =
          response['msg']?.toString() ?? (success ? '提交成功' : '提交失败');

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
            placeholder: '请扫描托盘',
            currentStep: OnlinePickCollectionStep.tray,
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
      final serialKey = '${stock.materialCode}@${stock.serialNumber ?? ''}'
          .trim();
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

    _inventoryCheckDetailMap.removeWhere(
      (key, _) => !remainingInventoryKeys.contains(key),
    );

    return _AggregationsResult(
      serialMap: serialMap,
      materialQtyMap: materialQtyMap,
      inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
      inventoryCheckDetails: List<OnlinePickInventoryCheckDetail>.from(
        _inventoryCheckDetailMap.values,
      ),
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

  Future<_InventoryValidationResult> _performInventoryValidation({
    required OnlinePickTaskItem taskItem,
    required OnlinePickBarcodeContent barcode,
    required num quantity,
    required String storeSite,
  }) async {
    final materialCode = (barcode.materialCode ?? '').trim();
    if (materialCode.isEmpty) {
      throw Exception('物料条码信息不完整，请重新扫描');
    }

    final normalizedSite = storeSite.toUpperCase();
    final normalizedMaterial = materialCode.toUpperCase();
    final batchFallback = (taskItem.hintBatchNo ?? taskItem.batchNo ?? '')
        .trim();
    final batchNo = (barcode.batchNo?.trim().isNotEmpty ?? false)
        ? barcode.batchNo!.trim()
        : batchFallback;
    final normalizedBatch = batchNo.toUpperCase();
    final expectedErp =
        (taskItem.subInventoryCode ?? state.expectedErpStore ?? '').trim();
    final normalizedErp = expectedErp.toUpperCase();
    final serial = (barcode.serialNumber ?? '').trim();
    final controlFlag = barcode.sequenceControl?.trim() ?? '';

    double resolvedQuantity = 0;
    String? resolvedErpStore;

    Map<String, dynamic> response;

    if (controlFlag == '0' || serial.isNotEmpty) {
      response = await _collectionService.getRepertoryByStoreSiteSn(
        storeSiteNo: storeSite,
        materialCode: materialCode,
        erpStoreroom: normalizedErp.isEmpty ? null : expectedErp,
        batchNo: normalizedBatch.isEmpty ? null : batchNo,
        serialNumber: serial.isEmpty ? null : serial,
      );

      final code = response['code']?.toString();
      if (code != null && code != '200') {
        final message = response['msg']?.toString() ?? '库存校验失败';
        throw Exception(message);
      }

      final data = response['data'];
      if (data is! List) {
        throw Exception('未获取到库位【$storeSite】的库存信息');
      }

      if (data.isEmpty) {
        throw Exception(
          '物料【$materialCode】批次【$batchNo】序列【$serial】在库位【$storeSite】不存在，请确认',
        );
      }

      Map<String, dynamic>? matched;
      if (normalizedErp.isNotEmpty) {
        matched = data
            .cast<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .firstWhere(
              (item) =>
                  (item['erpStoreroom']?.toString().toUpperCase() ?? '') ==
                  normalizedErp,
              orElse: () => <String, dynamic>{},
            );
        if (matched.isEmpty) {
          final actualErp =
              Map<String, dynamic>.from(
                data.first as Map,
              )['erpStoreroom']?.toString() ??
              '';
          throw Exception(
            '当前物料明细指定子库【$expectedErp】与当前库位的物料批次子库【$actualErp】存在不一致，请确认',
          );
        }
      } else {
        matched = Map<String, dynamic>.from(data.first as Map);
      }

      resolvedErpStore = matched['erpStoreroom']?.toString();
      resolvedQuantity =
          double.tryParse(matched['repqty']?.toString() ?? '') ?? 0;

      if (resolvedQuantity <= 0) {
        throw Exception(
          '物料【$materialCode】批次【$batchNo】序列【$serial】在库位【$storeSite】不存在，请确认',
        );
      }
    } else {
      response = await _collectionService.getRepertoryByStoreSite(
        storeSiteNo: storeSite,
        materialCode: materialCode,
      );

      final code = response['code']?.toString();
      if (code != null && code != '200') {
        final message = response['msg']?.toString() ?? '库存校验失败';
        throw Exception(message);
      }

      final data = response['data'];
      if (data is! List) {
        throw Exception('未获取到库位【$storeSite】的库存信息');
      }

      final matches = data
          .cast<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .where((item) {
            final entryMaterial = (item['matcode']?.toString() ?? '')
                .toUpperCase();
            final entrySite = (item['storesiteno']?.toString() ?? '')
                .toUpperCase();
            final entryBatch = (item['batchno']?.toString() ?? '')
                .toUpperCase();
            final entryErp = (item['erpStoreroom']?.toString() ?? '')
                .toUpperCase();
            final batchMatch =
                normalizedBatch.isEmpty || entryBatch == normalizedBatch;
            final erpMatch = normalizedErp.isEmpty || entryErp == normalizedErp;
            return entryMaterial == normalizedMaterial &&
                entrySite == normalizedSite &&
                batchMatch &&
                erpMatch;
          })
          .toList();

      final batchMessage = normalizedBatch.isEmpty ? '' : '批次【$batchNo】';
      if (matches.isEmpty) {
        throw Exception(
          '物料【$materialCode】$batchMessage 在库位【$storeSite】不存在，请确认',
        );
      }

      resolvedQuantity = matches.fold<double>(
        0,
        (value, item) =>
            value + (double.tryParse(item['repqty']?.toString() ?? '') ?? 0),
      );
      resolvedErpStore = matches.first['erpStoreroom']?.toString();

      if (resolvedQuantity <= 0) {
        throw Exception(
          '物料【$materialCode】$batchMessage 在库位【$storeSite】不存在，请确认',
        );
      }
    }

    return _InventoryValidationResult(
      availableQuantity: resolvedQuantity,
      resolvedErpStore: resolvedErpStore,
    );
  }

  String? _quantityValidationError({
    required OnlinePickTaskItem taskItem,
    required OnlinePickBarcodeContent barcode,
    required num quantity,
    required String storeSite,
    required double availableInventory,
  }) {
    final normalizedSite = storeSite.toUpperCase();
    final normalizedMaterial = (barcode.materialCode ?? '').toUpperCase();
    final batchNo = (barcode.batchNo ?? taskItem.hintBatchNo ?? '').trim();
    final normalizedBatch = batchNo.toUpperCase();
    final enforceStrictMatch =
        _currentMaterialSendControl == '0' &&
        (_roomMaterialControl == '0' || _roomMaterialControl == '1');

    final inventoryKey = _inventoryKeyFromComponents(
      storeSite: storeSite,
      materialCode: barcode.materialCode ?? '',
      batchNo: batchNo,
      trayNo: state.currentTray,
    );

    final recordedResidual = state.inventoryQtyMap[inventoryKey] ?? 0.0;

    final consumedInventory = state.collectedStocks
        .where((stock) {
          final stockSite = (stock.storeSite ?? '').toUpperCase();
          final stockMaterial = stock.materialCode.toUpperCase();
          final stockBatch = (stock.batchNo ?? '').toUpperCase();
          return stockSite == normalizedSite &&
              stockMaterial == normalizedMaterial &&
              (normalizedBatch.isEmpty || stockBatch == normalizedBatch);
        })
        .fold<double>(0, (value, stock) => value + stock.collectQty.toDouble());

    final remainingInventory =
        availableInventory - recordedResidual - consumedInventory;
    if (remainingInventory < quantity.toDouble()) {
      return '库位【$storeSite】物料【${barcode.materialCode ?? ''}】的库存【${(remainingInventory < 0 ? 0 : remainingInventory)}】小于本次移出库存【${quantity.toDouble().toFormatString()}】，请确认';
    }

    final relatedItems = state.taskItems.where((item) {
      final itemMaterial = (item.materialCode ?? '').toUpperCase();
      final itemSite = (item.storeSiteNo ?? '').toUpperCase();
      if (itemMaterial != normalizedMaterial || itemSite != normalizedSite) {
        return false;
      }
      final itemBatch = (item.hintBatchNo ?? item.batchNo ?? '').toUpperCase();
      if (!enforceStrictMatch || normalizedBatch.isEmpty) {
        return true;
      }
      return itemBatch == normalizedBatch;
    }).toList();

    if (relatedItems.isEmpty) {
      return null;
    }

    final totalTaskQty = relatedItems.fold<double>(
      0,
      (value, item) => value + item.taskQty.toDouble(),
    );

    double totalCollected = relatedItems.fold<double>(
      0,
      (value, item) => value + item.collectedQty.toDouble(),
    );

    totalCollected += state.collectedStocks
        .where((stock) {
          final stockSite = (stock.storeSite ?? '').toUpperCase();
          final stockMaterial = stock.materialCode.toUpperCase();
          final stockBatch = (stock.batchNo ?? '').toUpperCase();
          final batchMatches =
              !enforceStrictMatch ||
              normalizedBatch.isEmpty ||
              stockBatch == normalizedBatch;
          return stockSite == normalizedSite &&
              stockMaterial == normalizedMaterial &&
              batchMatches;
        })
        .fold<double>(0, (value, stock) => value + stock.collectQty.toDouble());

    if (totalCollected + quantity.toDouble() > totalTaskQty + 1e-6) {
      final remaining = (totalTaskQty - totalCollected).clamp(
        0,
        double.infinity,
      );
      return '本次采集数量【${quantity.toDouble().toFormatString()}】大于剩余可采集数量【${remaining}】';
    }

    return null;
  }

  String? _duplicateCollectionError({
    required OnlinePickBarcodeContent barcode,
    required String storeSite,
  }) {
    final material = (barcode.materialCode ?? '').trim();
    if (material.isEmpty) {
      return null;
    }

    final normalizedMaterial = material.toUpperCase();
    final normalizedSite = storeSite.toUpperCase();

    final serial = (barcode.serialNumber ?? '').trim();
    if (serial.isNotEmpty) {
      final normalizedSerial = serial.toUpperCase();
      final serialKey = '$normalizedMaterial@$normalizedSerial';
      final hasSerialKey = state.serialMap.keys.any(
        (key) => key.toUpperCase() == serialKey,
      );
      if (hasSerialKey) {
        return '物料【$material】序列号【$serial】不允许重复采集，请确认';
      }

      OnlinePickCollectionStock? duplicateSerialStock;
      for (final stock in state.collectedStocks) {
        final stockSerial = (stock.serialNumber ?? '').toUpperCase();
        if (stock.materialCode.toUpperCase() == normalizedMaterial &&
            stockSerial == normalizedSerial) {
          duplicateSerialStock = stock;
          break;
        }
      }

      if (duplicateSerialStock != null) {
        final site = duplicateSerialStock.storeSite ?? storeSite;
        return '采集物料【$material】序列号【$serial】库位【$site】已经采集,不允许重复采集!';
      }
    }

    final batch = (barcode.batchNo ?? '').trim();
    if (batch.isNotEmpty) {
      final normalizedBatch = batch.toUpperCase();
      OnlinePickCollectionStock? duplicateBatchStock;
      for (final stock in state.collectedStocks) {
        final stockBatch = (stock.batchNo ?? '').toUpperCase();
        final stockSite = (stock.storeSite ?? '').toUpperCase();
        if (stock.materialCode.toUpperCase() == normalizedMaterial &&
            stockBatch == normalizedBatch &&
            stockSite == normalizedSite) {
          duplicateBatchStock = stock;
          break;
        }
      }

      if (duplicateBatchStock != null) {
        final site = duplicateBatchStock.storeSite ?? storeSite;
        return '采集物料【$material】批次【$batch】库位【$site】已经采集,不允许重复采集!';
      }
    }

    return null;
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
    if (RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(code)) {
      return _ScanCodeType.quantity;
    }
    return _ScanCodeType.material;
  }

  String _extractTrayNo(String raw) {
    final parts = raw
        .split(r'$')
        .map((element) => element.trim())
        .where((element) => element.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return '';
    }

    final trayIndex = parts.indexWhere(
      (element) => element.toUpperCase() == 'TP',
    );
    if (trayIndex != -1 && trayIndex + 1 < parts.length) {
      return parts[trayIndex + 1].trim();
    }

    if (parts.length == 1) {
      return parts.first.trim();
    }

    return '';
  }

  OnlinePickTaskItem? _findTaskItemByTray(String trayNo) {
    if (trayNo.isEmpty) {
      return null;
    }

    final normalized = trayNo.toUpperCase();
    for (final item in state.taskItems) {
      final pallet = (item.palletNo ?? '').toUpperCase();
      if (pallet == normalized) {
        return item;
      }
    }
    return null;
  }

  OnlinePickTaskItem? _findTaskItemByLocation(String location) {
    if (location.isEmpty) {
      return null;
    }

    final normalized = location.toUpperCase();
    for (final item in state.taskItems) {
      final site = (item.storeSiteNo ?? '').toUpperCase();
      if (site == normalized) {
        return item;
      }
    }
    return null;
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
      inventoryChecks: _inventoryCheckDetailMap.values
          .map((detail) => detail.toJson())
          .toList(growable: false),
      destination: state.selectedDestination,
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
      _inventoryCheckDetailMap
        ..clear()
        ..addEntries(
          _manualInventoryMap.entries.map((entry) {
            final segments = _splitInventoryKey(entry.key);
            final detail = OnlinePickInventoryCheckDetail(
              key: entry.key,
              storeSite: segments['storeSite'] ?? '',
              materialCode: segments['materialCode'] ?? '',
              batchNo: segments['batchNo'],
              trayNo: segments['trayNo'],
              quantity: entry.value,
            );
            return MapEntry(entry.key, detail);
          }),
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
          inventoryCheckDetails: aggregations.inventoryCheckDetails,
          collectingItems: _deriveCollectingItems(stocks, effectiveTaskItems),
          taskItems: taskItems ?? state.taskItems,
        ),
      );
    } else if (materialQtyMap != null) {
      emit(
        state.copyWith(
          materialQtyMap: materialQtyMap,
          inventoryQtyMap: Map<String, double>.from(_manualInventoryMap),
          inventoryCheckDetails: List<OnlinePickInventoryCheckDetail>.from(
            _inventoryCheckDetailMap.values,
          ),
          taskItems: taskItems ?? state.taskItems,
        ),
      );
    } else if (taskItems != null) {
      emit(state.copyWith(taskItems: taskItems));
    }
  }

  Future<void> _clearSnapshot() async {
    _manualInventoryMap.clear();
    _inventoryCheckDetailMap.clear();
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
    required this.inventoryCheckDetails,
    this.expectedErpStore,
  });

  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final List<OnlinePickInventoryCheckDetail> inventoryCheckDetails;
  final String? expectedErpStore;
}

class _InventoryValidationResult {
  const _InventoryValidationResult({
    required this.availableQuantity,
    this.resolvedErpStore,
  });

  final double availableQuantity;
  final String? resolvedErpStore;
}

enum _ScanCodeType { location, tray, material, quantity }
