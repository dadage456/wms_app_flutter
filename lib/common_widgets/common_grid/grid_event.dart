import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';

abstract class CommonDataGridEvent<T> extends Equatable {
  const CommonDataGridEvent();

  @override
  List<Object?> get props => [];
}

/// 加载数据事件
class LoadDataEvent<T> extends CommonDataGridEvent<T> {
  final int pageIndex;
  final Completer<DataGridResponseData<T>>? completer;

  const LoadDataEvent(this.pageIndex, {this.completer});

  @override
  List<Object?> get props => [pageIndex];
}

/// 删除选中行事件
class DeleteSelectedRowsEvent<T> extends CommonDataGridEvent<T> {
  final List<int> selectedRows;

  const DeleteSelectedRowsEvent(this.selectedRows);

  @override
  List<Object?> get props => [selectedRows];
}

class ChangeSelectedRowsEvent<T> extends CommonDataGridEvent<T> {
  final List<int> selectedRows;

  const ChangeSelectedRowsEvent(this.selectedRows);

  @override
  List<Object?> get props => [selectedRows];
}

class UpdateTableDataEvent<T> extends CommonDataGridEvent<T> {
  final List<T> data;

  const UpdateTableDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}
