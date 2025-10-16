import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../common_widgets/common_grid/grid_event.dart';
import '../../../common_widgets/common_grid/grid_state.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../models/aswh_up_task.dart';
import 'bloc/aswh_up_receive_bloc.dart';
import 'bloc/aswh_up_receive_event.dart';
import 'config/aswh_up_receive_grid_config.dart';

class AswhUpReceivePage extends StatefulWidget {
  const AswhUpReceivePage({super.key});

  @override
  State<AswhUpReceivePage> createState() => _AswhUpReceivePageState();
}

class _AswhUpReceivePageState extends State<AswhUpReceivePage> {
  late final AswhUpReceiveBloc _bloc;
  late final CommonDataGridBloc<AswhUpTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhUpReceiveBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _gridBloc.add(LoadDataEvent<AswhUpTask>(0));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '组盘接收列表',
        onBackPressed: () => Modular.to.pop(),
      ).appBar,
      body: Column(
        children: [
          _buildScanner(),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描单号',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(SearchAswhUpReceiveTasksEvent(value));
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
            CommonDataGridBloc<AswhUpTask>,
            CommonDataGridState<AswhUpTask>
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
              } else if (state.status == GridStatus.loaded &&
                  state.data.isEmpty) {
                LoadingDialogManager.instance.showSnackWarningMsg(
                  context,
                  '当前任务列表没有待处理任务',
                );
              }
            },
            builder: (context, state) {
              return CommonDataGrid<AswhUpTask>(
                columns: AswhUpReceiveGridConfig.columns(_openDetail),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: false,
                selectedRows: const [],
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent<AswhUpTask>(pageIndex));
                },
                rowHeight: 48,
                headerHeight: 44,
              );
            },
          ),
    );
  }

  void _openDetail(AswhUpTask task) {
    Modular.to.pushNamed(
      '/aswh-up/receive/detail/${task.inTaskId}',
      arguments: {'task': task},
    );
  }
}
