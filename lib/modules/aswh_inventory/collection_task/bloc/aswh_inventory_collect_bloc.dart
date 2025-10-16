
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/inventory_collect_models.dart';
import '../repositories/inventory_collect_cache_repository.dart';
import '../services/aswh_inventory_collect_service.dart';
import 'aswh_inventory_collect_enums.dart';
import 'aswh_inventory_collect_event.dart';
import 'aswh_inventory_collect_state.dart';


class AswhInventoryCollectBloc
    extends Bloc<AswhInventoryCollectEvent, AswhInventoryCollectState> {
  AswhInventoryCollectBloc({
    required AswhInventoryCollectService collectService,
    required InventoryCollectCacheRepository cacheRepository,
  })  : _collectService = collectService,
        _cacheRepository = cacheRepository,
        super(const AswhInventoryCollectState()) {
    on<AswhInventoryCollectStarted>(_onStarted);
    on<AswhInventoryCollectScanCaptured>(_onScanCaptured);
    on<AswhInventoryCollectTrayConfirmed>(_onTrayConfirmed);
    on<AswhInventoryCollectSiteValidated>(_onSiteValidated);
    on<AswhInventoryCollectMaterialDecoded>(_onMaterialDecoded);
    on<AswhInventoryCollectQuantityEntered>(_onQuantityEntered);
    on<AswhInventoryCollectTaskItemSelected>(_onTaskItemSelected);
    on<AswhInventoryCollectSwitchTabRequested>(_onSwitchTab);
    on<AswhInventoryCollectSubmitRequested>(_onSubmitRequested);
    on<AswhInventoryCollectCommandActionTriggered>(_onCommandActionTriggered);
    on<AswhInventoryCollectPopupClosed>(_onPopupClosed);
    on<AswhInventoryCollectSelectionChanged>(_onSelectionChanged);
    on<AswhInventoryCollectResetRequested>(_onResetRequested);
    on<AswhInventoryCollectPickLocationChanged>(_onPickLocationChanged);
    on<AswhInventoryCollectCommandMenuVisibilityChanged>(
      _onCommandMenuVisibilityChanged,
    );
    on<AswhInventoryCollectSingleTrayRequested>(_onSingleTrayRequested);
    on<AswhInventoryCollectBulkTrayRequested>(_onBulkTrayRequested);
    on<AswhInventoryCollectReturnTrayRequested>(_onReturnTrayRequested);
    on<AswhInventoryCollectResultsPatched>(_onResultsPatched);
  }

  final AswhInventoryCollectService _collectService;
  final InventoryCollectCacheRepository _cacheRepository;

  late InventoryTaskItemQuery _query;
  String? _taskId;
  String? _taskComment;
  String? _taskKey;

  Future<void> _onStarted(
    AswhInventoryCollectStarted event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AswhInventoryCollectStatus.loading,
        isLoading: true,
        message: null,
      ),
    );

    _query = event.query;
    _taskComment = event.query.taskComment;
    _taskId = event.query.checkTaskId ?? event.query.checkTaskNo;
    _taskKey = event.taskKey ?? _taskId;

    if (_taskKey != null) {
      await _cacheRepository.initialize(_taskKey!);
    }

    try {
      final items = await _collectService.fetchTaskItems(query: event.query);
      emit(
        state.copyWith(
          status: AswhInventoryCollectStatus.ready,
          isLoading: false,
          taskItems: items,
          message: null,
          taskId: _taskId,
          taskComment: _taskComment,
        ),
      );

      await _loadPickLocations(emit);
      await _restoreFromCache(emit);
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhInventoryCollectStatus.failure,
          isLoading: false,
          message: error.toString(),
        ),
      );
    }
  }

  Future<void> _restoreFromCache(Emitter<AswhInventoryCollectState> emit) async {
    if (!_cacheRepository.isReady) return;

    final snapshot = await _cacheRepository.readSnapshot();
    if (snapshot == null) return;

    emit(
      state.copyWith(
        collectingItems: snapshot.collectedRecords,
        taskItems:
            snapshot.taskItems.isEmpty ? state.taskItems : snapshot.taskItems,
        currentTrayCode: snapshot.activeTrayNo,
        currentSiteCode: snapshot.activeStoreSiteNo,
        lastScannedCode: snapshot.lastScannedCode,
        restoredSnapshot: snapshot,
        message: '已从本地缓存恢复采集进度',
      ),
    );
  }

  Future<void> _onScanCaptured(
    AswhInventoryCollectScanCaptured event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final sanitized = event.code.trim();
    if (sanitized.isEmpty) {
      return;
    }

    switch (state.currentStep) {
      case AswhInventoryCollectStep.trayScan:
        return _handleTrayScan(sanitized, emit);
      case AswhInventoryCollectStep.siteScan:
        return _handleSiteScan(sanitized, emit);
      case AswhInventoryCollectStep.materialScan:
        return _handleMaterialScan(sanitized, emit);
      case AswhInventoryCollectStep.quantityInput:
        final quantity = double.tryParse(sanitized);
        if (quantity == null) {
          emit(
            state.copyWith(
              message: '数量格式不正确，请重新输入',
            ),
          );
          return;
        }
        return _onQuantityEntered(
          AswhInventoryCollectQuantityEntered(quantity),
          emit,
        );
    }
  }

  Future<void> _handleTrayScan(
    String trayCode,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        currentTrayCode: trayCode,
        currentStep: AswhInventoryCollectStep.siteScan,
        lastScannedCode: trayCode,
        message: '托盘号 $trayCode 扫描成功，请继续扫描库位',
      ),
    );
    await _persistSnapshot();
  }

  Future<void> _handleSiteScan(
    String siteCode,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final storeRoom = _resolveStoreRoomNo();
    if (storeRoom == null) {
      emit(
        state.copyWith(
          message: '未获取到库房信息，无法校验库位',
        ),
      );
      return;
    }

    emit(state.copyWith(message: '库位校验中...', isLoading: true));
    try {
      final results = await _collectService.validateStoreSite(
        storeRoomNo: storeRoom,
        storeSiteNo: siteCode,
      );

      final matched = results.firstWhereOrNull(
        (item) => item.storeSiteNo == siteCode,
      );

      if (matched != null && matched.siteFlag != null &&
          matched.siteFlag!.toUpperCase() != 'Y') {
        emit(
          state.copyWith(
            isLoading: false,
            message: '库位 ${matched.storeSiteNo} 未开放，无法采集',
          ),
        );
        return;
      }

      final expectedErpSite = state.activeTask?.erpStoreSite;
      if (expectedErpSite != null &&
          matched != null &&
          matched.erpStoreSite != null &&
          expectedErpSite != matched.erpStoreSite) {
        emit(
          state.copyWith(
            isLoading: false,
            message: 'ERP 库位不匹配，请确认扫描库位是否正确',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          isLoading: false,
          currentSiteCode: matched?.storeSiteNo ?? siteCode,
          currentStep: AswhInventoryCollectStep.materialScan,
          lastScannedCode: siteCode,
          message: '库位 ${matched?.storeSiteNo ?? siteCode} 校验通过，继续扫描物料',
        ),
      );
      await _persistSnapshot();
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          message: '库位校验失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _handleMaterialScan(
    String materialCode,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final matched = state.taskItems.firstWhereOrNull((item) {
      final matchesMaterial =
          (item.materialCode ?? '').contains(materialCode) ||
              materialCode.contains(item.materialCode ?? '');
      final matchesTray = state.currentTrayCode == null ||
          item.palletNo == null ||
          item.palletNo == state.currentTrayCode;
      final matchesSite = state.currentSiteCode == null ||
          item.storeSiteNo == null ||
          item.storeSiteNo == state.currentSiteCode;
      return matchesMaterial && matchesTray && matchesSite;
    });

    if (matched == null) {
      emit(
        state.copyWith(
          message: '未在任务明细中找到物料 $materialCode，请确认后重试',
        ),
      );
      return;
    }

    await _ensureMaterialControl(matched.materialCode);

    final control = state.materialControls[matched.materialCode];
    if (control != null && control.batchRequired &&
        (matched.batchNo == null || matched.batchNo!.isEmpty)) {
      emit(
        state.copyWith(
          message: '物料需校验批次，当前任务批次为空，请检查',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        activeTask: matched,
        currentStep: AswhInventoryCollectStep.quantityInput,
        lastScannedCode: materialCode,
        message: '物料 ${matched.materialCode ?? materialCode} 校验成功，请录入数量',
      ),
    );
    await _persistSnapshot();
  }

  Future<void> _onTrayConfirmed(
    AswhInventoryCollectTrayConfirmed event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    await _handleTrayScan(event.trayCode, emit);
  }

  Future<void> _onSiteValidated(
    AswhInventoryCollectSiteValidated event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    await _handleSiteScan(event.siteCode, emit);
  }

  Future<void> _onMaterialDecoded(
    AswhInventoryCollectMaterialDecoded event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    await _handleMaterialScan(event.materialCode, emit);
  }

  Future<void> _onQuantityEntered(
    AswhInventoryCollectQuantityEntered event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final activeTask = state.activeTask;
    if (activeTask == null) {
      emit(
        state.copyWith(
          message: '请先扫描物料并选择任务明细',
        ),
      );
      return;
    }

    if (event.quantity <= 0) {
      emit(state.copyWith(message: '采集数量必须大于 0'));
      return;
    }

    final remainingQty = activeTask.planQty - activeTask.collectedQty;
    if (remainingQty > 0 && event.quantity > remainingQty + 0.0001) {
      emit(
        state.copyWith(
          message: '采集数量超过计划数量，请核对后重新录入',
        ),
      );
      return;
    }

    final control = state.materialControls[activeTask.materialCode];
    if (control != null && control.supplierRequired &&
        (activeTask.supplierCode == null ||
            activeTask.supplierCode!.isEmpty)) {
      emit(
        state.copyWith(
          message: '物料需校验供应商，请补充供应商信息',
        ),
      );
      return;
    }

    if (control != null && control.serialRequired &&
        (activeTask.serialNo == null || activeTask.serialNo!.isEmpty)) {
      emit(
        state.copyWith(
          message: '物料需校验序列号，请扫描包含序列信息的条码',
        ),
      );
      return;
    }

    if (control != null && control.validityRequired) {
      final hasValidityInfo = (activeTask.batchNo != null &&
              activeTask.batchNo!.isNotEmpty) ||
          (state.lastScannedCode != null &&
              state.lastScannedCode!.isNotEmpty);
      if (!hasValidityInfo) {
        emit(
          state.copyWith(
            message: '物料需校验有效期，请确认条码包含有效期信息',
          ),
        );
        return;
      }
    }

    final record = InventoryCollectingRecord(
      taskComment: _taskComment ?? activeTask.taskComment ?? '',
      taskItemId: (activeTask.checkItemId ?? activeTask.checkTaskId ?? '')
          .toString(),
      materialCode: activeTask.materialCode ?? '',
      materialId: null,
      storeRoomNo: activeTask.storeRoomNo ?? '',
      storeSiteNo: state.currentSiteCode ?? activeTask.storeSiteNo ?? '',
      collectQty: event.quantity,
      batchNo: activeTask.batchNo,
      serialNo: activeTask.serialNo,
      trayNo: state.currentTrayCode ?? activeTask.palletNo,
      collectedAt: DateTime.now(),
    );

    final updatedCollecting = [...state.collectingItems, record];
    final updatedTaskItems = state.taskItems.map((item) {
      if (item == activeTask) {
        return item.copyWith(
          collectedQty: (item.collectedQty) + event.quantity,
        );
      }
      return item;
    }).toList();

    emit(
      state.copyWith(
        collectingItems: updatedCollecting,
        taskItems: updatedTaskItems,
        currentStep: AswhInventoryCollectStep.trayScan,
        message: '已采集数量 ${event.quantity}，请继续扫描托盘',
        currentTrayCode: null,
        currentSiteCode: null,
        activeTask: null,
      ),
    );
    await _persistSnapshot();
  }

  Future<void> _onTaskItemSelected(
    AswhInventoryCollectTaskItemSelected event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        activeTask: event.taskItem,
        currentTrayCode: event.taskItem.palletNo,
        currentSiteCode: event.taskItem.storeSiteNo,
        message: '已选择任务明细 ${event.taskItem.materialCode ?? ''}',
      ),
    );
    await _persistSnapshot();
  }

  Future<void> _onSwitchTab(
    AswhInventoryCollectSwitchTabRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(state.copyWith(activeTab: event.tab));
  }

  Future<void> _onSubmitRequested(
    AswhInventoryCollectSubmitRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    if (state.collectingItems.isEmpty) {
      emit(state.copyWith(message: '暂无采集记录，无需提交'));
      return;
    }

    emit(
      state.copyWith(
        status: AswhInventoryCollectStatus.submitting,
        isSubmitting: true,
        message: '正在提交采集结果...',
      ),
    );

    try {
      await _collectService.submitCollectionRecords(
        records: state.collectingItems,
        taskComment: _taskComment ?? _query.taskComment,
      );

      emit(
        state.copyWith(
          status: AswhInventoryCollectStatus.success,
          isSubmitting: false,
          collectingItems: const [],
          collectedItems: [...state.collectedItems, ...state.collectingItems],
          message: '提交成功，待采集列表将刷新',
        ),
      );
      await _cacheRepository.clear();
      await _persistSnapshot();
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhInventoryCollectStatus.failure,
          isSubmitting: false,
          message: '提交失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onCommandActionTriggered(
    AswhInventoryCollectCommandActionTriggered event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(state.copyWith(message: '正在下发指令...', isLoading: true));
    try {
      await _collectService.dispatchCommand(event.command);
      emit(
        state.copyWith(
          isLoading: false,
          popup: const AswhCollectPopup(
            type: AswhCollectPopupType.info,
            title: '指令已发送',
            message: '指令已成功下发。',
          ),
          message: '指令发送成功',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          message: '指令下发失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onResultsPatched(
    AswhInventoryCollectResultsPatched event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        collectingItems: event.records,
        taskItems: event.taskItems,
        message: event.message ?? '采集结果已更新',
      ),
    );

    await _persistSnapshot();
  }

  Future<void> _onPopupClosed(
    AswhInventoryCollectPopupClosed event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(state.copyWith(popup: null));
  }

  Future<void> _onSelectionChanged(
    AswhInventoryCollectSelectionChanged event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(state.copyWith(selectedIds: event.selectedIds));
    await _persistSnapshot();
  }

  Future<void> _onResetRequested(
    AswhInventoryCollectResetRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        currentTrayCode: null,
        currentSiteCode: null,
        activeTask: null,
        currentStep: AswhInventoryCollectStep.trayScan,
        message: null,
      ),
    );
    await _persistSnapshot();
  }

  Future<void> _onPickLocationChanged(
    AswhInventoryCollectPickLocationChanged event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedPickLocation: event.location,
        commandMenu: state.commandMenu.copyWith(isOpen: false),
      ),
    );
  }

  Future<void> _onCommandMenuVisibilityChanged(
    AswhInventoryCollectCommandMenuVisibilityChanged event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        commandMenu: state.commandMenu.copyWith(isOpen: event.isOpen),
      ),
    );
  }

  Future<void> _onSingleTrayRequested(
    AswhInventoryCollectSingleTrayRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final pickLocation = state.selectedPickLocation;
    if (pickLocation == null) {
      emit(state.copyWith(message: '请先选择拣选口位置'));
      return;
    }

    if (state.selectedIds.isEmpty) {
      emit(state.copyWith(message: '请至少勾选一条任务明细'));
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        commandMenu: state.commandMenu.copyWith(isOpen: false),
        message: '正在下发托盘指令...',
      ),
    );

    final errors = <String>[];
    for (final item in state.taskItems) {
      if (!state.selectedIds.contains(_resolveItemId(item))) {
        continue;
      }

      if (item.palletNo == null || item.storeSiteNo == null) {
        errors.add(item.materialCode ?? '未知物料');
        continue;
      }

      final command = InventoryCollectCommand(
        taskId: _taskId ?? _query.checkTaskId ?? _query.checkTaskNo,
        taskNo: _query.checkTaskNo,
        trayNo: item.palletNo!,
        startAddr: item.storeSiteNo!,
        endAddr: pickLocation.code ?? '',
        singleFlag: '1',
      );

      try {
        await _collectService.dispatchCommand(command);
      } catch (_) {
        errors.add(item.palletNo ?? item.materialCode ?? '未知');
      }
    }

    emit(
      state.copyWith(
        isLoading: false,
        message: errors.isEmpty
            ? '指令发送成功，请等待托盘到达'
            : '部分托盘指令失败：${errors.join('、')}',
      ),
    );
  }

  Future<void> _onBulkTrayRequested(
    AswhInventoryCollectBulkTrayRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final pickLocation = state.selectedPickLocation;
    if (pickLocation == null) {
      emit(state.copyWith(message: '请先选择拣选口位置'));
      return;
    }

    if (event.quantity <= 0) {
      emit(state.copyWith(message: '托盘数量必须大于 0'));
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        commandMenu: state.commandMenu.copyWith(isOpen: false),
        message: '正在批量下发托盘指令...',
      ),
    );

    final pendingItems = state.taskItems
        .where((item) => item.palletNo != null && item.storeSiteNo != null)
        .toList();

    final errors = <String>[];
    final limited = pendingItems.take(event.quantity);
    for (final item in limited) {
      final command = InventoryCollectCommand(
        taskId: _taskId ?? _query.checkTaskId ?? _query.checkTaskNo,
        taskNo: _query.checkTaskNo,
        trayNo: item.palletNo!,
        startAddr: item.storeSiteNo!,
        endAddr: pickLocation.code ?? '',
        singleFlag: '0',
      );

      try {
        await _collectService.dispatchCommand(command);
      } catch (_) {
        errors.add(item.palletNo ?? '未知');
      }
    }

    emit(
      state.copyWith(
        isLoading: false,
        message: errors.isEmpty
            ? '批量托盘指令已发送，请等待'
            : '以下托盘发送失败：${errors.join('、')}',
      ),
    );
  }

  Future<void> _onReturnTrayRequested(
    AswhInventoryCollectReturnTrayRequested event,
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    final pickLocation = state.selectedPickLocation;
    if (pickLocation == null) {
      emit(state.copyWith(message: '请先选择拣选口位置'));
      return;
    }

    final trayNo = state.currentTrayCode;
    if (trayNo == null || trayNo.isEmpty) {
      emit(state.copyWith(message: '请先扫描托盘后再回库'));
      return;
    }

    final target = state.taskItems.firstWhereOrNull(
      (item) => item.palletNo == trayNo,
    );

    if (target == null || target.storeSiteNo == null) {
      emit(state.copyWith(message: '未找到托盘对应的库位，无法回库'));
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        commandMenu: state.commandMenu.copyWith(isOpen: false),
        message: '正在下发回库指令...',
      ),
    );

    final command = InventoryCollectCommand(
      taskId: _taskId ?? _query.checkTaskId ?? _query.checkTaskNo,
      taskNo: _query.checkTaskNo,
      trayNo: trayNo,
      startAddr: pickLocation.code ?? '',
      endAddr: target.storeSiteNo!,
      action: InventoryCollectCommandAction.inventoryReset,
    );

    try {
      await _collectService.dispatchCommand(command);
      emit(
        state.copyWith(
          isLoading: false,
          message: '回库指令已发送，请等待托盘回库',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          message: '回库指令下发失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _persistSnapshot() async {
    if (!_cacheRepository.isReady || _taskId == null || _taskComment == null) {
      return;
    }

    final snapshot = InventoryCollectStateSnapshot(
      taskId: _taskId!,
      taskComment: _taskComment!,
      activeTrayNo: state.currentTrayCode,
      activeStoreSiteNo: state.currentSiteCode,
      lastScannedCode: state.lastScannedCode,
      taskItems: state.taskItems,
      collectedRecords: state.collectingItems,
      updatedAt: DateTime.now(),
    );

    await _cacheRepository.persistSnapshot(snapshot);
  }

  String? _resolveStoreRoomNo() {
    return state.activeTask?.storeRoomNo ??
        state.taskItems.firstOrNull?.storeRoomNo;
  }

  Future<void> _loadPickLocations(
    Emitter<AswhInventoryCollectState> emit,
  ) async {
    try {
      final locations = await _collectService.fetchPickLocations();
      emit(
        state.copyWith(
          pickLocations: locations,
          selectedPickLocation:
              locations.isNotEmpty ? locations.first : state.selectedPickLocation,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          message: '拣选口位置加载失败：${error.toString()}',
        ),
      );
    }
  }

  Future<void> _ensureMaterialControl(String? materialCode) async {
    if (materialCode == null || materialCode.isEmpty) {
      return;
    }

    if (state.materialControls.containsKey(materialCode)) {
      return;
    }

    try {
      final control = await _collectService.fetchMaterialControl(materialCode);
      if (control != null) {
        final updated = Map<String, InventoryMatControl>.from(
          state.materialControls,
        )
          ..[materialCode] = control;
        emit(state.copyWith(materialControls: updated));
      }
    } catch (_) {
      // 忽略物料控制加载失败，避免阻塞采集流程
    }
  }

  String _resolveItemId(InventoryTaskItem item) {
    return (item.checkItemId ??
            item.palletNo ??
            item.materialCode ??
            item.checkTaskNo ??
            '')
        .toString();
  }


  @override
  Future<void> close() async {
    await _cacheRepository.dispose();
    return super.close();
  }
}
