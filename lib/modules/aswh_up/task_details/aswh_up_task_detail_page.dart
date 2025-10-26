import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';

import 'package:wms_app/modules/aswh_up/task_details/models/aswh_up_task_detail_item.dart';
import 'package:wms_app/modules/outbound/task_details/widgets/outbound_batch_action_bar.dart';

import 'bloc/aswh_up_task_detail_bloc.dart';
import 'bloc/aswh_up_task_detail_event.dart';
import 'bloc/aswh_up_task_detail_state.dart';
import 'config/aswh_up_task_detail_grid_config.dart';

class AswhUpTaskDetailPage extends StatefulWidget {
  const AswhUpTaskDetailPage({
    super.key,
    required this.taskId,
    this.workStation,
  });

  final int taskId;
  final String? workStation;

  @override
  State<AswhUpTaskDetailPage> createState() => _AswhUpTaskDetailPageState();
}

class _AswhUpTaskDetailPageState extends State<AswhUpTaskDetailPage> {
  late final AswhUpTaskDetailBloc _bloc;
  late final CommonDataGridBloc<AswhUpTaskDetailItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();
  final DataGridController _dataGridController = DataGridController();
  final DataPagerController _dataPagerController = DataPagerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhUpTaskDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(
      AswhUpTaskDetailInitialized(
        taskId: widget.taskId,
        workStation: widget.workStation,
      ),
    );
  }

  @override
  void dispose() {
    _scannerController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _gridBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<
            CommonDataGridBloc<AswhUpTaskDetailItem>,
            CommonDataGridState<AswhUpTaskDetailItem>
          >(
            listener: (context, gridState) {
              if (gridState.status == GridStatus.loading) {
                LoadingDialogManager.instance.showLoadingDialog(context);
              } else {
                LoadingDialogManager.instance.hideLoadingDialog(context);
              }

              if (gridState.status == GridStatus.error) {
                LoadingDialogManager.instance.showErrorDialog(
                  context,
                  gridState.errorMessage ?? '加载失败，请稍后重试',
                );
              }
            },
          ),
        ],
        child: SelectionArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: CustomAppBar(
              title: '组盘任务明细',
              // subtitle: widget.workStation?.isNotEmpty == true
              //     ? '工位：${widget.workStation}'
              //     : null,
              onBackPressed: () => Navigator.of(context).pop(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: () {
                    _bloc.add(const AswhUpTaskDetailRefreshRequested());
                  },
                ),
              ],
            ).appBar,
            body: Column(
              children: [
                _buildScanner(),
                Expanded(child: _buildDataGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描物料或库位',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(AswhUpTaskDetailSearchRequested(searchKey: value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildDataGrid() {
    return BlocBuilder<
      CommonDataGridBloc<AswhUpTaskDetailItem>,
      CommonDataGridState<AswhUpTaskDetailItem>
    >(
      builder: (context, gridState) {
        return Column(
          children: [
            Expanded(
              child: CommonDataGrid<AswhUpTaskDetailItem>(
                columns: AswhUpTaskDetailGridConfig.columns(),
                datas: gridState.data,
                currentPage: gridState.currentPage,
                totalPages: gridState.totalPages,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent<AswhUpTaskDetailItem>(pageIndex));
                },
                selectedRows: gridState.selectedRows,
                onSelectionChanged: (rows) {
                  _gridBloc.add(
                    ChangeSelectedRowsEvent<AswhUpTaskDetailItem>(rows),
                  );
                },
                allowPager: true,
                allowSelect: true,
                dataGridController: _dataGridController,
                dataPagerController: _dataPagerController,
              ),
            ),
            _buildBatchActionBar(),
          ],
        );
      },
    );
  }

  /// 构建批量操作栏
  Widget _buildBatchActionBar() {
    final selectedCount = _gridBloc.state.selectedRows.length;
    final totalCount = _gridBloc.state.data.length;

    if (selectedCount == 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 54,
      child: OutboundBatchActionBar(
        selectedCount: selectedCount,
        totalCount: totalCount,
        onSelectAll: () {},
        onDeselectAll: () {},
        onCancelSelected: () {
          final selected = _gridBloc.state.selectedRows;
          if (selected.isEmpty) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              '请先选择需要撤销的明细',
            );
            return;
          }
          _bloc.add(AswhUpTaskDetailDeleteSelected(selectedRows: selected));
        },
        onClearSelection: () {},
      ),
    );
  }
}
