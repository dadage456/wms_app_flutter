import 'dart:developer';

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

import 'bloc/outbound_task_detail_bloc.dart';
import 'bloc/outbound_task_detail_event.dart';
import 'config/outbound_task_detail_grid_config.dart';
import 'models/outbound_task_item.dart';
import 'widgets/outbound_batch_action_bar.dart';

/// 出库任务明细页面
class OutboundTaskDetailPage extends StatefulWidget {
  final String outTaskId;
  final String workStation;
  final int userId;
  final int roleOrUserId;

  const OutboundTaskDetailPage({
    Key? key,
    required this.outTaskId,
    required this.workStation,
    required this.userId,
    required this.roleOrUserId,
  }) : super(key: key);

  @override
  State<OutboundTaskDetailPage> createState() => _OutboundTaskDetailPageState();
}

class _OutboundTaskDetailPageState extends State<OutboundTaskDetailPage> {
  late OutboundTaskDetailBloc _bloc;
  late final CommonDataGridBloc<OutboundTaskItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OutboundTaskDetailBloc>(context);
    _bloc.initializeQuery(widget.outTaskId, widget.workStation);
    _gridBloc = _bloc.gridBloc;
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 初始化页面
  // void _initializePage() {

  //   _gridBloc.add(const LoadDataEvent(1));
  // }

  /// 处理搜索
  void _handleSearch(String searchKey) {
    _bloc.add(OutboundTaskDetailEvent.search(searchKey: searchKey));
  }

  /// 处理扫码
  void _handleScan(String qrContent) {
    _bloc.add(OutboundTaskDetailEvent.scanQRCode(qrContent: qrContent));
  }

  /// 处理撤销选中项
  void _handleCancelSelected(List<String> selectedItemIds) {
    _bloc.add(
      OutboundTaskDetailEvent.cancelSelectedItems(
        selectedRows: _gridBloc.state.selectedRows,
      ),
    );
  }

  /// 处理刷新
  void _handleRefresh() {
    _bloc.add(const OutboundTaskDetailEvent.refresh());
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF6F6F6);

    return SelectionArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          title: '平库下架任务明细',
          onBackPressed: () {
            Navigator.of(context).pop();
          },
          actions: [
            IconButton(
              onPressed: _handleRefresh,
              icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
            ),
          ],
        ).appBar,
        body: Column(
          children: [
            _buildScanInput(),
            const SizedBox(height: 0),
            Expanded(child: _buildTable()),
          ],
        ),
        // bottomNavigationBar: _buildBatchActionBar(),
      ),
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
        _handleSearch(value);
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
                    child: CommonDataGrid<OutboundTaskItem>(
                      columns: OutboundTaskDetailGridConfig.getColumns(),
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
      CommonDataGridBloc<OutboundTaskItem>,
      CommonDataGridState<OutboundTaskItem>
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
              _handleCancelSelected(selectedItemIds);
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
