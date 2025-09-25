import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_event.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/scanner_broadcast.dart';
import 'bloc/collection_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';

class OutboundCollectionPage extends StatefulWidget {
  final OutboundTask task;

  const OutboundCollectionPage({Key? key, required this.task}): super(key: key);

  @override
  State<OutboundCollectionPage> createState() => _OutboundCollectionPageState();
}

class _OutboundCollectionPageState extends State<OutboundCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final userInfo = Modular.get<UserManager>().userInfo;
    BlocProvider.of<CollectionBloc>(context).add(InitializeTaskEvent(widget.task, userInfo!.userId));

    // 注册监听
    FlutterBroadcastReceiver.registerReceiver(
      onReceive: (context, intent) {
        if (intent.action == "com.scanner.broadcast") {
          setState(() {
            scannedData = intent.extras?["data"] ?? '';
          });
        }
      },
      actions: ["com.scanner.broadcast"],
    );
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => _handleBackPress(context),
        ),
        title: const Text(
          '平库下架采集',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () => _showMoreOptions(context),
            child: const Text('更多',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
      body: BlocConsumer<CollectionBloc, CollectionState>(
        listener: (context, state) {
          if (state.error != null) {
            _showErrorDialog(context, state.error!);
            Modular.get<CollectionBloc>().add(ClearErrorEvent());
          }

          debugPrint('------ state changed-----------');
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // 输入框（示例风格）
              _buildScanInput(),
              // 信息卡片（示例风格）
              _buildInfoCard(state),
              // 标签页（示例风格）
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 44,
                child: TabBar(
                  dividerHeight: 0,
                  controller: _tabController,
                  labelColor: const Color(0xFF1976D2),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF1976D2),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(text: '任务列表'),
                    Tab(text: '正在采集'),
                  ],
                  onTap: (index) {
                    Modular.get<CollectionBloc>().add(ChangeTabEvent(index));
                  },
                ),
              ),
              // 表格内容
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 任务列表（使用通用表格）
                    CommonDataGrid<OutTaskItem>(
                      columns: _collectionColumns(),
                      datas: state.detailList,
                      allowPager: false,
                      allowSelect: true,
                      currentPage: 1,
                      totalPages: 1,
                      onLoadData: (_) async {},
                      headerHeight: 44,
                      rowHeight: 48,
                      selectedRows: _selectedIndicesFor(state.detailList, state.checkedIds),
                      onSelectionChanged: (indices) {
                        _onGridSelectionChanged(indices, state.detailList);
                      },
                    ),
                    // 正在采集（使用通用表格，不显示选择列）
                    CommonDataGrid<OutTaskItem>(
                      columns: _collectionColumns(),
                      datas: state.collectionList,
                      allowPager: false,
                      allowSelect: false,
                      currentPage: 1,
                      totalPages: 1,
                      onLoadData: (_) async {},
                      headerHeight: 44,
                      rowHeight: 48,
                      selectedRows: const [],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomButtons(context),
    );
  }

  // 表格列定义：与原 DataTable 列一致
  List<GridColumnConfig<OutTaskItem>> _collectionColumns() {
    return [
      GridColumnConfig<OutTaskItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (r) => r.matcode ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'storesiteno',
        headerText: '库位',
        valueGetter: (r) => r.storesiteno ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'hintqty',
        headerText: '任务数量',
        valueGetter: (r) => r.hintqty,
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'collectedqty',
        headerText: '采集数量',
        valueGetter: (r) => r.collectedqty,
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'repqty',
        headerText: '结余库存',
        valueGetter: (r) => r.repqty,
        textStyle: const TextStyle(color: Colors.blue),
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'hintbatchno',
        headerText: '批次',
        valueGetter: (r) => r.hintbatchno ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (r) => r.sn ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'storeroomno',
        headerText: '库房',
        valueGetter: (r) => r.storeroomno ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'subinventoryCode',
        headerText: '子库',
        valueGetter: (r) => r.subinventoryCode ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'matname',
        headerText: '物料名称',
        valueGetter: (r) => r.matname ?? '',
      ),
    ];
  }

  // 由选中ID映射为当前列表中的行索引
  List<int> _selectedIndicesFor(List<OutTaskItem> items, List<String> checkedIds) {
    final idSet = checkedIds.toSet();
    final indices = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (idSet.contains(items[i].outtaskitemid.toString())) {
        indices.add(i);
      }
    }
    return indices;
  }

  // 将网格返回的索引集合映射到事件（与 checkedIds 做差异，同步到 Bloc）
  void _onGridSelectionChanged(List<int> indices, List<OutTaskItem> items) {
    final bloc = Modular.get<CollectionBloc>();
    final current = bloc.state.checkedIds.toSet();
    final next = indices
        .map((i) => items[i].outtaskitemid.toString())
        .toSet();

    // 需要新增选中的
    for (final id in next.difference(current)) {
      bloc.add(ToggleItemSelectionEvent(id, true));
    }
    // 需要取消选中的
    for (final id in current.difference(next)) {
      bloc.add(ToggleItemSelectionEvent(id, false));
    }
  }

  // 扫描输入（示例风格）
  Widget _buildScanInput() {
    return Container(
      height: 44,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: const BoxDecoration(color: Colors.white),
      child: TextField(
        onSubmitted: (value) {
          Modular.get<CollectionBloc>().add(PerformBarcodeEvent(value));
        },
        decoration: InputDecoration(
          hintText: '请扫描或输入库位/物料',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  // 信息卡片（示例风格）
  Widget _buildInfoCard(CollectionState state) {
    final matCode = state.matCode.isNotEmpty
        ? state.matCode
        : (state.currentBarcode?.matcode ?? '');
    final batchNo = state.batchNo.isNotEmpty
        ? state.batchNo
        : (state.currentBarcode?.batchno ?? '');
    final sn = state.sn.isNotEmpty
        ? state.sn
        : (state.currentBarcode?.sn ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildInfoRow('库位：', state.storeSite, '库存：', '${state.repQty}'),
          _buildDottedDivider(),
          _buildInfoRow('采集数量：', '${state.collectQty}', '物料：', matCode),
          _buildDottedDivider(),
          _buildInfoRow('批次：', batchNo, '序列：', sn),
          _buildDottedDivider(),
          _buildInfoRow('名称：', state.currentBarcode?.matname ?? '', '', ''),
        ],
      ),
    );
  }

  // 底部按钮（示例风格）
  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: const BoxDecoration(color: Colors.white),
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // 可跳转采集结果页，或弹出结果对话框
              },
              style: _buildOutlinedButtonStyle(),
              child: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showCommitConfirmation(context),
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
      foregroundColor: const Color(0xFF1976D2),
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Color(0xFF1976D2)),
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

  // 信息行 + 点状分割线
  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    const infoStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 10,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(label1, style: infoStyle),
                Text(value1, style: infoStyle),
              ],
            ),
          ),
          if (label2.isNotEmpty)
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Text(label2, style: infoStyle),
                  Text(value2, style: infoStyle),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF0067FC)),
              ),
            );
          }),
        );
      },
    );
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // 采集结果 - 可以导航到采集结果页面
        break;
      case 1:
        _showCommitConfirmation(context);
        break;
      case 2:
        _showMoreOptions(context);
        break;
    }
  }

  void _showCommitConfirmation(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isEmpty) {
      _showErrorDialog(context, '本次无采集明细，请确认！');
      return;
    }

    // 检查未完成任务
    String msg = '';
    for (final item in state.detailList) {
      if (item.hintqty != item.collectedqty) {
        msg =
            '库位【${item.storesiteno}】物料【${item.matcode}】还剩【${item.hintqty - item.collectedqty}】未做，请确认是否提交？';
        break;
      }
    }

    if (msg.isEmpty) {
      msg = '请确认是否提交？';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交确认'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Modular.get<CollectionBloc>().add(CommitCollectionEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('异常采集'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'exception');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('报缺'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'shortage');
            },
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'exception':
        // 导航到异常采集页面
        Modular.to.pushNamed('/exception');
        break;
      case 'shortage':
        _handleShortageAction(context);
        break;
    }
  }

  void _handleShortageAction(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isNotEmpty) {
      _showErrorDialog(context, '采集数据未提交,不允许报缺！');
      return;
    }

    if (state.checkedIds.isEmpty) {
      _showErrorDialog(context, '请至少选择一行记录！');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('物料报缺'),
        content: const Text('请确认是否该采集明细物料报缺？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Modular.get<CollectionBloc>().add(ReportShortageEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    final state = Modular.get<CollectionBloc>().state;

    if (state.stocks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交 确定退出采集吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Modular.to.pop();
              },
              child: const Text('确认'),
            ),
          ],
        ),
      );
    } else {
      Modular.to.pop();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {

    LoadingDialogManager.instance.showErrorDialog(context, message);

    return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('平库出库采集异常'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }
}
