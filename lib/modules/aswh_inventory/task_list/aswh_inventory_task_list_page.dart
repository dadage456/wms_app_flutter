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

import 'bloc/aswh_inventory_task_list_bloc.dart';
import 'bloc/aswh_inventory_task_list_event.dart';
import 'bloc/aswh_inventory_task_list_state.dart';
import 'config/aswh_inventory_task_grid_config.dart';
import 'models/inventory_task.dart';

const _pageBackground = Color(0xFFF6F6F6);

class AswhInventoryTaskListPage extends StatefulWidget {
  const AswhInventoryTaskListPage({super.key});

  @override
  State<AswhInventoryTaskListPage> createState() =>
      _AswhInventoryTaskListPageState();
}

class _AswhInventoryTaskListPageState extends State<AswhInventoryTaskListPage> {
  late final AswhInventoryTaskListBloc _bloc;
  late final CommonDataGridBloc<InventoryTaskSummary> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhInventoryTaskListBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const AswhInventoryTaskListEvent.started());
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AswhInventoryTaskListBloc, AswhInventoryTaskListState>(
      listener: (context, state) {
        if (state.status == AswhTaskListStatus.actionInProgress) {
          LoadingDialogManager.instance.showLoadingDialog(
            context,
            text: '处理中...',
          );
        } else {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.status == AswhTaskListStatus.failure &&
            state.message != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.message!,
          );
        }

        if (state.status == AswhTaskListStatus.success &&
            state.message != null &&
            state.message!.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          _navigateHome();
          return false;
        },
        child: Scaffold(
          backgroundColor: _pageBackground,
          appBar: CustomAppBar(
            title: '立库盘点',
            onBackPressed: _navigateHome,
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () => Modular.to.pushNamed('/aswh-inventory/receive'),
              ),
            ],
          ).appBar,
          body: Column(
            children: [
              _buildScanner(),
              Expanded(child: _buildDataGrid()),
            ],
          ),
        ),
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
      onScanResult: (value) =>
          _bloc.add(AswhInventoryTaskListEvent.scanContentReceived(value)),
      suffix: IconButton(
        icon: SvgPicture.asset('assets/images/icon_filter.svg'),
        onPressed: () async {
          final controller = TextEditingController(
            text: _bloc.state.filter.searchKey,
          );
          final searchKey = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('输入查询关键字'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: '请输入盘库单号/任务号'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('取消'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(controller.text.trim()),
                    child: const Text('查询'),
                  ),
                ],
              );
            },
          );
          if (searchKey != null) {
            _bloc.add(AswhInventoryTaskListEvent.filterSubmitted(searchKey));
          }
        },
      ),
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildDataGrid() {
    return BlocProvider.value(
      value: _gridBloc,
      child:
          BlocConsumer<
            CommonDataGridBloc<InventoryTaskSummary>,
            CommonDataGridState<InventoryTaskSummary>
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
                  state.errorMessage ?? '数据加载失败',
                );
              }
            },
            builder: (context, state) {
              return CommonDataGrid<InventoryTaskSummary>(
                columns: AswhInventoryTaskGridConfig.columns((task, type) {
                  if (type == 0) {
                    _navigateToCollect(task);
                  } else {
                    _confirmCancel(task);
                  }
                }),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onLoadData: (pageIndex) async {
                  _bloc.add(AswhInventoryTaskListEvent.pageChanged(pageIndex));
                },
                selectedRows: state.selectedRows,
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
  }

  void _navigateToCollect(InventoryTaskSummary task) {
    Modular.to.pushNamed(
      '/aswh-inventory/collect/${task.checkTaskNo}',
      arguments: {'task': task.toJson()},
    );
  }

  Future<void> _confirmCancel(InventoryTaskSummary task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('撤销确认'),
          content: Text('是否撤销盘库单号：${task.taskComment}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确认'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _bloc.add(AswhInventoryTaskListEvent.taskCancelRequested(task));
    }
  }

  void _navigateHome() {
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
}
