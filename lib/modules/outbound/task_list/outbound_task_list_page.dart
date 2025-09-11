import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/grid_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/grid_event.dart';
import 'package:wms_app/common_widgets/common_grid/grid_state.dart';
import 'package:wms_app/common_widgets/custom_app_bar.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/outbound/task_list/config/outbound_task_grid_config.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';

const Color _bgColor = Color(0xFFF6F6F6);
const TextStyle _appBarTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const TextStyle _infoTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

class OutboundTaskListPage extends StatefulWidget {
  const OutboundTaskListPage({super.key});

  @override
  State<OutboundTaskListPage> createState() => _OutboundTaskListPageState();
}

class _OutboundTaskListPageState extends State<OutboundTaskListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _scanController = TextEditingController();
  late final CommonDataGridBloc<OutboundTask> _bloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _bloc = CommonDataGridBloc<OutboundTask>(
      dataLoader: (pageIndex) async {
        await Future.delayed(const Duration(seconds: 1));
        return DataGridResponseData(totalPages: 1, data: []);
      },
    );
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
      ).appBar,
      body: Column(
        children: [
          _buildScanInput(),
          const SizedBox(height: 0),
          _buildTable(),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildScanInput() {
    return Container(
      height: 44,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
      ),
      child: TextField(
        controller: _scanController,
        decoration: InputDecoration(
          hintText: '请扫描或输入库位/物料',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // 输入框 8 圆角
            borderSide: BorderSide.none, // 去掉默认边框
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildTable() {
    return BlocProvider(
      create: (context) => _bloc,
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
              print(
                '--------rows: ${state.status}  ${state.errorMessage ?? ''}',
              );
              debugPrint('--------selected rows: ${state.selectedRows}');
              return CommonDataGrid<OutboundTask>(
                columns: OutboundTaskGridConfig.getColumns(),
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                onLoadData: (pageIndex) async {
                  debugPrint('load page data $pageIndex');
                  await Future.delayed(const Duration(microseconds: 1));

                  _bloc.add(LoadDataEvent(pageIndex));
                },

                selectedRows: state.selectedRows,
                onSelectionChanged: (list) {
                  debugPrint('selectedRows: $list');
                  _bloc.add(ChangeSelectedRowsEvent(list));
                },
                datas: state.data,
                allowPager: true,
                allowSelect: true,
              );
            },
          ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(color: Colors.white),
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: _buildOutlinedButtonStyle(),
              child: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: _buildButtonStyle(),
              child: const Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _buildOutlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1976D2), // 文字 + 图标色
      backgroundColor: Colors.transparent, // 背景透明
      side: const BorderSide(color: Color(0xFF1976D2)), // 蓝色边框
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.zero,
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
