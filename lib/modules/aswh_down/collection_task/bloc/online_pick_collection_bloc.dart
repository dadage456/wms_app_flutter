import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/services/collection_cache_manager.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/services/aswh_down_collection_service.dart';
import 'package:wms_app/services/user_manager.dart';

class OnlinePickCollectionBloc
    extends Bloc<OnlinePickCollectionEvent, OnlinePickCollectionState> {
  OnlinePickCollectionBloc({
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
    required OnlinePickCollectionCacheManager cacheManager,
  }) : _collectionService = collectionService,
       _userManager = userManager,
       _cacheManager = cacheManager,
       super(const OnlinePickCollectionState()) {
    on<InitializeCollectionEvent>(_onInitializeCollection);
    on<PerformScanEvent>(_onPerformScan);
    on<ChangeCollectionTabEvent>(_onChangeTab);
    on<UpdateSelectionEvent>(_onUpdateSelection);
    on<ResetCollectionStatusEvent>(_onResetStatus);
    on<SetCollectionFocusEvent>(_onSetFocus);
    on<DeleteCollectedStocksEvent>(_onDeleteCollectedStocks);
    on<SubmitCollectionEvent>(_onSubmitCollection);
    on<LoadPickLocationsEvent>(_onLoadPickLocations);
    on<SelectPickLocationEvent>(_onSelectPickLocation);
    on<ChangeCollectionModeEvent>(_onChangeMode);
    on<RequestEmptyTrayOutEvent>(_onEmptyTrayOut);
    on<RequestEmptyTrayInEvent>(_onEmptyTrayIn);
    on<RequestSingleTrayEvent>(_onSingleTrayRequest);
    on<RequestReturnTrayEvent>(_onReturnTrayRequest);
    on<RequestAllTrayEvent>(_onAllTrayRequest);
    on<PersistCollectionCacheEvent>(_onPersistCache);
  }

  final AswhDownCollectionService _collectionService;
  final UserManager _userManager;
  final OnlinePickCollectionCacheManager _cacheManager;

  final Uuid _uuid = const Uuid();

  Future<void> _onInitializeCollection(
    InitializeCollectionEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final siteFlag = (event.task.forceSite ?? '').toUpperCase();
    final batchFlag = (event.task.forceBatch ?? '').toUpperCase();
    final mtlCheckMode = _determineMtlCheckMode(
      siteFlag: siteFlag,
      batchFlag: batchFlag,
    );

    emit(
      state.copyWith(
        status: CollectionStatus.loading(),
        task: event.task,
        placeholder: '请扫描库位',
        step: OnlinePickCollectionStep.location,
        currentTrayCode: '',
        currentTab: 0,
        selectedItemIds: [],
        currentTrayItems: const [],
        pendingCheckItems: const [],
        collectedStocks: const [],
        selectedLocation: event.task.taskComment ?? '',
        dicSeq: const {},
        dicMtlQty: const {},
        dicInvMtlQty: const {},
        issuedTrayNos: const [],
        mode: OnlinePickCollectionModeType.outbound,
        currentBarcode: null,
        requireInventoryCheck: false,
        siteFlag: siteFlag,
        batchFlag: batchFlag,
        mtlCheckMode: mtlCheckMode,
      ),
    );

    try {
      final collectorId = event.userId == 0
          ? _userManager.userInfo?.userId ?? 0
          : event.userId;

      final query = OnlinePickCollectionQuery(
        outTaskNo: event.task.outTaskNo,
        storeRoomNo: event.task.storeRoomNo ?? '',
        forceSite: event.task.forceSite ?? '',
        forceBatch: event.task.forceBatch ?? '',
        taskComment: event.task.taskComment ?? '',
        workStation: event.task.workStation ?? '',
        collector: collectorId,
      );

      final items = await _collectionService.fetchCollectionTaskItems(
        query: query,
      );

      final roomMatControl = await _loadRoomMatControl(event.task);

      emit(
        state.copyWith(
          status: CollectionStatus.success('任务明细已加载'),
          taskItems: items,
          pendingCheckItems: _buildPendingItems(items),
          currentTrayItems: const [],
          focus: true,
          roomMatControl: roomMatControl,
        ),
      );

      await _restoreCache(event.task, collectorId, emit);
      add(const LoadPickLocationsEvent());
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '加载任务明细失败'),
          taskItems: const [],
          currentTrayItems: const [],
          pendingCheckItems: const [],
          selectedItemIds: const [],
        ),
      );
    } catch (error) {
      log('加载任务明细失败：${error.toString()}');
      emit(
        state.copyWith(
          status: CollectionStatus.error('加载任务明细失败：${error.toString()}'),
          taskItems: const [],
          currentTrayItems: const [],
          pendingCheckItems: const [],
          selectedItemIds: const [],
        ),
      );
    }
  }

  Future<void> _onPerformScan(
    PerformScanEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final code = event.barcode.trim();
    if (code.isEmpty) {
      return;
    }

    if (state.requireInventoryCheck) {
      final quantity = double.tryParse(code);
      if (quantity == null) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('请先录入该物料在当前库位的结余数量'),
            focus: true,
          ),
        );
        return;
      }

      await _handleQuantityScan(quantity, emit);
      return;
    }

    if (code.contains(r'\$KW\$')) {
      await _handleLocationScan(code, emit);
      return;
    }

    if (code.contains(r'\$TP\$')) {
      await _handleTrayScan(code, emit);
      return;
    }

    final quantity = double.tryParse(code);
    if (quantity != null) {
      await _handleQuantityScan(quantity, emit);
      return;
    }

    await _handleMaterialScan(code, emit);
  }

  Future<void> _handleLocationScan(
    String rawCode,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final location = rawCode.replaceAll(r'\$KW\$', '').toUpperCase();
    if (location.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('库位格式不正确，请重新扫描'),
          focus: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: CollectionStatus.success('库位 $location 已扫描'),
        placeholder: '请扫描托盘条码',
        step: OnlinePickCollectionStep.tray,
        focus: true,
        currentStoreSite: location,
        requireInventoryCheck: false,
      ),
    );
    await _persistCacheSnapshot();
  }

  Future<void> _handleTrayScan(
    String rawCode,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final tray = rawCode.replaceAll(r'\$TP\$', '').toUpperCase();
    if (tray.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘条码格式不正确，请重新扫描'),
          focus: true,
        ),
      );
      return;
    }

    final trayItems = _filterItemsByTray(state.taskItems, tray);
    if (trayItems.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('任务明细中不存在托盘号【$tray】'),
          focus: true,
        ),
      );
      return;
    }

    final inferredSite =
        (trayItems.first.storeSiteNo ?? '').toUpperCase().trim();
    final nextStoreSite = inferredSite.isNotEmpty
        ? inferredSite
        : state.currentStoreSite.toUpperCase();

    final issued = state.issuedTrayNos.contains(tray)
        ? state.issuedTrayNos
        : [...state.issuedTrayNos, tray];

    emit(
      state.copyWith(
        status: CollectionStatus.success('托盘 $tray 已扫描'),
        placeholder: '请扫描物料二维码',
        step: OnlinePickCollectionStep.material,
        currentTrayCode: tray,
        currentTrayItems: trayItems,
        focus: true,
        issuedTrayNos: issued,
        requireInventoryCheck: false,
        currentStoreSite: nextStoreSite,
      ),
    );
    await _persistCacheSnapshot();
  }

  Future<void> _handleQuantityScan(
    double quantity,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.currentBarcode == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描物料二维码'),
          focus: true,
        ),
      );
      return;
    }

    if (state.requireInventoryCheck) {
      await _collectInventoryRecord(quantity, emit);
      return;
    }

    if (state.mode == OnlinePickCollectionModeType.inventory) {
      await _collectInventoryRecord(quantity, emit);
      return;
    }

    await _collectOutboundQuantity(quantity, emit);
  }

  Future<void> _handleMaterialScan(
    String code,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.currentStoreSite.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描库位后再扫描物料'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final barcodeContent = await _collectionService.getMaterialInfoByQr(code);

      if (barcodeContent.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('未解析到有效的物料信息'),
            focus: true,
          ),
        );
        return;
      }

      final normalized = _normalizeBarcodeContent(barcodeContent);
      final materialCode = normalized.materialCode ?? '';
      if (materialCode.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('物料编码为空，无法采集'),
            focus: true,
          ),
        );
        return;
      }

      final matControl = normalized.sequenceControl?.trim() ?? '';
      String matSendControl = '0';
      try {
        final controlMessage =
            await _collectionService.getMatControl(materialCode);
        final parts = controlMessage.split('!');
        if (parts.length > 4 && parts[4].isNotEmpty) {
          matSendControl = parts[4];
        }
      } catch (_) {
        // ignore and keep default
      }

      final batchNo = (normalized.batchNo ?? '').toUpperCase();
      final serialNumber = (normalized.serialNumber ?? '').toUpperCase();
      if ((matControl == '0') && serialNumber.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('物料【$materialCode】序列号不能为空'),
            focus: true,
          ),
        );
        return;
      }
      if ((matControl == '1' || matControl == '2') && batchNo.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('物料【$materialCode】批次号不能为空'),
            focus: true,
          ),
        );
        return;
      }

      if (serialNumber.isNotEmpty) {
        final seqKey = '${materialCode.toUpperCase()}@$serialNumber';
        if (state.dicSeq.containsKey(seqKey)) {
          emit(
            state.copyWith(
              status: CollectionStatus.error('序列号已采集，请勿重复扫描'),
              focus: true,
            ),
          );
          return;
        }
      }

      final erpRoom = _resolveErpRoom(
        materialCode: materialCode,
        batchNo: batchNo,
        storeSite: state.currentStoreSite,
      );

      final candidates = _matchTaskItems(
        materialCode: materialCode,
        batchNo: batchNo,
        serialNumber: serialNumber,
        storeSite: state.currentStoreSite,
        matControl: matControl,
      );

      if (candidates.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(
              '未在任务明细中找到物料【$materialCode】库位【${state.currentStoreSite.toUpperCase()}】托盘【${state.currentTrayCode.toUpperCase()}】的采集任务，请核对任务配置',
            ),
            focus: true,
          ),
        );
        return;
      }

      final inventoryResult = await _loadInventoryForBarcode(
        storeSite: state.currentStoreSite,
        materialCode: materialCode,
        batchNo: batchNo,
        serialNumber: serialNumber,
        matControl: matControl,
        erpRoom: erpRoom,
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('物料 $materialCode 已解析'),
          currentBarcode: normalized,
          placeholder: state.mode == OnlinePickCollectionModeType.inventory
              ? '请输入该物料在当前库位的结余数量'
              : '请录入采集数量',
          step: OnlinePickCollectionStep.quantity,
          focus: true,
          matControlFlag: matControl,
          matSendControl: matSendControl,
          erpRoom: erpRoom,
          erpStoreInv: inventoryResult.erpStore,
          availableInventory: inventoryResult.quantity,
        ),
      );

      if (matControl == '0' &&
          state.mode == OnlinePickCollectionModeType.outbound) {
        await _collectOutboundQuantity(1, emit);
        return;
      }

      await _persistCacheSnapshot();
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '解析条码失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('解析条码失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _collectOutboundQuantity(
    double quantity,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (quantity <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数量必须大于 0'),
          focus: true,
        ),
      );
      return;
    }

    final barcode = state.currentBarcode;
    if (barcode == null || (barcode.materialCode ?? '').isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描物料二维码'),
          focus: true,
        ),
      );
      return;
    }

    if (state.currentTrayCode.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描托盘条码'),
          focus: true,
        ),
      );
      return;
    }

    final materialCode = (barcode.materialCode ?? '').toUpperCase();
    final batchNo = (barcode.batchNo ?? '').toUpperCase();
    final serialNumber = (barcode.serialNumber ?? '').toUpperCase();
    final storeSite = state.currentStoreSite;

    final candidates = _matchTaskItems(
      materialCode: materialCode,
      batchNo: batchNo,
      serialNumber: serialNumber,
      storeSite: storeSite,
      matControl: state.matControlFlag,
    );

    if (candidates.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '未在任务明细中找到物料【$materialCode】库位【$storeSite】托盘【${state.currentTrayCode.toUpperCase()}】的可分配任务行',
          ),
          focus: true,
        ),
      );
      return;
    }

    final totalRemaining = candidates.fold<double>(
      0,
      (sum, item) =>
          sum + math.max(0, (item.taskQty - item.collectedQty).toDouble()),
    );
    if (quantity - totalRemaining > 1e-6) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '本次采集数量【$quantity】大于剩余可采集数量【${totalRemaining.toStringAsFixed(3)}】',
          ),
          focus: true,
        ),
      );
      return;
    }

    final inventoryKey = _buildInventoryKey(
      storeSite: storeSite,
      materialCode: materialCode,
      batchOrSn: serialNumber.isNotEmpty ? serialNumber : batchNo,
    );

    final consumedInventory = state.dicInvMtlQty[inventoryKey] ?? 0;
    if (state.availableInventory > 0 &&
        consumedInventory + quantity - state.availableInventory > 1e-6) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '库位【$storeSite】物料【$materialCode】的可用库存不足',
          ),
          focus: true,
        ),
      );
      return;
    }

    var remaining = quantity;
    final allocations = <int, double>{};
    for (final item in candidates) {
      if (remaining <= 0) break;
      final available =
          math.max(0, (item.taskQty - item.collectedQty).toDouble());
      if (available <= 0) continue;
      final allocated = math.min(remaining, available);
      allocations[item.outTaskItemId] = allocated;
      remaining -= allocated;
    }

    if (remaining > 1e-6) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数量分配失败，请检查任务剩余量'),
          focus: true,
        ),
      );
      return;
    }

    final updatedItems = <OnlinePickTaskItem>[];
    final updatedStocks = List<OnlinePickCollectionStock>.from(
      state.collectedStocks,
    );
    final updatedDicSeq = Map<String, String>.from(state.dicSeq);
    final updatedDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);

    for (final item in state.taskItems) {
      final allocation = allocations[item.outTaskItemId];
      if (allocation == null) {
        updatedItems.add(item);
        continue;
      }

      final newCollected = (item.collectedQty) + allocation;
      final updatedItem = item.copyWith(collectedQty: newCollected);
      updatedItems.add(updatedItem);

      final entryKey = item.outTaskItemId.toString();
      final baseQty = item.taskQty.toDouble();
      final existingEntry = updatedDicMtlQty[entryKey];
      final previousCollected = existingEntry != null && existingEntry.length > 1
          ? existingEntry[1]
          : item.collectedQty.toDouble();
      updatedDicMtlQty[entryKey] = [
        baseQty,
        previousCollected + allocation,
      ];

      final stock = OnlinePickCollectionStock(
        stockId: _uuid.v4(),
        materialCode: materialCode,
        batchNo: batchNo.isEmpty ? null : batchNo,
        serialNumber: serialNumber.isEmpty ? null : serialNumber,
        taskQty: baseQty,
        collectQty: allocation,
        outTaskItemId: entryKey,
        taskId: state.task?.outTaskId.toString() ?? '',
        storeRoom: item.storeRoomNo,
        storeSite: storeSite,
        erpStore:
            state.erpRoom.isNotEmpty ? state.erpRoom : item.subInventoryCode,
        trayNo:
            state.currentTrayCode.isEmpty ? item.palletNo : state.currentTrayCode,
      );
      updatedStocks.add(stock);

      if (serialNumber.isNotEmpty) {
        updatedDicSeq['$materialCode@$serialNumber'] = stock.stockId;
      }
    }

    updatedDicInv[inventoryKey] =
        (updatedDicInv[inventoryKey] ?? 0) + quantity;

    final shouldRequireInventory = _shouldRequireInventoryCheck(
      materialCode: materialCode,
      storeSite: storeSite,
      updatedItems: updatedItems,
    );

    final nextPlaceholder = shouldRequireInventory
        ? '请输入该物料在当前库位的结余数量'
        : '请扫描库位';

    final nextStep = shouldRequireInventory
        ? OnlinePickCollectionStep.quantity
        : OnlinePickCollectionStep.location;

    final nextTab = shouldRequireInventory ? 2 : state.currentTab;

    emit(
      state.copyWith(
        collectedStocks: updatedStocks,
        taskItems: updatedItems,
        pendingCheckItems: _buildPendingItems(updatedItems),
        currentTrayItems:
            _filterItemsByTray(updatedItems, state.currentTrayCode),
        status: CollectionStatus.success('已采集数量 $quantity'),
        placeholder: nextPlaceholder,
        step: nextStep,
        focus: true,
        resetBarcode: !shouldRequireInventory,
        dicSeq: updatedDicSeq,
        dicMtlQty: updatedDicMtlQty,
        dicInvMtlQty: updatedDicInv,
        currentTab: nextTab,
        availableInventory: state.availableInventory <= 0
            ? state.availableInventory
            : state.availableInventory - quantity,
        requireInventoryCheck: shouldRequireInventory,
      ),
    );

    await _persistCacheSnapshot();
  }

  Future<void> _collectInventoryRecord(
    double quantity,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (quantity <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请输入大于 0 的结余数量'),
          focus: true,
        ),
      );
      return;
    }

    final barcode = state.currentBarcode;
    if (barcode == null || (barcode.materialCode ?? '').isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描需要核对的物料'),
          focus: true,
        ),
      );
      return;
    }

    if (state.currentTrayCode.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描托盘条码'),
          focus: true,
        ),
      );
      return;
    }

    final materialCode = (barcode.materialCode ?? '').toUpperCase();
    final trayNo = state.currentTrayCode.toUpperCase();
    final storeSite = state.currentStoreSite.toUpperCase();

    var found = false;
    final updatedRecords = state.inventoryCheckRecords
        .map(
          (record) => record.materialCode.toUpperCase() == materialCode &&
                  record.trayNo.toUpperCase() == trayNo &&
                  record.storeSite.toUpperCase() == storeSite
              ? (found = true,
                  record.copyWith(quantity: record.quantity + quantity))
              : record,
        )
        .toList();

    if (!found) {
      updatedRecords.add(
        OnlinePickInventoryCheckRecord(
          recordId: _uuid.v4(),
          materialCode: materialCode,
          trayNo: trayNo,
          storeSite: storeSite,
          quantity: quantity,
        ),
      );
    }

    emit(
      state.copyWith(
        inventoryCheckRecords: updatedRecords,
        status: CollectionStatus.success('已记录库存结余 $quantity'),
        placeholder: '请扫描库位',
        step: OnlinePickCollectionStep.location,
        focus: true,
        resetBarcode: true,
        currentTab: 2,
        requireInventoryCheck: false,
      ),
    );

    await _persistCacheSnapshot();
  }

  bool _shouldRequireInventoryCheck({
    required String materialCode,
    required String storeSite,
    required List<OnlinePickTaskItem> updatedItems,
  }) {
    if (state.matControlFlag == '1' || state.matControlFlag == '2') {
      return true;
    }

    if (storeSite.isEmpty) {
      return false;
    }

    final remaining = updatedItems.where((item) {
      return (item.materialCode ?? '').toUpperCase() == materialCode &&
          (item.storeSiteNo ?? '').toUpperCase() == storeSite.toUpperCase();
    }).fold<double>(
      0,
      (sum, item) =>
          sum + math.max(0, (item.taskQty - item.collectedQty).toDouble()),
    );

    return remaining <= 1e-6;
  }

  String _determineMtlCheckMode({
    required String siteFlag,
    required String batchFlag,
  }) {
    final forceSite = siteFlag.toUpperCase() == 'Y';
    final forceBatch = batchFlag.toUpperCase() == 'Y';
    if (forceSite && forceBatch) {
      return 'material-site-batch';
    }
    if (forceSite) {
      return 'material-site';
    }
    if (forceBatch) {
      return 'material-batch';
    }
    return 'material';
  }

  List<OnlinePickTaskItem> _matchTaskItems({
    required String materialCode,
    required String batchNo,
    required String serialNumber,
    required String storeSite,
    required String matControl,
  }) {
    final material = materialCode.toUpperCase();
    final batch = batchNo.toUpperCase();
    final serial = serialNumber.toUpperCase();
    final tray = state.currentTrayCode.toUpperCase();
    final site = storeSite.toUpperCase();
    final expectedErp = state.erpRoom.toUpperCase();

    final baseCandidates = state.taskItems.where((item) {
      if (state.selectedItemIds.isNotEmpty &&
          !state.selectedItemIds.contains(item.outTaskItemId)) {
        return false;
      }

      if ((item.materialCode ?? '').toUpperCase() != material) {
        return false;
      }

      if (tray.isNotEmpty && (item.palletNo ?? '').toUpperCase() != tray) {
        return false;
      }

      if (matControl == '0' && serial.isNotEmpty) {
        final itemSn = (item.serialNumber ?? '').toUpperCase();
        if (itemSn.isEmpty || itemSn != serial) {
          return false;
        }
      }

      return true;
    }).toList();

    if (baseCandidates.isEmpty) {
      return const [];
    }

    final requireSite = _isForceSiteFlag();
    final requireBatch = _isForceBatchFlag() || matControl == '1' || matControl == '2';

    List<OnlinePickTaskItem> matches = baseCandidates;

    if (site.isNotEmpty) {
      final siteMatches = matches
          .where((item) => (item.storeSiteNo ?? '').toUpperCase() == site)
          .toList();
      if (siteMatches.isNotEmpty) {
        matches = siteMatches;
      } else if (requireSite) {
        return const [];
      }
    } else if (requireSite) {
      return const [];
    }

    if (batch.isNotEmpty) {
      final batchMatches = matches
          .where(
            (item) =>
                (item.hintBatchNo ?? item.batchNo ?? '').toUpperCase() == batch,
          )
          .toList();
      if (batchMatches.isNotEmpty) {
        matches = batchMatches;
      } else if (requireBatch) {
        return const [];
      }
    } else if (requireBatch) {
      return const [];
    }

    if (matControl == '0' && serial.isNotEmpty) {
      final serialMatches = matches
          .where((item) => (item.serialNumber ?? '').toUpperCase() == serial)
          .toList();
      if (serialMatches.isNotEmpty) {
        matches = serialMatches;
      } else {
        return const [];
      }
    }

    if (expectedErp.isNotEmpty) {
      final erpMatches = matches
          .where(
            (item) => (item.subInventoryCode ?? '').toUpperCase() == expectedErp,
          )
          .toList();
      if (erpMatches.isNotEmpty) {
        matches = erpMatches;
      } else {
        return const [];
      }
    }

    return matches;
  }

  String _resolveErpRoom({
    required String materialCode,
    required String batchNo,
    required String storeSite,
  }) {
    final material = materialCode.toUpperCase();
    final batch = batchNo.toUpperCase();
    final site = storeSite.toUpperCase();

    for (final item in state.taskItems) {
      if ((item.materialCode ?? '').toUpperCase() == material &&
          (item.storeSiteNo ?? '').toUpperCase() == site &&
          (item.hintBatchNo ?? item.batchNo ?? '').toUpperCase() == batch) {
        return (item.subInventoryCode ?? '').toUpperCase();
      }
    }

    for (final item in state.taskItems) {
      if ((item.materialCode ?? '').toUpperCase() == material &&
          (item.storeSiteNo ?? '').toUpperCase() == site) {
        return (item.subInventoryCode ?? '').toUpperCase();
      }
    }

    for (final item in state.taskItems) {
      if ((item.materialCode ?? '').toUpperCase() == material) {
        return (item.subInventoryCode ?? '').toUpperCase();
      }
    }

    return '';
  }

  Future<String> _loadRoomMatControl(OnlinePickTask task) async {
    try {
      final response =
          await _collectionService.getRoomMatControl(task.outTaskId.toString());
      final parts = response.split('!');
      if (parts.length > 4 && parts[4].isNotEmpty) {
        return parts[4];
      }
    } catch (_) {
      // ignore and fallback to default
    }
    return '0';
  }

  Future<_InventoryLoadResult> _loadInventoryForBarcode({
    required String storeSite,
    required String materialCode,
    required String batchNo,
    required String serialNumber,
    required String matControl,
    required String erpRoom,
  }) async {
    double availableQty = 0;
    String erpStore = state.erpStoreInv;

    double _parseQty(dynamic value) {
      return double.tryParse(value?.toString() ?? '0') ?? 0;
    }

    if (matControl == '1' || matControl == '2') {
      final response = await _collectionService.getRepertoryByStoreSite(
        storeSiteNo: storeSite,
        materialCode: materialCode,
      );

      final code = response['code'] as int?;
      if (code != 200) {
        throw Exception(response['msg']?.toString() ?? '库存校验失败');
      }

      final data = response['data'];
      if (data is! List) {
        throw Exception('库存数据格式错误');
      }

      final list = data.cast<dynamic>();
      if (list.isEmpty) {
        throw Exception(
          '物料【$materialCode】批次【$batchNo】在库位【$storeSite】不存在，请确认',
        );
      }

      final filtered = <dynamic>[];
      for (final item in list) {
        final map = item as Map<String, dynamic>?;
        if (map == null) continue;
        final itemBatch = (map['batchno']?.toString() ?? '').toUpperCase();
        final itemErp = (map['erpStoreroom']?.toString() ?? '').toUpperCase();
        if (erpRoom.isNotEmpty) {
          if (itemErp == erpRoom.toUpperCase() && itemBatch == batchNo) {
            filtered.add(map);
          }
        } else {
          if (itemBatch == batchNo) {
            filtered.add(map);
          }
        }
      }

      if (filtered.isEmpty) {
        throw Exception(
          '物料【$materialCode】批次【$batchNo】在库位【$storeSite】不存在，请确认',
        );
      }

      availableQty = filtered.fold<double>(
        0,
        (sum, item) => sum + _parseQty((item as Map)['repqty']),
      );

      final first = filtered.first as Map;
      final erpCandidate = (first['erpStoreroom']?.toString() ?? '').toUpperCase();
      if (erpCandidate.isNotEmpty) {
        if (erpRoom.isNotEmpty && erpCandidate != erpRoom.toUpperCase()) {
          throw Exception(
            '当前物料明细指定子库【$erpRoom】与当前库位的物料批次子库【$erpCandidate】存在不一致，请确认',
          );
        }
        erpStore = erpCandidate;
      }
    } else {
      final responseSn = await _collectionService.getRepertoryByStoreSiteSn(
        storeSiteNo: storeSite,
        materialCode: materialCode,
        erpStoreroom: null,
        batchNo: null,
        serialNumber: null,
      );

      final codeSn = responseSn['code'] as int?;
      if (codeSn != 200) {
        throw Exception(responseSn['msg']?.toString() ?? '库存校验失败');
      }

      final dataSn = responseSn['data'];
      if (dataSn is! List || dataSn.isEmpty) {
        throw Exception(
          '物料【$materialCode】序列【$serialNumber】在库位【$storeSite】不存在，请确认',
        );
      }

      final baseQty = _parseQty((dataSn.first as Map)['repqty']);
      if (baseQty <= 0) {
        throw Exception(
          '物料【$materialCode】序列【$serialNumber】在库位【$storeSite】不存在，请确认',
        );
      }

      double matchedQty = baseQty;

      if (erpRoom.isNotEmpty) {
        final responseErp = await _collectionService.getRepertoryByStoreSiteSn(
          storeSiteNo: storeSite,
          materialCode: materialCode,
          erpStoreroom: erpRoom,
          batchNo: batchNo.isEmpty ? null : batchNo,
          serialNumber: serialNumber.isEmpty ? null : serialNumber,
        );
        final dataErp = responseErp['data'];
        if (dataErp is List && dataErp.isNotEmpty) {
          matchedQty = _parseQty((dataErp.first as Map)['repqty']);
        }
      } else {
        final responseBatch = await _collectionService.getRepertoryByStoreSiteSn(
          storeSiteNo: storeSite,
          materialCode: materialCode,
          erpStoreroom: null,
          batchNo: batchNo.isEmpty ? null : batchNo,
          serialNumber: serialNumber.isEmpty ? null : serialNumber,
        );
        final dataBatch = responseBatch['data'];
        if (dataBatch is List && dataBatch.isNotEmpty) {
          matchedQty = _parseQty((dataBatch.first as Map)['repqty']);
        }
      }

      if (matchedQty <= 0) {
        throw Exception(
          '物料【$materialCode】序列【$serialNumber】在库位【$storeSite】不存在，请确认',
        );
      }

      final erpResponse = await _collectionService.getRepertoryByStoreSiteErp(
        storeSiteNo: storeSite,
        materialCode: materialCode,
      );
      final erpCode = erpResponse['code'] as int?;
      if (erpCode == 200) {
        final erpData = erpResponse['data'];
        if (erpData is List && erpData.isNotEmpty) {
          final erpCandidate =
              (erpData.first['erpStoreroom']?.toString() ?? '').toUpperCase();
          if (erpRoom.isNotEmpty && erpCandidate.isNotEmpty &&
              erpCandidate != erpRoom.toUpperCase()) {
            throw Exception(
              '当前物料明细指定子库【$erpRoom】与当前库位的物料批次子库【$erpCandidate】存在不一致，请确认',
            );
          }
          if (erpCandidate.isNotEmpty) {
            erpStore = erpCandidate;
          }
        }
      }

      availableQty = matchedQty;
    }

    return _InventoryLoadResult(
      quantity: availableQty,
      erpStore: erpStore,
    );
  }

  String _buildInventoryKey({
    required String storeSite,
    required String materialCode,
    required String batchOrSn,
  }) {
    final site = storeSite.toUpperCase();
    final material = materialCode.toUpperCase();
    final suffix = batchOrSn.toUpperCase();
    return '$site|$material|$suffix';
  }

  OnlinePickBarcodeContent _normalizeBarcodeContent(
    OnlinePickBarcodeContent content,
  ) {
    final matControl = content.sequenceControl?.trim() ?? '';
    final legacy = content.legacyId?.trim() ?? '';
    var batchNo = content.batchNo ?? '';
    var serial = content.serialNumber ?? '';

    if ((matControl == '0' || matControl == '1' || matControl == '2') &&
        batchNo.isEmpty &&
        legacy == '0' &&
        serial.isNotEmpty) {
      batchNo = serial;
    }

    return content.copyWith(
      batchNo: batchNo,
      serialNumber: serial,
    );
  }

  void _onChangeTab(
    ChangeCollectionTabEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onUpdateSelection(
    UpdateSelectionEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(selectedItemIds: event.selectedItemIds));
  }

  void _onResetStatus(
    ResetCollectionStatusEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  void _onSetFocus(
    SetCollectionFocusEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    emit(state.copyWith(focus: event.focus));
  }

  void _onDeleteCollectedStocks(
    DeleteCollectedStocksEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    if (event.stockIds.isEmpty) {
      return;
    }

    final removeIds = event.stockIds.toSet();
    final removedStocks = state.collectedStocks
        .where((stock) => removeIds.contains(stock.stockId))
        .toList();

    if (removedStocks.isEmpty) {
      return;
    }

    final filtered = state.collectedStocks
        .where((stock) => !removeIds.contains(stock.stockId))
        .toList();

    final updatedItems = state.taskItems.map((item) {
      final removedQty = removedStocks
          .where(
            (stock) => int.tryParse(stock.outTaskItemId) == item.outTaskItemId,
          )
          .fold<num>(0, (sum, stock) => sum + stock.collectQty);
      if (removedQty == 0) {
        return item;
      }
      final newQty = (item.collectedQty) - removedQty;
      return item.copyWith(collectedQty: newQty < 0 ? 0 : newQty);
    }).toList();

    final updatedDicSeq = Map<String, String>.from(state.dicSeq);
    for (final stock in removedStocks) {
      final serial = stock.serialNumber ?? '';
      if (serial.isNotEmpty) {
        updatedDicSeq.remove('${stock.materialCode}@$serial');
      }
    }

    final updatedDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
    for (final stock in removedStocks) {
      final key = stock.outTaskItemId;
      final entry = updatedDicMtlQty[key];
      if (entry != null && entry.isNotEmpty) {
        final base = entry[0];
        final collected = entry.length > 1 ? entry[1] : 0;
        final remaining = (collected - stock.collectQty).toDouble();
        updatedDicMtlQty[key] = [base, remaining < 0 ? 0 : remaining];
      }
    }

    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);
    for (final stock in removedStocks) {
      final key = _buildInventoryKey(
        storeSite: (stock.storeSite ?? '').toUpperCase(),
        materialCode: stock.materialCode,
        batchOrSn: (stock.serialNumber ?? '').isNotEmpty
            ? stock.serialNumber ?? ''
            : stock.batchNo ?? '',
      );
      final value = (updatedDicInv[key] ?? 0) - stock.collectQty.toDouble();
      updatedDicInv[key] = value < 0 ? 0 : value;
    }

    var availableInventory = state.availableInventory;
    if (availableInventory > 0 && state.currentBarcode != null) {
      final site = state.currentStoreSite.toUpperCase();
      final mat = (state.currentBarcode!.materialCode ?? '').toUpperCase();
      for (final stock in removedStocks) {
        final stockSite = (stock.storeSite ?? '').toUpperCase();
        final stockMat = stock.materialCode.toUpperCase();
        if (stockSite == site && stockMat == mat) {
          availableInventory += stock.collectQty.toDouble();
        }
      }
    }

    emit(
      state.copyWith(
        collectedStocks: filtered,
        taskItems: updatedItems,
        pendingCheckItems: _buildPendingItems(updatedItems),
        currentTrayItems: _filterItemsByTray(
          updatedItems,
          state.currentTrayCode,
        ),
        status: CollectionStatus.success('已删除 ${event.stockIds.length} 条采集记录'),
        focus: true,
        dicSeq: updatedDicSeq,
        dicMtlQty: updatedDicMtlQty,
        dicInvMtlQty: updatedDicInv,
        availableInventory: availableInventory,
      ),
    );
    add(const PersistCollectionCacheEvent());
  }

  void _onSubmitCollection(
    SubmitCollectionEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.collectedStocks.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('暂无采集数据，无需提交'),
          focus: true,
        ),
      );
      return;
    }

    final task = state.task;
    if (task == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('缺少任务信息，无法提交'),
          focus: true,
        ),
      );
      return;
    }

    if (state.inventoryCheckRecords.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请采集结余库存后再提交！'),
          focus: true,
        ),
      );
      return;
    }

    final missingRecordMessage = _findMissingInventoryRecord();
    if (missingRecordMessage != null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(missingRecordMessage),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final downShelvesInfos = state.collectedStocks.map((stock) {
        return {
          'taskNo': task.outTaskNo,
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
      }).toList();

      final itemListInfos = <Map<String, dynamic>>[];
      state.dicMtlQty.forEach((key, value) {
        final matchedItem = state.taskItems.firstWhereOrNull(
          (item) => item.outTaskItemId.toString() == key,
        );
        if (matchedItem == null) {
          return;
        }
        final baseQty = value.isNotEmpty ? value[0] : matchedItem.taskQty;
        final collected = value.length > 1
            ? value[1]
            : matchedItem.collectedQty;
        itemListInfos.add({
          'outTaskItemid': key,
          'mtlCode': matchedItem.materialCode ?? '',
          'mtlQty': [baseQty, collected],
        });
      });

      if (itemListInfos.isEmpty) {
        for (final item in state.taskItems) {
          if ((item.collectedQty) > 0) {
            itemListInfos.add({
              'outTaskItemid': item.outTaskItemId.toString(),
              'mtlCode': item.materialCode ?? '',
              'mtlQty': [item.taskQty, item.collectedQty],
            });
          }
        }
      }

      final inventoryCheckInfos = state.inventoryCheckRecords
          .map((item) => item.toJson())
          .toList();

      await _collectionService.commitAswhDownShelves(
        downShelvesInfos: downShelvesInfos,
        itemListInfos: itemListInfos,
        inventoryCheckInfos: inventoryCheckInfos,
      );

      final collectorId = _userManager.userInfo?.userId ?? 0;
      final refreshedItems = await _collectionService.fetchCollectionTaskItems(
        query: OnlinePickCollectionQuery(
          outTaskNo: task.outTaskNo,
          storeRoomNo: task.storeRoomNo ?? '',
          forceSite: task.forceSite ?? '',
          forceBatch: task.forceBatch ?? '',
          taskComment: task.taskComment ?? '',
          workStation: task.workStation ?? '',
          collector: collectorId,
        ),
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          collectedStocks: const [],
          taskItems: refreshedItems,
          pendingCheckItems: _buildPendingItems(refreshedItems),
          currentTrayItems: const [],
          selectedItemIds: const [],
          dicSeq: const {},
          dicMtlQty: const {},
          dicInvMtlQty: const {},
          currentTrayCode: '',
          currentStoreSite: '',
          currentBarcode: null,
          placeholder: '请扫描库位',
          step: OnlinePickCollectionStep.location,
          focus: true,
          inventoryCheckRecords: const [],
          availableInventory: 0,
        ),
      );

      await _cacheManager.clearSnapshot(task.outTaskId.toString());
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '提交失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('提交失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onLoadPickLocations(
    LoadPickLocationsEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (state.task == null) {
      return;
    }

    if (state.loadingLocations) {
      return;
    }

    emit(state.copyWith(loadingLocations: true));

    try {
      final options = await _collectionService.fetchInOutLocations(
        locationType: '1',
      );

      final selected = state.selectedLocation.isNotEmpty
          ? state.selectedLocation
          : (options.isNotEmpty ? options.first : state.selectedLocation);

      emit(
        state.copyWith(
          loadingLocations: false,
          locationOptions: options,
          selectedLocation: selected,
        ),
      );

      await _persistCacheSnapshot();
    } on DioException catch (error) {
      emit(
        state.copyWith(
          loadingLocations: false,
          status: CollectionStatus.error(error.message ?? '加载拣选口失败'),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loadingLocations: false,
          status: CollectionStatus.error('加载拣选口失败：${error.toString()}'),
        ),
      );
    }
  }

  void _onSelectPickLocation(
    SelectPickLocationEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    final label = event.location;
    emit(
      state.copyWith(
        selectedLocation: event.location,
        status: CollectionStatus.success('已选择拣选口 $label'),
        focus: true,
      ),
    );
    add(const PersistCollectionCacheEvent());
  }

  void _onChangeMode(
    ChangeCollectionModeEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) {
    final target = state.availableModes.firstWhereOrNull(
      (mode) => mode.type == event.mode,
    );
    emit(
      state.copyWith(
        mode: event.mode,
        status: CollectionStatus.success('已切换至${target?.label ?? ''}'),
        focus: true,
      ),
    );
    add(const PersistCollectionCacheEvent());
  }

  Future<void> _onEmptyTrayOut(
    RequestEmptyTrayOutEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final validation = _validateCommand(
      requireTray: true,
      requireLocation: true,
    );
    if (validation != null) {
      emit(
        state.copyWith(status: CollectionStatus.error(validation), focus: true),
      );
      return;
    }

    final task = state.task!;
    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: state.currentTrayCode,
        startAddr: state.selectedLocation,
        endAddr: '1111',
        singleFlag: '1',
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('空托盘出库指令已下发'),
          focus: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '空托盘出库失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('空托盘出库失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onEmptyTrayIn(
    RequestEmptyTrayInEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final validation = _validateCommand(
      requireTray: true,
      requireLocation: true,
    );
    if (validation != null) {
      emit(
        state.copyWith(status: CollectionStatus.error(validation), focus: true),
      );
      return;
    }

    final task = state.task!;
    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      await _collectionService.commitEmptyTrayWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: state.currentTrayCode,
        startAddr: state.selectedLocation,
        endAddr: '0000',
        singleFlag: '1',
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('空托盘入库指令已下发'),
          focus: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '空托盘入库失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('空托盘入库失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onSingleTrayRequest(
    RequestSingleTrayEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final validation = _validateCommand(
      requireTray: false,
      requireLocation: true,
    );
    if (validation != null) {
      emit(
        state.copyWith(status: CollectionStatus.error(validation), focus: true),
      );
      return;
    }

    if (state.selectedItemIds.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请至少选择一行记录'),
          focus: true,
        ),
      );
      return;
    }

    final targetId = state.selectedItemIds.first;
    final targetItem =
        state.pendingCheckItems.firstWhereOrNull(
          (item) => item.outTaskItemId == targetId,
        ) ??
        state.taskItems.firstWhereOrNull(
          (item) => item.outTaskItemId == targetId,
        );

    if (targetItem == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('未找到选中的任务行'),
          focus: true,
        ),
      );
      return;
    }

    final trayNo = (targetItem.palletNo ?? '').toUpperCase();
    if (trayNo.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('选中行缺少托盘号，无法下发指令'),
          focus: true,
        ),
      );
      return;
    }

    final startAddr = targetItem.storeSiteNo ?? '';
    if (startAddr.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('选中行缺少库位信息'),
          focus: true,
        ),
      );
      return;
    }

    final task = state.task!;
    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      await _collectionService.commitDownWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: trayNo,
        startAddr: startAddr,
        endAddr: state.selectedLocation,
        singleFlag: '1',
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('托盘 $trayNo 指令已下发'),
          focus: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '托盘指令下发失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘指令下发失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onReturnTrayRequest(
    RequestReturnTrayEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    final validation = _validateCommand(
      requireTray: true,
      requireLocation: true,
    );
    if (validation != null) {
      emit(
        state.copyWith(status: CollectionStatus.error(validation), focus: true),
      );
      return;
    }

    final task = state.task!;
    final trayNo = state.currentTrayCode;
    final targetItem = state.taskItems.firstWhereOrNull(
      (item) => (item.palletNo ?? '').toUpperCase() == trayNo,
    );

    final endAddr = targetItem?.storeSiteNo ?? '';
    if (endAddr.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('未找到托盘对应的库位，无法回库'),
          focus: true,
        ),
      );
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      await _collectionService.commitResetWmsToWcs(
        taskId: task.outTaskId.toString(),
        taskNo: task.outTaskNo,
        trayNo: trayNo,
        startAddr: state.selectedLocation,
        endAddr: endAddr,
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('托盘回库指令已下发'),
          focus: true,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(error.message ?? '托盘回库失败'),
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘回库失败：${error.toString()}'),
          focus: true,
        ),
      );
    }
  }

  Future<void> _onAllTrayRequest(
    RequestAllTrayEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    if (event.count <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘数量必须大于0'),
          focus: true,
        ),
      );
      return;
    }

    final validation = _validateCommand(
      requireTray: false,
      requireLocation: true,
    );
    if (validation != null) {
      emit(
        state.copyWith(status: CollectionStatus.error(validation), focus: true),
      );
      return;
    }

    final task = state.task!;
    emit(state.copyWith(status: CollectionStatus.loading()));

    final processedTrays = <String>{};
    var success = 0;
    var failure = 0;

    for (final item in state.taskItems) {
      if (success >= event.count) {
        break;
      }
      final tray = (item.palletNo ?? '').toUpperCase();
      if (tray.isEmpty || processedTrays.contains(tray)) {
        continue;
      }
      processedTrays.add(tray);

      try {
        await _collectionService.commitDownWmsToWcs(
          taskId: task.outTaskId.toString(),
          taskNo: task.outTaskNo,
          trayNo: tray,
          startAddr: item.storeSiteNo ?? '',
          endAddr: state.selectedLocation,
          singleFlag: '0',
        );
        success += 1;
      } catch (_) {
        failure += 1;
      }
    }

    if (success == 0 && failure == 0) {
      emit(
        state.copyWith(status: CollectionStatus.error('暂无可下发的托盘'), focus: true),
      );
      return;
    }

    if (success == 0 && failure > 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('托盘指令下发失败，请重试'),
          focus: true,
        ),
      );
      return;
    }

    final message = failure == 0
        ? '已下发 $success 个托盘指令'
        : '已下发 $success 个托盘指令，$failure 个失败';

    emit(
      state.copyWith(status: CollectionStatus.success(message), focus: true),
    );
  }

  Future<void> _onPersistCache(
    PersistCollectionCacheEvent event,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    await _persistCacheSnapshot();
  }

  Future<void> _restoreCache(
    OnlinePickTask task,
    int userId,
    Emitter<OnlinePickCollectionState> emit,
  ) async {
    try {
      final snapshot = await _cacheManager.loadSnapshot(
        task.outTaskId.toString(),
      );
      if (snapshot == null || snapshot.userId != userId) {
        return;
      }

      var updatedItems = state.taskItems;
      if (snapshot.stocks.isNotEmpty) {
        final collectedMap = <int, double>{};
        for (final stock in snapshot.stocks) {
          final id = int.tryParse(stock.outTaskItemId);
          if (id == null) continue;
          collectedMap[id] =
              (collectedMap[id] ?? 0) + stock.collectQty.toDouble();
        }
        updatedItems = state.taskItems
            .map(
              (item) => collectedMap.containsKey(item.outTaskItemId)
                  ? item.copyWith(
                      collectedQty:
                          (item.collectedQty) +
                          collectedMap[item.outTaskItemId]!,
                    )
                  : item,
            )
            .toList();
      }

      final trayNo = snapshot.trayNo.toUpperCase();
      final issued = snapshot.stocks
          .map((stock) => (stock.trayNo ?? '').toUpperCase())
          .where((value) => value.isNotEmpty)
          .toSet()
          .toList();

      final requireInventoryCheck = snapshot.requireInventoryCheck;
      final placeholder = requireInventoryCheck
          ? '请输入该物料在当前库位的结余数量'
          : state.placeholder;
      final step = requireInventoryCheck
          ? OnlinePickCollectionStep.quantity
          : state.step;
      final currentTab = requireInventoryCheck ? 2 : state.currentTab;

      emit(
        state.copyWith(
          collectedStocks: snapshot.stocks,
          taskItems: updatedItems,
          pendingCheckItems: _buildPendingItems(updatedItems),
          currentTrayItems: _filterItemsByTray(updatedItems, trayNo),
          dicSeq: snapshot.dicSeq,
          dicMtlQty: snapshot.dicMtlQty,
          dicInvMtlQty: snapshot.dicInvMtlQty,
          currentTrayCode: trayNo,
          currentBarcode: snapshot.lastBarcode,
          selectedLocation: snapshot.location.isNotEmpty
              ? snapshot.location
              : state.selectedLocation,
          mode: _mapMode(snapshot.mode),
          currentStoreSite: snapshot.currentStoreSite.isNotEmpty
              ? snapshot.currentStoreSite
              : state.currentStoreSite,
          roomMatControl: snapshot.roomMatControl,
          matControlFlag: snapshot.matControlFlag,
          matSendControl: snapshot.matSendControl,
          erpRoom: snapshot.erpRoom,
          erpStoreInv: snapshot.erpStoreInv.isNotEmpty
              ? snapshot.erpStoreInv
              : state.erpStoreInv,
          availableInventory: snapshot.availableInventory,
          inventoryCheckRecords: snapshot.inventoryChecks,
          issuedTrayNos: issued,
          status: snapshot.stocks.isNotEmpty
              ? CollectionStatus.success('已恢复未提交的采集记录')
              : state.status,
          focus: true,
          placeholder: placeholder,
          step: step,
          currentTab: currentTab,
          requireInventoryCheck: requireInventoryCheck,
          siteFlag: snapshot.siteFlag.isNotEmpty
              ? snapshot.siteFlag
              : state.siteFlag,
          batchFlag: snapshot.batchFlag.isNotEmpty
              ? snapshot.batchFlag
              : state.batchFlag,
          mtlCheckMode: snapshot.mtlCheckMode.isNotEmpty
              ? snapshot.mtlCheckMode
              : state.mtlCheckMode,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('恢复缓存失败：${error.toString()}'),
        ),
      );
    }
  }

  OnlinePickCollectionModeType _mapMode(String mode) {
    switch (mode) {
      case 'inventory':
        return OnlinePickCollectionModeType.inventory;
      case 'exception':
        return OnlinePickCollectionModeType.exception;
      default:
        return OnlinePickCollectionModeType.outbound;
    }
  }

  Future<void> _persistCacheSnapshot() async {
    final task = state.task;
    if (task == null) {
      return;
    }

    try {
      final snapshot = OnlinePickCollectionCacheSnapshot(
        stocks: state.collectedStocks,
        dicSeq: state.dicSeq,
        dicMtlQty: state.dicMtlQty,
        dicInvMtlQty: state.dicInvMtlQty,
        lastBarcode: state.currentBarcode,
        location: state.selectedLocation,
        trayNo: state.currentTrayCode,
        userId: _userManager.userInfo?.userId ?? 0,
        pendingQuantity: state.currentBarcode?.quantity,
        mode: state.mode.name,
        expectedErpStore: state.erpStoreInv,
        inventoryChecks: state.inventoryCheckRecords,
        roomMatControl: state.roomMatControl,
        currentStoreSite: state.currentStoreSite,
        matControlFlag: state.matControlFlag,
        matSendControl: state.matSendControl,
        erpRoom: state.erpRoom,
        erpStoreInv: state.erpStoreInv,
        availableInventory: state.availableInventory,
        requireInventoryCheck: state.requireInventoryCheck,
        siteFlag: state.siteFlag,
        batchFlag: state.batchFlag,
        mtlCheckMode: state.mtlCheckMode,
      );

      await _cacheManager.saveSnapshot(task.outTaskId.toString(), snapshot);
    } catch (_) {
      // ignore cache errors to避免影响主流程
    }
  }

  String? _validateCommand({
    required bool requireTray,
    required bool requireLocation,
  }) {
    if (state.collectedStocks.isNotEmpty) {
      return '采集数据未提交，不允许下达指令';
    }
    if (state.task == null) {
      return '缺少任务信息，无法执行指令';
    }
    if (requireLocation && state.selectedLocation.isEmpty) {
      return '请先选择拣选口';
    }
    if (requireTray && state.currentTrayCode.isEmpty) {
      return '请先扫描托盘号';
    }
    return null;
  }

  List<OnlinePickTaskItem> _buildPendingItems(List<OnlinePickTaskItem> items) {
    return items.where((item) => (item.collectedQty) < (item.taskQty)).toList();
  }

  List<OnlinePickTaskItem> _filterItemsByTray(
    List<OnlinePickTaskItem> items,
    String trayNo,
  ) {
    if (trayNo.isEmpty) {
      return const [];
    }
    return items
        .where((item) => (item.palletNo ?? '').toUpperCase() == trayNo)
        .toList();
  }

  String? _findMissingInventoryRecord() {
    final records = state.inventoryCheckRecords
        .map(
          (record) => _inventoryRecordKey(
            storeSite: record.storeSite,
            trayNo: record.trayNo,
            materialCode: record.materialCode,
          ),
        )
        .toSet();

    for (final stock in state.collectedStocks) {
      final material = stock.materialCode.toUpperCase();
      final tray = (stock.trayNo ?? '').toUpperCase();
      final site = (stock.storeSite ?? '').toUpperCase();
      final key = _inventoryRecordKey(
        storeSite: site,
        trayNo: tray,
        materialCode: material,
      );
      if (!records.contains(key)) {
        final trayLabel = tray.isEmpty ? '—' : tray;
        return '物料【$material】在库位【$site】托盘【$trayLabel】尚未录入结余数量，请先完成库存核对';
      }
    }

    return null;
  }

  String _inventoryRecordKey({
    required String storeSite,
    required String trayNo,
    required String materialCode,
  }) {
    return '${storeSite.toUpperCase()}|${trayNo.toUpperCase()}|${materialCode.toUpperCase()}';
  }

  bool _isForceSiteFlag() => state.siteFlag.toUpperCase() == 'Y';

  bool _isForceBatchFlag() => state.batchFlag.toUpperCase() == 'Y';
}

class _InventoryLoadResult {
  const _InventoryLoadResult({
    required this.quantity,
    required this.erpStore,
  });

  final double quantity;
  final String erpStore;
}
