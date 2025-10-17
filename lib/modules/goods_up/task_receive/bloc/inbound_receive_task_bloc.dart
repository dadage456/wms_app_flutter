import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../../../models/user_info_model.dart';
import '../../services/goods_up_task_service.dart';
import 'inbound_receive_task_event.dart';
import 'inbound_receive_task_state.dart';

/// 入库接收任务列表 BLoC
class InboundReceiveTaskBloc
    extends Bloc<InboundReceiveTaskEvent, InboundReceiveTaskState> {
  InboundReceiveTaskBloc({
    required GoodsUpTaskService taskService,
    required UserManager userManager,
    UserInfoModel? userInfoOverride,
  }) : _taskService = taskService,
       _userManager = userManager,
       _userInfoOverride = userInfoOverride,
       super(const InboundReceiveTaskState()) {
    currentQuery = _buildDefaultQuery();
    gridBloc = CommonDataGridBloc<GoodsUpTask>(dataLoader: _createLoader());

    on<SearchInboundReceiveTasksEvent>(_onSearch);
    on<RefreshInboundReceiveTasksEvent>(_onRefresh);
  }

  final GoodsUpTaskService _taskService;
  final UserManager _userManager;
  final UserInfoModel? _userInfoOverride;

  late GoodsUpTaskQuery currentQuery;
  late final CommonDataGridBloc<GoodsUpTask> gridBloc;

  DataGridLoader<GoodsUpTask> _createLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final response = await _taskService.getInboundTaskList(query: query);
      final totalPages = (response.total / query.pageSize).ceil();
      return DataGridResponseData<GoodsUpTask>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  GoodsUpTaskQuery _buildDefaultQuery() {
    final userInfo = _userInfoOverride ?? _userManager.userInfo;
    if (userInfo == null) {
      throw StateError('未获取到用户信息，无法加载入库接收任务');
    }

    return GoodsUpTaskQuery(
      userId: 'ALL',
      roleOrUserId: '${userInfo.userId}',
      pageIndex: 1,
      pageSize: 100,
      finishFlag: '0',
    );
  }

  Future<void> _onSearch(
    SearchInboundReceiveTasksEvent event,
    Emitter<InboundReceiveTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    gridBloc.add(LoadDataEvent<GoodsUpTask>(currentQuery.pageIndex));
  }

  Future<void> _onRefresh(
    RefreshInboundReceiveTasksEvent event,
    Emitter<InboundReceiveTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent<GoodsUpTask>(gridBloc.state.currentPage));
  }

  @override
  Future<void> close() {
    gridBloc.close();
    return super.close();
  }
}
