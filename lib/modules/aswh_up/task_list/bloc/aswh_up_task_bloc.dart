import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';

import '../../../../services/user_manager.dart';
import '../../models/aswh_up_task.dart';
import '../../services/aswh_up_task_service.dart';
import 'aswh_up_task_event.dart';
import 'aswh_up_task_state.dart';

class AswhUpTaskBloc extends Bloc<AswhUpTaskEvent, AswhUpTaskState> {
  AswhUpTaskBloc({
    required AswhUpTaskService taskService,
    required UserManager userManager,
  }) : _taskService = taskService,
       _userManager = userManager,
       super(const AswhUpTaskState()) {
    on<SearchAswhUpTasksEvent>(_onSearch);
    on<RefreshAswhUpTasksEvent>(_onRefresh);

    currentQuery = _buildDefaultQuery();
    gridBloc = CommonDataGridBloc<AswhUpTask>(dataLoader: _createDataLoader());
  }

  final AswhUpTaskService _taskService;
  final UserManager _userManager;

  late AswhUpTaskQuery currentQuery;
  late final CommonDataGridBloc<AswhUpTask> gridBloc;
  int _latestTotal = 0;

  DataGridLoader<AswhUpTask> _createDataLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      currentQuery = query;
      final result = await _taskService.fetchTasks(query);
      _latestTotal = result.total;
      final calculated = query.pageSize == 0
          ? 1
          : (result.total / query.pageSize).ceil();
      final totalPages = calculated <= 0 ? 1 : calculated;
      return DataGridResponseData<AswhUpTask>(
        totalPages: totalPages,
        data: result.rows,
      );
    };
  }

  AswhUpTaskQuery _buildDefaultQuery() {
    final userInfo = _userManager.userInfo;
    return AswhUpTaskQuery(
      userId: '${userInfo?.userId ?? ''}',
      roleOrUserId: '${userInfo?.userId ?? ''}',
      pageSize: 100,
      pageIndex: 1,
      roomTag: '1',
    );
  }

  Future<void> _onSearch(
    SearchAswhUpTasksEvent event,
    Emitter<AswhUpTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    emit(state.copyWith(searchKey: event.searchKey));
    gridBloc.add(const LoadDataEvent<AswhUpTask>(0));
  }

  Future<void> _onRefresh(
    RefreshAswhUpTasksEvent event,
    Emitter<AswhUpTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent<AswhUpTask>(state.currentPage));
  }
}
