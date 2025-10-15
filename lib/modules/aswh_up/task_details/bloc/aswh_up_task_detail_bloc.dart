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
    on<AswhUpTaskDetailScanSubmitted>(_onScanSubmitted);
    on<AswhUpTaskDetailToggleSelection>(_onToggleSelection);
    on<AswhUpTaskDetailDeleteSelected>(_onDeleteSelected);
    on<AswhUpTaskDetailRefreshRequested>(_onRefreshRequested);
    on<AswhUpTaskDetailClearMessage>(_onClearMessage);
    on<AswhUpTaskDetailShowMessage>(_onShowMessage);

    gridBloc = CommonDataGridBloc<AswhUpTaskDetailItem>(
      dataLoader: _createLoader(),
      dataDeleter: _createDeleter(),
    );

    _gridSubscription = gridBloc.stream.listen((gridState) {
      if (gridState.status == GridStatus.loaded && gridState.data.isEmpty) {
        add(
          const AswhUpTaskDetailShowMessage(
            message: '当前任务列表没有待处理任务！',
            type: AswhUpTaskDetailMessageType.warning,
          ),
        );
      }
      if (gridState.status == GridStatus.success) {
        add(
          const AswhUpTaskDetailShowMessage(
            message: '单据撤销成功！',
            type: AswhUpTaskDetailMessageType.success,
          ),
        );
      }
    });
  }

  final AswhUpTaskService _service;
  final UserManager _userManager;

  late final CommonDataGridBloc<AswhUpTaskDetailItem> gridBloc;
  AswhUpTaskDetailQuery? _currentQuery;
  late final StreamSubscription _gridSubscription;

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
      final calculated = pageSize == 0
          ? 1
          : (response.total / pageSize).ceil();
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
    if (userInfo == null) {
      emit(
        state.copyWith(
          message: '未获取到用户信息',
          messageType: AswhUpTaskDetailMessageType.error,
          messageId: state.messageId + 1,
        ),
      );
      return;
    }

    _currentQuery = AswhUpTaskDetailQuery(
      inTaskId: event.taskId,
      userId: '${userInfo.userId}',
      workStation: event.workStation,
      roomTag: '1',
    );

    emit(
      state.copyWith(
        taskId: event.taskId,
        workStation: event.workStation,
        message: null,
      ),
    );

    gridBloc.add(const LoadDataEvent<AswhUpTaskDetailItem>(1));
  }

  Future<void> _onSearchRequested(
    AswhUpTaskDetailSearchRequested event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    if (_currentQuery == null) return;
    final trimmed = event.searchKey.trim();
    _currentQuery = _currentQuery!.copyWith(
      searchKey: trimmed,
      pageIndex: 1,
    );
    emit(state.copyWith(searchKey: trimmed));
    gridBloc.add(const LoadDataEvent<AswhUpTaskDetailItem>(1));
  }

  Future<void> _onScanSubmitted(
    AswhUpTaskDetailScanSubmitted event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    final content = event.content.trim();
    if (content.isEmpty) {
      emit(
        state.copyWith(
          message: '采集内容为空,请重新采集',
          messageType: AswhUpTaskDetailMessageType.error,
          messageId: state.messageId + 1,
        ),
      );
      return;
    }

    if (content.contains('MC')) {
      try {
        final barcode = await _service.getMaterialInfoByQR(content);
        final materialCode = (barcode.materialCode ?? '').trim();
        if (materialCode.isEmpty) {
          emit(
            state.copyWith(
              message: '未从二维码解析到物料编码',
              messageType: AswhUpTaskDetailMessageType.error,
              messageId: state.messageId + 1,
            ),
          );
          return;
        }
        add(AswhUpTaskDetailSearchRequested(searchKey: materialCode));
      } catch (error) {
        emit(
          state.copyWith(
            message: '解析物料二维码失败：$error',
            messageType: AswhUpTaskDetailMessageType.error,
            messageId: state.messageId + 1,
          ),
        );
      }
      return;
    }

    if (content.contains(r'$KW$')) {
      final site = _extractSiteCode(content);
      if (site.isEmpty) {
        emit(
          state.copyWith(
            message: '未从库位二维码解析到库位信息',
            messageType: AswhUpTaskDetailMessageType.error,
            messageId: state.messageId + 1,
          ),
        );
        return;
      }
      add(AswhUpTaskDetailSearchRequested(searchKey: site));
      return;
    }

    emit(
      state.copyWith(
        message: '采集内容不合法',
        messageType: AswhUpTaskDetailMessageType.error,
        messageId: state.messageId + 1,
      ),
    );
  }

  void _onToggleSelection(
    AswhUpTaskDetailToggleSelection event,
    Emitter<AswhUpTaskDetailState> emit,
  ) {
    final total = gridBloc.state.data.length;
    if (total <= 0) {
      return;
    }
    final selected = gridBloc.state.selectedRows;
    final shouldClear = selected.length == total;
    if (shouldClear) {
      gridBloc.add(const ChangeSelectedRowsEvent<AswhUpTaskDetailItem>([]));
    } else {
      gridBloc.add(
        ChangeSelectedRowsEvent<AswhUpTaskDetailItem>(
          List<int>.generate(total, (index) => index),
        ),
      );
    }
  }

  Future<void> _onDeleteSelected(
    AswhUpTaskDetailDeleteSelected event,
    Emitter<AswhUpTaskDetailState> emit,
  ) async {
    if (event.selectedRows.isEmpty) {
      emit(
        state.copyWith(
          message: '请至少选择一行记录',
          messageType: AswhUpTaskDetailMessageType.warning,
          messageId: state.messageId + 1,
        ),
      );
      return;
    }

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

  void _onClearMessage(
    AswhUpTaskDetailClearMessage event,
    Emitter<AswhUpTaskDetailState> emit,
  ) {
    emit(state.copyWith(clearMessage: true));
  }

  void _onShowMessage(
    AswhUpTaskDetailShowMessage event,
    Emitter<AswhUpTaskDetailState> emit,
  ) {
    emit(
      state.copyWith(
        message: event.message,
        messageType: event.type,
        messageId: state.messageId + 1,
      ),
    );
  }

  String _extractSiteCode(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    const marker = r'$KW$';
    final markerIndex = trimmed.indexOf(marker);
    if (markerIndex >= 0) {
      final candidate = trimmed.substring(markerIndex + marker.length).trim();
      if (candidate.isNotEmpty) {
        return candidate;
      }
    }

    final segments = trimmed.split(r'$');
    if (segments.length >= 3) {
      final candidate = segments[2].trim();
      if (candidate.isNotEmpty) {
        return candidate;
      }
    }

    return trimmed;
  }

  @override
  Future<void> close() async {
    await _gridSubscription.cancel();
    await gridBloc.close();
    return super.close();
  }
}
