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
import 'package:wms_app/services/user_manager.dart';

import 'bloc/goods_up_task_bloc.dart';
import 'bloc/goods_up_task_event.dart';
import 'config/goods_up_task_grid_config.dart';
import 'models/goods_up_task.dart';
import '../task_list/widgets/goods_up_task_filter_dialog.dart';

class GoodsUpTaskListPage extends StatefulWidget {
  const GoodsUpTaskListPage({super.key});

  @override
  State<GoodsUpTaskListPage> createState() => _GoodsUpTaskListPageState();
}

class _GoodsUpTaskListPageState extends State<GoodsUpTaskListPage> {
  late final GoodsUpTaskBloc _bloc;
  late final CommonDataGridBloc<GoodsUpTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<GoodsUpTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '平库上架任务',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/goods-up/receive'),
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
      onScanResult: (value) => _bloc.add(SearchGoodsUpTasksEvent(value)),
      onError: (message) =>
          LoadingDialogManager.instance.showErrorDialog(context, message),
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
                  state.errorMessage ?? '加载任务失败',
                );
              }
            },
            builder: (context, state) {
              return CommonDataGrid<GoodsUpTask>(
                columns: GoodsUpTaskGridConfig.columns((task, type) {
                  if (type == 0) {
                    _navigateToCollect(task);
                  } else {
                    _navigateToDetail(task);
                  }
                }),
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onLoadData: (index) async {
                  _gridBloc.add(LoadDataEvent<GoodsUpTask>(index));
                },
                selectedRows: state.selectedRows,
                onSelectionChanged: (rows) =>
                    _gridBloc.add(ChangeSelectedRowsEvent<GoodsUpTask>(rows)),
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

  void _navigateToCollect(GoodsUpTask task) {
    Modular.to.pushNamed(
      '/goods-up/collect/${task.inTaskNo}',
      arguments: {'task': task},
    );
  }

  void _navigateToDetail(GoodsUpTask task) {
    final userManager = Modular.get<UserManager>();
    final userInfo = userManager.userInfo;
    if (userInfo == null) {
      LoadingDialogManager.instance.showErrorDialog(context, '用户信息获取失败');
      return;
    }

    Modular.to.pushNamed(
      '/goods-up/detail/${task.inTaskId}',
      arguments: {
        'task': task,
        'workStation': task.workStation,
        'userId': userInfo.userId,
        'roleOrUserId': userInfo.userId,
      },
    );
  }
}
