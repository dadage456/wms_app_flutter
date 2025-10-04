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
import 'package:wms_app/modules/outbound/task_list/bloc/outbound_task_bloc.dart';
import 'package:wms_app/modules/outbound/task_list/bloc/outbound_task_event.dart';
import 'package:wms_app/modules/outbound/task_list/config/outbound_task_grid_config.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/modules/outbound/task_list/widgets/outbound_task_filter_dialog.dart';
import 'package:wms_app/services/user_manager.dart';

const Color _bgColor = Color(0xFFF6F6F6);

class OutboundTaskListPage extends StatefulWidget {
  const OutboundTaskListPage({super.key});

  @override
  State<OutboundTaskListPage> createState() => _OutboundTaskListPageState();
}

class _OutboundTaskListPageState extends State<OutboundTaskListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _scanController = TextEditingController();
  late final CommonDataGridBloc<OutboundTask> _gridBloc;
  late final OutboundTaskBloc _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bloc = BlocProvider.of<OutboundTaskBloc>(context);

    _gridBloc = _bloc.gridBloc;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: CustomAppBar(
        title: '出库任务列表',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/outbound/receive');
            },
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
      ).appBar,
      body: Column(
        children: [
          _buildScanInput(),
          const SizedBox(height: 0),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildScanInput() {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _scanController,
              onSubmitted: (value) {
                _bloc.add(SearchOutboundTasksEvent(value));
              },
              decoration: InputDecoration(
                hintText: '请扫描单号',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // 输入框 8 圆角
                  borderSide: BorderSide.none, // 去掉默认边框
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _scanController,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink() // 无文字时不显示
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _scanController.clear();
                            _bloc.add(SearchOutboundTasksEvent(''));
                          },
                        ),
                ),
              ),
            ),
          ),
          SizedBox(width: 0),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/icon_filter.svg', // SVG 文件路径
              // width: 32, // 设置图标的宽度
              // height: 32, // 设置图标的高度
              // colorFilter: const ColorFilter.mode(
              //   Colors.blue, // 给 SVG 图像上色
              //   BlendMode.srcIn,
              // ),
            ),
            onPressed: () {
              // TODO: 在这里添加筛选逻辑
              print('Filter button pressed');
              OutboundTaskFilterDialog.show(
                context: context,
                currentFilter: _bloc.currentQuery?.finishFlag ?? '0',
                onFilterChanged: (v) {
                  _bloc.add(FilterOutboundTasksEvent(v));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return BlocProvider(
      create: (context) => _gridBloc,
      child:
          BlocConsumer<
            CommonDataGridBloc<OutboundTask>,
            CommonDataGridState<OutboundTask>
          >(
            listener:
                (
                  BuildContext context,
                  CommonDataGridState<OutboundTask> state,
                ) {
                  debugPrint('------------------状态变化 ------------------');
                  debugPrint('--------状态: ${state.status}');
                  if (state.status == GridStatus.loading) {
                    LoadingDialogManager.instance.showLoadingDialog(context);
                  } else {
                    LoadingDialogManager.instance.hideLoadingDialog(context);
                  }

                  if (state.status == GridStatus.error) {
                    LoadingDialogManager.instance.showErrorDialog(
                      context,
                      state.errorMessage ?? '未知错误',
                    );
                  }
                },
            builder: (context, state) {
              debugPrint('------------------构建表格 ------------------');
              debugPrint(
                '--------rows: ${state.status}  ${state.errorMessage ?? ''}',
              );

              debugPrint(state.data?.toString());
              debugPrint('--------selected rows: ${state.selectedRows}');
              return CommonDataGrid<OutboundTask>(
                columns: OutboundTaskGridConfig.getColumns((item, type) {
                  if (type == 0) {
                    debugPrint('--------item: 进入采集页面');
                    _navigateToCollect(context, item);
                  } else {
                    debugPrint('--------item: 进入明细页面');
                    _navigateToDetail(context, item);
                  }
                }),
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onLoadData: (pageIndex) async {
                  debugPrint('load page data $pageIndex');
                  await Future.delayed(const Duration(microseconds: 1));

                  _gridBloc.add(LoadDataEvent(pageIndex));
                },

                selectedRows: state.selectedRows,
                onSelectionChanged: (list) {
                  debugPrint('selectedRows: $list');
                  _gridBloc.add(ChangeSelectedRowsEvent(list));
                },
                datas: state.data,
                allowPager: false,
                allowSelect: false,
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
    );
  }

  /// 导航到采集页面
  void _navigateToCollect(BuildContext context, OutboundTask task) {
    // 获取用户信息
    final userManager = Modular.get<UserManager>();
    final userInfo = userManager.userInfo;

    if (userInfo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('用户信息获取失败，请重新登录')));
      return;
    }

    debugPrint('Navigating to collect page with task: ${task.outTaskNo}');
    // 导航到出库采集页面
    Modular.to.pushNamed(
      '/outbound/collect/${task.outTaskNo}',
      arguments: {'task': task},
    );
  }

  /// 导航到明细页面
  void _navigateToDetail(BuildContext context, OutboundTask task) {
    // 获取用户信息
    final userManager = Modular.get<UserManager>();
    final userInfo = userManager.userInfo;

    if (userInfo == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('用户信息获取失败，请重新登录')));
      return;
    }

    // 导航到出库任务明细页面
    Modular.to.pushNamed(
      '/outbound/detail/${task.outTaskId}',
      arguments: {
        'outTaskId': task.outTaskId.toString(),
        'workStation': task.workStation,
        'userId': userInfo.userId,
        'roleOrUserId': userInfo.userId,
      },
    );
  }
}
