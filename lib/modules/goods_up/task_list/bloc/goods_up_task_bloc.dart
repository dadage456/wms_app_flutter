import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';

import '../../../../services/user_manager.dart';
import '../models/goods_up_task.dart';
import '../../services/goods_up_task_service.dart';
import 'goods_up_task_event.dart';
import 'goods_up_task_state.dart';

class GoodsUpTaskBloc extends Bloc<GoodsUpTaskEvent, GoodsUpTaskState> {
  GoodsUpTaskBloc({
    required GoodsUpTaskService taskService,
    required UserManager userManager,
  })  : _taskService = taskService,
        _userManager = userManager,
        super(const GoodsUpTaskState()) {
    on<SearchGoodsUpTasksEvent>(_onSearch);
    on<FilterGoodsUpTasksEvent>(_onFilter);
    on<RefreshGoodsUpTasksEvent>(_onRefresh);

    currentQuery = _buildDefaultQuery();
    gridBloc = CommonDataGridBloc<GoodsUpTask>(dataLoader: _createDataLoader());
  }

  final GoodsUpTaskService _taskService;
  final UserManager _userManager;

  late GoodsUpTaskQuery currentQuery;
  late final CommonDataGridBloc<GoodsUpTask> gridBloc;

  DataGridLoader<GoodsUpTask> _createDataLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex + 1);
      final result = await _taskService.getInboundTaskList(query: query);
      final totalPages = (result.total / query.pageSize).ceil();
      return DataGridResponseData<GoodsUpTask>(
        totalPages: totalPages,
        data: result.rows,
      );
    };
  }

  GoodsUpTaskQuery _buildDefaultQuery() {
    final userInfo = _userManager.userInfo!;
    return GoodsUpTaskQuery(
      userId: '${userInfo.userId}',
      roleOrUserId: '${userInfo.userId}',
      pageSize: 100,
    );
  }

  Future<void> _onSearch(
    SearchGoodsUpTasksEvent event,
    Emitter<GoodsUpTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(searchKey: event.searchKey, pageIndex: 1);
    gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
  }

  Future<void> _onFilter(
    FilterGoodsUpTasksEvent event,
    Emitter<GoodsUpTaskState> emit,
  ) async {
    emit(state.copyWith(finishFlag: event.finishFlag));
    currentQuery = currentQuery.copyWith(finishFlag: event.finishFlag, pageIndex: 1);
    final completer = Completer<DataGridResponseData<GoodsUpTask>>();
    gridBloc.add(LoadDataEvent<GoodsUpTask>(0, completer: completer));
    try {
      final response = await completer.future;
      debugPrint('Loaded ${response.data.length} inbound tasks');
    } catch (e) {
      debugPrint('Failed to load inbound tasks: $e');
    }
  }

  Future<void> _onRefresh(
    RefreshGoodsUpTasksEvent event,
    Emitter<GoodsUpTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
  }

  @override
  Future<void> close() {
    gridBloc.close();
    return super.close();
  }
}
