import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../../common_widgets/common_grid/grid_event.dart';
import '../../../../common_widgets/common_grid/grid_state.dart';
import '../../../../models/user_info_model.dart';
import '../../../../services/user_manager.dart';
import '../../../../utils/error_handler.dart';
import '../../models/aswh_up_task.dart';
import '../../services/aswh_up_task_service.dart';
import '../../task_details/models/aswh_up_task_detail_item.dart';
import 'aswh_up_receive_detail_event.dart';
import 'aswh_up_receive_detail_state.dart';

class AswhUpReceiveDetailBloc
    extends Bloc<AswhUpReceiveDetailEvent, AswhUpReceiveDetailState> {
  AswhUpReceiveDetailBloc(
    this._service,
    this._userManager, {
    UserInfoModel? userInfoOverride,
  }) : _userInfoOverride = userInfoOverride,
       super(const AswhUpReceiveDetailState()) {
    on<InitializeAswhUpReceiveDetailEvent>(_onInitialize);
    on<SearchAswhUpReceiveDetailEvent>(_onSearch);
    on<ReceiveSelectedAswhUpItemsEvent>(_onReceiveSelected);
    on<RefreshAswhUpReceiveDetailEvent>(_onRefresh);

    gridBloc = CommonDataGridBloc<AswhUpTaskDetailItem>(
      dataLoader: _createLoader(),
      dataDeleter: _createDeleter(),
    );
  }

  final AswhUpTaskService _service;
  final UserManager _userManager;
  final UserInfoModel? _userInfoOverride;

  late final CommonDataGridBloc<AswhUpTaskDetailItem> gridBloc;
  AswhUpTaskDetailQuery? _currentQuery;
  AswhUpTask? _task;

  DataGridLoader<AswhUpTaskDetailItem> _createLoader() {
    return (pageIndex) async {
      final query = _currentQuery?.copyWith(pageIndex: pageIndex);
      if (query == null) {
        return const DataGridResponseData<AswhUpTaskDetailItem>(
          totalPages: 0,
          data: [],
        );
      }

      final response = await _service.fetchTaskItems(query: query);
      final totalPages = (response.total / query.pageSize).ceil();
      return DataGridResponseData<AswhUpTaskDetailItem>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  DataGridDeleter _createDeleter() {
    return (selectedRows) async {
      final data = gridBloc.state.data;
      final ids = selectedRows
          .map((index) => data[index].inTaskItemId)
          .toList(growable: false);

      await _service.commitTaskItems(
        inTaskItemIds: ids,
        roomTag: '1',
        isCancel: false,
      );

      gridBloc.add(
        LoadDataEvent<AswhUpTaskDetailItem>(gridBloc.state.currentPage),
      );
    };
  }

  Future<void> _onInitialize(
    InitializeAswhUpReceiveDetailEvent event,
    Emitter<AswhUpReceiveDetailState> emit,
  ) async {
    final userInfo = _userInfoOverride ?? _userManager.userInfo;
    if (userInfo == null) {
      addError(StateError('未获取到用户信息，无法加载入库接收明细'));
      return;
    }

    _currentQuery = AswhUpTaskDetailQuery(
      inTaskId: event.taskId,
      userId: 'ALL',
      workStation: event.workStation,
      pageIndex: 1,
      pageSize: 100,
    );
  }

  Future<void> _onSearch(
    SearchAswhUpReceiveDetailEvent event,
    Emitter<AswhUpReceiveDetailState> emit,
  ) async {
    if (_currentQuery == null) return;

    _currentQuery = _currentQuery!.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    gridBloc.add(LoadDataEvent<AswhUpTaskDetailItem>(_currentQuery!.pageIndex));
  }

  Future<void> _onReceiveSelected(
    ReceiveSelectedAswhUpItemsEvent event,
    Emitter<AswhUpReceiveDetailState> emit,
  ) async {
    if (event.selectedRows.isEmpty) {
      emit(state.copyWith(errorMessage: '请先选择要接收的明细'));
      return;
    }

    gridBloc.add(
      DeleteSelectedRowsEvent<AswhUpTaskDetailItem>(event.selectedRows),
    );
  }

  Future<void> _onRefresh(
    RefreshAswhUpReceiveDetailEvent event,
    Emitter<AswhUpReceiveDetailState> emit,
  ) async {
    try {
      gridBloc.add(RefrenshLoadDataEvent<AswhUpTaskDetailItem>());
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
