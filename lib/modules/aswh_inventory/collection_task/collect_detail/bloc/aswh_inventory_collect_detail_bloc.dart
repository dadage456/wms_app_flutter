import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/inventory_collect_detail_models.dart';
import '../../models/inventory_collect_models.dart';
import '../../repositories/inventory_collect_cache_repository.dart';
import 'aswh_inventory_collect_detail_event.dart';
import 'aswh_inventory_collect_detail_state.dart';

class AswhInventoryCollectDetailBloc extends Bloc<
    AswhInventoryCollectDetailEvent, AswhInventoryCollectDetailState> {
  AswhInventoryCollectDetailBloc({
    required InventoryCollectCacheRepository cacheRepository,
  })  : _cacheRepository = cacheRepository,
        super(const AswhInventoryCollectDetailState()) {
    on<AswhInventoryCollectDetailStarted>(_onStarted);
    on<AswhInventoryCollectDetailSelectionChanged>(_onSelectionChanged);
    on<AswhInventoryCollectDetailSelectAllToggled>(_onSelectAllToggled);
    on<AswhInventoryCollectDetailDeleteRequested>(_onDeleteRequested);
    on<AswhInventoryCollectDetailDeletionCancelled>(_onDeletionCancelled);
    on<AswhInventoryCollectDetailDeletionConfirmed>(_onDeletionConfirmed);
  }

  final InventoryCollectCacheRepository _cacheRepository;

  Future<void> _onStarted(
    AswhInventoryCollectDetailStarted event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    emit(state.copyWith(status: AswhInventoryCollectDetailStatus.loading));

    final generatedItems = event.records.mapIndexed((index, record) {
      final timestamp = record.collectedAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch;
      final stockId =
          '${record.taskItemId}_${record.trayNo ?? ''}_${record.batchNo ?? ''}_${record.serialNo ?? ''}_$timestamp\_$index';
      return InventoryCollectedItem.fromRecord(
        record,
        stockId: stockId,
        sourceQty: record.collectQty,
      );
    }).toList();

    emit(
      state.copyWith(
        status: AswhInventoryCollectDetailStatus.ready,
        items: generatedItems,
        taskItems: event.taskItems,
        taskId: event.taskId,
        taskComment: event.taskComment,
        activeTrayNo: event.activeTrayNo,
        activeStoreSiteNo: event.activeStoreSiteNo,
        lastScannedCode: event.lastScannedCode,
        message: generatedItems.isEmpty ? '暂无采集记录' : null,
      ),
    );
  }

  Future<void> _onSelectionChanged(
    AswhInventoryCollectDetailSelectionChanged event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedIds: event.selectedIds,
        message: state.message,
      ),
    );
  }

  Future<void> _onSelectAllToggled(
    AswhInventoryCollectDetailSelectAllToggled event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    final updatedIds = event.selectAll
        ? state.items.map((item) => item.stockId).toSet()
        : <String>{};
    emit(
      state.copyWith(
        selectedIds: updatedIds,
        message: state.message,
      ),
    );
  }

  Future<void> _onDeleteRequested(
    AswhInventoryCollectDetailDeleteRequested event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    if (state.selectedIds.isEmpty) {
      emit(
        state.copyWith(
          message: '请至少选择一条记录',
          pendingDeletion: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pendingDeletion: true,
        message: state.message,
      ),
    );
  }

  Future<void> _onDeletionCancelled(
    AswhInventoryCollectDetailDeletionCancelled event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        pendingDeletion: false,
        message: state.message,
      ),
    );
  }

  Future<void> _onDeletionConfirmed(
    AswhInventoryCollectDetailDeletionConfirmed event,
    Emitter<AswhInventoryCollectDetailState> emit,
  ) async {
    if (state.selectedIds.isEmpty) {
      emit(
        state.copyWith(
          pendingDeletion: false,
          message: '请选择需要删除的记录',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AswhInventoryCollectDetailStatus.updating,
        pendingDeletion: false,
        message: '正在删除选中的采集记录...',
      ),
    );

    final toRemove = state.items
        .where((item) => state.selectedIds.contains(item.stockId))
        .toList();

    if (toRemove.isEmpty) {
      emit(
        state.copyWith(
          status: AswhInventoryCollectDetailStatus.ready,
          message: '未找到需要删除的记录',
        ),
      );
      return;
    }

    final remainingItems = state.items
        .where((item) => !state.selectedIds.contains(item.stockId))
        .toList();

    final removalMap = <String, double>{};
    for (final item in toRemove) {
      removalMap[item.invTaskItemId] =
          (removalMap[item.invTaskItemId] ?? 0) + item.sourceQty;
    }

    final updatedTaskItems = state.taskItems.map((taskItem) {
      final itemId = _resolveTaskItemId(taskItem);
      final removed = removalMap[itemId] ?? 0;
      final updatedQty = math.max(0, taskItem.collectedQty - removed);
      return taskItem.copyWith(collectedQty: updatedQty);
    }).toList();

    final updatedRecords = remainingItems
        .map(
          (item) => item.toRecord(
            taskComment: state.taskComment ?? '',
          ),
        )
        .toList();

    if (_cacheRepository.isReady &&
        state.taskId != null &&
        state.taskComment != null) {
      final snapshot = InventoryCollectStateSnapshot(
        taskId: state.taskId!,
        taskComment: state.taskComment!,
        activeTrayNo: state.activeTrayNo,
        activeStoreSiteNo: state.activeStoreSiteNo,
        lastScannedCode: state.lastScannedCode,
        taskItems: updatedTaskItems,
        collectedRecords: updatedRecords,
        updatedAt: DateTime.now(),
      );
      await _cacheRepository.persistSnapshot(snapshot);
    }

    emit(
      state.copyWith(
        status: AswhInventoryCollectDetailStatus.success,
        items: remainingItems,
        taskItems: updatedTaskItems,
        selectedIds: <String>{},
        hasChanges: true,
        message: '已删除 ${toRemove.length} 条采集记录',
      ),
    );
  }

  String _resolveTaskItemId(InventoryTaskItem item) {
    return (item.checkItemId?.toString().isNotEmpty == true
            ? item.checkItemId.toString()
            : item.checkTaskId?.toString()) ??
        item.palletNo ??
        item.materialCode ??
        item.checkTaskNo ??
        '';
  }
}
