import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../common_widgets/common_grid/grid_event.dart';
import '../../../common_widgets/common_grid/grid_state.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import 'bloc/inventory_receive_bloc.dart';
import 'bloc/inventory_receive_event.dart';
import 'bloc/inventory_receive_state.dart';
import '../task_list/config/inventory_task_grid_config.dart';
import '../task_list/models/inventory_task.dart';

class InventoryTaskReceivePage extends StatefulWidget {
  const InventoryTaskReceivePage({super.key});

  @override
  State<InventoryTaskReceivePage> createState() =>
      _InventoryTaskReceivePageState();
}

class _InventoryTaskReceivePageState extends State<InventoryTaskReceivePage> {
  late final InventoryReceiveBloc _bloc;
  late final CommonDataGridBloc<InventoryTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InventoryReceiveBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const InventoryReceiveEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '平库盘点接收',
        onBackPressed: () => Modular.to.pop(),
      ).appBar,
      body: Column(
        children: [
          _buildScanner(),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描单号',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(InventoryReceiveEvent.scanned(value));
      },
      onSubmit: (value) {
        _bloc.add(InventoryReceiveEvent.searchSubmitted(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildTable() {
    return BlocConsumer<InventoryReceiveBloc, InventoryReceiveState>(
      listener: (context, state) {
        if (state.status == InventoryReceiveStatus.loading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }
        if (state.status == InventoryReceiveStatus.failure &&
            state.message != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.message!,
          );
        }
        if (state.status == InventoryReceiveStatus.success &&
            state.message != null) {
          LoadingDialogManager.instance.showSuccessDialog(
            context,
            state.message!,
          );
        }
      },
      builder: (context, state) {
        return BlocProvider.value(
          value: _gridBloc,
          child: BlocBuilder<CommonDataGridBloc<InventoryTask>,
              CommonDataGridState<InventoryTask>>(
            builder: (context, gridState) {
              return CommonDataGrid<InventoryTask>(
                columns: InventoryTaskGridConfig.columns((task, type) {
                  // 只保留接收按钮
                  if (type == 0) {
                    _showReceiveConfirm(task);
                  }
                }, showCancel: false),
                datas: gridState.data,
                currentPage: gridState.currentPage,
                totalPages: gridState.totalPages,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                selectedRows: gridState.selectedRows,
                onSelectionChanged: (rows) {
                  _gridBloc.add(ChangeSelectedRowsEvent(rows));
                },
                allowPager: false,
                allowSelect: false,
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
        );
      },
    );
  }

  void _showReceiveConfirm(InventoryTask task) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('接收确认'),
          content: const Text('确认接收该盘点任务吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bloc.add(InventoryReceiveEvent.receiveRequested(task));
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }
}
