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
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/task_details/config/online_pick_task_detail_grid_config.dart';

import '../bloc/online_pick_receive_detail_bloc.dart';
import '../bloc/online_pick_receive_detail_event.dart';
import '../bloc/online_pick_receive_detail_state.dart';

class OnlinePickReceiveDetailPage extends StatefulWidget {
  const OnlinePickReceiveDetailPage({
    super.key,
    required this.outTaskId,
    required this.taskData,
  });

  final int outTaskId;
  final Map<String, dynamic> taskData;

  @override
  State<OnlinePickReceiveDetailPage> createState() =>
      _OnlinePickReceiveDetailPageState();
}

class _OnlinePickReceiveDetailPageState
    extends State<OnlinePickReceiveDetailPage> {
  static const _background = Color(0xFFF6F6F6);

  late final OnlinePickReceiveDetailBloc _bloc;
  late final CommonDataGridBloc<OnlinePickTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<OnlinePickReceiveDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;

    final payloadTask = widget.taskData['task'];
    final OnlinePickTask? task = payloadTask is OnlinePickTask
        ? payloadTask
        : null;

    _bloc.add(
      OnlinePickReceiveDetailStarted(outTaskId: widget.outTaskId, task: task),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      OnlinePickReceiveDetailBloc,
      OnlinePickReceiveDetailState
    >(
      listener: (BuildContext context, OnlinePickReceiveDetailState state) {},
      builder: (BuildContext context, OnlinePickReceiveDetailState state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: '在线拣选接收明细',
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
        _bloc.add(OnlinePickReceiveDetailSearchSubmitted(value));
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
            CommonDataGridBloc<OnlinePickTaskItem>,
            CommonDataGridState<OnlinePickTaskItem>
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
                    child: CommonDataGrid<OnlinePickTaskItem>(
                      columns: OnlinePickTaskDetailGridConfig.columns(),
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
                    CommonDataGridBloc<OnlinePickTaskItem>,
                    CommonDataGridState<OnlinePickTaskItem>
                  >(
                    builder: (context, gridState) {
                      return SelectionActionBar(
                        selectedCount: gridState.selectedRows.length,
                        totalCount: gridState.data.length,
                        confirmLabel: '接收',
                        onConfirm: () {
                          _bloc.add(
                            OnlinePickReceiveDetailCommitRequested(
                              gridState.selectedRows,
                            ),
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
