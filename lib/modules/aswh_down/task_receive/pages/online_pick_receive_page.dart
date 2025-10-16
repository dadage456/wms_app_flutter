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
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';

import '../bloc/online_pick_receive_bloc.dart';
import '../bloc/online_pick_receive_event.dart';
import '../bloc/online_pick_receive_state.dart';
import '../config/online_pick_receive_grid_config.dart';

class OnlinePickReceivePage extends StatefulWidget {
  const OnlinePickReceivePage({super.key});

  @override
  State<OnlinePickReceivePage> createState() => _OnlinePickReceivePageState();
}

class _OnlinePickReceivePageState extends State<OnlinePickReceivePage> {
  static const _background = Color(0xFFF6F6F6);

  late final OnlinePickReceiveBloc _bloc;
  late final CommonDataGridBloc<OnlinePickTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();
  bool _pendingRefreshAfterDetail = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<OnlinePickReceiveBloc>();
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const OnlinePickReceiveStarted());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.pop({'refresh': _pendingRefreshAfterDetail});
        return false;
      },
      child: BlocListener<OnlinePickReceiveBloc, OnlinePickReceiveState>(
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
            _bloc.add(const OnlinePickReceiveStatusCleared());
          } else if (status.isSuccess) {
            _bloc.add(const OnlinePickReceiveStatusCleared());
          }
        },
        child: Scaffold(
          backgroundColor: _background,
          appBar: CustomAppBar(
            title: '在线拣选接收',
            onBackPressed: () =>
                Modular.to.pop({'refresh': _pendingRefreshAfterDetail}),
            actions: [
              IconButton(
                onPressed: () =>
                    _bloc.add(const OnlinePickReceiveRefreshRequested()),
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
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return BlocBuilder<OnlinePickReceiveBloc, OnlinePickReceiveState>(
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
            child: Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                _buildSummaryChip(
                  label: '记录数',
                  value: '${state.recordCount}',
                  style: textStyle,
                ),
                _buildSummaryChip(
                  label: '搜索关键字',
                  value: state.searchKeyword.isEmpty
                      ? '未筛选'
                      : state.searchKeyword,
                  style: textStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryChip({
    required String label,
    required String value,
    required TextStyle? style,
  }) {
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
      placeholder: '请扫描或输入任务号/凭证号',
      clearOnSubmit: true,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          _bloc.add(OnlinePickReceiveSearchRequested(value));
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
            CommonDataGridBloc<OnlinePickTask>,
            CommonDataGridState<OnlinePickTask>
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
              final grid = CommonDataGrid<OnlinePickTask>(
                columns: OnlinePickReceiveGridConfig.columns(_navigateToDetail),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: false,
                selectedRows: const [],
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
                    const Center(child: Text('暂无待接收任务')),
                  ],
                );
              }

              return grid;
            },
          ),
    );
  }

  Future<void> _navigateToDetail(OnlinePickTask task) async {
    final result = await Modular.to.pushNamed(
      '/aswh-down/receive/detail/${task.outTaskId}',
      arguments: {'task': task},
    );

    if (result is Map && result['refresh'] == true) {
      _pendingRefreshAfterDetail = true;
      _bloc.add(const OnlinePickReceiveRefreshRequested());
    }
  }
}
