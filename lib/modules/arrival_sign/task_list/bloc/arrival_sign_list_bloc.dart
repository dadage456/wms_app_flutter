import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';
import 'package:wms_app/services/user_manager.dart';

import 'arrival_sign_list_event.dart';
import 'arrival_sign_list_state.dart';

class ArrivalSignListBloc
    extends Bloc<ArrivalSignListEvent, ArrivalSignListState> {
  ArrivalSignListBloc({
    required this.arrivalSignService,
    required this.userManager,
  }) : super(const ArrivalSignListState()) {
    on<ArrivalSignListEvent>(_onEvent);
  }

  final ArrivalSignService arrivalSignService;
  final UserManager userManager;

  late ArrivalSignTaskQuery currentQuery = _createDefaultQuery();

  late final CommonDataGridBloc<ArrivalSignTask> gridBloc =
      CommonDataGridBloc<ArrivalSignTask>(dataLoader: _createLoader());

  DataGridLoader<ArrivalSignTask> _createLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final response = await arrivalSignService.getArrivalSignTasks(
        query: query,
      );
      final totalPages = response.total == 0
          ? 1
          : (response.total / query.pageSize).ceil();
      return DataGridResponseData(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  Future<void> _onEvent(
    ArrivalSignListEvent event,
    Emitter<ArrivalSignListState> emit,
  ) async {
    await event.when(
      initialized: () => _handleInitialized(emit),
      search: (keyword) => _handleSearch(keyword, emit),
      refresh: () => _handleRefresh(emit),
      cancel: (arrivalsBillId) => _handleCancel(arrivalsBillId, emit),
    );
  }

  Future<void> _handleInitialized(Emitter<ArrivalSignListState> emit) async {
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  Future<void> _handleSearch(
    String keyword,
    Emitter<ArrivalSignListState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(
      searchKey: keyword,
      pageIndex: 1,
    );
    gridBloc.add(const LoadDataEvent(1));
  }

  Future<void> _handleRefresh(
    Emitter<ArrivalSignListState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(gridBloc.state.currentPage));
  }

  Future<void> _handleCancel(
    String arrivalsBillId,
    Emitter<ArrivalSignListState> emit,
  ) async {
    emit(
      state.copyWith(isProcessing: true, errorMessage: null, successMessage: null),
    );
    try {
      await arrivalSignService.cancelArrivalSign(
        arrivalsBillId: arrivalsBillId,
      );
      emit(state.copyWith(isProcessing: false, successMessage: '撤销成功'));
      gridBloc.add(const LoadDataEvent(1));
    } catch (error) {
      emit(
        state.copyWith(
          isProcessing: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  ArrivalSignTaskQuery _createDefaultQuery() {
    final user = userManager.userInfo;
    if (user == null) {
      return const ArrivalSignTaskQuery(userId: '', roleOrUserId: '');
    }
    return ArrivalSignTaskQuery(
      userId: '${user.userId}',
      roleOrUserId: '${user.userId}',
      pageSize: 100,
    );
  }
}
