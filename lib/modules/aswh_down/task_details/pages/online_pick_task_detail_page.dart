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

class OnlinePickTaskDetailPage extends StatefulWidget {
  const OnlinePickTaskDetailPage({
    super.key,
    required this.task,
  });

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
    return BlocListener<OnlinePickTaskDetailBloc, OnlinePickTaskDetailState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.status.isError) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.status.message ?? '操作失败',
          );
          _bloc.add(const OnlinePickTaskDetailStatusReset());
        } else if (state.status.isSuccess &&
            (state.status.message?.isNotEmpty ?? false)) {
          LoadingDialogManager.instance.showSnackSuccessMsg(
            context,
            state.status.message!,
          );
          _bloc.add(const OnlinePickTaskDetailStatusReset());
        }
      },
      child: Scaffold(
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
            Expanded(child: _buildDataGrid()),
          ],
        ),
        bottomNavigationBar: _buildActionBar(),
      ),
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
        _bloc.add(OnlinePickTaskDetailScanRequested(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildDataGrid() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<
          CommonDataGridBloc<OnlinePickTaskItem>,
          CommonDataGridState<OnlinePickTaskItem>>(
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
          }
        },
        builder: (context, state) {
          final grid = CommonDataGrid<OnlinePickTaskItem>(
            columns: OnlinePickTaskDetailGridConfig.columns(),
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            datas: state.data,
            allowPager: true,
            allowSelect: true,
            headerHeight: 44,
            rowHeight: 48,
            onLoadData: (pageIndex) async {
              _gridBloc.add(LoadDataEvent(pageIndex));
            },
            selectedRows: state.selectedRows,
            onSelectionChanged: (rows) {
              _gridBloc.add(ChangeSelectedRowsEvent(rows));
            },
          );

          final isEmpty =
              state.status == GridStatus.loaded && state.data.isEmpty;

          if (isEmpty) {
            return Stack(
              children: [
                grid,
                const Center(
                  child: Text('当前任务列表没有待处理任务'),
                ),
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
        CommonDataGridState<OnlinePickTaskItem>>(
      bloc: _gridBloc,
      builder: (context, state) {
        return OnlinePickTaskDetailActionBar(
          selectedCount: state.selectedRows.length,
          onCancel: () =>
              _bloc.add(const OnlinePickTaskDetailCancelSubmitted()),
          onRefresh: () =>
              _bloc.add(const OnlinePickTaskDetailRefreshRequested()),
        );
      },
    );
  }
}
