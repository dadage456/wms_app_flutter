import 'dart:developer';

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
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/task_details/bloc/online_pick_task_detail_bloc.dart';
import 'package:wms_app/modules/aswh_down/task_details/bloc/online_pick_task_detail_event.dart';
import 'package:wms_app/modules/aswh_down/task_details/bloc/online_pick_task_detail_state.dart';
import 'package:wms_app/modules/aswh_down/task_details/config/online_pick_task_detail_grid_config.dart';
import 'package:wms_app/modules/aswh_down/task_details/widgets/online_pick_task_detail_action_bar.dart';
import 'package:wms_app/modules/outbound/task_details/widgets/outbound_batch_action_bar.dart';

class OnlinePickTaskDetailPage extends StatefulWidget {
  const OnlinePickTaskDetailPage({super.key, required this.task});

  final OnlinePickTask task;

  @override
  State<OnlinePickTaskDetailPage> createState() =>
      _OnlinePickTaskDetailPageState();
}

class _OnlinePickTaskDetailPageState extends State<OnlinePickTaskDetailPage>
    with SingleTickerProviderStateMixin {
  static const _background = Color(0xFFF6F6F6);

  late final OnlinePickTaskDetailBloc _bloc;
  late final CommonDataGridBloc<OnlinePickTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickTaskDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(OnlinePickTaskDetailInitialized(task: widget.task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: CustomAppBar(
        title: '在线拣选任务明细',
        onBackPressed: () => Modular.to.pop(),
        actions: [
          IconButton(
            onPressed: () =>
                _bloc.add(const OnlinePickTaskDetailRefreshRequested()),
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ).appBar,
      body: Column(
        children: [
          _buildScanner(),
          const SizedBox(height: 4),
          Expanded(child: _buildTable()),
        ],
      ),
      // bottomNavigationBar: _buildActionBar(),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描或输入物料编码/库位',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      controller: _scannerController,
      config: config,
      onScanResult: (value) {
        _bloc.add(OnlinePickTaskDetailSearchSubmitted(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  /// 构建表格
  Widget _buildTable() {
    return BlocProvider(
      create: (context) => _gridBloc,
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
                  state.errorMessage ?? '未知错误',
                );
              }

              if (state.status == GridStatus.success) {
                LoadingDialogManager.instance.showSnackSuccessMsg(
                  context,
                  '撤销成功',
                  duration: Duration(milliseconds: 800),
                );
              }
            },
            buildWhen: (previous, current) {
              return previous.data != current.data ||
                  previous.currentPage != current.currentPage ||
                  previous.totalPages != current.totalPages;
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: CommonDataGrid<OnlinePickTaskItem>(
                      columns: OnlinePickTaskDetailGridConfig.columns(),
                      currentPage: state.currentPage,
                      totalPages: state.totalPages,
                      onLoadData: (pageIndex) async {
                        await Future.delayed(const Duration(microseconds: 1));
                        _gridBloc.add(LoadDataEvent(pageIndex));
                      },
                      selectedRows: state.selectedRows,
                      onSelectionChanged: (list) {
                        debugPrint(
                          '------ detail page onSelectionChanged: $list',
                        );
                        _gridBloc.add(ChangeSelectedRowsEvent(list));
                      },
                      datas: state.data,
                      allowPager: true,
                      allowSelect: true,
                    ),
                  ),
                  _buildBatchActionBar(),
                ],
              );
            },
          ),
    );
  }

  /// 构建批量操作栏
  Widget _buildBatchActionBar() {
    return BlocBuilder<
      CommonDataGridBloc<OnlinePickTaskItem>,
      CommonDataGridState<OnlinePickTaskItem>
    >(
      builder: (context, state) {
        final selectedCount = state.selectedRows.length;
        final totalCount = state.data.length;
        log('------- totalCount: $totalCount');

        if (selectedCount == 0) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 54,
          child: OutboundBatchActionBar(
            selectedCount: selectedCount,
            totalCount: totalCount,
            onSelectAll: () {
              final allIds =
                  state.data.map((item) => item.outTaskItemId).toList() ?? [];
              _gridBloc.add(ChangeSelectedRowsEvent(allIds));
            },
            onDeselectAll: () {
              _gridBloc.add(const ChangeSelectedRowsEvent([]));
            },
            onCancelSelected: () {
              final selectedItemIds = state.selectedRows
                  .map((id) => id.toString())
                  .toList();
              _bloc.add(
                OnlinePickTaskDetailCancelSubmitted(state.selectedRows),
              );
            },
            onClearSelection: () {
              _gridBloc.add(const ChangeSelectedRowsEvent([]));
            },
          ),
        );
      },
    );
  }
}
