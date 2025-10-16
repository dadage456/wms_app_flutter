import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/models/arrival_receive_task.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/services/user_manager.dart';

import 'arrival_receive_event.dart';
import 'arrival_receive_state.dart';

class ArrivalReceiveBloc
    extends Bloc<ArrivalReceiveEvent, ArrivalReceiveState> {
  ArrivalReceiveBloc({
    required this.service,
    required this.userManager,
  }) : super(const ArrivalReceiveState()) {
    on<ArrivalReceiveEvent>(_onEvent);
  }

  final ArrivalSignService service;
  final UserManager userManager;

  late ArrivalReceiveTaskQuery currentQuery = _createDefaultQuery();

  late final CommonDataGridBloc<ArrivalReceiveTask> gridBloc =
      CommonDataGridBloc<ArrivalReceiveTask>(dataLoader: _createLoader());

  DataGridLoader<ArrivalReceiveTask> _createLoader() {
    return (pageIndex) async {
      final query = currentQuery.copyWith(pageIndex: pageIndex);
      final response = await service.getArrivalUnSignList(query: query);
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
    ArrivalReceiveEvent event,
    Emitter<ArrivalReceiveState> emit,
  ) async {
    await event.when(
      initialized: () => _handleInitialized(emit),
      search: (keyword) => _handleSearch(keyword, emit),
      refresh: () => _handleRefresh(emit),
      receive: (arrivalsBillId) => _handleReceive(arrivalsBillId, emit),
    );
  }

  Future<void> _handleInitialized(Emitter<ArrivalReceiveState> emit) async {
    gridBloc.add(LoadDataEvent(currentQuery.pageIndex));
  }

  Future<void> _handleSearch(
    String keyword,
    Emitter<ArrivalReceiveState> emit,
  ) async {
    currentQuery = currentQuery.copyWith(searchKey: keyword, pageIndex: 1);
    gridBloc.add(const LoadDataEvent(1));
  }

  Future<void> _handleRefresh(
    Emitter<ArrivalReceiveState> emit,
  ) async {
    gridBloc.add(LoadDataEvent(gridBloc.state.currentPage));
  }

  Future<void> _handleReceive(
    String arrivalsBillId,
    Emitter<ArrivalReceiveState> emit,
  ) async {
    emit(
      state.copyWith(isProcessing: true, errorMessage: null, successMessage: null),
    );
    try {
      await service.receiveArrivalOrder(arrivalsBillId: arrivalsBillId);
      emit(state.copyWith(isProcessing: false, successMessage: '接收成功'));
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

  ArrivalReceiveTaskQuery _createDefaultQuery() {
    final user = userManager.userInfo;
    if (user == null) {
      return const ArrivalReceiveTaskQuery(userId: '', roleOrUserId: '');
    }
    return ArrivalReceiveTaskQuery(
      userId: '${user.userId}',
      roleOrUserId: '${user.userId}',
      pageSize: 100,
    );
  }
}
