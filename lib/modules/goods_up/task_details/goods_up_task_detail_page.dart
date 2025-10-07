import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';

import 'bloc/goods_up_task_detail_bloc.dart';
import 'bloc/goods_up_task_detail_event.dart';
import 'config/goods_up_task_detail_grid_config.dart';
import 'models/goods_up_task_item.dart';

class GoodsUpTaskDetailPage extends StatefulWidget {
  const GoodsUpTaskDetailPage({
    super.key,
    required this.inTaskId,
    required this.workStation,
  });

  final int inTaskId;
  final String? workStation;

  @override
  State<GoodsUpTaskDetailPage> createState() => _GoodsUpTaskDetailPageState();
}

class _GoodsUpTaskDetailPageState extends State<GoodsUpTaskDetailPage> {
  late final GoodsUpTaskDetailBloc _bloc;
  late final CommonDataGridBloc<GoodsUpTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<GoodsUpTaskDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;

    _bloc.add(
      InitializedEvent(inTaskId: widget.inTaskId, workStation: widget.workStation),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '上架任务明细',
        onBackPressed: () => Navigator.of(context).pop(),
      ).appBar,
      body: Column(
        children: [
          _buildScanner(),
          Expanded(child: _buildTable()),
          _buildBottomActions(),
        ],
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
      onScanResult: (value) =>
          _bloc.add(ScanEvent(qrContent: value)),
      onError: (message) =>
          LoadingDialogManager.instance.showErrorDialog(context, message),
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<CommonDataGridBloc<GoodsUpTaskItem>,
          CommonDataGridState<GoodsUpTaskItem>>(
        listener: (context, state) {
          if (state.status == GridStatus.loading) {
            LoadingDialogManager.instance.showLoadingDialog(context);
          } else {
            LoadingDialogManager.instance.hideLoadingDialog(context);
          }

          if (state.status == GridStatus.error) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              state.errorMessage ?? '加载明细失败',
            );
          }
        },
        builder: (context, state) {
          return CommonDataGrid<GoodsUpTaskItem>(
            columns: GoodsUpTaskDetailGridConfig.columns(),
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            onLoadData: (index) async {
              _gridBloc.add(LoadDataEvent<GoodsUpTaskItem>(index));
            },
            selectedRows: state.selectedRows,
            onSelectionChanged: (rows) =>
                _gridBloc.add(ChangeSelectedRowsEvent<GoodsUpTaskItem>(rows)),
            datas: state.data,
            allowPager: false,
            allowSelect: true,
            headerHeight: 44,
            rowHeight: 52,
          );
        },
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final selected = _gridBloc.state.selectedRows;
                if (selected.isEmpty) {
                  LoadingDialogManager.instance
                      .showErrorDialog(context, '请先选择需要撤销的明细');
                  return;
                }
                _bloc.add(
                  CancelSelectedEvent(selectedRows: selected),
                );
              },
              child: const Text('撤销'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _bloc.add(const RefreshEvent()),
              child: const Text('刷新'),
            ),
          ),
        ],
      ),
    );
  }
}
