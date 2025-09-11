import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/outbound_collect_models.dart';
import '../models/outbound_task.dart';
import '../models/outbound_task_item.dart';
import '../services/outbound_task_service.dart';
import 'outbound_collect_event.dart';
import 'outbound_collect_state.dart';

/// 出库采集BLoC
class OutboundCollectBloc extends Bloc<OutboundCollectEvent, OutboundCollectState> {
  final OutboundTaskService _outboundTaskService;

  OutboundCollectBloc(this._outboundTaskService) : super(const OutboundCollectState.initial()) {
    on<InitializeCollectEvent>(_onInitialize);
    on<LoadTaskItemsEvent>(_onLoadTaskItems);
    on<RefreshTaskItemsEvent>(_onRefreshTaskItems);
    on<SearchTaskItemsEvent>(_onSearchTaskItems);
    on<ProcessScanCodeEvent>(_onProcessScanCode);
    on<ValidateSiteEvent>(_onValidateSite);
    on<ValidateMaterialEvent>(_onValidateMaterial);
    on<QueryInventoryEvent>(_onQueryInventory);
    on<ConfirmQuantityEvent>(_onConfirmQuantity);
    on<AddCollectRecordEvent>(_onAddCollectRecord);
    on<RemoveCollectRecordEvent>(_onRemoveCollectRecord);
    on<ClearCollectRecordsEvent>(_onClearCollectRecords);
    on<SubmitCollectDataEvent>(_onSubmitCollectData);
    on<ReportShortageEvent>(_onReportShortage);
    on<SwitchTabEvent>(_onSwitchTab);
    on<ResetScanStateEvent>(_onResetScanState);
    on<SetScanStepEvent>(_onSetScanStep);
    on<SetCurrentSiteEvent>(_onSetCurrentSite);
    on<SetCurrentMaterialEvent>(_onSetCurrentMaterial);
    on<ExceptionCollectEvent>(_onExceptionCollect);
  }

