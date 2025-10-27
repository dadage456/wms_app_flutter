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

      emit(
        state.copyWith(
          status: CollectionStatus.success('任务明细已加载'),
          taskItems: items,
          pendingCheckItems: _buildPendingItems(items),
          currentTrayItems: const [],
          focus: true,
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

    // 识别库位条码
    if (code.contains(r'\$KW\$')) {
      final location = code.replaceAll(r'\$KW\$', '').toUpperCase();
      emit(
        state.copyWith(
          status: CollectionStatus.success('库位 $location 已扫描'),
          placeholder: '请扫描托盘条码',
          step: OnlinePickCollectionStep.tray,
          focus: true,
          currentTrayCode: state.currentTrayCode,
        ),
      );
      await _persistCacheSnapshot();
      return;
    }

    // 识别托盘条码
    if (code.contains(r'\$TP\$')) {
      final tray = code.replaceAll(r'\$TP\$', '').toUpperCase();
      final trayItems = _filterItemsByTray(state.taskItems, tray);
      emit(
        state.copyWith(
          status: CollectionStatus.success('托盘 $tray 已扫描'),
          placeholder: '请扫描物料二维码',
          step: OnlinePickCollectionStep.material,
          currentTrayCode: tray,
          currentTrayItems: trayItems,
          focus: true,
          issuedTrayNos: state.issuedTrayNos.contains(tray)
              ? state.issuedTrayNos
              : [...state.issuedTrayNos, tray],
        ),
      );
      await _persistCacheSnapshot();
      return;
    }

    final quantity = double.tryParse(code);

    if (quantity != null && state.currentBarcode != null) {
      if (state.mode == OnlinePickCollectionModeType.inventory &&
          state.currentTrayCode.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('请先扫描托盘后再录入数量'),
            focus: true,
          ),
        );
        return;
      }

      if (state.selectedItemIds.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('请先在任务列表中选择要采集的任务行'),
            focus: true,
          ),
        );
        return;
      }

      final selectedItem = state.taskItems.firstWhereOrNull(
        (item) => state.selectedItemIds.contains(item.outTaskItemId),
      );

      if (selectedItem == null) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('未找到匹配的任务明细'),
            focus: true,
          ),
        );
        return;
      }

      final stock = OnlinePickCollectionStock(
        stockId: _uuid.v4(),
        materialCode: state.currentBarcode!.materialCode ?? '',
        batchNo: state.currentBarcode!.batchNo,
        serialNumber: state.currentBarcode!.serialNumber,
        taskQty: selectedItem.taskQty,
        collectQty: quantity,
        outTaskItemId: selectedItem.outTaskItemId.toString(),
        taskId: state.task?.outTaskId.toString() ?? '',
        storeRoom: selectedItem.storeRoomNo,
        storeSite: selectedItem.storeSiteNo,
        erpStore: selectedItem.subInventoryCode,
        trayNo: state.currentTrayCode.isEmpty
            ? selectedItem.palletNo
            : state.currentTrayCode,
      );

      final serialNumber = stock.serialNumber ?? '';
      if (serialNumber.isNotEmpty) {
        final seqKey = '${stock.materialCode}@$serialNumber';
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

      final updatedStocks = List<OnlinePickCollectionStock>.from(
        state.collectedStocks,
      )..add(stock);

      final updatedDicSeq = Map<String, String>.from(state.dicSeq);
      if (serialNumber.isNotEmpty) {
        updatedDicSeq['${stock.materialCode}@$serialNumber'] = stock.stockId;
      }

      final updatedDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
      final itemKey = selectedItem.outTaskItemId.toString();
      final baseQty = selectedItem.taskQty.toDouble();
      final currentQty =
          updatedDicMtlQty[itemKey]?.elementAtOrNull(1) ??
          selectedItem.collectedQty.toDouble();
      updatedDicMtlQty[itemKey] = [baseQty, currentQty + quantity];

      final updatedDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);
      if (state.mode == OnlinePickCollectionModeType.inventory) {
        updatedDicInvMtlQty[itemKey] =
            (updatedDicInvMtlQty[itemKey] ?? 0) + quantity;
      }

      final updatedItems = state.taskItems
          .map(
            (item) => item.outTaskItemId == selectedItem.outTaskItemId
                ? item.copyWith(collectedQty: (item.collectedQty) + quantity)
                : item,
          )
          .toList();

      emit(
        state.copyWith(
          collectedStocks: updatedStocks,
          taskItems: updatedItems,
          pendingCheckItems: _buildPendingItems(updatedItems),
          currentTrayItems: _filterItemsByTray(
            updatedItems,
            state.currentTrayCode,
          ),
          status: CollectionStatus.success('已采集数量 $quantity'),
          placeholder: '请扫描库位',
          step: OnlinePickCollectionStep.location,
          selectedItemIds: state.selectedItemIds,
          focus: true,
          resetBarcode: true,
          dicSeq: updatedDicSeq,
          dicMtlQty: updatedDicMtlQty,
          dicInvMtlQty: updatedDicInvMtlQty,
        ),
      );
      await _persistCacheSnapshot();
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

      emit(
        state.copyWith(
          status: CollectionStatus.success(
            '物料 ${barcodeContent.materialCode ?? ''} 已解析',
          ),
          currentBarcode: barcodeContent,
          placeholder: '请录入采集数量',
          step: OnlinePickCollectionStep.quantity,
          focus: true,
        ),
      );
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
      if (entry != null && entry.length >= 2) {
        final remaining = (entry[1] - stock.collectQty).toDouble();
        updatedDicMtlQty[key] = [entry[0], remaining < 0 ? 0 : remaining];
      }
    }

    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);
    for (final stock in removedStocks) {
      final key = stock.outTaskItemId;
      if (updatedDicInv.containsKey(key)) {
        final value = (updatedDicInv[key] ?? 0) - stock.collectQty.toDouble();
        updatedDicInv[key] = value < 0 ? 0 : value;
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

      final inventoryCheckInfos = state.pendingCheckItems
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
          currentBarcode: null,
          placeholder: '请扫描库位',
          step: OnlinePickCollectionStep.location,
          focus: true,
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
          issuedTrayNos: issued,
          status: snapshot.stocks.isNotEmpty
              ? CollectionStatus.success('已恢复未提交的采集记录')
              : state.status,
          focus: true,
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
}
