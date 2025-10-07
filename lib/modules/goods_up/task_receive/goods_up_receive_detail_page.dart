import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/common_grid/selection_action_bar.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';

import '../task_details/config/goods_up_task_detail_grid_config.dart';
import '../task_details/models/goods_up_task_item.dart';
import '../task_list/models/goods_up_task.dart';
import 'bloc/inbound_receive_task_detail_bloc.dart';
import 'bloc/inbound_receive_task_detail_event.dart';
import 'bloc/inbound_receive_task_detail_state.dart';

class GoodsUpReceiveDetailPage extends StatefulWidget {
  const GoodsUpReceiveDetailPage({super.key, required this.task});

  final GoodsUpTask task;

  @override
  State<GoodsUpReceiveDetailPage> createState() =>
      _GoodsUpReceiveDetailPageState();
}

class _GoodsUpReceiveDetailPageState extends State<GoodsUpReceiveDetailPage> {
  late final InboundReceiveTaskDetailBloc _bloc;
  late final CommonDataGridBloc<GoodsUpTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InboundReceiveTaskDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.initialize(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      InboundReceiveTaskDetailBloc,
      InboundReceiveTaskDetailState
    >(
      listener: (context, state) {
        if (state.errorMessage != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: '上架接收明细',
            onBackPressed: () => Modular.to.pop(),
          ).appBar,
          body: Column(
            children: [
              _buildScanner(),
              Expanded(child: _buildTable()),
              _buildActionBar(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描或输入物料编码',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(SearchInboundReceiveTaskItemsEvent(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<
        CommonDataGridBloc<GoodsUpTaskItem>,
        CommonDataGridState<GoodsUpTaskItem>
      >(
        listener: (context, state) {
          if (state.status == GridStatus.loading) {
            LoadingDialogManager.instance.showLoadingDialog(context);
          } else {
            LoadingDialogManager.instance.hideLoadingDialog(context);
          }

          if (state.status == GridStatus.error) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              state.errorMessage ?? '加载失败',
            );
          } else if (state.status == GridStatus.success) {
            LoadingDialogManager.instance.showSnackSuccessMsg(
              context,
              '接收成功',
              duration: const Duration(milliseconds: 800),
            );
          }
        },
        builder: (context, state) {
          return CommonDataGrid<GoodsUpTaskItem>(
            columns: GoodsUpTaskDetailGridConfig.columns(),
            datas: state.data,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            allowPager: true,
            allowSelect: true,
            selectedRows: state.selectedRows,
            onSelectionChanged: (rows) {
              _gridBloc.add(ChangeSelectedRowsEvent<GoodsUpTaskItem>(rows));
            },
            onLoadData: (pageIndex) async {
              _gridBloc.add(LoadDataEvent<GoodsUpTaskItem>(pageIndex));
            },
          );
        },
      ),
    );
  }

  Widget _buildActionBar() {
    return BlocBuilder<
      CommonDataGridBloc<GoodsUpTaskItem>,
      CommonDataGridState<GoodsUpTaskItem>
    >(
      bloc: _gridBloc,
      builder: (context, state) {
        return SelectionActionBar(
          selectedCount: state.selectedRows.length,
          totalCount: state.data.length,
          confirmLabel: '接收',
          onConfirm: () {
            if (state.selectedRows.isEmpty) {
              LoadingDialogManager.instance
                  .showErrorDialog(context, '请先选择要接收的明细');
              return;
            }
            _bloc.add(ReceiveSelectedInboundItemsEvent(state.selectedRows));
          },
        );
      },
    );
  }
}
