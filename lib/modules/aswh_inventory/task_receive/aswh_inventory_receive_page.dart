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

import '../task_list/models/inventory_task.dart';
import 'bloc/aswh_inventory_receive_bloc.dart';
import 'bloc/aswh_inventory_receive_event.dart';
import 'bloc/aswh_inventory_receive_state.dart';
import 'config/aswh_inventory_receive_grid_config.dart';

const _pageBackground = Color(0xFFF6F6F6);

class AswhInventoryReceivePage extends StatefulWidget {
  const AswhInventoryReceivePage({super.key});

  @override
  State<AswhInventoryReceivePage> createState() =>
      _AswhInventoryReceivePageState();
}

class _AswhInventoryReceivePageState
    extends State<AswhInventoryReceivePage> {
  late final AswhInventoryReceiveBloc _bloc;
  late final CommonDataGridBloc<InventoryTaskSummary> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhInventoryReceiveBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const AswhInventoryReceiveStarted());
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AswhInventoryReceiveBloc, AswhInventoryReceiveState>(
      listener: (context, state) {
        if (state.status == InventoryReceiveStatus.actionInProgress) {
          LoadingDialogManager.instance.showLoadingDialog(
            context,
            text: '处理中...',
          );
        } else if (state.status != InventoryReceiveStatus.loading) {
          LoadingDialogManager.instance.hideLoadingDialog(context);
        }

        if (state.status == InventoryReceiveStatus.failure &&
            state.message != null) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.message!,
          );
        }

        if ((state.status == InventoryReceiveStatus.success ||
                state.status == InventoryReceiveStatus.actionSuccess) &&
            state.message != null &&
            state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }

        if (state.status == InventoryReceiveStatus.actionSuccess) {
          _scannerController.clear();
          _scannerController.requestFocus();
        }
      },
      child: Scaffold(
        backgroundColor: _pageBackground,
        appBar: CustomAppBar(
          title: '立库盘点接收',
          onBackPressed: () => Modular.to.pop(),
        ).appBar,
        body: Column(
          children: [
            _buildScanner(),
            Expanded(child: _buildDataGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildScanner() {
    final config = ScannerConfig().copyWith(
      placeholder: '请扫描单号',
      clearOnSubmit: true,
      autoFocus: true,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) =>
          _bloc.add(AswhInventoryReceiveScanCaptured(value)),
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
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
            _bloc.add(AswhInventoryReceiveSearchSubmitted(searchKey));
          }
        },
      ),
    );
  }

  Widget _buildDataGrid() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<
          CommonDataGridBloc<InventoryTaskSummary>,
          CommonDataGridState<InventoryTaskSummary>>(
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
            columns: AswhInventoryReceiveGridConfig.columns((task) {
              _confirmReceive(task);
            }),
            datas: state.data,
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            onLoadData: (pageIndex) async {
              _bloc.add(AswhInventoryReceivePageChanged(pageIndex));
            },
            selectedRows: const [],
            allowPager: true,
            allowSelect: false,
            headerHeight: 44,
            rowHeight: 48,
          );
        },
      ),
    );
  }

  Future<void> _confirmReceive(InventoryTaskSummary task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('接收确认'),
          content: const Text('是否执行接收操作?'),
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

    if (confirmed == true) {
      _bloc.add(AswhInventoryReceiveConfirmed(task));
    }
  }
}
