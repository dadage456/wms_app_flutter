import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';

import '../../../../services/user_manager.dart';
import '../../services/goods_up_task_service.dart';
import '../models/goods_up_task_item.dart';
import 'goods_up_task_detail_event.dart';
import 'goods_up_task_detail_state.dart';

class GoodsUpTaskDetailBloc
    extends Bloc<GoodsUpTaskDetailEvent, GoodsUpTaskDetailState> {
  GoodsUpTaskDetailBloc(this._service, this._userManager)
    : super(const GoodsUpTaskDetailState()) {
    on<InitializedEvent>(_onInitialized);
    on<SearchEvent>(_onSearch);
    on<CancelSelectedEvent>(_onCancelSelected);
    on<RefreshEvent>(_onRefresh);

    gridBloc = CommonDataGridBloc<GoodsUpTaskItem>(
      dataLoader: _createLoader(),
      dataDeleter: _createDeleter(),
    );
  }

  final GoodsUpTaskService _service;
  final UserManager _userManager;

  late final CommonDataGridBloc<GoodsUpTaskItem> gridBloc;
  GoodsUpTaskItemQuery? currentQuery;

  DataGridLoader<GoodsUpTaskItem> _createLoader() {
    return (pageIndex) async {
      final query = currentQuery?.copyWith(pageIndex: pageIndex);
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
      await _service.commitInboundTaskItems(inTaskItemIds: ids, isCancel: true);
      gridBloc.add(RefrenshLoadDataEvent<GoodsUpTaskItem>());
    };
  }

  Future<void> _onInitialized(
    InitializedEvent event,
    Emitter<GoodsUpTaskDetailState> emit,
  ) async {
    final userInfo = _userManager.userInfo;
    if (userInfo == null) {
      emit(state.copyWith(errorMessage: '未获取到用户信息'));
      return;
    }

    currentQuery = GoodsUpTaskItemQuery(
      inTaskId: event.inTaskId,
      userId: '${userInfo.userId}',
      workStation: event.workStation,
    );

    emit(
      state.copyWith(inTaskId: event.inTaskId, workStation: event.workStation),
    );

    gridBloc.add(LoadDataEvent<GoodsUpTaskItem>(currentQuery!.pageIndex));
  }

  Future<void> _onSearch(
    SearchEvent event,
    Emitter<GoodsUpTaskDetailState> emit,
  ) async {
    if (currentQuery == null) return;
    currentQuery = currentQuery!.copyWith(
      searchKey: event.searchKey,
      pageIndex: 1,
    );
    gridBloc.add(LoadDataEvent<GoodsUpTaskItem>(currentQuery!.pageIndex));
  }

  Future<void> _onCancelSelected(
    CancelSelectedEvent event,
    Emitter<GoodsUpTaskDetailState> emit,
  ) async {
    gridBloc.add(DeleteSelectedRowsEvent<GoodsUpTaskItem>(event.selectedRows));
  }

  Future<void> _onRefresh(
    RefreshEvent event,
    Emitter<GoodsUpTaskDetailState> emit,
  ) async {
    gridBloc.add(RefrenshLoadDataEvent<GoodsUpTaskItem>());
  }

  @override
  Future<void> close() {
    gridBloc.close();
    return super.close();
  }
}
