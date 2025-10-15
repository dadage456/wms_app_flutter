import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../../common_widgets/common_grid/grid_event.dart';
import '../../../../common_widgets/common_grid/grid_state.dart';
import '../../../../models/user_info_model.dart';
import '../../../../services/user_manager.dart';
import '../../models/aswh_up_task.dart';
import '../../services/aswh_up_task_service.dart';
import 'aswh_up_receive_event.dart';
import 'aswh_up_receive_state.dart';

class AswhUpReceiveBloc extends Bloc<AswhUpReceiveEvent, AswhUpReceiveState> {
  AswhUpReceiveBloc({
    required AswhUpTaskService taskService,
    required UserManager userManager,
    UserInfoModel? userInfoOverride,
  })  : _taskService = taskService,
        _userManager = userManager,
        _userInfoOverride = userInfoOverride,
        super(const AswhUpReceiveState()) {
    currentQuery = _buildDefaultQuery();
    gridBloc = CommonDataGridBloc<AswhUpTask>(dataLoader: _createLoader());

    on<SearchAswhUpReceiveTasksEvent>(_onSearch);
    on<RefreshAswhUpReceiveTasksEvent>(_onRefresh);
  }

  final AswhUpTaskService _taskService;
  final UserManager _userManager;
  final UserInfoModel? _userInfoOverride;

  late AswhUpTaskQuery currentQuery;
  late final CommonDataGridBloc<AswhUpTask> gridBloc;

  AswhUpTaskQuery _buildDefaultQuery() {
    final userInfo = _userInfoOverride ?? _userManager.userInfo;
    if (userInfo == null) {
      throw StateError('未获取到用户信息，无法加载组盘接收任务');
    }

    return AswhUpTaskQuery(
      userId: 'ALL',
      roleOrUserId: '${userInfo.userId}',
      roomTag: '1',
      pageIndex: 1,
      pageSize: 100,
      finishFlag: '0',
    );
  }

  DataGridLoader<AswhUpTask> _createLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final response = await _taskService.fetchTasks(query);
      final totalPages = (response.total / query.pageSize).ceil();
      return DataGridResponseData<AswhUpTask>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  Future<void> _onSearch(
    SearchAswhUpReceiveTasksEvent event,
    Emitter<AswhUpReceiveState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    final completer = Completer<DataGridResponseData<AswhUpTask>>();
    gridBloc.add(LoadDataEvent<AswhUpTask>(0, completer: completer));
    await completer.future;
  }

  Future<void> _onRefresh(
    RefreshAswhUpReceiveTasksEvent event,
    Emitter<AswhUpReceiveState> emit,
  ) async {
    gridBloc.add(LoadDataEvent<AswhUpTask>(gridBloc.state.currentPage));
  }

  @override
  Future<void> close() {
    gridBloc.close();
    return super.close();
  }
}