  /// 初始化采集页面
  Future<void> _onInitialize(
    InitializeCollectEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    emit(const OutboundCollectState.loading());
    
    try {
      // 加载任务明细列表
      final query = CollectTaskQuery(
        outTaskNo: event.task.outTaskNo,
        collecter: event.userId,
      );
      
      final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);
      
      emit(OutboundCollectState.loaded(
        task: event.task,
        taskItems: response.rows,
        collectRecords: [],
        currentTabIndex: 0,
        currentScanStep: ScanStep.site,
        userId: event.userId,
        workStation: event.workStation,
      ));
    } catch (e) {
      emit(OutboundCollectState.error(
        message: '初始化失败: $e',
        task: event.task,
        userId: event.userId,
        workStation: event.workStation,
      ));
    }
  }

  /// 加载任务明细列表
  Future<void> _onLoadTaskItems(
    LoadTaskItemsEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      final query = CollectTaskQuery(
        outTaskNo: currentState.task.outTaskNo,
        collecter: currentState.userId,
      );
      
      final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);
      
      emit(currentState.copyWith(
        taskItems: response.rows,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '加载任务明细失败: $e',
      ));
    }
  }

  /// 刷新任务明细列表
  Future<void> _onRefreshTaskItems(
    RefreshTaskItemsEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    add(const OutboundCollectEvent.loadTaskItems());
  }

  /// 搜索任务明细
  Future<void> _onSearchTaskItems(
    SearchTaskItemsEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      final query = CollectTaskQuery(
        outTaskNo: currentState.task.outTaskNo,
        collecter: currentState.userId,
        searchKey: event.searchKey,
      );
      
      final response = await _outboundTaskService.getOutTaskCollectItemList(query: query);
      
      emit(currentState.copyWith(
        taskItems: response.rows,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '搜索任务明细失败: $e',
      ));
    }
  }

  /// 处理扫码内容
  Future<void> _onProcessScanCode(
    ProcessScanCodeEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(OutboundCollectState.scanProcessing(
      task: currentState.task,
      taskItems: currentState.taskItems,
      collectRecords: currentState.collectRecords,
      currentTabIndex: currentState.currentTabIndex,
      currentScanStep: currentState.currentScanStep,
      userId: currentState.userId,
      workStation: currentState.workStation,
      currentSiteCode: currentState.currentSiteCode,
      currentBarcodeContent: currentState.currentBarcodeContent,
      currentInventory: currentState.currentInventory,
      scanContent: event.content,
    ));

    try {
      // 根据当前扫码步骤处理扫码内容
      switch (currentState.currentScanStep) {
        case ScanStep.site:
          // 验证库位
          add(OutboundCollectEvent.validateSite(siteCode: event.content));
          break;
        case ScanStep.material:
          // 解析物料条码
          final barcodeContent = await _outboundTaskService.parseBarcodeContent(event.content);
          if (barcodeContent != null) {
            add(OutboundCollectEvent.validateMaterial(
              barcodeContent: barcodeContent,
              siteCode: currentState.currentSiteCode ?? '',
            ));
          } else {
            emit(currentState.copyWith(
              errorMessage: '无法解析条码内容',
            ));
          }
          break;
        case ScanStep.quantity:
          // 数量确认步骤不需要扫码
          break;
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '处理扫码内容失败: $e',
      ));
    }
  }

  /// 验证库位
  Future<void> _onValidateSite(
    ValidateSiteEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      // 检查库位是否在任务明细中
      final hasValidSite = currentState.taskItems.any(
        (item) => item.storeSiteNo == event.siteCode,
      );

      if (hasValidSite) {
        emit(currentState.copyWith(
          currentSiteCode: event.siteCode,
          currentScanStep: ScanStep.material,
          successMessage: '库位验证成功，请扫描物料条码',
        ));
      } else {
        emit(currentState.copyWith(
          errorMessage: '库位不在当前任务中',
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '验证库位失败: $e',
      ));
    }
  }

  /// 验证物料
  Future<void> _onValidateMaterial(
    ValidateMaterialEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      // 检查物料是否在当前库位的任务明细中
      final taskItem = currentState.taskItems.where(
        (item) => item.storeSiteNo == event.siteCode && 
                 item.matCode == event.barcodeContent.matCode,
      ).firstOrNull;

      if (taskItem != null) {
        // 查询库存
        final inventoryQuery = InventoryQuery(
          storeSite: event.siteCode,
          matCode: event.barcodeContent.matCode,
          batchNo: event.barcodeContent.batchNo,
          sn: event.barcodeContent.sn,
        );
        
        add(OutboundCollectEvent.queryInventory(query: inventoryQuery));
      } else {
        emit(currentState.copyWith(
          errorMessage: '物料不在当前库位的任务中',
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '验证物料失败: $e',
      ));
    }
  }

  /// 查询库存
  Future<void> _onQueryInventory(
    QueryInventoryEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(OutboundCollectState.inventoryQuerying(
      task: currentState.task,
      taskItems: currentState.taskItems,
      collectRecords: currentState.collectRecords,
      currentTabIndex: currentState.currentTabIndex,
      currentScanStep: currentState.currentScanStep,
      userId: currentState.userId,
      workStation: currentState.workStation,
      currentSiteCode: currentState.currentSiteCode,
      currentBarcodeContent: currentState.currentBarcodeContent,
      query: event.query,
    ));

    try {
      final response = await _outboundTaskService.getMtlRepertoryByStoresiteNo(query: event.query);
      
      emit(currentState.copyWith(
        currentInventory: response,
        successMessage: '库存查询成功，请确认采集数量',
      ));
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '库存查询失败: $e',
      ));
    }
  }

  /// 确认采集数量
  Future<void> _onConfirmQuantity(
    ConfirmQuantityEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      if (currentState.currentBarcodeContent != null && 
          currentState.currentSiteCode != null &&
          currentState.currentInventory != null) {
        
        final collectRecord = CollectRecord(
          matCode: currentState.currentBarcodeContent!.matCode,
          matName: '', // 需要从任务明细中获取
          storeSiteNo: currentState.currentSiteCode!,
          qty: event.quantity,
          batchNo: currentState.currentBarcodeContent!.batchNo,
          sn: currentState.currentBarcodeContent!.sn,
          collectTime: DateTime.now().toIso8601String(),
        );

        add(OutboundCollectEvent.addCollectRecord(record: collectRecord));
      } else {
        emit(currentState.copyWith(
          errorMessage: '采集信息不完整',
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '确认数量失败: $e',
      ));
    }
  }

  /// 添加采集记录
  Future<void> _onAddCollectRecord(
    AddCollectRecordEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    final updatedRecords = [...currentState.collectRecords, event.record];
    
    emit(currentState.copyWith(
      collectRecords: updatedRecords,
      currentScanStep: ScanStep.site,
      currentSiteCode: null,
      currentBarcodeContent: null,
      currentInventory: null,
      successMessage: '采集记录添加成功',
    ));
  }

  /// 删除采集记录
  Future<void> _onRemoveCollectRecord(
    RemoveCollectRecordEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    final updatedRecords = [...currentState.collectRecords];
    if (event.index >= 0 && event.index < updatedRecords.length) {
      updatedRecords.removeAt(event.index);
      
      emit(currentState.copyWith(
        collectRecords: updatedRecords,
        successMessage: '采集记录删除成功',
      ));
    }
  }

  /// 清空采集记录
  Future<void> _onClearCollectRecords(
    ClearCollectRecordsEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      collectRecords: [],
      successMessage: '采集记录已清空',
    ));
  }

  /// 提交采集数据
  Future<void> _onSubmitCollectData(
    SubmitCollectDataEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    if (currentState.collectRecords.isEmpty) {
      emit(currentState.copyWith(
        errorMessage: '没有采集记录可提交',
      ));
      return;
    }

    emit(OutboundCollectState.submitting(
      task: currentState.task,
      taskItems: currentState.taskItems,
      collectRecords: currentState.collectRecords,
      currentTabIndex: currentState.currentTabIndex,
      currentScanStep: currentState.currentScanStep,
      userId: currentState.userId,
      workStation: currentState.workStation,
      currentSiteCode: currentState.currentSiteCode,
      currentBarcodeContent: currentState.currentBarcodeContent,
      currentInventory: currentState.currentInventory,
    ));

    try {
      final response = await _outboundTaskService.commitDownShelves(
        collectRecords: currentState.collectRecords,
      );
      
      if (response.code == '200') {
        emit(currentState.copyWith(
          collectRecords: [],
          successMessage: '提交成功',
        ));
        
        // 刷新任务明细列表
        add(const OutboundCollectEvent.refreshTaskItems());
      } else {
        emit(currentState.copyWith(
          errorMessage: response.message ?? '提交失败',
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '提交失败: $e',
      ));
    }
  }

  /// 报缺任务明细
  Future<void> _onReportShortage(
    ReportShortageEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      final response = await _outboundTaskService.commitFinishOutTaskItem(
          outTaskItemId: event.outTaskItemId,
        );
      
      if (response.code == '200') {
        emit(currentState.copyWith(
          successMessage: '报缺成功',
        ));
        
        // 刷新任务明细列表
        add(const OutboundCollectEvent.refreshTaskItems());
      } else {
        emit(currentState.copyWith(
          errorMessage: response.message ?? '报缺失败',
        ));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '报缺失败: $e',
      ));
    }
  }

  /// 切换Tab
  Future<void> _onSwitchTab(
    SwitchTabEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      currentTabIndex: event.tabIndex,
    ));
  }

  /// 重置扫码状态
  Future<void> _onResetScanState(
    ResetScanStateEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      currentScanStep: ScanStep.site,
      currentSiteCode: null,
      currentBarcodeContent: null,
      currentInventory: null,
      errorMessage: null,
      successMessage: null,
    ));
  }

  /// 设置当前扫码步骤
  Future<void> _onSetScanStep(
    SetScanStepEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      currentScanStep: event.step,
    ));
  }

  /// 设置当前库位
  Future<void> _onSetCurrentSite(
    SetCurrentSiteEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      currentSiteCode: event.siteCode,
    ));
  }

  /// 设置当前物料信息
  Future<void> _onSetCurrentMaterial(
    SetCurrentMaterialEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    emit(currentState.copyWith(
      currentBarcodeContent: event.barcodeContent,
    ));
  }

  /// 异常采集
  Future<void> _onExceptionCollect(
    ExceptionCollectEvent event,
    Emitter<OutboundCollectState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OutboundCollectLoaded) return;

    try {
      // 添加异常采集记录
      final updatedRecords = [...currentState.collectRecords, event.record];
      
      emit(currentState.copyWith(
        collectRecords: updatedRecords,
        successMessage: '异常采集记录添加成功: ${event.reason}',
      ));
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: '异常采集失败: $e',
      ));
    }
  }
}