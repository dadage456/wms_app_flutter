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
import '../../../services/user_manager.dart';
import '../models/aswh_up_task.dart';
import 'bloc/aswh_up_task_bloc.dart';
import 'bloc/aswh_up_task_event.dart';
import 'bloc/aswh_up_task_state.dart';
import 'config/aswh_up_task_grid_config.dart';

class AswhUpTaskListPage extends StatefulWidget {
  const AswhUpTaskListPage({super.key});

  @override
  State<AswhUpTaskListPage> createState() => _AswhUpTaskListPageState();
}

class _AswhUpTaskListPageState extends State<AswhUpTaskListPage> {
  late final AswhUpTaskBloc _bloc;
  late final CommonDataGridBloc<AswhUpTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhUpTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '立库组盘任务',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/aswh-up/receive'),
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
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
      onScanResult: (value) => _bloc.add(SearchAswhUpTasksEvent(value)),
      onError: (message) =>
          LoadingDialogManager.instance.showErrorDialog(context, message),
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
                  state.errorMessage ?? '加载任务失败',
                );
              }
            },
            builder: (context, state) {
              return CommonDataGrid<AswhUpTask>(
                columns: AswhUpTaskGridConfig.columns((task, type) {
                  if (type == 0) {
                    _navigateToCollect(task);
                  } else {
                    _navigateToDetail(task);
                  }
                }),
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onLoadData: (index) async {
                  _gridBloc.add(LoadDataEvent<AswhUpTask>(index));
                },
                selectedRows: state.selectedRows,
                onSelectionChanged: (rows) =>
                    _gridBloc.add(ChangeSelectedRowsEvent<AswhUpTask>(rows)),
                datas: state.data,
                allowPager: true,
                allowSelect: false,
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
    );
  }

  void _navigateToCollect(AswhUpTask task) {
    Modular.to.pushNamed(
      '/aswh-up/collect/${task.inTaskNo}',
      arguments: {'task': task},
    );
  }

  void _navigateToDetail(AswhUpTask task) {
    final userManager = Modular.get<UserManager>();
    final userInfo = userManager.userInfo;
    if (userInfo == null) {
      LoadingDialogManager.instance.showErrorDialog(context, '用户信息获取失败');
      return;
    }

    Modular.to.pushNamed(
      '/aswh-up/detail/${task.inTaskId}',
      arguments: {
        'task': task,
        'workStation': task.workStation,
        'userId': userInfo.userId,
        'roleOrUserId': userInfo.userId,
      },
    );
  }
}
