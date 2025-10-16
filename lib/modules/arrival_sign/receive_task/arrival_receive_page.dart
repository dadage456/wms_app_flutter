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
import 'package:wms_app/modules/arrival_sign/receive_task/bloc/arrival_receive_bloc.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/bloc/arrival_receive_event.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/bloc/arrival_receive_state.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/config/arrival_receive_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/receive_task/models/arrival_receive_task.dart';

class ArrivalReceivePage extends StatefulWidget {
  const ArrivalReceivePage({super.key});

  @override
  State<ArrivalReceivePage> createState() => _ArrivalReceivePageState();
}

class _ArrivalReceivePageState extends State<ArrivalReceivePage> {
  late final ArrivalReceiveBloc _bloc;
  late final CommonDataGridBloc<ArrivalReceiveTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArrivalReceiveBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const ArrivalReceiveEvent.initialized());
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '接收到货任务',
        onBackPressed: () => Navigator.of(context).pop(),
      ).appBar,
      body: BlocListener<ArrivalReceiveBloc, ArrivalReceiveState>(
        listener: (context, state) {
          if (state.isProcessing) {
            LoadingDialogManager.instance.showLoadingDialog(context);
          } else {
            LoadingDialogManager.instance.hideLoadingDialog(context);
          }

          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage!)),
            );
          }

          if (state.errorMessage != null) {
            LoadingDialogManager.instance.showErrorDialog(
              context,
              state.errorMessage!,
            );
          }
        },
        child: Column(
          children: [
            _buildScanInput(),
            Expanded(child: _buildTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildScanInput() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描到货单号',
      clearOnSubmit: true,
    );

    return ScannerWidget(
      controller: _scannerController,
      config: config,
      onScanResult: (value) {
        _bloc.add(ArrivalReceiveEvent.search(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocBuilder<CommonDataGridBloc<ArrivalReceiveTask>,
          CommonDataGridState<ArrivalReceiveTask>>(
        builder: (context, state) {
          if (state.status == GridStatus.loading && state.data.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == GridStatus.error) {
            return Center(child: Text(state.errorMessage ?? '加载失败'));
          }

          if (state.data.isEmpty) {
            return const Center(child: Text('当前任务列表没有待处理任务！'));
          }

          return CommonDataGrid<ArrivalReceiveTask>(
            columns: ArrivalReceiveGridConfig.buildColumns((task, action) {
              switch (action) {
                case ArrivalReceiveAction.receive:
                  _confirmReceive(task);
                  break;
                case ArrivalReceiveAction.detail:
                  Modular.to.pushNamed(
                    '/arrival-sign/receive/detail',
                    arguments: {'arrivalsBillId': task.arrivalsBillId},
                  );
                  break;
              }
            }),
            datas: state.data,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            onLoadData: (pageIndex) async {
              _gridBloc.add(LoadDataEvent(pageIndex));
            },
            allowPager: true,
            allowSelect: false,
            headerHeight: 44,
            rowHeight: 48,
          );
        },
      ),
    );
  }

  Future<void> _confirmReceive(ArrivalReceiveTask task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('确认接收'),
          content: Text('确定接收到货单 ${task.arrivalsBillNo} 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('接收'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _bloc.add(ArrivalReceiveEvent.receive(task.arrivalsBillId));
    }
  }
}
