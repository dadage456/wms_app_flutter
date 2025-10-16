import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/error_handler.dart';

import '../../services/aswh_down_collection_service.dart';
import 'online_pick_wcs_event.dart';
import 'online_pick_wcs_state.dart';

class OnlinePickWcsBloc extends Bloc<OnlinePickWcsEvent, OnlinePickWcsState> {
  OnlinePickWcsBloc({
    required AswhDownCollectionService collectionService,
    required UserManager userManager,
  }) : _collectionService = collectionService,
       _userManager = userManager,
       super(const OnlinePickWcsState()) {
    gridBloc = CommonDataGridBloc<OnlinePickWcsCommand>(
      dataLoader: _createDataLoader(),
    );

    _gridSubscription = gridBloc.stream.listen((gridState) {
      add(OnlinePickWcsRecordCountChanged(gridState.data.length));
    });

    on<OnlinePickWcsStarted>(_onStarted);
    on<OnlinePickWcsRefreshRequested>(_onRefresh);
    on<OnlinePickWcsSearchSubmitted>(_onSearchSubmitted);
    on<OnlinePickWcsResetCommandRequested>(_onResetRequested);
    on<OnlinePickWcsDownCommandRequested>(_onDownRequested);
    on<OnlinePickWcsStatusCleared>(_onStatusCleared);
    on<OnlinePickWcsRecordCountChanged>(_onRecordCountChanged);
  }

  final AswhDownCollectionService _collectionService;
  // ignore: unused_field
  final UserManager _userManager;

  late final CommonDataGridBloc<OnlinePickWcsCommand> gridBloc;
  late final StreamSubscription _gridSubscription;

  String _taskId = '';
  String _taskNo = '';
  String _taskComment = '';
  String _trayNo = '';
  String _workStation = '';
  String _queryStr = '';

  DataGridLoader<OnlinePickWcsCommand> _createDataLoader() {
    return (_) async {
      if (_taskId.isEmpty || _taskComment.isEmpty) {
        return const DataGridResponseData<OnlinePickWcsCommand>(
          totalPages: 1,
          data: [],
        );
      }

      final commands = await _collectionService.fetchWcsCommands(
        taskComment: _taskComment,
        taskId: _taskId,
        queryStr: _queryStr,
      );

      return DataGridResponseData<OnlinePickWcsCommand>(
        totalPages: 1,
        data: commands,
      );
    };
  }

  Future<void> _onStarted(
    OnlinePickWcsStarted event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    final args = event.args;
    _taskId = (args['taskId'] ?? '') as String;
    _taskNo = (args['taskNo'] ?? '') as String;
    _taskComment = (args['taskComment'] ?? '') as String;
    _trayNo = (args['trayNo'] ?? '') as String;
    _workStation = (args['workStation'] ?? '') as String;

    emit(
      state.copyWith(
        taskId: _taskId,
        taskNo: _taskNo,
        taskComment: _taskComment,
        trayNo: _trayNo,
        workStation: _workStation,
      ),
    );

    gridBloc.add(const LoadDataEvent(1));
  }

  Future<void> _onRefresh(
    OnlinePickWcsRefreshRequested event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    final completer = Completer<DataGridResponseData<OnlinePickWcsCommand>>();
    gridBloc.add(RefrenshLoadDataEvent(completer: completer));
    try {
      await completer.future;
      emit(state.copyWith(status: CollectionStatus.success('刷新成功')));
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onSearchSubmitted(
    OnlinePickWcsSearchSubmitted event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    _queryStr = event.keyword.trim();
    emit(state.copyWith(queryStr: _queryStr));
    gridBloc.add(const LoadDataEvent(1));
  }

  Future<void> _onResetRequested(
    OnlinePickWcsResetCommandRequested event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    final selected = _resolveSelectedCommands();
    if (selected.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请至少选择一条指令记录')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));
    try {
      for (final command in selected) {
        final trayNo = _resolveTrayNo(command);
        final startAddr = _resolveAddress(command.startAddress, '起始地址');
        final endAddr = _resolveAddress(command.destinationAddress, '目标地址');

        await _collectionService.commitResetWmsToWcs(
          taskId: command.taskId?.isNotEmpty == true
              ? command.taskId!
              : _taskId,
          taskNo: command.taskNo?.isNotEmpty == true
              ? command.taskNo!
              : _taskNo,
          trayNo: trayNo,
          startAddr: startAddr,
          endAddr: endAddr,
        );
      }

      emit(
        state.copyWith(
          status: CollectionStatus.success('撤销回指令成功'),
          shouldNotifyParent: true,
        ),
      );
      gridBloc.add(const RefrenshLoadDataEvent());
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onDownRequested(
    OnlinePickWcsDownCommandRequested event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    final selected = _resolveSelectedCommands();
    if (selected.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请至少选择一条指令记录')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      for (final command in selected) {
        final trayNo = _resolveTrayNo(command);
        final startAddr = _resolveAddress(command.startAddress, '起始地址');
        final endAddr = _resolveAddress(command.destinationAddress, '目标地址');

        await _collectionService.commitDownWmsToWcs(
          taskId: command.taskId?.isNotEmpty == true
              ? command.taskId!
              : _taskId,
          taskNo: command.taskNo?.isNotEmpty == true
              ? command.taskNo!
              : _taskNo,
          trayNo: trayNo,
          startAddr: startAddr,
          endAddr: endAddr,
          singleFlag: '1',
        );
      }

      emit(
        state.copyWith(
          status: CollectionStatus.success('撤销出库指令成功'),
          shouldNotifyParent: true,
        ),
      );
      gridBloc.add(const RefrenshLoadDataEvent());
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _onStatusCleared(
    OnlinePickWcsStatusCleared event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onRecordCountChanged(
    OnlinePickWcsRecordCountChanged event,
    Emitter<OnlinePickWcsState> emit,
  ) async {
    emit(state.copyWith(recordCount: event.recordCount));
  }

  List<OnlinePickWcsCommand> _resolveSelectedCommands() {
    final gridState = gridBloc.state;
    final indexes = gridState.selectedRows;
    if (indexes.isEmpty) {
      return const [];
    }

    final selected = <OnlinePickWcsCommand>[];
    for (final index in indexes) {
      if (index >= 0 && index < gridState.data.length) {
        selected.add(gridState.data[index]);
      }
    }
    return selected;
  }

  String _resolveTrayNo(OnlinePickWcsCommand command) {
    final fromCommand = command.palletNo?.trim();
    if (fromCommand != null && fromCommand.isNotEmpty) {
      return fromCommand;
    }
    if (_trayNo.trim().isNotEmpty) {
      return _trayNo.trim();
    }
    throw Exception('托盘号缺失');
  }

  String _resolveAddress(String? value, String label) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isNotEmpty) {
      return trimmed;
    }
    throw Exception('$label 缺失');
  }

  @override
  Future<void> close() async {
    await _gridSubscription.cancel();
    await gridBloc.close();
    await super.close();
  }
}
