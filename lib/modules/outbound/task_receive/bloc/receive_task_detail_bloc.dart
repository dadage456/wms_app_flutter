import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/outbound/task_details/models/outbound_task_item.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../services/outbound_task_service.dart';
import 'receive_task_detail_event.dart';
import 'receive_task_detail_state.dart';

class ReceiveTaskDetailBloc
    extends Bloc<ReceiveTaskDetailEvent, ReceiveTaskDetailState> {
  final OutboundTaskService outboundTaskService;
  final UserManager userManager;

  ReceiveTaskDetailBloc(this.outboundTaskService, this.userManager)
    : super(const ReceiveTaskDetailState()) {
    on<SearchReceiveTaskItemsEvent>(_onSearch);
    on<ReceiveSelectedItemsEvent>(_onReceiveSelected);
    on<RefreshReceiveTaskItemsEvent>(_onRefresh);
    _initGridBloc();
  }

  late final CommonDataGridBloc<OutboundTaskItem> gridBloc;
  late OutboundTaskItemQuery currentQuery;

  void _initGridBloc() {
    gridBloc = CommonDataGridBloc<OutboundTaskItem>(
      dataLoader: _createLoader(),
      dataCommiter: _createReceiver(),
    );
  }

  void initializeQuery(OutboundTask task) {
    final userInfo = userManager.userInfo!;
    currentQuery = OutboundTaskItemQuery(
      outTaskId: task.outTaskId.toString(),
      workStation: task.workStation,
      userId: 'ALL',
      roleOrUserId: userInfo.userId.toString(),
      pageIndex: 1,
      pageSize: 100,
    );
  }

  DataGridLoader<OutboundTaskItem> _createLoader() {
    return (int pageIndex) async {
      currentQuery = currentQuery.copyWith(pageIndex: pageIndex);
      final data = await outboundTaskService.getOutboundTaskItemList(
        query: currentQuery,
      );
      final totalPages = (data.total / currentQuery.pageSize).ceil();

      return DataGridResponseData<OutboundTaskItem>(
        totalPages: totalPages,
        data: data.rows,
      );
    };
  }

  DataGridDeleter _createReceiver() {
    return (selectedRows) async {
      final datas = gridBloc.state.data;
      final ids = selectedRows.map((index) {
        return datas[index].outTaskItemId.toString();
      }).toList();

      await outboundTaskService.commitOutboundTaskItems(
        taskItemIds: ids,
        isCancel: false,
      );

      gridBloc.add(const RefrenshLoadDataEvent<OutboundTaskItem>());
    };
  }

  Future<void> _onSearch(
    SearchReceiveTaskItemsEvent event,
    Emitter<ReceiveTaskDetailState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  Future<void> _onReceiveSelected(
    ReceiveSelectedItemsEvent event,
    Emitter<ReceiveTaskDetailState> emit,
  ) async {
    gridBloc.add(CommitSelectedRowsEvent(event.selectedRows));
  }

  Future<void> _onRefresh(
    RefreshReceiveTaskItemsEvent event,
    Emitter<ReceiveTaskDetailState> emit,
  ) async {
    try {
      gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
    } catch (e) {
      emit(state.copyWith(errorMessage: ErrorHandler.handleError(e)));
    }
  }
}
