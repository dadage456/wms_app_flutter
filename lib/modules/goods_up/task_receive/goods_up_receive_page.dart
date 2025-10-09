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

import '../task_list/models/goods_up_task.dart';
import 'bloc/inbound_receive_task_bloc.dart';
import 'bloc/inbound_receive_task_event.dart';
import 'config/inbound_receive_task_grid_config.dart';

class GoodsUpReceivePage extends StatefulWidget {
  const GoodsUpReceivePage({super.key});

  @override
  State<GoodsUpReceivePage> createState() => _GoodsUpReceivePageState();
}

class _GoodsUpReceivePageState extends State<GoodsUpReceivePage> {
  late final InboundReceiveTaskBloc _bloc;
  late final CommonDataGridBloc<GoodsUpTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InboundReceiveTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _gridBloc.add(LoadDataEvent<GoodsUpTask>(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '平库上架接收',
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
        _bloc.add(SearchInboundReceiveTasksEvent(value));
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
            CommonDataGridBloc<GoodsUpTask>,
            CommonDataGridState<GoodsUpTask>
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
              return CommonDataGrid<GoodsUpTask>(
                columns: InboundReceiveTaskGridConfig.columns((task) {
                  Modular.to.pushNamed(
                    '/goods-up/receive/detail/${task.inTaskId}',
                    arguments: {'task': task},
                  );
                }),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: false,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent<GoodsUpTask>(pageIndex));
                },
                selectedRows: const [],
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
    );
  }
}
