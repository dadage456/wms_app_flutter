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
  bool _shouldNotifyParent = false;

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop({'refresh': _shouldNotifyParent});
        return false;
      },
      child:
          BlocListener<
            OnlinePickReceiveDetailBloc,
            OnlinePickReceiveDetailState
          >(
            listener: (context, state) {
              final status = state.status;
              if (status.isLoading) {
                LoadingDialogManager.instance.showLoadingDialog(context);
                return;
              }
              LoadingDialogManager.instance.hideLoadingDialog(context);

              if (status.isError && (status.message?.isNotEmpty ?? false)) {
                LoadingDialogManager.instance.showErrorDialog(
                  context,
                  status.message!,
                );
                _bloc.add(const OnlinePickReceiveDetailStatusCleared());
              } else if (status.isSuccess &&
                  (status.message?.isNotEmpty ?? false)) {
                LoadingDialogManager.instance.showSnackSuccessMsg(
                  context,
                  status.message!,
                );
                _shouldNotifyParent = true;
                _bloc.add(const OnlinePickReceiveDetailStatusCleared());
              }
            },
            child: Scaffold(
              backgroundColor: _background,
              appBar: CustomAppBar(
                title: '在线拣选接收明细',
                onBackPressed: () =>
                    Modular.to.pop({'refresh': _shouldNotifyParent}),
                actions: [
                  IconButton(
                    onPressed: () => _bloc.add(
                      const OnlinePickReceiveDetailRefreshRequested(),
                    ),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
              ).appBar,
              body: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildSummaryCard(),
                  const SizedBox(height: 8),
                  _buildScanner(),
                  const SizedBox(height: 8),
                  Expanded(child: _buildDataGrid()),
                ],
              ),
              bottomNavigationBar: _buildActionBar(),
            ),
          ),
    );
  }

  Widget _buildSummaryCard() {
    return BlocBuilder<
      OnlinePickReceiveDetailBloc,
      OnlinePickReceiveDetailState
    >(
      builder: (context, state) {
        final task = state.task;
        final labelStyle = Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF333333));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 20,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip('任务号', task?.outTaskNo ?? '-', labelStyle),
                    _buildInfoChip('凭证号', task?.taskComment ?? '-', labelStyle),
                    _buildInfoChip('工位', task?.workStation ?? '-', labelStyle),
                    _buildInfoChip('记录数', '${state.recordCount}', labelStyle),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(String label, String value, TextStyle? style) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('$label：$value', style: style),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描或输入物料/库位/托盘',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          _bloc.add(OnlinePickReceiveDetailScanSubmitted(value));
        },
        onError: (message) {
          LoadingDialogManager.instance.showErrorDialog(context, message);
        },
      ),
    );
  }

  Widget _buildDataGrid() {
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

              if (state.status == GridStatus.error &&
                  (state.errorMessage?.isNotEmpty ?? false)) {
                LoadingDialogManager.instance.showErrorDialog(
                  context,
                  state.errorMessage!,
                );
              }
            },
            builder: (context, state) {
              final grid = CommonDataGrid<OnlinePickTaskItem>(
                columns: OnlinePickTaskDetailGridConfig.columns(),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: true,
                selectedRows: state.selectedRows,
                onSelectionChanged: (rows) =>
                    _gridBloc.add(ChangeSelectedRowsEvent(rows)),
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                headerHeight: 44,
                rowHeight: 48,
              );

              if (state.status == GridStatus.loaded && state.data.isEmpty) {
                return Stack(
                  children: [
                    grid,
                    const Center(child: Text('暂无明细数据')),
                  ],
                );
              }

              return grid;
            },
          ),
    );
  }

  Widget _buildActionBar() {
    return BlocBuilder<
      CommonDataGridBloc<OnlinePickTaskItem>,
      CommonDataGridState<OnlinePickTaskItem>
    >(
      bloc: _gridBloc,
      builder: (context, state) {
        final total = state.data.length;
        final selected = state.selectedRows.length;
        final allSelected = total > 0 && selected == total;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 6,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Text(
                  '已选 $selected / $total',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF465CFF),
                  ),
                ),
                const Spacer(),
                _buildActionButton(
                  label: allSelected ? '取消全选' : '全选',
                  icon: allSelected ? Icons.clear_all : Icons.select_all,
                  onPressed: total == 0 ? null : () => _toggleSelectAll(state),
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  label: '接收',
                  icon: Icons.done_all,
                  onPressed: selected > 0
                      ? () => _bloc.add(
                          const OnlinePickReceiveDetailCommitRequested(),
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    final isDisabled = onPressed == null;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? const Color(0xFFE0E0E0) : null,
        foregroundColor: isDisabled ? const Color(0xFF999999) : null,
        minimumSize: const Size(120, 42),
      ),
    );
  }

  void _toggleSelectAll(CommonDataGridState<OnlinePickTaskItem> state) {
    final total = state.data.length;
    final selected = state.selectedRows.length;
    if (total == 0) {
      return;
    }

    if (selected == total) {
      _gridBloc.add(const ChangeSelectedRowsEvent([]));
    } else {
      _gridBloc.add(
        ChangeSelectedRowsEvent(List<int>.generate(total, (index) => index)),
      );
    }
  }
}
