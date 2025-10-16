import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../services/inventory_task_service.dart';
import '../../task_list/models/inventory_task.dart';
import '../models/inventory_collect_models.dart';
import '../repositories/inventory_collect_cache_repository.dart';
import 'inventory_collect_enums.dart';
import 'inventory_collect_event.dart';
import 'inventory_collect_state.dart';

@immutable
class InventoryCollectBloc
    extends Bloc<InventoryCollectEvent, InventoryCollectState> {
  InventoryCollectBloc({
    required InventoryTaskService service,
    required InventoryCollectCacheRepository cacheRepository,
  })  : _service = service,
        _cacheRepository = cacheRepository,
        super(const InventoryCollectState()) {
    on<_Started>(_onStarted);
    on<_StoreSiteScanned>(_onStoreSiteScanned);
    on<_MaterialScanned>(_onMaterialScanned);
    on<_QuantitySubmitted>(_onQuantitySubmitted);
    on<_TabChanged>(_onTabChanged);
    on<_RecordsRemoved>(_onRecordsRemoved);
    on<_SubmitRequested>(_onSubmitRequested);
    on<_RefreshRequested>(_onRefreshRequested);
  }

  final InventoryTaskService _service;
  final InventoryCollectCacheRepository _cacheRepository;

  InventoryTask? get _task => state.task;

  Future<void> _onStarted(
    _Started event,
    Emitter<InventoryCollectState> emit,
  ) async {
    emit(state.copyWith(status: InventoryCollectStatus.loading, message: null));

    final task = event.task;
    final taskKey = task.checkTaskNo.isNotEmpty
        ? task.checkTaskNo
        : task.taskComment;
    await _cacheRepository.init(taskKey ?? 'inventory');

    try {
      final items = await _service.fetchInventoryTaskItems(
        query: InventoryTaskItemQuery(
          taskId: (task.checkTaskId ?? task.checkTaskNo).toString(),
        ),
      );
      final cachedRecords = await _cacheRepository.loadRecords();
      final adjustedItems = _applyRecordsToItems(items, cachedRecords);
      emit(
        state.copyWith(
          status: InventoryCollectStatus.success,
          task: task,
          taskItems: adjustedItems,
          collectingRecords: cachedRecords,
          hasUnsubmittedData: cachedRecords.isNotEmpty,
          currentStoreSite: '',
          step: InventoryCollectStep.scanLocation,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: error.toString(),
          task: task,
        ),
      );
    }
  }

  Future<void> _onStoreSiteScanned(
    _StoreSiteScanned event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final task = _task;
    if (task == null) return;

    emit(state.copyWith(status: InventoryCollectStatus.cacheUpdating));
    final isValid = await _service.validateStoreSite(
      storeRoomNo: task.storeRoomNo,
      storeSiteNo: event.storeSite,
    );
    if (!isValid) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: '库位 ${event.storeSite} 校验失败',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: InventoryCollectStatus.success,
        currentStoreSite: event.storeSite,
        step: InventoryCollectStep.scanMaterial,
        message: '库位 ${event.storeSite} 校验成功',
      ),
    );
  }

  Future<void> _onMaterialScanned(
    _MaterialScanned event,
    Emitter<InventoryCollectState> emit,
  ) async {
    if (state.currentStoreSite.isEmpty) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: '请先扫描库位',
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: InventoryCollectStatus.loading));
      final barcode = await _service.fetchBarcodeContent(event.barcode);
      emit(
        state.copyWith(
          status: InventoryCollectStatus.success,
          barcodeContent: barcode,
          step: InventoryCollectStep.inputQuantity,
          message: '物料 ${barcode.materialCode ?? ''} 解析成功',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onQuantitySubmitted(
    _QuantitySubmitted event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final task = _task;
    final barcode = state.barcodeContent;
    if (task == null || barcode == null || state.currentStoreSite.isEmpty) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: '请先扫描库位和物料',
        ),
      );
      return;
    }

    if (state.taskItems.isEmpty) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: '任务明细为空，无法采集',
        ),
      );
      return;
    }

    final matchedItem = state.taskItems.firstWhere(
      (item) =>
          item.storeSiteNo == state.currentStoreSite &&
          item.materialCode == (barcode.materialCode ?? barcode.materialName ?? ''),
      orElse: () => state.taskItems.firstWhere(
        (item) => item.storeSiteNo == state.currentStoreSite,
        orElse: () => state.taskItems.first,
      ),
    );

    final newRecord = InventoryCollectRecord(
      itemId: matchedItem.itemId,
      materialCode: matchedItem.materialCode,
      materialName: matchedItem.materialName ?? barcode.materialName,
      storeSiteNo: matchedItem.storeSiteNo,
      storeRoomNo: matchedItem.storeRoomNo,
      systemQuantity: matchedItem.systemQuantity,
      actualQuantity: event.quantity,
      difference: event.quantity - matchedItem.systemQuantity,
      batchNo: barcode.batchNo,
      serialNo: barcode.serialNo,
      unit: matchedItem.unit,
      taskComment: task.taskComment,
    );

    final updatedRecords = List<InventoryCollectRecord>.from(
      state.collectingRecords,
    )..add(newRecord);
    final updatedItems = _applyRecordsToItems(state.taskItems, updatedRecords);

    await _cacheRepository.saveRecords(updatedRecords);

    emit(
      state.copyWith(
        status: InventoryCollectStatus.success,
        collectingRecords: updatedRecords,
        taskItems: updatedItems,
        step: InventoryCollectStep.scanLocation,
        barcodeContent: null,
        currentStoreSite: '',
        hasUnsubmittedData: true,
        message: '已采集数量 ${event.quantity}',
      ),
    );
  }

  Future<void> _onTabChanged(
    _TabChanged event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final tab = event.index == 0
        ? InventoryCollectTab.pending
        : InventoryCollectTab.collecting;
    emit(state.copyWith(activeTab: tab));
  }

  Future<void> _onRecordsRemoved(
    _RecordsRemoved event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final removed = event.removed;
    if (removed.isEmpty) return;

    final remaining = List<InventoryCollectRecord>.from(state.collectingRecords)
      ..removeWhere(
        (record) => removed.any(
          (item) =>
              item.itemId == record.itemId &&
              item.storeSiteNo == record.storeSiteNo &&
              item.materialCode == record.materialCode,
        ),
      );

    final updatedItems = _applyRecordsToItems(state.taskItems, remaining);
    await _cacheRepository.saveRecords(remaining);

    emit(
      state.copyWith(
        status: InventoryCollectStatus.success,
        collectingRecords: remaining,
        taskItems: updatedItems,
        hasUnsubmittedData: remaining.isNotEmpty,
        message: '已删除 ${removed.length} 条采集记录',
      ),
    );
  }

  Future<void> _onSubmitRequested(
    _SubmitRequested event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final task = _task;
    if (task == null) return;
    if (state.collectingRecords.isEmpty) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: '暂无需要提交的记录',
        ),
      );
      return;
    }

    emit(state.copyWith(status: InventoryCollectStatus.submitting));
    final request = InventoryCommitRequest(
      records: state.collectingRecords,
      taskComment: task.taskComment,
    );

    try {
      await _service.submitInventoryInfos(request);
      await _cacheRepository.saveRecords(const []);
      emit(
        state.copyWith(
          status: InventoryCollectStatus.success,
          collectingRecords: const [],
          hasUnsubmittedData: false,
          message: '提交成功',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<InventoryCollectState> emit,
  ) async {
    final task = _task;
    if (task == null) return;
    emit(state.copyWith(status: InventoryCollectStatus.loading));
    try {
      final items = await _service.fetchInventoryTaskItems(
        query: InventoryTaskItemQuery(
          taskId: (task.checkTaskId ?? task.checkTaskNo).toString(),
        ),
      );
      final updatedItems = _applyRecordsToItems(items, state.collectingRecords);
      emit(
        state.copyWith(
          status: InventoryCollectStatus.success,
          taskItems: updatedItems,
          message: '已刷新任务明细',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: InventoryCollectStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  List<InventoryTaskItem> _applyRecordsToItems(
    List<InventoryTaskItem> items,
    List<InventoryCollectRecord> records,
  ) {
    final grouped = <String, double>{};
    for (final record in records) {
      final key = '${record.itemId}_${record.storeSiteNo}';
      grouped.update(key, (value) => value + record.actualQuantity,
          ifAbsent: () => record.actualQuantity);
    }

    return items
        .map(
          (item) => item.copyWith(
            collectedQuantity: grouped['${item.itemId}_${item.storeSiteNo}'] ??
                0,
            actualQuantity: grouped['${item.itemId}_${item.storeSiteNo}'] ?? 0,
            difference: (grouped['${item.itemId}_${item.storeSiteNo}'] ?? 0) -
                item.systemQuantity,
          ),
        )
        .toList();
  }

  @override
  Future<void> close() async {
    await _cacheRepository.dispose();
    return super.close();
  }
}
