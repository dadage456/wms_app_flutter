import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/services/user_manager.dart';

import '../../services/outbound_task_service.dart';
import 'receive_task_event.dart';
import 'receive_task_state.dart';

/// 平库出库接收任务列表BLoC
class ReceiveTaskBloc extends Bloc<ReceiveTaskEvent, ReceiveTaskState> {
  final OutboundTaskService outboundTaskService;
  final UserManager userManager;

  late OutboundTaskQuery currentQuery = _buildDefaultQuery();
  late final CommonDataGridBloc<OutboundTask> gridBloc =
      CommonDataGridBloc(dataLoader: _createLoader());

  ReceiveTaskBloc({
    required this.outboundTaskService,
    required this.userManager,
  }) : super(const ReceiveTaskState()) {
    on<SearchReceiveTasksEvent>(_onSearch);
    on<RefreshReceiveTasksEvent>(_onRefresh);
  }

  DataGridLoader<OutboundTask> _createLoader() {
    return (int pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final data = await outboundTaskService.getOutboundTaskList(query: query);
      final totalPages = (data.total / query.pageSize).ceil();

      return DataGridResponseData<OutboundTask>(
        totalPages: totalPages,
        data: data.rows,
      );
    };
  }

  Future<void> _onSearch(
    SearchReceiveTasksEvent event,
    Emitter<ReceiveTaskState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );

    final completer = Completer<DataGridResponseData<OutboundTask>>();
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex, completer: completer));
    await completer.future;
  }

  Future<void> _onRefresh(
    RefreshReceiveTasksEvent event,
    Emitter<ReceiveTaskState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  OutboundTaskQuery _buildDefaultQuery() {
    final userInfo = Modular.get<UserManager>().userInfo!;
    return OutboundTaskQuery(
      userId: 'ALL',
      roleOrUserId: '${userInfo.userId}',
      pageSize: 100,
      finishFlag: '0',
    );
  }
}
