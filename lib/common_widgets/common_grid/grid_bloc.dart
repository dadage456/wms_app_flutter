import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/utils/error_handler.dart';

typedef DataGridLoader<T> =
    Future<DataGridResponseData<T>> Function(int pageIndex);
typedef DataGridDeleter = Future<void> Function(List<int> items);

class DataGridResponseData<T> {
  final int totalPages;
  final List<T> data;

  const DataGridResponseData({required this.totalPages, required this.data});
}

class CommonDataGridBloc<T>
    extends Bloc<CommonDataGridEvent<T>, CommonDataGridState<T>> {
  final DataGridLoader<T> dataLoader;
  final DataGridDeleter? dataDeleter;

  CommonDataGridBloc({required this.dataLoader, this.dataDeleter})
    : super(CommonDataGridState<T>()) {
    on<LoadDataEvent<T>>(_onLoadData);
    on<DeleteSelectedRowsEvent<T>>(_onDeleteSelectedRows);

    on<ChangeSelectedRowsEvent<T>>(_onChangeSelectedRows);
    on<UpdateTableDataEvent<T>>(_onUpdateData);
    on<RefrenshLoadDataEvent<T>>(_onRefrenshData);
  }

  /// 处理加载数据事件
  Future<void> _onLoadData(
    LoadDataEvent<T> event,
    Emitter<CommonDataGridState<T>> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: GridStatus.loading,
          currentPage: event.pageIndex,
        ),
      );

      final data = await dataLoader(event.pageIndex);

      debugPrint('加载数据成功: ${data.data} total: ${data.totalPages}');

      emit(
        state.copyWith(
          status: GridStatus.loaded,
          currentPage: event.pageIndex,
          totalPages: data.totalPages,
          data: data.data,
          selectedRows: [],
        ),
      );

      // 始终完成 caller 给的 completer（告知调用方这次请求的结果）
      if (event.completer != null && !event.completer!.isCompleted) {
        event.completer!.complete(data);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GridStatus.error,
          errorMessage: ErrorHandler.handleError(e),
        ),
      );
      if (event.completer != null && !event.completer!.isCompleted) {
        event.completer!.completeError(e);
      }
    }
  }

  /// 处理删除选中行事件
  Future<void> _onDeleteSelectedRows(
    DeleteSelectedRowsEvent<T> event,
    Emitter<CommonDataGridState<T>> emit,
  ) async {
    if (dataDeleter == null) {
      emit(state.copyWith(status: GridStatus.error, errorMessage: '删除功能未配置'));
      return;
    }

    try {
      // 发出删除中状态
      emit(state.copyWith(status: GridStatus.loading));
      // 执行删除操作
      await dataDeleter!(event.selectedRows);

      // 删除成功后，从当前数据中移除被删除的项
      // final updatedData = <T>[];

      // for (var i = 0; i < state.data.length; i++) {
      //   if (!event.selectedRows.contains(i)) {
      //     updatedData.add(state.data[i]);
      //   }
      // }

      // // 清空选中项并更新数据
      // emit(
      //   state.copyWith(
      //     status: GridStatus.loaded,
      //     data: updatedData,
      //     selectedRows: [],
      //   ),
      // );
      // 重新加载当前页数据以确保数据同步
      final data = await dataLoader(state.currentPage);

      emit(state.copyWith(status: GridStatus.success));

      emit(
        state.copyWith(
          status: GridStatus.loaded,
          totalPages: data.totalPages,
          data: data.data,
          selectedRows: [],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GridStatus.error,
          errorMessage: '删除失败: ${e.toString()}',
        ),
      );
    }
  }

  /// 修改选择行
  Future<void> _onChangeSelectedRows(
    ChangeSelectedRowsEvent<T> event,
    Emitter<CommonDataGridState<T>> emit,
  ) async {
    emit(state.copyWith(selectedRows: event.selectedRows));
  }

  /// 更新表格中的数据
  Future<void> _onUpdateData(
    UpdateTableDataEvent<T> event,
    Emitter<CommonDataGridState<T>> emit,
  ) async {
    emit(state.copyWith(data: event.data));
  }

  /// 更新表格中的数据
  Future<void> _onRefrenshData(
    RefrenshLoadDataEvent<T> event,
    Emitter<CommonDataGridState<T>> emit,
  ) async {
    await _onLoadData(
      LoadDataEvent(state.currentPage, completer: event.completer),
      emit,
    );
  }
}
