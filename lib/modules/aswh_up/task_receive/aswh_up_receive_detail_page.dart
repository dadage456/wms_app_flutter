import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../common_widgets/common_grid/grid_event.dart';
import '../../../common_widgets/common_grid/grid_state.dart';
import '../../../common_widgets/common_grid/selection_action_bar.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../models/aswh_up_task.dart';
import '../services/aswh_up_task_service.dart';
import '../task_details/config/aswh_up_task_detail_grid_config.dart';
import '../task_details/models/aswh_up_task_detail_item.dart';
import 'bloc/aswh_up_receive_detail_bloc.dart';
import 'bloc/aswh_up_receive_detail_event.dart';
import 'bloc/aswh_up_receive_detail_state.dart';

class AswhUpReceiveDetailPage extends StatefulWidget {
  const AswhUpReceiveDetailPage({super.key, required this.task});

  final AswhUpTask task;

  @override
  State<AswhUpReceiveDetailPage> createState() =>
      _AswhUpReceiveDetailPageState();
}

class _AswhUpReceiveDetailPageState extends State<AswhUpReceiveDetailPage> {
  late final AswhUpReceiveDetailBloc _bloc;
  late final CommonDataGridBloc<AswhUpTaskDetailItem> _gridBloc;
  final ScannerController _scannerController = ScannerController();
  late final AswhUpTaskService _service;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhUpReceiveDetailBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _service = Modular.get<AswhUpTaskService>();
    _bloc.initialize(widget.task);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      AswhUpReceiveDetailBloc,
      AswhUpReceiveDetailState
    >(
      listener: (context, state) {
        if (state.errorMessage != null) {
          LoadingDialogManager.instance
              .showErrorDialog(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F6F6),
          appBar: CustomAppBar(
            title: '组盘接收明细',
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
      placeholder: '请扫描物料或库位',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) async {
        await _handleScanValue(value);
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Future<void> _handleScanValue(String value) async {
    if (value.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(
        context,
        '采集内容为空，请重新采集',
      );
      return;
    }

    try {
      if (value.contains('MC')) {
        LoadingDialogManager.instance.showLoadingDialog(context);
        final info = await _service.getMaterialInfoByQR(value);
        LoadingDialogManager.instance.hideLoadingDialog(context);
        if (info.materialCode == null || info.materialCode!.isEmpty) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            '未识别到物料编码',
          );
          return;
        }
        _bloc.add(SearchAswhUpReceiveDetailEvent(info.materialCode!));
      } else if (value.contains(r'$KW$')) {
        final parts = value.split('\$');
        if (parts.length >= 3) {
          _bloc.add(SearchAswhUpReceiveDetailEvent(parts[2]));
        } else {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            '库位条码格式不正确',
          );
        }
      } else {
        LoadingDialogManager.instance.showErrorDialog(
          context,
          '采集内容不合法',
        );
      }
    } catch (error) {
      LoadingDialogManager.instance.hideLoadingDialog(context);
      LoadingDialogManager.instance
          .showErrorDialog(context, error.toString());
    }
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<
        CommonDataGridBloc<AswhUpTaskDetailItem>,
        CommonDataGridState<AswhUpTaskDetailItem>
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
          return CommonDataGrid<AswhUpTaskDetailItem>(
            columns: AswhUpTaskDetailGridConfig.columns(),
            datas: state.data,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            allowPager: true,
            allowSelect: true,
            selectedRows: state.selectedRows,
            onSelectionChanged: (rows) {
              _gridBloc
                  .add(ChangeSelectedRowsEvent<AswhUpTaskDetailItem>(rows));
            },
            onLoadData: (pageIndex) async {
              _gridBloc.add(LoadDataEvent<AswhUpTaskDetailItem>(pageIndex));
            },
            rowHeight: 48,
            headerHeight: 44,
          );
        },
      ),
    );
  }

  Widget _buildActionBar() {
    return BlocBuilder<
      CommonDataGridBloc<AswhUpTaskDetailItem>,
      CommonDataGridState<AswhUpTaskDetailItem>
    >(
      bloc: _gridBloc,
      builder: (context, state) {
        return SelectionActionBar(
          selectedCount: state.selectedRows.length,
          totalCount: state.data.length,
          confirmLabel: '接收',
          onConfirm: () {
            _bloc.add(ReceiveSelectedAswhUpItemsEvent(state.selectedRows));
          },
        );
      },
    );
  }
}
