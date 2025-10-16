import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/arrival_sign/task_list/bloc/arrival_sign_list_bloc.dart';
import 'package:wms_app/modules/arrival_sign/task_list/bloc/arrival_sign_list_event.dart';
import 'package:wms_app/modules/arrival_sign/task_list/bloc/arrival_sign_list_state.dart';
import 'package:wms_app/modules/arrival_sign/task_list/config/arrival_sign_task_grid_config.dart';
import 'package:wms_app/modules/arrival_sign/task_list/models/arrival_sign_task.dart';

class ArrivalSignTaskListPage extends StatefulWidget {
  const ArrivalSignTaskListPage({super.key});

  @override
  State<ArrivalSignTaskListPage> createState() => _ArrivalSignTaskListPageState();
}

class _ArrivalSignTaskListPageState extends State<ArrivalSignTaskListPage>
    with SingleTickerProviderStateMixin {
  late final ArrivalSignListBloc _bloc;
  late final CommonDataGridBloc<ArrivalSignTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArrivalSignListBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const ArrivalSignListEvent.initialized());
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
        title: '到货接收',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/arrival-sign/receive'),
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
      ).appBar,
      body: BlocListener<ArrivalSignListBloc, ArrivalSignListState>(
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
            const SizedBox(height: 8),
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
        _bloc.add(ArrivalSignListEvent.search(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
      suffix: IconButton(
        icon: SvgPicture.asset('assets/images/icon_filter.svg'),
        onPressed: () {
          _bloc.add(const ArrivalSignListEvent.refresh());
        },
      ),
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocBuilder<CommonDataGridBloc<ArrivalSignTask>,
          CommonDataGridState<ArrivalSignTask>>(
        builder: (context, state) {
          if (state.status == GridStatus.loading && state.data.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == GridStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? '加载失败'),
            );
          }

          if (state.data.isEmpty) {
            return const Center(child: Text('暂无数据'));
          }

          return CommonDataGrid<ArrivalSignTask>(
            columns: ArrivalSignTaskGridConfig.buildColumns((task, action) {
              switch (action) {
                case ArrivalSignTaskAction.collect:
                  Modular.to.pushNamed('/arrival-sign/collect', arguments: {
                    'task': task.toJson(),
                  });
                  break;
                case ArrivalSignTaskAction.detail:
                  Modular.to.pushNamed(
                    '/arrival-sign/detail',
                    arguments: {'arrivalsBillId': task.arrivalsBillId},
                  );
                  break;
                case ArrivalSignTaskAction.cancel:
                  _confirmCancel(task);
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

  Future<void> _confirmCancel(ArrivalSignTask task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('确认撤销'),
          content: Text('确定撤销到货单 \${task.arrivalsBillNo} 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('撤销'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _bloc.add(ArrivalSignListEvent.cancel(task.arrivalsBillId));
    }
  }
}
