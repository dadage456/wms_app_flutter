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
          emit(
            state.copyWith(
              trayNo: result.normalizedValue,
              step: OnlinePickCollectionStep.material,
              placeholder:
                  _placeholderForStep(OnlinePickCollectionStep.material),
              focus: true,
              status: CollectionStatus.success('托盘 ${result.normalizedValue} 就绪'),
              clearPendingQuantity: true,
            ),
          );
          await _persistCache();
          break;
        case OnlinePickScanType.material:
          if (state.location.isEmpty) {
            emit(
              state.copyWith(
                status: CollectionStatus.error('请先扫描库位条码'),
                focus: true,
              ),
            );
            return;
          }
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

          final matched = _matchTaskItem(barcode.materialCode ?? '');
          if (matched == null) {
            emit(
              state.copyWith(
                status: CollectionStatus.error('未匹配到待采集任务行'),
                focus: true,
                clearBarcode: true,
                clearCurrentItem: true,
              ),
            );
            return;
          }

          emit(
            state.copyWith(
              barcodeContent: barcode,
              currentItem: matched,
              step: OnlinePickCollectionStep.quantity,
              placeholder: _placeholderForStep(OnlinePickCollectionStep.quantity),
              status: CollectionStatus.success('物料 ${barcode.materialCode} 已匹配'),
              focus: true,
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

    _InventoryValidationResult? validationResult;
    try {
      validationResult = await _validateInventoryBeforeCollect(
        quantity: event.quantity,
        currentItem: currentItem,
        barcode: state.barcodeContent,
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

    final barcode = state.barcodeContent;
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
        status: CollectionStatus.success('已记录采集数量 ${event.quantity}'),
        step: OnlinePickCollectionStep.location,
        placeholder: _placeholderForStep(OnlinePickCollectionStep.location),
        focus: true,
        clearBarcode: true,
        clearCurrentItem: true,
        clearPendingQuantity: true,
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

      await _submitCollection(downShelvesInfos, itemInfos);
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
      ),
    );
  }

  Future<void> _submitCollection(
    List<Map<String, dynamic>> downShelvesInfos,
    List<Map<String, dynamic>> itemInfos,
  ) async {
    switch (state.submitChannel) {
      case OnlinePickSubmissionChannel.standard:
        await _collectionService.commitDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
        );
        break;
      case OnlinePickSubmissionChannel.tray:
        await _collectionService.commitTrayDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
        );
        break;
      case OnlinePickSubmissionChannel.aswh:
        await _collectionService.commitAswhDownShelves(
          downShelvesInfos: downShelvesInfos,
          itemListInfos: itemInfos,
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

      final items = await itemsFuture;
      final wcsCommands = await wcsFuture;

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

  OnlinePickTaskItem? _matchTaskItem(String materialCode) {
    final trimmed = materialCode.trim();
    if (trimmed.isEmpty) return null;
    try {
      return state.detailList.firstWhere(
        (item) => (item.materialCode ?? '').trim() == trimmed,
      );
    } catch (_) {
      return null;
    }
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
