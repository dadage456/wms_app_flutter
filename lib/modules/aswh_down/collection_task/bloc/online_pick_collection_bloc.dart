import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_task_service.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import 'online_pick_collection_event.dart';
import 'online_pick_collection_state.dart';

class OnlinePickCollectionBloc
    extends Bloc<OnlinePickCollectionEvent, OnlinePickCollectionState> {
  OnlinePickCollectionBloc({
    required OnlinePickTask task,
    required AswhDownTaskService taskService,
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
    HiveInterface? hive,
    Uuid? uuid,
    String? submissionHint,
  })  : _taskService = taskService,
        _collectionService = collectionService,
        _userManager = userManager,
        _hive = hive ?? Hive,
        _uuid = uuid ?? const Uuid(),
        super(
          OnlinePickCollectionState.initial(
            task,
            submitChannel:
                _resolveInitialSubmissionChannel(task, submissionHint),
          ),
        ) {
    on<OnlinePickCollectionStarted>(_onStarted);
    on<OnlinePickCollectionScanPerformed>(_onScanPerformed);
    on<OnlinePickCollectionQuantitySubmitted>(_onQuantitySubmitted);
    on<OnlinePickCollectionStocksSynced>(_onStocksSynced);
    on<OnlinePickCollectionResetStatus>(_onResetStatus);
    on<OnlinePickCollectionChangeTab>(_onChangeTab);
    on<OnlinePickCollectionSelectionChanged>(_onSelectionChanged);
    on<OnlinePickCollectionFocusRequested>(_onFocusRequested);
    on<OnlinePickCollectionDeleteStocksRequested>(_onDeleteStocksRequested);
    on<OnlinePickCollectionResultRemoved>(_onResultRemoved);
    on<OnlinePickCollectionDetailsRefreshRequested>(
        _onDetailsRefreshRequested);
    on<OnlinePickCollectionSubmitRequested>(_onSubmitRequested);
    on<OnlinePickCollectionCacheCleared>(_onCacheCleared);
    on<OnlinePickCollectionModeChanged>(_onModeChanged);
    on<OnlinePickCollectionLocationSelected>(_onLocationSelected);
    on<OnlinePickCollectionPalletsCallRequested>(_onPalletsCallRequested);
    on<OnlinePickCollectionExceptionSubmitted>(_onExceptionSubmitted);
    on<OnlinePickCollectionEmptyTrayOutboundRequested>(
        _onEmptyTrayOutboundRequested);
    on<OnlinePickCollectionTrayReturnRequested>(_onTrayReturnRequested);
    on<OnlinePickCollectionInventoryCheckSubmitted>(
        _onInventoryCheckSubmitted);
    on<OnlinePickCollectionEmptyTrayInboundRequested>(
        _onEmptyTrayInboundRequested);
    on<OnlinePickCollectionSingleTrayRequested>(_onSingleTrayRequested);
  }

  final AswhDownTaskService _taskService;
  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;
  final HiveInterface _hive;
  final Uuid _uuid;

  Box<OnlinePickCollectionCacheSnapshot>? _cacheBox;
  OnlinePickCollectionQuery? _currentQuery;
  List<OnlinePickTaskItem> _remoteDetails = const [];

  Future<void> _onStarted(
    OnlinePickCollectionStarted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    await _openCacheBox();

    emit(
      state.copyWith(
        status: CollectionStatus.loading(),
        focus: true,
        placeholder: _placeholderForStep(OnlinePickCollectionStep.location),
      ),
    );

    try {
      final user = _userManager.userInfo;
      final query = OnlinePickCollectionQuery(
        outTaskNo: state.task.outTaskNo,
        storeRoomNo: state.task.storeRoomNo ?? '',
        taskComment: state.task.taskComment ?? '',
        forceSite: state.task.forceSite ?? '',
        forceBatch: state.task.forceBatch ?? '',
        workStation: state.task.workStation ?? '',
        collector: user?.userId ?? 0,
      );
      _currentQuery = query;

      final itemsFuture = _collectionService.fetchCollectionTaskItems(
        query: query,
      );
      final wcsFuture = _collectionService.fetchWcsCommands(
        taskComment: state.task.taskComment ?? '',
        taskId: state.task.outTaskId.toString(),
      );
      final locationsFuture = _collectionService.fetchInOutLocations();
      final roomControlFuture = _collectionService.getRoomMatControl(
        state.task.outTaskId.toString(),
      );

      final items = await itemsFuture;
      _remoteDetails = items;

      var expectedErpStore = state.expectedErpStore;
      if (items.isNotEmpty) {
        expectedErpStore = items.first.subInventoryCode ?? expectedErpStore;
      }

      final detailList = _deriveDetailListFromRemote(state.collectedStocks);
      final collectingList = _buildCollectingListFromDetail(detailList);
      final wcsCommands = await wcsFuture;
      final locations = await locationsFuture;
      final selectedLocation = _resolveSelectedLocation(locations);
      final roomMatControl = _parseRoomMatControl(await roomControlFuture);

      emit(
        state.copyWith(
          status: const CollectionStatus.success(),
          detailList: detailList,
          collectingList: collectingList,
          expectedErpStore: expectedErpStore,
          wcsCommands: wcsCommands,
          focus: true,
          locationOptions: locations,
          selectedLocation: selectedLocation,
          roomMatControl: roomMatControl,
        ),
      );

      if (event.restoreCache) {
        await _restoreFromCache(emit);
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onScanPerformed(
    OnlinePickCollectionScanPerformed event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    try {
      final result = OnlinePickScannerParser.parse(event.rawValue);

      if (state.pendingInventoryPrompt != null) {
        if (result.type != OnlinePickScanType.quantity ||
            result.quantity == null) {
          emit(
            state.copyWith(
              status: CollectionStatus.error('请先录入结余数量'),
              focus: true,
            ),
          );
          return;
        }
        add(OnlinePickCollectionInventoryCheckSubmitted(result.quantity!));
        return;
      }

      switch (result.type) {
        case OnlinePickScanType.location:
          emit(
            state.copyWith(
              location: result.normalizedValue,
              step: OnlinePickCollectionStep.tray,
              placeholder: _placeholderForStep(OnlinePickCollectionStep.tray),
              focus: true,
              status: CollectionStatus.success('已识别库位 ${result.normalizedValue}'),
              clearBarcode: true,
              clearCurrentItem: true,
              clearPendingQuantity: true,
            ),
          );
          await _persistCache();
          break;
        case OnlinePickScanType.tray:
          final trayNo = result.normalizedValue;
          final resolvedLocation = _resolveLocationByTray(trayNo);
          final successMessage = resolvedLocation?.isNotEmpty == true
              ? '托盘 $trayNo 就绪，库位 ${resolvedLocation!}'
              : '托盘 $trayNo 就绪';
          emit(
            state.copyWith(
              trayNo: trayNo,
              step: OnlinePickCollectionStep.material,
              placeholder:
                  _placeholderForStep(OnlinePickCollectionStep.material),
              focus: true,
              status: CollectionStatus.success(successMessage),
              location:
                  resolvedLocation?.isNotEmpty == true ? resolvedLocation : state.location,
              clearPendingQuantity: true,
              clearCurrentItem: true,
              clearBarcode: true,
            ),
          );
          await _persistCache();
          break;
        case OnlinePickScanType.material:
          if (state.trayNo.isEmpty) {
            emit(
              state.copyWith(
                status: CollectionStatus.error('请先扫描托盘条码'),
                focus: true,
              ),
            );
            return;
          }

          emit(state.copyWith(status: CollectionStatus.loading()));
          final barcode = await _collectionService.getMaterialInfoByQr(
            event.rawValue,
          );

          OnlinePickTaskItem matched;
          try {
            matched = _matchTaskItem(barcode);
          } on OnlinePickMatchException catch (error) {
            emit(
              state.copyWith(
                status: CollectionStatus.error(error.message),
                focus: true,
                clearBarcode: true,
                clearCurrentItem: true,
              ),
            );
            return;
          }

          final resolvedLocation = state.location.isNotEmpty
              ? state.location
              : (matched.storeSiteNo ?? '').trim();

          emit(
            state.copyWith(
              barcodeContent: barcode,
              currentItem: matched,
              step: OnlinePickCollectionStep.quantity,
              placeholder: _placeholderForStep(OnlinePickCollectionStep.quantity),
              status: CollectionStatus.success('物料 ${barcode.materialCode} 已匹配'),
              focus: true,
              location: resolvedLocation.isNotEmpty
                  ? resolvedLocation
                  : state.location,
            ),
          );
          await _persistCache();
          break;
        case OnlinePickScanType.quantity:
          add(OnlinePickCollectionQuantitySubmitted(result.quantity ?? 0));
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onQuantitySubmitted(
    OnlinePickCollectionQuantitySubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final currentItem = state.currentItem;
    if (currentItem == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描物料二维码'),
          focus: true,
        ),
      );
      return;
    }
    if (state.location.isEmpty || state.trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请确认已扫描库位和托盘'),
          focus: true,
        ),
      );
      return;
    }

    if (event.quantity <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数量必须大于 0'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(pendingQuantity: event.quantity));

    final barcode = state.barcodeContent;
    final bool serialControlled = _isSerialControlled(barcode, currentItem);
    final double remainingQty =
        _remainingTaskQuantity(currentItem).toDouble();

    if (serialControlled) {
      if (event.quantity != 1) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('序列号物料默认采集数量为 1，请确认'),
            focus: true,
            clearPendingQuantity: true,
          ),
        );
        return;
      }
      if (remainingQty <= 0) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('该序列号已采集完成，请勿重复录入'),
            focus: true,
            clearPendingQuantity: true,
          ),
        );
        return;
      }
    } else {
      final double requested = event.quantity.toDouble();
      if (requested - remainingQty > 1e-6) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(
              '本次采集数量【${requested.toStringAsFixed(3)}】大于剩余可采数量【${remainingQty.toStringAsFixed(3)}】',
            ),
            focus: true,
            clearPendingQuantity: true,
          ),
        );
        return;
      }
      if (remainingQty <= 0) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('该任务行已完成采集，请勿重复录入'),
            focus: true,
            clearPendingQuantity: true,
          ),
        );
        return;
      }
    }

    _InventoryValidationResult? validationResult;
    try {
      validationResult = await _validateInventoryBeforeCollect(
        quantity: event.quantity,
        currentItem: currentItem,
        barcode: barcode,
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
          clearPendingQuantity: true,
        ),
      );
      return;
    }

    final resolvedErpStore = validationResult?.erpStore?.isNotEmpty == true
        ? validationResult!.erpStore
        : (state.expectedErpStore.isNotEmpty
            ? state.expectedErpStore
            : currentItem.subInventoryCode);
    final stock = OnlinePickCollectionStock(
      stockId: _uuid.v4(),
      materialCode: barcode?.materialCode ?? currentItem.materialCode ?? '',
      batchNo: barcode?.batchNo ?? currentItem.batchNo ?? currentItem.hintBatchNo,
      serialNumber: barcode?.serialNumber ?? currentItem.serialNumber,
      taskQty: currentItem.taskQty,
      collectQty: event.quantity,
      outTaskItemId: currentItem.outTaskItemId.toString(),
      taskId: currentItem.outTaskId.toString(),
      storeRoom: currentItem.storeRoomNo,
      storeSite: state.location,
      erpStore: resolvedErpStore,
      trayNo: state.trayNo,
    );

    final updatedStocks = List<OnlinePickCollectionStock>.from(
      state.collectedStocks,
    )
      ..add(stock);

    final cache = _rebuildCachesFromStocks(updatedStocks);
    final detailList = _deriveDetailListFromRemote(updatedStocks);
    final collecting = _buildCollectingListFromDetail(detailList);

    final prompt = _deriveInventoryPrompt(
      currentItem: currentItem,
      barcode: barcode,
      updatedStocks: updatedStocks,
    );

    final successMessage = prompt != null
        ? '已记录采集数量 ${event.quantity}，请录入结余数量'
        : '已记录采集数量 ${event.quantity}';
    final placeholder = prompt != null
        ? '请输入该物料在当前库位的结余数量'
        : _placeholderForStep(OnlinePickCollectionStep.location);
    final nextStep =
        prompt != null ? OnlinePickCollectionStep.quantity : OnlinePickCollectionStep.location;

    emit(
      state.copyWith(
        collectedStocks: updatedStocks,
        detailList: detailList,
        collectingList: collecting,
        serialMap: cache.serialMap,
        materialQtyMap: cache.materialQtyMap,
        inventoryQtyMap: cache.inventoryQtyMap,
        expectedErpStore:
            cache.expectedErpStore.isNotEmpty ? cache.expectedErpStore : state.expectedErpStore,
        status: CollectionStatus.success(successMessage),
        step: nextStep,
        placeholder: placeholder,
        focus: true,
        clearBarcode: true,
        clearCurrentItem: true,
        clearPendingQuantity: true,
        pendingInventoryPrompt: prompt,
        clearPendingInventoryPrompt: prompt == null,
      ),
    );
    await _persistCache();
  }

  Future<void> _onInventoryCheckSubmitted(
    OnlinePickCollectionInventoryCheckSubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final prompt = state.pendingInventoryPrompt;
    if (prompt == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('当前无需录入结余数量'),
          focus: true,
        ),
      );
      return;
    }

    final quantity = event.quantity.toDouble();
    if (quantity < 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('结余数量不能为负数'),
          focus: true,
        ),
      );
      return;
    }

    final updatedChecks = _mergeInventoryCheck(
      state.inventoryChecks,
      prompt,
      quantity,
    );

    final message =
        '已记录结余数量 ${quantity.toStringAsFixed(3)}，请继续采集';

    emit(
      state.copyWith(
        inventoryChecks: updatedChecks,
        status: CollectionStatus.success(message),
        placeholder: _placeholderForStep(OnlinePickCollectionStep.location),
        step: OnlinePickCollectionStep.location,
        focus: true,
        clearBarcode: true,
        clearCurrentItem: true,
        clearPendingQuantity: true,
        clearPendingInventoryPrompt: true,
      ),
    );
    await _persistCache();
  }

  Future<_InventoryValidationResult?> _validateInventoryBeforeCollect({
    required num quantity,
    required OnlinePickTaskItem currentItem,
    OnlinePickBarcodeContent? barcode,
  }) async {
    if (state.mode != OnlinePickCollectionModeType.outbound) {
      return null;
    }

    final storeSite = state.location.trim();
    if (storeSite.isEmpty) {
      throw Exception('请先扫描库位条码');
    }

    final materialCode =
        (barcode?.materialCode ?? currentItem.materialCode ?? '').trim();
    if (materialCode.isEmpty) {
      throw Exception('当前物料编码缺失，无法校验库存');
    }

    final requestedQty = quantity.toDouble();
    if (requestedQty <= 0) {
      throw Exception('采集数量必须大于 0');
    }

    final batchNo = _resolveBatchNo(barcode, currentItem);
    final serialNumber = _resolveSerialNumber(barcode, currentItem);
    final expectedErp = (state.expectedErpStore.isNotEmpty
            ? state.expectedErpStore
            : currentItem.subInventoryCode ?? '')
        .trim();

    final inventoryKey = _composeInventoryKey(
      storeSite: storeSite,
      materialCode: materialCode,
      batchNo: batchNo,
      serialNumber: serialNumber,
    );
    final collectedQty = state.inventoryQtyMap[inventoryKey] ?? 0;

    final bool serialControlled = _isSerialControlled(barcode, currentItem);

    final List<Map<String, dynamic>> records = serialControlled
        ? await _collectionService.getRepertoryByStoreSiteSn(
            storeSiteNo: storeSite,
            materialCode: materialCode,
            erpStoreroom: expectedErp.isNotEmpty ? expectedErp : null,
            batchNo: batchNo.isNotEmpty ? batchNo : null,
            serialNumber: serialNumber.isNotEmpty ? serialNumber : null,
          )
        : await _collectionService.getRepertoryByStoreSite(
            storeSiteNo: storeSite,
            materialCode: materialCode,
            erpStoreroom: expectedErp.isNotEmpty ? expectedErp : null,
            batchNo: batchNo.isNotEmpty ? batchNo : null,
            serialNumber: serialNumber.isNotEmpty ? serialNumber : null,
          );

    if (records.isEmpty) {
      final targetLabel = serialControlled && serialNumber.isNotEmpty
          ? '序列号【$serialNumber】'
          : (batchNo.isNotEmpty ? '批次【$batchNo】' : '库存');
      throw Exception('库位【$storeSite】物料【$materialCode】$targetLabel不存在，请确认');
    }

    final filteredRecords = serialControlled
        ? records.where((record) {
            if (serialNumber.isEmpty) return true;
            final sn = record['sn']?.toString().trim() ?? '';
            return sn == serialNumber;
          }).toList()
        : records.where((record) {
            if (batchNo.isEmpty) return true;
            final batch = record['batchno']?.toString().trim() ?? '';
            return batch == batchNo;
          }).toList();

    if (filteredRecords.isEmpty) {
      if (serialControlled && serialNumber.isNotEmpty) {
        throw Exception('库位【$storeSite】物料【$materialCode】序列号【$serialNumber】不存在，请确认');
      }
      if (!serialControlled && batchNo.isNotEmpty) {
        throw Exception('库位【$storeSite】物料【$materialCode】批次【$batchNo】不存在，请确认');
      }
    }

    final recordsToUse =
        filteredRecords.isEmpty ? records : filteredRecords;
    final availableQty = recordsToUse.fold<double>(0, (sum, record) {
      return sum + _parseQty(record['repqty']);
    });

    if (availableQty <= 0) {
      throw Exception('库位【$storeSite】物料【$materialCode】库存不足，请确认');
    }

    final remainingQty = availableQty - collectedQty.toDouble();
    if (remainingQty + 1e-6 < requestedQty) {
      throw Exception(
        '库位【$storeSite】物料【$materialCode】剩余库存【${remainingQty.toStringAsFixed(3)}】不足，无法采集 ${requestedQty.toStringAsFixed(3)}',
      );
    }

    String? erpStore;
    for (final record in recordsToUse) {
      final candidate = record['erpStoreroom']?.toString().trim();
      if (candidate != null && candidate.isNotEmpty) {
        erpStore = candidate;
        break;
      }
    }

    if ((erpStore == null || erpStore.isEmpty)) {
      final erpRecords = await _collectionService.getRepertoryByStoreSiteErp(
        storeSiteNo: storeSite,
        materialCode: materialCode,
      );
      if (erpRecords.isNotEmpty) {
        final candidate =
            erpRecords.first['erpStoreroom']?.toString().trim();
        if (candidate != null && candidate.isNotEmpty) {
          erpStore = candidate;
        }
      }
    }

    if (expectedErp.isNotEmpty && erpStore != null && erpStore.isNotEmpty) {
      if (expectedErp != erpStore) {
        throw Exception(
          '任务要求子库【$expectedErp】与当前库位子库【$erpStore】不一致，请确认',
        );
      }
    }

    return _InventoryValidationResult(
      availableQuantity: availableQty,
      collectedQuantity: collectedQty.toDouble(),
      erpStore: erpStore?.isNotEmpty == true ? erpStore : expectedErp,
    );
  }

  String _resolveBatchNo(
    OnlinePickBarcodeContent? barcode,
    OnlinePickTaskItem currentItem,
  ) {
    final candidates = <String?>[
      barcode?.batchNo,
      currentItem.batchNo,
      currentItem.hintBatchNo,
    ];
    for (final value in candidates) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        return trimmed;
      }
    }
    return '';
  }

  String _resolveSerialNumber(
    OnlinePickBarcodeContent? barcode,
    OnlinePickTaskItem currentItem,
  ) {
    final candidates = <String?>[
      barcode?.serialNumber,
      currentItem.serialNumber,
    ];
    for (final value in candidates) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        return trimmed;
      }
    }
    return '';
  }

  bool _isSerialControlled(
    OnlinePickBarcodeContent? barcode,
    OnlinePickTaskItem currentItem,
  ) {
    final control = (barcode?.sequenceControl ?? '').trim();
    if (control.isEmpty) {
      return (currentItem.serialNumber ?? '').trim().isNotEmpty;
    }

    return control != '1' && control != '2';
  }

  String _composeInventoryKey({
    required String storeSite,
    required String materialCode,
    String? batchNo,
    String? serialNumber,
  }) {
    final normalizedSite = storeSite.trim();
    final normalizedMaterial = materialCode.trim();
    final normalizedBatch = (batchNo ?? '').trim();
    final normalizedSerial = (serialNumber ?? '').trim();
    final suffix = normalizedBatch.isNotEmpty ? normalizedBatch : normalizedSerial;
    return [normalizedSite, normalizedMaterial, suffix].join('|');
  }

  double _parseQty(dynamic value) {
    if (value == null) {
      return 0;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value.toString()) ?? 0;
  }

  Future<void> _onStocksSynced(
    OnlinePickCollectionStocksSynced event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final stocks = event.payload
        .map((item) => OnlinePickCollectionStock.fromJson(item))
        .toList();

    final cache = _rebuildCachesFromStocks(stocks);
    final detailList = _deriveDetailListFromRemote(stocks);
    final collecting = _buildCollectingListFromDetail(detailList);
    final filteredChecks = _filterInventoryChecks(state.inventoryChecks, stocks);

    emit(
      state.copyWith(
        collectedStocks: stocks,
        detailList: detailList,
        collectingList: collecting,
        serialMap: cache.serialMap,
        materialQtyMap: cache.materialQtyMap,
        inventoryQtyMap: cache.inventoryQtyMap,
        expectedErpStore: cache.expectedErpStore,
        status: const CollectionStatus.success('采集结果已同步'),
        clearBarcode: true,
        clearCurrentItem: true,
        clearPendingQuantity: true,
        focus: true,
        inventoryChecks: filteredChecks,
        clearPendingInventoryPrompt: true,
      ),
    );
    await _persistCache();
  }

  void _onResetStatus(
    OnlinePickCollectionResetStatus event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  void _onChangeTab(
    OnlinePickCollectionChangeTab event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onSelectionChanged(
    OnlinePickCollectionSelectionChanged event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    final ids = event.selectedItems.map((e) => e.outTaskItemId).toList();
    emit(state.copyWith(selectedDetailIds: ids));
  }

  void _onFocusRequested(
    OnlinePickCollectionFocusRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(focus: event.focus));
  }

  Future<void> _onDeleteStocksRequested(
    OnlinePickCollectionDeleteStocksRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (event.stockIds.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请选择要删除的采集记录'),
          focus: true,
        ),
      );
      return;
    }

    final remaining = state.collectedStocks
        .where((stock) => !event.stockIds.contains(stock.stockId))
        .toList();

    final cache = _rebuildCachesFromStocks(remaining);
    final detailList = _deriveDetailListFromRemote(remaining);
    final collecting = _buildCollectingListFromDetail(detailList);
    final filteredChecks = _filterInventoryChecks(state.inventoryChecks, remaining);

    emit(
      state.copyWith(
        collectedStocks: remaining,
        detailList: detailList,
        collectingList: collecting,
        serialMap: cache.serialMap,
        materialQtyMap: cache.materialQtyMap,
        inventoryQtyMap: cache.inventoryQtyMap,
        expectedErpStore: cache.expectedErpStore,
        status: const CollectionStatus.success('已删除选中采集记录'),
        focus: true,
        inventoryChecks: filteredChecks,
        clearPendingInventoryPrompt: true,
      ),
    );
    await _persistCache();
  }

  Future<void> _onResultRemoved(
    OnlinePickCollectionResultRemoved event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (event.removedStocks.isEmpty) {
      return;
    }

    final removedIds = event.removedStocks.map((e) => e.stockId).toSet();
    final remaining = state.collectedStocks
        .where((stock) => !removedIds.contains(stock.stockId))
        .toList();

    final cache = _rebuildCachesFromStocks(remaining);
    final detailList = _deriveDetailListFromRemote(remaining);
    final collecting = _buildCollectingListFromDetail(detailList);
    final filteredChecks = _filterInventoryChecks(state.inventoryChecks, remaining);

    emit(
      state.copyWith(
        collectedStocks: remaining,
        detailList: detailList,
        collectingList: collecting,
        serialMap: cache.serialMap,
        materialQtyMap: cache.materialQtyMap,
        inventoryQtyMap: cache.inventoryQtyMap,
        expectedErpStore: cache.expectedErpStore,
        status: const CollectionStatus.success('采集结果已更新'),
        focus: true,
        inventoryChecks: filteredChecks,
        clearPendingInventoryPrompt: true,
      ),
    );
    await _persistCache();
  }

  Future<void> _onDetailsRefreshRequested(
    OnlinePickCollectionDetailsRefreshRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    await _refreshTaskData(
      emit,
      showLoading: event.showLoading,
      successMessage: event.successMessage,
    );
  }

  Future<void> _onSubmitRequested(
    OnlinePickCollectionSubmitRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('暂无采集记录可提交'),
          focus: true,
        ),
      );
      return;
    }

    if (state.pendingInventoryPrompt != null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先录入结余数量后再提交'),
          focus: true,
        ),
      );
      return;
    }

    if (state.inventoryChecks.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集结余库存后再提交！'),
          focus: true,
        ),
      );
      return;
    }

    final missingStocks = state.collectedStocks
        .where((stock) => !_hasInventoryCheckForStock(stock))
        .toList();
    if (missingStocks.isNotEmpty) {
      final first = missingStocks.first;
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '物料【${first.materialCode}】没有采集结余库存，请补录后再提交！',
          ),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      final downShelvesInfos = state.collectedStocks.map((stock) {
        return {
          'stockid': stock.stockId,
          'matcode': stock.materialCode,
          'batchno': stock.batchNo,
          'sn': stock.serialNumber,
          'taskQty': stock.taskQty,
          'collectQty': stock.collectQty,
          'outtaskitemid': stock.outTaskItemId,
          'taskid': stock.taskId,
          'storeRoom': stock.storeRoom,
          'storeSite': stock.storeSite,
          'erpStore': stock.erpStore,
          'trayNo': stock.trayNo,
        };
      }).toList();

      final itemInfos = state.collectedStocks.map((stock) {
        return {
          'outtaskitemid': stock.outTaskItemId,
          'collectQty': stock.collectQty,
          'matcode': stock.materialCode,
          'storeSite': stock.storeSite,
          'trayNo': stock.trayNo,
        };
      }).toList();

      final inventoryCheckInfos = state.inventoryChecks.map((check) {
        return {
          'stockid': check.checkId,
          'matCode': check.materialCode,
          'trayNo': check.trayNo,
          'storeSite': check.storeSite,
          'collectQty': check.quantity,
        };
      }).toList();

      await _submitCollection(
        downShelvesInfos,
        itemInfos,
        inventoryCheckInfos,
      );
      await _clearCollectionAfterSubmit(emit);
      await _refreshTaskData(
        emit,
        successMessage: '${state.submitChannel.label}提交成功',
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _clearCollectionAfterSubmit(
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final box = _cacheBox;
    if (box != null) {
      await box.clear();
    }

    final detailList = _deriveDetailListFromRemote(const []);
    final collectingList = _buildCollectingListFromDetail(detailList);

    emit(
      state.copyWith(
        collectedStocks: const [],
        detailList: detailList,
        collectingList: collectingList,
        serialMap: const {},
        materialQtyMap: const {},
        inventoryQtyMap: const {},
        step: OnlinePickCollectionStep.location,
        placeholder: _placeholderForStep(OnlinePickCollectionStep.location),
        focus: true,
        clearBarcode: true,
        clearCurrentItem: true,
        clearPendingQuantity: true,
        inventoryChecks: const [],
        clearPendingInventoryPrompt: true,
      ),
    );
  }

  Future<void> _submitCollection(
    List<Map<String, dynamic>> downShelvesInfos,
    List<Map<String, dynamic>> itemInfos,
    List<Map<String, dynamic>> inventoryCheckInfos,
  ) async {
    switch (state.submitChannel) {
      case OnlinePickSubmissionChannel.standard:
        await _collectionService.commitDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
          inventoryCheckInfos: inventoryCheckInfos,
        );
        break;
      case OnlinePickSubmissionChannel.tray:
        await _collectionService.commitTrayDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
          inventoryCheckInfos: inventoryCheckInfos,
        );
        break;
      case OnlinePickSubmissionChannel.aswh:
        await _collectionService.commitAswhDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
          inventoryCheckInfos: inventoryCheckInfos,
        );
        break;
    }
  }

  Future<void> _onCacheCleared(
    OnlinePickCollectionCacheCleared event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final box = _cacheBox;
    if (box == null) return;
    await box.clear();
    emit(
      state.copyWith(
        status: const CollectionStatus.success('已清空采集缓存'),
        focus: true,
        inventoryChecks: const [],
        clearPendingInventoryPrompt: true,
      ),
    );
  }

  void _onModeChanged(
    OnlinePickCollectionModeChanged event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(
      state.copyWith(
        mode: event.mode.type,
        status: CollectionStatus.success('已切换至 ${event.mode.label} 模式'),
        focus: true,
      ),
    );
  }

  void _onLocationSelected(
    OnlinePickCollectionLocationSelected event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(
      state.copyWith(
        selectedLocation: event.location,
        status:
            CollectionStatus.success('拣选口已切换为 ${event.location.label}'),
        focus: true,
      ),
    );
  }

  Future<void> _onPalletsCallRequested(
    OnlinePickCollectionPalletsCallRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (event.count <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘数量需大于 0'),
          focus: true,
        ),
      );
      return;
    }

    if (state.collectedStocks.isNotEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('存在未提交的采集记录，无法下发托盘'),
          focus: true,
        ),
      );
      return;
    }

    final location = state.selectedLocation;
    if (location == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先选择拣选口位置'),
          focus: true,
        ),
      );
      return;
    }

    final taskNo = state.task.outTaskNo ?? '';
    if (taskNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('任务凭证号为空，无法下发托盘'),
          focus: true,
        ),
      );
      return;
    }

    final uniqueTrays = _uniqueTrayItems().where((item) {
      final tray = (item.palletNo ?? '').trim();
      if (tray.isEmpty) return false;
      return !state.requestedPallets.contains(tray);
    }).toList();

    if (uniqueTrays.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('暂无可下发的托盘记录'),
          focus: true,
        ),
      );
      return;
    }

    final targetItems = uniqueTrays.take(event.count).toList();
    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));

    final processedTrays = <String>[];
    try {
      for (final item in targetItems) {
        final tray = (item.palletNo ?? '').trim();
        final startAddr = (item.storeSiteNo ?? '').trim();
        if (tray.isEmpty || startAddr.isEmpty) {
          continue;
        }

        await _collectionService.commitDownWmsToWcs(
          taskId: item.outTaskId.toString(),
          taskNo: taskNo,
          trayNo: tray,
          startAddr: startAddr,
          endAddr: location.value,
          singleFlag: event.count == 1 ? '1' : '0',
          isInventory: state.mode == OnlinePickCollectionModeType.inventory,
        );
        processedTrays.add(tray);
      }

      if (processedTrays.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('托盘数据不完整，未能下发指令'),
            focus: true,
          ),
        );
        return;
      }

      final updatedTrays = {
        ...state.requestedPallets,
        ...processedTrays,
      }.toList();

      final message = '已下发 ${processedTrays.length} 个托盘指令';
      emit(
        state.copyWith(
          status: CollectionStatus.success(message),
          requestedPallets: updatedTrays,
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onExceptionSubmitted(
    OnlinePickCollectionExceptionSubmitted event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final submission = event.submission;
    final materialCode = submission.materialCode.trim();
    if (materialCode.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请输入异常物料编码'),
          focus: true,
        ),
      );
      return;
    }

    if (submission.quantity <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('异常数量必须大于 0'),
          focus: true,
        ),
      );
      return;
    }

    final storeSite = (submission.storeSite.isNotEmpty
            ? submission.storeSite
            : state.location)
        .trim();
    if (storeSite.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请输入异常库位'),
          focus: true,
        ),
      );
      return;
    }

    final exceptionType = submission.exceptionType.trim();
    if (exceptionType.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请选择异常类型'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      final user = _userManager.userInfo;
      final operatorName =
          (user?.userName ?? '').isNotEmpty ? user!.userName : user?.nickName ?? '';
      final trayNo =
          submission.trayNo.isNotEmpty ? submission.trayNo.trim() : state.trayNo;
      final materialName = submission.materialName.trim();
      final batchNo = submission.batchNo.trim();
      final serialNumber = submission.serialNumber.trim();
      final unit = submission.unit.trim();
      final description = submission.description.trim();
      final proofNo = (state.task.taskComment ?? '').trim();
      var storeRoomNo = (state.task.storeRoomNo ?? '').trim();

      final request = <String, dynamic>{
        'taskNo': state.task.outTaskNo ?? '',
        'taskno': state.task.outTaskNo ?? '',
        'taskid': state.task.outTaskId.toString(),
        'matCode': materialCode,
        'matcode': materialCode,
        'collectQty': submission.quantity,
        'quantity': submission.quantity,
        'storeSiteNo': storeSite,
        'storesiteno': storeSite,
        'storeRoomNo': storeRoomNo,
        'storeroomno': storeRoomNo,
        'excepttype': exceptionType,
        'protype': exceptionType,
      };

      if (materialName.isNotEmpty) {
        request['matName'] = materialName;
        request['matname'] = materialName;
      }

      if (batchNo.isNotEmpty) {
        request['batchNo'] = batchNo;
        request['batchno'] = batchNo;
      }

      if (serialNumber.isNotEmpty) {
        request['sn'] = serialNumber;
      }

      if (unit.isNotEmpty) {
        request['unit'] = unit;
      }

      if (description.isNotEmpty) {
        request['exceptdesc'] = description;
      }

      if (trayNo.isNotEmpty) {
        request['palletno'] = trayNo;
      }

      if (proofNo.isNotEmpty) {
        request['proofNo'] = proofNo;
      }

      final currentItem = state.currentItem;
      if (currentItem != null) {
        request['taskQty'] = currentItem.taskQty;
        if (storeRoomNo.isEmpty && (currentItem.storeRoomNo ?? '').isNotEmpty) {
          storeRoomNo = currentItem.storeRoomNo!.trim();
          request['storeRoomNo'] = storeRoomNo;
          request['storeroomno'] = storeRoomNo;
        }
      }

      if (operatorName.isNotEmpty) {
        request['operator'] = operatorName;
      }

      await _collectionService.commitExceptionShelves(
        exceptionInfos: [request],
      );

      emit(
        state.copyWith(
          status: const CollectionStatus.success('异常补录已提交'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onEmptyTrayOutboundRequested(
    OnlinePickCollectionEmptyTrayOutboundRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isNotEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数据未提交，不允许下发指令'),
          focus: true,
        ),
      );
      return;
    }

    final trayNo = state.trayNo.trim();
    if (trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集托盘号'),
          focus: true,
        ),
      );
      return;
    }

    final location = state.selectedLocation?.value.trim() ?? '';
    if (location.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先选择拣选口位置'),
          focus: true,
        ),
      );
      return;
    }

    final taskNo = (state.task.outTaskNo ?? '').trim();
    if (taskNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('凭证号为空，请确认'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: state.task.outTaskId.toString(),
        taskNo: taskNo,
        trayNo: trayNo,
        startAddr: location,
        endAddr: '1111',
        singleFlag: '1',
      );

      emit(
        state.copyWith(
          status: const CollectionStatus.success('空托盘出库指令已下发，请等待'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onEmptyTrayInboundRequested(
    OnlinePickCollectionEmptyTrayInboundRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isNotEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数据未提交，不允许下发指令'),
          focus: true,
        ),
      );
      return;
    }

    final trayNo = state.trayNo.trim();
    if (trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集托盘号'),
          focus: true,
        ),
      );
      return;
    }

    final location = state.selectedLocation?.value.trim() ?? '';
    if (location.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先选择拣选口位置'),
          focus: true,
        ),
      );
      return;
    }

    final taskNo = (state.task.outTaskNo ?? '').trim();
    if (taskNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('凭证号为空，请确认'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: state.task.outTaskId.toString(),
        taskNo: taskNo,
        trayNo: trayNo,
        startAddr: location,
        endAddr: '0000',
        singleFlag: '1',
      );

      emit(
        state.copyWith(
          status: const CollectionStatus.success('空托盘入库指令已下发，请等待'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onSingleTrayRequested(
    OnlinePickCollectionSingleTrayRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isNotEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数据未提交，不允许下发指令'),
          focus: true,
        ),
      );
      return;
    }

    final trayNo = state.trayNo.trim();
    if (trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集托盘号'),
          focus: true,
        ),
      );
      return;
    }

    final startAddr = _resolveLocationByTray(trayNo);
    if (startAddr == null || startAddr.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('任务明细中不存在该托盘对应的库位'),
          focus: true,
        ),
      );
      return;
    }

    final endAddr = state.selectedLocation?.value.trim() ?? '';
    if (endAddr.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先选择拣选口位置'),
          focus: true,
        ),
      );
      return;
    }

    final taskNo = (state.task.outTaskNo ?? '').trim();
    if (taskNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('凭证号为空，请确认'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      await _collectionService.commitDownWmsToWcs(
        taskId: state.task.outTaskId.toString(),
        taskNo: taskNo,
        trayNo: trayNo,
        startAddr: startAddr,
        endAddr: endAddr,
        singleFlag: '1',
        isInventory: state.mode == OnlinePickCollectionModeType.inventory,
      );

      final updatedTrays = {
        ...state.requestedPallets,
        trayNo,
      }.toList();

      emit(
        state.copyWith(
          status: CollectionStatus.success('托盘 $trayNo 指令已下发，请等待'),
          requestedPallets: updatedTrays,
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onTrayReturnRequested(
    OnlinePickCollectionTrayReturnRequested event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isNotEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数据未提交，不允许下发回库指令'),
          focus: true,
        ),
      );
      return;
    }

    final trayNo = state.trayNo.trim();
    if (trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集托盘号'),
          focus: true,
        ),
      );
      return;
    }

    final location = state.selectedLocation?.value.trim() ?? '';
    if (location.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先选择拣选口位置'),
          focus: true,
        ),
      );
      return;
    }

    final taskNo = (state.task.outTaskNo ?? '').trim();
    if (taskNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('凭证号为空，请确认'),
          focus: true,
        ),
      );
      return;
    }

    final trayItem = _findTrayItem(trayNo);
    final targetSite = trayItem?.storeSiteNo?.trim() ?? '';
    if (targetSite.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('未找到托盘对应的目标库位，请确认'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading(), focus: true));
    try {
      await _collectionService.commitResetWmsToWcs(
        taskId: state.task.outTaskId.toString(),
        taskNo: taskNo,
        trayNo: trayNo,
        startAddr: location,
        endAddr: targetSite,
        isInventory: state.mode == OnlinePickCollectionModeType.inventory,
      );

      emit(
        state.copyWith(
          status: const CollectionStatus.success('托盘回库指令已下发，请等待'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  OnlinePickTaskItem? _findTrayItem(String trayNo) {
    final normalized = trayNo.trim();
    if (normalized.isEmpty) {
      return null;
    }

    final candidates = <OnlinePickTaskItem>{};
    candidates.addAll(state.detailList);
    candidates.addAll(state.collectingList);
    candidates.addAll(_remoteDetails);

    for (final item in candidates) {
      final tray = (item.palletNo ?? '').trim();
      if (tray.isEmpty) {
        continue;
      }
      if (tray == normalized) {
        return item;
      }
    }

    return null;
  }

  Future<void> _openCacheBox() async {
    if (_cacheBox != null) return;
    _cacheBox = await _hive.openBox<OnlinePickCollectionCacheSnapshot>(
      'aswh_down_collect_${state.task.outTaskId}',
    );
  }

  Future<void> _restoreFromCache(
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final box = _cacheBox;
    if (box == null) return;
    final snapshot = box.get('snapshot');
    if (snapshot == null) return;

    final cache = _rebuildCachesFromStocks(snapshot.stocks);
    final detailList = _deriveDetailListFromRemote(snapshot.stocks);
    final collecting = _buildCollectingListFromDetail(detailList);

    emit(
      state.copyWith(
        collectedStocks: snapshot.stocks,
        detailList: detailList,
        collectingList: collecting,
        serialMap: cache.serialMap,
        materialQtyMap: cache.materialQtyMap,
        inventoryQtyMap: cache.inventoryQtyMap,
        expectedErpStore: snapshot.expectedErpStore,
        location: snapshot.location,
        trayNo: snapshot.trayNo,
        barcodeContent: snapshot.lastBarcode,
        pendingQuantity: snapshot.pendingQuantity,
        status: const CollectionStatus.success('已恢复采集缓存'),
        focus: true,
        wcsCommands: state.wcsCommands,
      ),
    );
  }

  Future<void> _persistCache() async {
    final box = _cacheBox;
    if (box == null) return;
    final snapshot = OnlinePickCollectionCacheSnapshot(
      stocks: state.collectedStocks,
      dicSeq: state.serialMap,
      dicMtlQty: state.materialQtyMap,
      dicInvMtlQty: state.inventoryQtyMap,
      lastBarcode: state.barcodeContent,
      location: state.location,
      trayNo: state.trayNo,
      userId: _userManager.userInfo?.userId ?? 0,
      pendingQuantity: state.pendingQuantity,
      mode: state.mode.name,
      expectedErpStore: state.expectedErpStore,
    );
    await box.put('snapshot', snapshot);
  }

  Future<void> _refreshTaskData(
    Emitter<OnlinePickCollectionState> emit, {
    bool showLoading = false,
    String? successMessage,
  }) async {
    final query = _currentQuery;
    if (query == null) {
      return;
    }

    if (showLoading) {
      emit(
        state.copyWith(
          status: CollectionStatus.loading(),
          focus: true,
        ),
      );
    }

    try {
      final itemsFuture = _collectionService.fetchCollectionTaskItems(
        query: query,
      );
      final wcsFuture = _collectionService.fetchWcsCommands(
        taskComment: state.task.taskComment ?? '',
        taskId: state.task.outTaskId.toString(),
      );
      final roomControlFuture = _collectionService.getRoomMatControl(
        state.task.outTaskId.toString(),
      );

      final items = await itemsFuture;
      final wcsCommands = await wcsFuture;
      final roomMatControl = _parseRoomMatControl(await roomControlFuture);

      _remoteDetails = items;

      var expectedErpStore = state.expectedErpStore;
      if (items.isNotEmpty) {
        expectedErpStore = items.first.subInventoryCode ?? expectedErpStore;
      }

      final detailList = _deriveDetailListFromRemote(state.collectedStocks);
      final collectingList = _buildCollectingListFromDetail(detailList);

      emit(
        state.copyWith(
          detailList: detailList,
          collectingList: collectingList,
          expectedErpStore: expectedErpStore,
          wcsCommands: wcsCommands,
          status: successMessage != null
              ? CollectionStatus.success(successMessage)
              : const CollectionStatus.success(),
          focus: true,
          roomMatControl: roomMatControl,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  OnlinePickTaskItem _matchTaskItem(OnlinePickBarcodeContent barcode) {
    final materialCode = (barcode.materialCode ?? '').trim();
    if (materialCode.isEmpty) {
      throw OnlinePickMatchException('未识别到物料编码，请检查条码');
    }

    var candidates = _remoteDetails
        .where((item) => (item.materialCode ?? '').trim() == materialCode)
        .toList();
    if (candidates.isEmpty) {
      throw OnlinePickMatchException('任务明细中物料【$materialCode】不存在');
    }

    final trayNo = state.trayNo.trim();
    if (trayNo.isNotEmpty) {
      final trayMatches = candidates
          .where((item) => (item.palletNo ?? '').trim() == trayNo)
          .toList();
      if (trayMatches.isEmpty) {
        throw OnlinePickMatchException('任务明细中不存在托盘号【$trayNo】的物料【$materialCode】');
      }
      candidates = trayMatches;
    }

    final location = state.location.trim();
    if (location.isNotEmpty) {
      final siteMatches = candidates
          .where((item) => (item.storeSiteNo ?? '').trim() == location)
          .toList();
      if (siteMatches.isNotEmpty) {
        candidates = siteMatches;
      } else if (_shouldMatchSite()) {
        throw OnlinePickMatchException(
          '采集物料【$materialCode】库位【$location】不在任务明细中，请核实',
        );
      }
    } else if (_shouldMatchSite()) {
      final distinctSites = candidates
          .map((item) => (item.storeSiteNo ?? '').trim())
          .where((site) => site.isNotEmpty)
          .toSet();
      if (distinctSites.length > 1) {
        throw OnlinePickMatchException('请先扫描库位条码');
      }
    }

    final controlFlag = barcode.sequenceControl?.trim() ?? '';
    final batchNo = (barcode.batchNo ?? '').trim();
    final serialNumber = (barcode.serialNumber ?? '').trim();

    if (serialNumber.isNotEmpty) {
      final serialMatches = candidates
          .where((item) => (item.serialNumber ?? '').trim() == serialNumber)
          .toList();
      if (serialMatches.isNotEmpty) {
        candidates = serialMatches;
      }
    }

    if (_shouldMatchBatch(controlFlag)) {
      final normalizedBatch =
          batchNo.isNotEmpty ? batchNo : serialNumber;
      if (normalizedBatch.isNotEmpty) {
        final batchMatches = candidates.where((item) {
          final expected =
              (item.batchNo ?? item.hintBatchNo ?? '').trim();
          return expected == normalizedBatch;
        }).toList();
        if (batchMatches.isEmpty) {
          throw OnlinePickMatchException(
            '采集物料【$materialCode】批次【$normalizedBatch】不在任务明细中，请核实',
          );
        }
        candidates = batchMatches;
      }
    } else if (batchNo.isNotEmpty) {
      final batchMatches = candidates.where((item) {
        final expected = (item.batchNo ?? item.hintBatchNo ?? '').trim();
        return expected == batchNo;
      }).toList();
      if (batchMatches.isNotEmpty) {
        candidates = batchMatches;
      }
    }

    candidates.sort(
      (a, b) =>
          _remainingTaskQuantity(b).compareTo(_remainingTaskQuantity(a)),
    );

    final matched = candidates.firstWhere(
      (item) => _remainingTaskQuantity(item) > 1e-6,
      orElse: () => candidates.first,
    );

    if (_remainingTaskQuantity(matched) <= 1e-6) {
      throw OnlinePickMatchException('物料【$materialCode】任务已完成采集');
    }

    return matched;
  }

  _CollectionCache _rebuildCachesFromStocks(
    List<OnlinePickCollectionStock> stocks,
  ) {
    final serialMap = <String, String>{};
    final materialQtyMap = <String, List<double>>{};
    final inventoryQtyMap = <String, double>{};
    var expectedErpStore = '';

    for (final stock in stocks) {
      final serialKey =
          '${stock.materialCode}@${stock.serialNumber ?? ''}'.trim();
      if ((stock.serialNumber ?? '').isNotEmpty) {
        serialMap[serialKey] = stock.stockId;
      }

      final materialKey = _materialKey(stock);
      final existing = materialQtyMap[materialKey];
      final first = existing != null ? existing.first : stock.collectQty.toDouble();
      final total =
          (existing != null ? existing.last : 0) + stock.collectQty.toDouble();
      materialQtyMap[materialKey] = [first, total];

      final inventoryKey = _inventoryKey(stock);
      inventoryQtyMap[inventoryKey] =
          (inventoryQtyMap[inventoryKey] ?? 0) + stock.collectQty.toDouble();

      if (expectedErpStore.isEmpty && (stock.erpStore?.isNotEmpty ?? false)) {
        expectedErpStore = stock.erpStore!;
      }
    }

    return _CollectionCache(
      serialMap: serialMap,
      materialQtyMap: materialQtyMap,
      inventoryQtyMap: inventoryQtyMap,
      expectedErpStore: expectedErpStore,
    );
  }

  OnlinePickLocationOption? _resolveSelectedLocation(
    List<OnlinePickLocationOption> options,
  ) {
    if (options.isEmpty) {
      return null;
    }
    final current = state.selectedLocation;
    if (current == null) {
      return options.first;
    }
    return options.firstWhere(
      (option) => option.value == current.value,
      orElse: () => options.first,
    );
  }

  List<OnlinePickTaskItem> _uniqueTrayItems() {
    final seen = <String>{};
    final result = <OnlinePickTaskItem>[];
    for (final item in _remoteDetails) {
      final tray = (item.palletNo ?? '').trim();
      if (tray.isEmpty || seen.contains(tray)) {
        continue;
      }
      seen.add(tray);
      result.add(item);
    }
    return result;
  }

  List<OnlinePickTaskItem> _deriveDetailListFromRemote(
    List<OnlinePickCollectionStock> stocks,
  ) {
    final base = List<OnlinePickTaskItem>.from(_remoteDetails);
    if (stocks.isEmpty) {
      return base;
    }

    final additionMap = _aggregateStockQuantities(stocks);
    if (additionMap.isEmpty) {
      return base;
    }

    return base
        .map((item) {
          final addition = additionMap[item.outTaskItemId];
          if (addition == null || addition == 0) {
            return item;
          }
          final updatedCollected =
              item.collectedQty.toDouble() + addition.toDouble();
          return item.copyWith(collectedQty: updatedCollected);
        })
        .toList();
  }

  List<OnlinePickTaskItem> _buildCollectingListFromDetail(
    List<OnlinePickTaskItem> detailList,
  ) {
    return detailList
        .where((item) => item.collectedQty.toDouble() > 0)
        .toList();
  }

  Map<int, double> _aggregateStockQuantities(
    List<OnlinePickCollectionStock> stocks,
  ) {
    final map = <int, double>{};
    for (final stock in stocks) {
      final id = int.tryParse(stock.outTaskItemId);
      if (id == null) continue;
      map[id] = (map[id] ?? 0) + stock.collectQty.toDouble();
    }
    return map;
  }

  String _placeholderForStep(OnlinePickCollectionStep step) {
    switch (step) {
      case OnlinePickCollectionStep.location:
        return '请扫描库位条码';
      case OnlinePickCollectionStep.tray:
        return '请扫描托盘条码';
      case OnlinePickCollectionStep.material:
        return '请扫描物料二维码';
      case OnlinePickCollectionStep.quantity:
        return '请扫描或输入采集数量';
      case OnlinePickCollectionStep.review:
        return '请检查采集结果';
    }
  }

  String _materialKey(OnlinePickCollectionStock stock) {
    return [
      stock.materialCode ?? '',
      stock.batchNo ?? '',
      stock.storeSite ?? '',
      stock.trayNo ?? '',
    ].join('|');
  }

  String _inventoryKey(OnlinePickCollectionStock stock) {
    return _composeInventoryKey(
      storeSite: stock.storeSite ?? '',
      materialCode: stock.materialCode,
      batchNo: stock.batchNo,
      serialNumber: stock.serialNumber,
    );
  }

  String? _resolveLocationByTray(String trayNo) {
    final normalized = trayNo.trim();
    if (normalized.isEmpty) {
      return null;
    }
    try {
      final matched = _remoteDetails.firstWhere(
        (item) => (item.palletNo ?? '').trim() == normalized,
      );
      final site = (matched.storeSiteNo ?? '').trim();
      return site.isNotEmpty ? site : null;
    } catch (_) {
      return null;
    }
  }

  num _remainingTaskQuantity(OnlinePickTaskItem item) {
    final base = _remoteDetails.firstWhere(
      (detail) => detail.outTaskItemId == item.outTaskItemId,
      orElse: () => item,
    );
    final collected = state.collectedStocks
        .where((stock) => stock.outTaskItemId == item.outTaskItemId.toString())
        .fold<double>(0, (sum, stock) => sum + stock.collectQty.toDouble());
    return base.taskQty.toDouble() - collected;
  }

  double _taskQuantityForMaterialAtSite({
    required String materialCode,
    required String storeSite,
    required String trayNo,
  }) {
    return _remoteDetails.where((item) {
      final matchesMaterial = (item.materialCode ?? '').trim() == materialCode;
      final matchesSite = storeSite.isEmpty ||
          (item.storeSiteNo ?? '').trim() == storeSite;
      final matchesTray = trayNo.isEmpty ||
          (item.palletNo ?? '').trim() == trayNo;
      return matchesMaterial && matchesSite && matchesTray;
    }).fold<double>(0, (sum, item) => sum + item.taskQty.toDouble());
  }

  double _collectedQuantityForMaterialAtSite({
    required List<OnlinePickCollectionStock> updatedStocks,
    required String materialCode,
    required String storeSite,
    required String trayNo,
  }) {
    return updatedStocks.where((stock) {
      final matchesMaterial = stock.materialCode == materialCode;
      final matchesSite = storeSite.isEmpty ||
          (stock.storeSite ?? '').trim() == storeSite;
      final matchesTray = trayNo.isEmpty ||
          (stock.trayNo ?? '').trim() == trayNo;
      return matchesMaterial && matchesSite && matchesTray;
    }).fold<double>(0, (sum, stock) => sum + stock.collectQty.toDouble());
  }

  OnlinePickInventoryPrompt? _deriveInventoryPrompt({
    required OnlinePickTaskItem currentItem,
    required OnlinePickBarcodeContent? barcode,
    required List<OnlinePickCollectionStock> updatedStocks,
  }) {
    final controlFlag = barcode?.sequenceControl?.trim() ?? '';
    final materialCode = (currentItem.materialCode ?? '').trim();
    if (materialCode.isEmpty) {
      return null;
    }

    final trayNo = state.trayNo.trim();
    final storeSite = state.location.trim().isNotEmpty
        ? state.location.trim()
        : (currentItem.storeSiteNo ?? '').trim();

    if (controlFlag == '1' || controlFlag == '2') {
      return OnlinePickInventoryPrompt(
        materialCode: materialCode,
        storeSite: storeSite,
        trayNo: trayNo,
      );
    }

    final totalTask = _taskQuantityForMaterialAtSite(
      materialCode: materialCode,
      storeSite: storeSite,
      trayNo: trayNo,
    );
    final totalCollected = _collectedQuantityForMaterialAtSite(
      updatedStocks: updatedStocks,
      materialCode: materialCode,
      storeSite: storeSite,
      trayNo: trayNo,
    );

    if ((totalTask - totalCollected).abs() < 1e-6) {
      return OnlinePickInventoryPrompt(
        materialCode: materialCode,
        storeSite: storeSite,
        trayNo: trayNo,
      );
    }
    return null;
  }

  List<OnlinePickInventoryCheck> _filterInventoryChecks(
    List<OnlinePickInventoryCheck> checks,
    List<OnlinePickCollectionStock> stocks,
  ) {
    if (checks.isEmpty || stocks.isEmpty) {
      return const [];
    }
    final keys = stocks
        .map(
          (stock) => _inventoryCheckKey(
            stock.materialCode,
            stock.trayNo,
            stock.storeSite,
          ),
        )
        .toSet();
    return checks
        .where(
          (check) => keys.contains(
            _inventoryCheckKey(
              check.materialCode,
              check.trayNo,
              check.storeSite,
            ),
          ),
        )
        .toList();
  }

  String _inventoryCheckKey(
    String materialCode,
    String? trayNo,
    String? storeSite,
  ) {
    return [
      materialCode.trim(),
      (storeSite ?? '').trim(),
      (trayNo ?? '').trim(),
    ].join('|');
  }

  List<OnlinePickInventoryCheck> _mergeInventoryCheck(
    List<OnlinePickInventoryCheck> existing,
    OnlinePickInventoryPrompt prompt,
    double quantity,
  ) {
    final tray = prompt.trayNo.isNotEmpty ? prompt.trayNo : state.trayNo.trim();
    final site = prompt.storeSite.isNotEmpty
        ? prompt.storeSite
        : state.location.trim();
    final key = _inventoryCheckKey(prompt.materialCode, tray, site);

    final updated = <OnlinePickInventoryCheck>[];
    var merged = false;
    for (final check in existing) {
      final currentKey =
          _inventoryCheckKey(check.materialCode, check.trayNo, check.storeSite);
      if (currentKey == key) {
        updated.add(check.copyWith(quantity: check.quantity + quantity));
        merged = true;
      } else {
        updated.add(check);
      }
    }

    if (!merged) {
      updated.add(
        OnlinePickInventoryCheck(
          checkId: _uuid.v4(),
          materialCode: prompt.materialCode,
          trayNo: tray.isNotEmpty ? tray : null,
          storeSite: site.isNotEmpty ? site : null,
          quantity: quantity,
        ),
      );
    }

    return updated;
  }

  bool _hasInventoryCheckForStock(OnlinePickCollectionStock stock) {
    final key = _inventoryCheckKey(
      stock.materialCode,
      stock.trayNo,
      stock.storeSite,
    );
    return state.inventoryChecks.any(
      (check) =>
          _inventoryCheckKey(check.materialCode, check.trayNo, check.storeSite) ==
          key,
    );
  }

  bool _shouldMatchSite() {
    final force = (state.task.forceSite ?? '').toUpperCase() == 'Y';
    return force || state.roomMatControl.trim() == '1';
  }

  bool _shouldMatchBatch(String controlFlag) {
    final normalized = controlFlag.trim();
    final force = (state.task.forceBatch ?? '').toUpperCase() == 'Y';
    final strongRoom = state.roomMatControl.trim() == '1';
    return force ||
        strongRoom ||
        normalized == '1' ||
        normalized == '2';
  }

  String _parseRoomMatControl(String raw) {
    if (raw.isEmpty) {
      return '0';
    }
    final parts = raw.split('!').map((part) => part.trim()).toList();
    if (parts.length >= 5 && parts[4].isNotEmpty) {
      return parts[4];
    }
    for (final part in parts.reversed) {
      if (part.isNotEmpty) {
        return part;
      }
    }
    return '0';
  }

  static OnlinePickSubmissionChannel _resolveInitialSubmissionChannel(
    OnlinePickTask task,
    String? submissionHint,
  ) {
    final normalizedHint = submissionHint?.trim().toLowerCase() ?? '';
    if (normalizedHint.isNotEmpty) {
      if (_matchesTrayType(normalizedHint)) {
        return OnlinePickSubmissionChannel.tray;
      }
      if (_matchesStandardType(normalizedHint)) {
        return OnlinePickSubmissionChannel.standard;
      }
      if (_matchesAswhType(normalizedHint)) {
        return OnlinePickSubmissionChannel.aswh;
      }
    }

    final candidates = <String?>[
      task.taskComment,
      task.storeRoomNo,
      task.workStation,
      task.scheduleGroupName,
      task.urgentFlag,
    ];

    for (final value in candidates) {
      if (_matchesTrayType(value)) {
        return OnlinePickSubmissionChannel.tray;
      }
    }

    for (final value in candidates) {
      if (_matchesStandardType(value)) {
        return OnlinePickSubmissionChannel.standard;
      }
    }

    for (final value in candidates) {
      if (_matchesAswhType(value)) {
        return OnlinePickSubmissionChannel.aswh;
      }
    }

    return OnlinePickSubmissionChannel.aswh;
  }

  static bool _matchesTrayType(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final lower = value.toLowerCase();
    return lower.contains('tray') ||
        lower.contains('pallet') ||
        lower.contains('托盘') ||
        lower.contains('整托') ||
        lower.contains('traydown') ||
        _containsCode(lower, '02');
  }

  static bool _matchesStandardType(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final lower = value.toLowerCase();
    return lower.contains('flat') ||
        lower.contains('平库') ||
        lower.contains('standard') ||
        (lower.contains('commitdown') && !lower.contains('tray')) ||
        (lower.contains('downshelves') && !lower.contains('tray')) ||
        lower.contains('wms') ||
        _containsCode(lower, '00') ||
        _containsCode(lower, '01');
  }

  static bool _matchesAswhType(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final lower = value.toLowerCase();
    return lower.contains('aswh') ||
        lower.contains('as/rs') ||
        lower.contains('自动化') ||
        lower.contains('立库') ||
        _containsCode(lower, '03');
  }

  static bool _containsCode(String source, String code) {
    final pattern = RegExp(
        '(^|[^0-9a-z])${RegExp.escape(code.toLowerCase())}($|[^0-9a-z])');
    return pattern.hasMatch(source.toLowerCase());
  }
}

class _CollectionCache {
  const _CollectionCache({
    required this.serialMap,
    required this.materialQtyMap,
    required this.inventoryQtyMap,
    required this.expectedErpStore,
  });

  final Map<String, String> serialMap;
  final Map<String, List<double>> materialQtyMap;
  final Map<String, double> inventoryQtyMap;
  final String expectedErpStore;
}

class OnlinePickMatchException implements Exception {
  OnlinePickMatchException(this.message);

  final String message;

  @override
  String toString() => message;
}

class _InventoryValidationResult {
  const _InventoryValidationResult({
    required this.availableQuantity,
    required this.collectedQuantity,
    this.erpStore,
  });

  final double availableQuantity;
  final double collectedQuantity;
  final String? erpStore;
}
