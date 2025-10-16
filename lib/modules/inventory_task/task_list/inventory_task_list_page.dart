import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/common_grid/grid_bloc.dart';
import '../../../common_widgets/common_grid/grid_event.dart';
import '../../../common_widgets/common_grid/grid_state.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../../../services/user_manager.dart';
import 'bloc/inventory_task_bloc.dart';
import 'bloc/inventory_task_event.dart';
import 'bloc/inventory_task_state.dart';
import 'config/inventory_task_grid_config.dart';
import 'models/inventory_task.dart';

class InventoryTaskListPage extends StatefulWidget {
  const InventoryTaskListPage({super.key});

  @override
  State<InventoryTaskListPage> createState() => _InventoryTaskListPageState();
}

class _InventoryTaskListPageState extends State<InventoryTaskListPage> {
  late final InventoryTaskBloc _bloc;
  late final CommonDataGridBloc<InventoryTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InventoryTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const InventoryTaskEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '平库盘点任务',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/inventory/receive').then((_) {
                _bloc.add(const InventoryTaskEvent.refreshRequested());
              });
            },
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
      onScanResult: (value) {
        _bloc.add(InventoryTaskEvent.scanned(value));
      },
      onSubmit: (value) {
        _bloc.add(InventoryTaskEvent.searchSubmitted(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
      suffix: IconButton(
        icon: SvgPicture.asset('assets/images/icon_filter.svg'),
        onPressed: () {
          // 占位：后续可接入筛选对话框
        },
      ),
    );
  }

  Widget _buildTable() {
    return BlocConsumer<InventoryTaskBloc, InventoryTaskState>(
      listener: (context, state) {
        if (state.status == InventoryTaskListStatus.loading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }
        if (state.status == InventoryTaskListStatus.failure && state.message != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.message!,
          );
        }
        if (state.status == InventoryTaskListStatus.success && state.message != null) {
          LoadingDialogManager.instance.showSuccessDialog(
            context,
            state.message!,
          );
        }
      },
      builder: (context, state) {
        return BlocProvider.value(
          value: _gridBloc,
          child: BlocBuilder<CommonDataGridBloc<InventoryTask>,
              CommonDataGridState<InventoryTask>>(
            builder: (context, gridState) {
              return CommonDataGrid<InventoryTask>(
                columns: InventoryTaskGridConfig.columns((task, type) {
                  if (type == 0) {
                    _navigateToCollect(task);
                  } else {
                    _confirmCancel(task);
                  }
                }),
                datas: gridState.data,
                currentPage: gridState.currentPage,
                totalPages: gridState.totalPages,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                selectedRows: gridState.selectedRows,
                onSelectionChanged: (rows) {
                  _gridBloc.add(ChangeSelectedRowsEvent(rows));
                },
                allowPager: false,
                allowSelect: false,
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToCollect(InventoryTask task) {
    final userManager = Modular.get<UserManager>();
    final userInfo = userManager.userInfo;
    if (userInfo == null) {
      LoadingDialogManager.instance
          .showErrorDialog(context, '用户信息缺失，请重新登录');
      return;
    }

    Modular.to.pushNamed(
      '/inventory/collect/${task.checkTaskNo}',
      arguments: {'task': task, 'user': userInfo},
    ).then((_) {
      _bloc.add(const InventoryTaskEvent.refreshRequested());
    });
  }

  void _confirmCancel(InventoryTask task) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('撤销确认'),
          content: const Text('是否执行撤销操作？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bloc.add(InventoryTaskEvent.cancelTaskRequested(task));
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }
}
