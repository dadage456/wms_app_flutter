import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/modules/arrival_sign/services/arrival_sign_service.dart';
import 'package:wms_app/modules/arrival_sign/task_detail/models/arrival_sign_detail.dart';

import 'arrival_sign_detail_event.dart';
import 'arrival_sign_detail_state.dart';

class ArrivalSignDetailBloc
    extends Bloc<ArrivalSignDetailEvent, ArrivalSignDetailState> {
  ArrivalSignDetailBloc({required this.service})
      : super(const ArrivalSignDetailState()) {
    on<ArrivalSignDetailEvent>(_onEvent);
  }

  final ArrivalSignService service;
  ArrivalSignDetailQuery? _query;

  Future<void> _onEvent(
    ArrivalSignDetailEvent event,
    Emitter<ArrivalSignDetailState> emit,
  ) async {
    await event.when(
      initialized: (arrivalsBillId) => _handleInitialized(arrivalsBillId, emit),
      search: (keyword) => _handleSearch(keyword, emit),
      refresh: () => _handleRefresh(emit),
      pageChanged: (pageIndex) => _handlePageChanged(pageIndex, emit),
    );
  }

  Future<void> _handleInitialized(
    String arrivalsBillId,
    Emitter<ArrivalSignDetailState> emit,
  ) async {
    _query = ArrivalSignDetailQuery(arrivalsBillId: arrivalsBillId);
    await _loadPage(emit, 1);
  }

  Future<void> _handleSearch(
    String keyword,
    Emitter<ArrivalSignDetailState> emit,
  ) async {
    if (_query == null) {
      return;
    }
    _query = _query!.copyWith(searchKey: keyword, pageIndex: 1);
    await _loadPage(emit, 1);
  }

  Future<void> _handleRefresh(
    Emitter<ArrivalSignDetailState> emit,
  ) async {
    await _loadPage(emit, state.currentPage);
  }

  Future<void> _handlePageChanged(
    int pageIndex,
    Emitter<ArrivalSignDetailState> emit,
  ) async {
    await _loadPage(emit, pageIndex);
  }

  Future<void> _loadPage(
    Emitter<ArrivalSignDetailState> emit,
    int pageIndex,
  ) async {
    final query = _query;
    if (query == null) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final response = await service.getArrivalSignDetails(
        query: query.copyWith(pageIndex: pageIndex),
      );
      final totalPages = response.total == 0
          ? 1
          : (response.total / query.pageSize).ceil();
      emit(
        state.copyWith(
          isLoading: false,
          details: response.rows,
          currentPage: pageIndex,
          totalPages: totalPages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
