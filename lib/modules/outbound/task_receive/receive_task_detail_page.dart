import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/outbound/task_details/config/outbound_task_detail_grid_config.dart';
import 'package:wms_app/modules/outbound/task_details/models/outbound_task_item.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/modules/outbound/task_receive/bloc/receive_task_detail_state.dart';

import 'bloc/receive_task_detail_bloc.dart';
import 'bloc/receive_task_detail_event.dart';
import 'package:wms_app/common_widgets/common_grid/selection_action_bar.dart';

class ReceiveTaskDetailPage extends StatefulWidget {
  final OutboundTask task;

  const ReceiveTaskDetailPage({super.key, required this.task});

  @override
  State<ReceiveTaskDetailPage> createState() => _ReceiveTaskDetailPageState();
}

class _ReceiveTaskDetailPageState extends State<ReceiveTaskDetailPage> {
  late ReceiveTaskDetailBloc _bloc;
  late CommonDataGridBloc<OutboundTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ReceiveTaskDetailBloc>(context);
    _bloc.initializeQuery(widget.task);
    _gridBloc = _bloc.gridBloc;
    _gridBloc.add(LoadDataEvent(1));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveTaskDetailBloc, ReceiveTaskDetailState>(
      listener: (BuildContext context, ReceiveTaskDetailState state) {},
      builder: (BuildContext context, ReceiveTaskDetailState state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: '平库下架接收明细',
            onBackPressed: () => Modular.to.pop(),
          ).appBar,
          body: Column(
            children: [
              _buildScanInput(),
              Expanded(child: _buildTable()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScanInput() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描或输入物料编码',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(SearchReceiveTaskItemsEvent(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child:
          BlocConsumer<
            CommonDataGridBloc<OutboundTaskItem>,
            CommonDataGridState<OutboundTaskItem>
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
              return Column(
                children: [
                  Expanded(
                    child: CommonDataGrid<OutboundTaskItem>(
                      columns: OutboundTaskDetailGridConfig.getColumns(),
                      datas: state.data,
                      currentPage: state.currentPage,
                      totalPages: state.totalPages,
                      allowPager: true,
                      allowSelect: true,
                      selectedRows: state.selectedRows,
                      onSelectionChanged: (rows) {
                        _gridBloc.add(ChangeSelectedRowsEvent(rows));
                      },
                      onLoadData: (pageIndex) async {
                        _gridBloc.add(LoadDataEvent(pageIndex));
                      },
                    ),
                  ),
                  BlocBuilder<
                    CommonDataGridBloc<OutboundTaskItem>,
                    CommonDataGridState<OutboundTaskItem>
                  >(
                    builder: (context, gridState) {
                      return SelectionActionBar(
                        selectedCount: gridState.selectedRows.length,
                        totalCount: gridState.data.length,
                        confirmLabel: '接收',
                        onConfirm: () {
                          _bloc.add(
                            ReceiveSelectedItemsEvent(gridState.selectedRows),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
    );
  }
}
