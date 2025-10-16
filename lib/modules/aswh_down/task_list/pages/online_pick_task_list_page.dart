import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/modules/aswh_down/task_list/bloc/online_pick_task_bloc.dart';
import 'package:wms_app/modules/aswh_down/task_list/bloc/online_pick_task_event.dart';
import 'package:wms_app/modules/aswh_down/task_list/config/online_pick_task_grid_config.dart';
import 'package:wms_app/modules/aswh_down/task_list/widgets/online_pick_task_filter_dialog.dart';

class OnlinePickTaskListPage extends StatefulWidget {
  const OnlinePickTaskListPage({super.key});

  @override
  State<OnlinePickTaskListPage> createState() => _OnlinePickTaskListPageState();
}

class _OnlinePickTaskListPageState extends State<OnlinePickTaskListPage>
    with SingleTickerProviderStateMixin {
  static const _background = Color(0xFFF6F6F6);

  late final OnlinePickTaskBloc _bloc;
  late final CommonDataGridBloc<OnlinePickTask> _gridBloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _bloc.add(const OnlinePickTaskInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: CustomAppBar(
        title: '在线拣选任务',
        onBackPressed: () => Navigator.of(context).pop(),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/aswh-down/receive'),
            icon: const Icon(Icons.assignment_turned_in, color: Colors.white),
          ),
        ],
      ).appBar,
      body: Column(
        children: [
          _buildScanner(),
          const SizedBox(height: 4),
          Expanded(child: _buildDataGrid()),
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
      controller: _scannerController,
      config: config,
      onScanResult: (value) {
        _bloc.add(OnlinePickTaskSearchSubmitted(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
      suffix: IconButton(
        icon: SvgPicture.asset('assets/images/icon_filter.svg'),
        onPressed: () {
          OnlinePickTaskFilterDialog.show(
            context: context,
            currentFilter: _bloc.state.finishFlag,
            onFilterChanged: (value) {
              _bloc.add(OnlinePickTaskFinishFlagChanged(value));
            },
          );
        },
      ),
    );
  }

  Widget _buildDataGrid() {
    return BlocProvider.value(
      value: _gridBloc,
      child: BlocConsumer<
          CommonDataGridBloc<OnlinePickTask>,
          CommonDataGridState<OnlinePickTask>>(
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
          final grid = CommonDataGrid<OnlinePickTask>(
            columns: OnlinePickTaskGridConfig.columns(
              (task, actionIndex) {
                if (actionIndex == 0) {
                  _navigateToCollect(task);
                } else {
                  _navigateToDetail(task);
                }
              },
            ),
            currentPage: state.currentPage,
            totalPages: state.totalPages,
            datas: state.data,
            allowPager: false,
            allowSelect: false,
            headerHeight: 44,
            rowHeight: 48,
            onLoadData: (pageIndex) async {
              _gridBloc.add(LoadDataEvent(pageIndex));
            },
            onSelectionChanged: (_) {},
          );

          final isEmpty =
              state.status == GridStatus.loaded && state.data.isEmpty;

          if (isEmpty) {
            return Stack(
              children: [
                grid,
                const Center(child: Text('当前任务列表没有待处理任务')),
              ],
            );
          }

          return grid;
        },
      ),
    );
  }

  void _navigateToCollect(OnlinePickTask task) {
    Modular.to.pushNamed('/aswh-down/collect', arguments: {'task': task});
  }

  void _navigateToDetail(OnlinePickTask task) {
    Modular.to.pushNamed(
      '/aswh-down/detail/${task.outTaskId}',
      arguments: {'task': task},
    );
  }
}
