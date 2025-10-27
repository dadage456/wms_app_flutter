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
    _bloc = BlocProvider.of<OnlinePickReceiveBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const OnlinePickReceiveStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _buildScanInput(),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildScanInput() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描凭证号',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(OnlinePickReceiveSearchRequested(value));
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
            CommonDataGridBloc<OnlinePickTask>,
            CommonDataGridState<OnlinePickTask>
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
              }
            },
            builder: (context, state) {
              return CommonDataGrid<OnlinePickTask>(
                columns: OnlinePickReceiveGridConfig.columns(_navigateToDetail),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: false,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                selectedRows: const [],
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
    );
  }

  Future<void> _navigateToDetail(OnlinePickTask task) async {
    final result = await Modular.to.pushNamed(
      '/aswh-down/receive/detail/${task.outTaskId}',
      arguments: {'task': task},
    );
  }
}
