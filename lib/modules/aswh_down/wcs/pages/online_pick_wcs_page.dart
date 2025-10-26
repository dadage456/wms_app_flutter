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
import 'package:wms_app/modules/aswh_down/models/online_pick_wcs_models.dart';
import 'package:wms_app/modules/aswh_down/wcs/config/online_pick_wcs_grid_config.dart';

import '../bloc/online_pick_wcs_bloc.dart';
import '../bloc/online_pick_wcs_event.dart';
import '../bloc/online_pick_wcs_state.dart';

class OnlinePickWcsPage extends StatefulWidget {
  const OnlinePickWcsPage({super.key, required this.initialArgs});

  final Map<String, dynamic> initialArgs;

  @override
  State<OnlinePickWcsPage> createState() => _OnlinePickWcsPageState();
}

class _OnlinePickWcsPageState extends State<OnlinePickWcsPage> {
  static const _background = Color(0xFFF6F6F6);

  late final OnlinePickWcsBloc _bloc;
  late final CommonDataGridBloc<OnlinePickWcsCommand> _gridBloc;
  final ScannerController _scannerController = ScannerController();
  bool _shouldNotifyParent = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickWcsBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(OnlinePickWcsStarted(widget.initialArgs));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop({'refresh': _shouldNotifyParent});
        return false;
      },
      child: BlocListener<OnlinePickWcsBloc, OnlinePickWcsState>(
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
            _bloc.add(const OnlinePickWcsStatusCleared());
          } else if (status.isSuccess &&
              (status.message?.isNotEmpty ?? false)) {
            LoadingDialogManager.instance.showSnackSuccessMsg(
              context,
              status.message!,
            );
            _shouldNotifyParent = state.shouldNotifyParent;
            _bloc.add(const OnlinePickWcsStatusCleared());
          }
        },
        child: Scaffold(
          backgroundColor: _background,
          appBar: CustomAppBar(
            title: 'WMS ↔ WCS 指令',
            onBackPressed: () =>
                Modular.to.pop({'refresh': _shouldNotifyParent}),
            actions: [
              IconButton(
                onPressed: () =>
                    _bloc.add(const OnlinePickWcsRefreshRequested()),
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),
            ],
          ).appBar,
          body: Column(
            children: [
              const SizedBox(height: 8),
              _buildContextInfo(),
              const SizedBox(height: 8),
              _buildScannerBar(),
              const SizedBox(height: 8),
              Expanded(child: _buildDataGrid()),
            ],
          ),
          bottomNavigationBar: _buildActionBar(),
        ),
      ),
    );
  }

  Widget _buildContextInfo() {
    return BlocBuilder<OnlinePickWcsBloc, OnlinePickWcsState>(
      builder: (context, state) {
        final textStyle = Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF333333));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  color: Color.fromRGBO(0, 0, 0, 0.04),
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
                    _buildInfoChip('任务号', state.taskNo, textStyle),
                    _buildInfoChip('托盘号', state.trayNo, textStyle),
                    _buildInfoChip('工作站', state.workStation, textStyle),
                    _buildInfoChip('记录数', '${state.recordCount}', textStyle),
                  ],
                ),
                if (state.taskComment.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    state.taskComment,
                    style: textStyle?.copyWith(color: const Color(0xFF666666)),
                  ),
                ],
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
        color: const Color(0xFFF2F4FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('$label：${value.isEmpty ? '-' : value}', style: style),
    );
  }

  Widget _buildScannerBar() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描或输入托盘号/指令号进行查询',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          _bloc.add(OnlinePickWcsSearchSubmitted(value));
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
            CommonDataGridBloc<OnlinePickWcsCommand>,
            CommonDataGridState<OnlinePickWcsCommand>
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
              final grid = CommonDataGrid<OnlinePickWcsCommand>(
                columns: OnlinePickWcsGridConfig.columns(),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: false,
                allowSelect: true,
                selectedRows: state.selectedRows,
                onSelectionChanged: (rows) =>
                    _gridBloc.add(ChangeSelectedRowsEvent(rows)),
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                headerHeight: 44,
                rowHeight: 50,
              );

              if (state.status == GridStatus.loaded && state.data.isEmpty) {
                return Stack(
                  children: [
                    grid,
                    const Center(child: Text('暂无指令记录')),
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
      CommonDataGridBloc<OnlinePickWcsCommand>,
      CommonDataGridState<OnlinePickWcsCommand>
    >(
      bloc: _gridBloc,
      builder: (context, state) {
        final hasSelection = state.selectedRows.isNotEmpty;

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
                  '已选 ${state.selectedRows.length} 项',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF465CFF),
                  ),
                ),
                const Spacer(),
                _buildActionButton(
                  label: '撤销回指令',
                  icon: Icons.undo,
                  onPressed: hasSelection
                      ? () => _bloc.add(
                          const OnlinePickWcsResetCommandRequested(),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  label: '撤销出库指令',
                  icon: Icons.assignment_return,
                  onPressed: hasSelection
                      ? () =>
                            _bloc.add(const OnlinePickWcsDownCommandRequested())
                      : null,
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  label: '刷新',
                  icon: Icons.refresh,
                  onPressed: () =>
                      _bloc.add(const OnlinePickWcsRefreshRequested()),
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
        minimumSize: const Size(120, 40),
      ),
    );
  }
}
