import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/goods_up/task_details/models/goods_up_task_item.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../../../models/user_info_model.dart';
import '../../services/goods_up_task_service.dart';
import 'inbound_receive_task_detail_event.dart';
import 'inbound_receive_task_detail_state.dart';

class InboundReceiveTaskDetailBloc
    extends Bloc<InboundReceiveTaskDetailEvent, InboundReceiveTaskDetailState> {
  InboundReceiveTaskDetailBloc(
    this._service,
    this._userManager, {
    UserInfoModel? userInfoOverride,
  }) : _userInfoOverride = userInfoOverride,
       super(const InboundReceiveTaskDetailState()) {
    gridBloc = CommonDataGridBloc<GoodsUpTaskItem>(
      dataLoader: _createLoader(),
      dataDeleter: _createDeleter(),
    );

    on<SearchInboundReceiveTaskItemsEvent>(_onSearch);
    on<ReceiveSelectedInboundItemsEvent>(_onReceiveSelected);
    on<RefreshInboundReceiveTaskItemsEvent>(_onRefresh);
  }

  final GoodsUpTaskService _service;
  final UserManager _userManager;
  final UserInfoModel? _userInfoOverride;

  late final CommonDataGridBloc<GoodsUpTaskItem> gridBloc;
  GoodsUpTaskItemQuery? _currentQuery;

  void initialize(GoodsUpTask task) {
    final userInfo = _userInfoOverride ?? _userManager.userInfo;
    if (userInfo == null) {
      addError(StateError('未获取到用户信息，无法加载入库接收明细'));
      return;
    }

    _currentQuery = GoodsUpTaskItemQuery(
      inTaskId: task.inTaskId,
      userId: 'ALL',
      workStation: task.workStation,
      pageIndex: 1,
      pageSize: 100,
    );
  }

  DataGridLoader<GoodsUpTaskItem> _createLoader() {
    return (pageIndex) async {
      final query = _currentQuery?.copyWith(pageIndex: pageIndex);
      if (query == null) {
        return const DataGridResponseData<GoodsUpTaskItem>(
          totalPages: 0,
          data: [],
        );
      }

      final response = await _service.getInboundTaskItemList(query: query);
      final totalPages = (response.total / query.pageSize).ceil();
      return DataGridResponseData<GoodsUpTaskItem>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  DataGridDeleter _createDeleter() {
    return (indices) async {
      final data = gridBloc.state.data;
      final ids = indices
          .map((index) => data[index].inTaskItemId)
          .map((id) => id)
          .toList();
      await _service.commitInboundTaskItems(
        inTaskItemIds: ids,
        isCancel: false,
      );
      gridBloc.add(LoadDataEvent(1));
    };
  }

  Future<void> _onSearch(
    SearchInboundReceiveTaskItemsEvent event,
    Emitter<InboundReceiveTaskDetailState> emit,
  ) async {
    if (_currentQuery == null) return;

    _currentQuery = _currentQuery!.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    gridBloc.add(LoadDataEvent<GoodsUpTaskItem>(_currentQuery!.pageIndex));
  }

  Future<void> _onReceiveSelected(
    ReceiveSelectedInboundItemsEvent event,
    Emitter<InboundReceiveTaskDetailState> emit,
  ) async {
    gridBloc.add(DeleteSelectedRowsEvent<GoodsUpTaskItem>(event.selectedRows));
  }

  Future<void> _onRefresh(
    RefreshInboundReceiveTaskItemsEvent event,
    Emitter<InboundReceiveTaskDetailState> emit,
  ) async {
    try {
      gridBloc.add(RefrenshLoadDataEvent<GoodsUpTaskItem>());
    } catch (error) {
      emit(state.copyWith(errorMessage: ErrorHandler.handleError(error)));
    }
  }

  @override
  Future<void> close() {
    gridBloc.close();
    return super.close();
  }
}
