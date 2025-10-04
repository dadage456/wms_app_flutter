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
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';

import 'bloc/receive_task_bloc.dart';
import 'bloc/receive_task_event.dart';
import 'config/receive_task_grid_config.dart';

class ReceiveTaskPage extends StatefulWidget {
  const ReceiveTaskPage({super.key});

  @override
  State<ReceiveTaskPage> createState() => _ReceiveTaskPageState();
}

class _ReceiveTaskPageState extends State<ReceiveTaskPage> {
  late final ReceiveTaskBloc _bloc;
  late final CommonDataGridBloc<OutboundTask> _gridBloc;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ReceiveTaskBloc>(context);
    _gridBloc = _bloc.gridBloc;
    _gridBloc.add(LoadDataEvent(1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(
        title: '平库下架接收',
        onBackPressed: () => Modular.to.pop(),
      ).appBar,
      body: Column(
        children: [
          _buildScanInput(),
          Expanded(child: _buildTable()),
        ],
      ),
    );
  }

  Widget _buildScanInput() {
    return Container(
      height: 56,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (value) {
                _bloc.add(SearchReceiveTasksEvent(value));
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
                  valueListenable: _controller,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink() // 无文字时不显示
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            _bloc.add(const SearchReceiveTasksEvent(''));
                          },
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return BlocProvider.value(
      value: _gridBloc,
      child:
          BlocConsumer<
            CommonDataGridBloc<OutboundTask>,
            CommonDataGridState<OutboundTask>
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
                  state.errorMessage ?? '加载失败',
                );
              }
            },
            builder: (context, state) {
              return CommonDataGrid<OutboundTask>(
                columns: ReceiveTaskGridConfig.columns((task) {
                  Modular.to.pushNamed(
                    '/outbound/receive/detail/${task.outTaskId}',
                    arguments: {'task': task},
                  );
                }),
                datas: state.data,
                currentPage: state.currentPage,
                totalPages: state.totalPages,
                allowPager: true,
                allowSelect: false,
                onLoadData: (pageIndex) async {
                  _gridBloc.add(LoadDataEvent(pageIndex));
                },
                selectedRows: const [],
                headerHeight: 44,
                rowHeight: 48,
              );
            },
          ),
    );
  }
}
