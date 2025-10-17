import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';

import '../../../../services/user_manager.dart';
import '../../services/aswh_up_task_service.dart';
import '../models/aswh_up_task_detail_item.dart';
import 'aswh_up_task_detail_event.dart';
import 'aswh_up_task_detail_state.dart';

class AswhUpTaskDetailBloc
    extends Bloc<AswhUpTaskDetailEvent, AswhUpTaskDetailState> {
  AswhUpTaskDetailBloc(this._service, this._userManager)
    : super(const AswhUpTaskDetailState()) {
    on<AswhUpTaskDetailInitialized>(_onInitialized);
    on<AswhUpTaskDetailSearchRequested>(_onSearchRequested);
    on<AswhUpTaskDetailDeleteSelected>(_onDeleteSelected);
    on<AswhUpTaskDetailRefreshRequested>(_onRefreshRequested);

    gridBloc = CommonDataGridBloc<AswhUpTaskDetailItem>(
      dataLoader: _createLoader(),
      dataDeleter: _createDeleter(),
    );
  }

  final AswhUpTaskService _service;
  final UserManager _userManager;

  late final CommonDataGridBloc<AswhUpTaskDetailItem> gridBloc;
  AswhUpTaskDetailQuery? _currentQuery;

  DataGridLoader<AswhUpTaskDetailItem> _createLoader() {
    return (pageIndex) async {
      final query = _currentQuery;
      if (query == null) {
        return const DataGridResponseData<AswhUpTaskDetailItem>(
          totalPages: 1,
          data: <AswhUpTaskDetailItem>[],
        );
      }

      final adjusted = query.copyWith(pageIndex: pageIndex);
      _currentQuery = adjusted;

      final response = await _service.fetchTaskItems(query: adjusted);
      final pageSize = adjusted.pageSize <= 0 ? 1 : adjusted.pageSize;
      final calculated = pageSize == 0 ? 1 : (response.total / pageSize).ceil();
      final totalPages = calculated <= 0 ? 1 : calculated;
      return DataGridResponseData<AswhUpTaskDetailItem>(
        totalPages: totalPages,
        data: response.rows,
      );
    };
  }

  DataGridDeleter _createDeleter() {
    return (indices) async {
      final data = gridBloc.state.data;
      final ids = indices
          .where((index) => index >= 0 && index < data.length)
          .map((index) => data[index].inTaskItemId)
          .where((id) => id > 0)
          .toList();

      if (ids.isEmpty) {
        throw Exception('请选择需要撤销的明细');
      }

      await _service.commitTaskItems(
        inTaskItemIds: ids,
        roomTag: '1',
        isCancel: true,
      );
    };
  }

  Future<void> _onInitialized(
    AswhUpTaskDetailInitialized event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    final userInfo = _userManager.userInfo;

    _currentQuery = AswhUpTaskDetailQuery(
      inTaskId: event.taskId,
      userId: '${userInfo!.userId}',
      workStation: event.workStation,
      roomTag: '1',
    );
  }

  Future<void> _onSearchRequested(
    AswhUpTaskDetailSearchRequested event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    if (_currentQuery == null) return;
    final trimmed = event.searchKey.trim();
    _currentQuery = _currentQuery!.copyWith(searchKey: trimmed, pageIndex: 1);

    gridBloc.add(const LoadDataEvent<AswhUpTaskDetailItem>(1));
  }

  Future<void> _onDeleteSelected(
    AswhUpTaskDetailDeleteSelected event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    gridBloc.add(
      DeleteSelectedRowsEvent<AswhUpTaskDetailItem>(event.selectedRows),
    );
  }

  Future<void> _onRefreshRequested(
    AswhUpTaskDetailRefreshRequested event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    gridBloc.add(RefrenshLoadDataEvent<AswhUpTaskDetailItem>());
  }
}
