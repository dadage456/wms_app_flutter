import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/models/arrival_collect_submit_request.dart';
import 'package:wms_app/modules/arrival_sign/task_collect/services/arrival_collect_cache_repository.dart';
import 'package:wms_app/services/user_manager.dart';

import '../models/arrival_collect_cache.dart';
import '../models/arrival_collect_progress.dart';
import '../models/arrival_collect_task.dart';
import 'arrival_collect_event.dart';
import 'arrival_collect_state.dart';

class ArrivalCollectBloc
    extends Bloc<ArrivalCollectEvent, ArrivalCollectState> {
  ArrivalCollectBloc({
    required ArrivalSignService service,
    required UserManager userManager,
    required ArrivalCollectCacheRepository cacheRepository,
  }) : _service = service,
       _userManager = userManager,
       _cacheRepository = cacheRepository,
       super(const ArrivalCollectState()) {
    on<_Initialized>(_onInitialized);
    on<_RefreshDetails>(_onRefreshDetails);
    on<_SelectTask>(_onSelectTask);
    on<_ScanSubmitted>(_onScanSubmitted);
    on<_QuantitySubmitted>(_onQuantitySubmitted);
    on<_SwitchTab>(_onSwitchTab);
    on<_ToggleCollectSelection>(_onToggleCollectSelection);
    on<_DeleteSelected>(_onDeleteSelected);
    on<_Submit>(_onSubmit);
    on<_RestoreFromCache>(_onRestoreFromCache);
    on<_PersistCache>(_onPersistCache);
    on<_ResultPageClosed>(_onResultPageClosed);
  }

  final ArrivalSignService _service;
  final UserManager _userManager;
  final ArrivalCollectCacheRepository _cacheRepository;
  final Uuid _uuid = const Uuid();

  Future<void> _onInitialized(
    _Initialized event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    emit(
      state.copyWith(
        headerTask: event.task,
        isLoading: true,
        errorMessage: null,
        successMessage: null,
        progresses: const [],
        selectedProgressIds: const {},
      ),
    );

    try {
      await _loadDetails(emit: emit, task: event.task);
      add(const ArrivalCollectEvent.restoreFromCache());
    } catch (error, stackTrace) {
      debugPrint('到货采集加载失败: $error\n$stackTrace');
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> _loadDetails({
    required Emitter<ArrivalCollectState> emit,
    required ArrivalSignTask task,
  }) async {
    final response = await _service.getArrivalSignDetails(
      query: ArrivalSignDetailQuery(
        arrivalsBillId: task.arrivalsBillId,
        pageIndex: 1,
        pageSize: 200,
      ),
    );

    final items = response.rows
        .map(
          (detail) => ArrivalCollectTask.fromDetail(
            detail,
            arrivalsBillId: task.arrivalsBillId,
          ),
        )
        .toList();

    emit(
      state.copyWith(
        isLoading: false,
        taskItems: items,
        selectedTask: items.isNotEmpty ? items.first : null,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onRefreshDetails(
    _RefreshDetails event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final task = state.headerTask;
    if (task == null) return;

    emit(state.copyWith(isLoading: true));
    try {
      await _loadDetails(emit: emit, task: task);
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void _onSelectTask(_SelectTask event, Emitter<ArrivalCollectState> emit) {
    emit(
      state.copyWith(
        selectedTask: event.task,
        currentStep: ArrivalCollectScanStep.materialQRCode,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  Future<void> _onScanSubmitted(
    _ScanSubmitted event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final value = event.value.trim();
    if (value.isEmpty) {
      emit(state.copyWith(errorMessage: '扫码内容为空'));
      return;
    }

    switch (state.currentStep) {
      case ArrivalCollectScanStep.materialQRCode:
        await _handleMaterialScan(value, emit);
        break;
      case ArrivalCollectScanStep.quantity:
        final quantity = double.tryParse(value);
        if (quantity == null) {
          emit(state.copyWith(errorMessage: '请输入正确的数量'));
          return;
        }
        add(ArrivalCollectEvent.quantitySubmitted(quantity));
        break;
      case ArrivalCollectScanStep.location:
        emit(
          state.copyWith(
            successMessage: '库位\"$value\" 已记录',
            currentStep: ArrivalCollectScanStep.quantity,
          ),
        );
        break;
    }
  }

  Future<void> _handleMaterialScan(
    String value,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final items = state.taskItems;
    if (items.isEmpty) {
      emit(state.copyWith(errorMessage: '暂无可采集的物料'));
      return;
    }

    try {
      String materialCode = value;
      if (value.contains('MC')) {
        materialCode = await _service.getMaterialCodeByQr(value);
      }

      final matchedTask = items.firstWhereOrNull(
        (task) => task.materialCode == materialCode,
      );

      if (matchedTask == null) {
        emit(state.copyWith(errorMessage: '未找到对应物料: $materialCode'));
        return;
      }

      emit(
        state.copyWith(
          selectedTask: matchedTask,
          currentStep: ArrivalCollectScanStep.quantity,
          successMessage: '物料 ${matchedTask.materialCode} 已匹配，请输入数量',
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(state.copyWith(errorMessage: error.toString()));
    }
  }

  Future<void> _onQuantitySubmitted(
    _QuantitySubmitted event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final task = state.selectedTask;
    if (task == null) {
      emit(state.copyWith(errorMessage: '请先选择或扫描物料'));
      return;
    }

    final quantity = event.quantity;
    if (quantity <= 0) {
      emit(state.copyWith(errorMessage: '数量必须大于0'));
      return;
    }

    final remaining = task.remainingQuantity;
    if (quantity > remaining + 1e-6) {
      emit(state.copyWith(errorMessage: '采集数量不能超过剩余数量'));
      return;
    }

    if (task.materialControlType == 2) {
      final hasSerial = state.progresses.any(
        (element) =>
            (element.serialNumber ?? element.task.serialNumber) ==
            task.serialNumber,
      );
      if (hasSerial) {
        emit(state.copyWith(errorMessage: '序列号已采集，不能重复'));
        return;
      }
    }

    final progress = ArrivalCollectProgress(
      id: _uuid.v4(),
      task: task,
      collectQty: quantity,
      batchNo: task.batchNo,
      serialNumber: task.serialNumber,
      productionDate: task.productionDate,
      validDays: task.validDays,
    );

    final updatedTasks = state.taskItems.map((item) {
      if (item.materialCode == task.materialCode) {
        return item.copyWith(
          collectedQuantity: item.collectedQuantity + quantity,
        );
      }
      return item;
    }).toList();

    final newProgresses = List<ArrivalCollectProgress>.from(state.progresses)
      ..add(progress);

    final updatedSelectedTask = updatedTasks.firstWhereOrNull(
      (item) => item.materialCode == task.materialCode,
    );

    emit(
      state.copyWith(
        taskItems: updatedTasks,
        progresses: newProgresses,
        selectedProgressIds: const {},
        currentStep: ArrivalCollectScanStep.materialQRCode,
        selectedTask: updatedSelectedTask ?? state.selectedTask,
        successMessage: '已采集 ${task.materialCode} 数量 $quantity',
        errorMessage: null,
      ),
    );

    add(const ArrivalCollectEvent.persistCache());
  }

  void _onSwitchTab(_SwitchTab event, Emitter<ArrivalCollectState> emit) {
    emit(state.copyWith(activeTabIndex: event.index));
  }

  void _onToggleCollectSelection(
    _ToggleCollectSelection event,
    Emitter<ArrivalCollectState> emit,
  ) {
    final selections = Set<String>.from(state.selectedProgressIds);
    if (selections.contains(event.id)) {
      selections.remove(event.id);
    } else {
      selections.add(event.id);
    }
    emit(state.copyWith(selectedProgressIds: selections));
  }

  void _onDeleteSelected(
    _DeleteSelected event,
    Emitter<ArrivalCollectState> emit,
  ) {
    if (state.selectedProgressIds.isEmpty) {
      emit(state.copyWith(errorMessage: '请先选择需要删除的记录'));
      return;
    }

    final removedIds = state.selectedProgressIds;
    final remainingProgresses = state.progresses
        .where((p) => !removedIds.contains(p.id))
        .toList();

    final restoredTasks = state.taskItems.map((task) {
      final removedQty = state.progresses
          .where((p) => removedIds.contains(p.id))
          .where((p) => p.task.materialCode == task.materialCode)
          .fold<double>(0, (prev, p) => prev + p.collectQty);
      if (removedQty == 0) {
        return task;
      }
      final newQty = task.collectedQuantity - removedQty;
      final normalized = newQty < task.baseCollectedQuantity
          ? task.baseCollectedQuantity
          : newQty;
      return task.copyWith(collectedQuantity: normalized);
    }).toList();

    emit(
      state.copyWith(
        progresses: remainingProgresses,
        taskItems: restoredTasks,
        selectedProgressIds: const {},
        successMessage: '已删除选中的采集记录',
        errorMessage: null,
      ),
    );

    add(const ArrivalCollectEvent.persistCache());
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    if (state.progresses.isEmpty) {
      emit(state.copyWith(errorMessage: '暂无可提交的采集记录'));
      return;
    }

    final task = state.headerTask;
    if (task == null) {
      emit(state.copyWith(errorMessage: '缺少到货任务信息'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final user = await _userManager.getUserInfo();
      final request = ArrivalCollectSubmitRequest.fromProgressList(
        progresses: state.progresses,
        userCode: user?.userCode,
        arrivalsBillId: task.arrivalsBillId,
      );

      await _service.commitSignShelves(request);
      await _cacheRepository.clearCache(task.arrivalsBillId);

      emit(
        state.copyWith(
          isSubmitting: false,
          progresses: const [],
          selectedProgressIds: const {},
          successMessage: '提交成功',
        ),
      );
      add(const ArrivalCollectEvent.refreshDetails());
    } catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: error.toString()));
    }
  }

  Future<void> _onRestoreFromCache(
    _RestoreFromCache event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final task = state.headerTask;
    if (task == null) return;

    try {
      final cache = await _cacheRepository.loadCache(task.arrivalsBillId);
      if (cache == null) {
        return;
      }

      final progresses = cache.progresses;

      final updatedTasks = state.taskItems.map((item) {
        final collected = progresses
            .where((p) => p.task.materialCode == item.materialCode)
            .fold<double>(0, (prev, p) => prev + p.collectQty);
        if (collected == 0) {
          return item;
        }
        return item.copyWith(
          collectedQuantity: item.baseCollectedQuantity + collected,
        );
      }).toList();

      ArrivalCollectTask? updatedSelected = state.selectedTask;
      if (updatedSelected != null) {
        updatedSelected = updatedTasks.firstWhereOrNull(
          (item) => item.materialCode == updatedSelected!.materialCode,
        );
      }

      emit(
        state.copyWith(
          progresses: progresses,
          taskItems: updatedTasks,
          selectedTask: updatedSelected ?? state.selectedTask,
          cache: cache,
        ),
      );
    } catch (error) {
      debugPrint('恢复采集缓存失败: $error');
    }
  }

  Future<void> _onPersistCache(
    _PersistCache event,
    Emitter<ArrivalCollectState> emit,
  ) async {
    final task = state.headerTask;
    if (task == null) return;

    final cache = ArrivalCollectCache(
      progresses: state.progresses,
      hasPendingSubmit: state.progresses.isNotEmpty,
      arrivalsBillId: task.arrivalsBillId,
    );

    await _cacheRepository.saveCache(key: task.arrivalsBillId, cache: cache);
    emit(state.copyWith(cache: cache));
  }

  void _onResultPageClosed(
    _ResultPageClosed event,
    Emitter<ArrivalCollectState> emit,
  ) {
    final progresses = event.progresses;
    final updatedTasks = state.taskItems.map((item) {
      final collected = progresses
          .where((p) => p.task.materialCode == item.materialCode)
          .fold<double>(0, (prev, p) => prev + p.collectQty);
      return item.copyWith(
        collectedQuantity: item.baseCollectedQuantity + collected,
      );
    }).toList();

    ArrivalCollectTask? updatedSelected = state.selectedTask;
    if (updatedSelected != null) {
      updatedSelected = updatedTasks.firstWhereOrNull(
        (item) => item.materialCode == updatedSelected!.materialCode,
      );
    }

    emit(
      state.copyWith(
        progresses: progresses,
        taskItems: updatedTasks,
        selectedProgressIds: const {},
        selectedTask: updatedSelected ?? state.selectedTask,
      ),
    );
    add(const ArrivalCollectEvent.persistCache());
  }
}
