import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_event.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/services/user_manager.dart';
import 'package:wms_app/utils/custom_extension.dart';
import 'bloc/collection_bloc.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/modules/outbound/collection_task/outbound_collection_result_page.dart';
import 'package:wms_app/modules/outbound/collection_task/models/deleted_payload.dart';
import 'package:wms_app/modules/outbound/exception_collection/models/exception_collection_args.dart';

class OutboundCollectionPage extends StatefulWidget {
  final OutboundTask task;

  const OutboundCollectionPage({super.key, required this.task});

  @override
  State<OutboundCollectionPage> createState() => _OutboundCollectionPageState();
}

class _OutboundCollectionPageState extends State<OutboundCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<CollectionBloc>(context);

    _tabController = TabController(length: 2, vsync: this);
    final userInfo = Modular.get<UserManager>().userInfo;
    _bloc.add(InitializeTaskEvent(widget.task, userInfo!.userId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool canPop() {
    final state = _bloc.state;
    return state.stocks.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop(),

      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress(context);
      },
      child: Scaffold(
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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => _showMoreOptions(context),
              child: const Text(
                '更多',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        body: BlocConsumer<CollectionBloc, CollectionState>(
          listener: (context, state) {
            debugPrint('------ listener state changed-----------');
            debugPrint('------ isLoading: ${state.isLoading}');
            LoadingDialogManager.instance.hideLoadingDialog(context);
            if (state.error != null) {
              _showErrorDialog(context, state.error!);
              _bloc.add(ClearErrorEvent());
            } else if (state.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            }

            if (state.currentTab != _tabController.index) {
              _tabController.index = state.currentTab;
            }
            if (state.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else {
              LoadingDialogManager.instance.hideLoadingDialog(context);
            }

            if (state.focus) {
              _scannerController.requestFocus();
              _bloc.add(SetFocusEvent(false));
            }

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                // 输入框（示例风格）
                _buildScanInput(state.placeholder),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(text: '任务列表'),
                      Tab(text: '正在采集'),
                    ],
                    onTap: (index) {
                      _bloc.add(ChangeTabEvent(index));
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
                        selectedRows: _selectedIndicesFor(
                          state.detailList,
                          state.checkedIds,
                        ),
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
      ),
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
        name: 'orderno',
        headerText: '出库单号',
        valueGetter: (r) => r.orderno ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'matname',
        headerText: '物料名称',
        valueGetter: (r) => r.matname ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'matinnercode',
        headerText: '物料旧编码',
        valueGetter: (r) => r.matinnercode ?? '',
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'outtaskitemid',
        headerText: '任务id',
        valueGetter: (r) => r.outtaskitemid.toString(),
      ),
      GridColumnConfig<OutTaskItem>(
        name: 'taskindex',
        headerText: '任务序号',
        valueGetter: (r) {
          final index = _bloc.state.detailList.indexWhere((item) {
            return item.outtaskitemid == r.outtaskitemid;
          });
          return (index + 1);
        },
      ),
    ];
  }

  // 由选中ID映射为当前列表中的行索引
  List<int> _selectedIndicesFor(
    List<OutTaskItem> items,
    List<String> checkedIds,
  ) {
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
    final bloc = _bloc;
    // final current = bloc.state.checkedIds.toSet();
    final next = indices.map((i) => items[i].outtaskitemid.toString()).toSet();

    bloc.add(ChangedSelectionEvent(next.toList()));

    // 需要新增选中的
    // for (final id in next.difference(current)) {
    //   bloc.add(ToggleItemSelectionEvent(id, true));
    // }
    // // 需要取消选中的
    // for (final id in current.difference(next)) {
    //   bloc.add(ToggleItemSelectionEvent(id, false));
    // }
  }

  // 扫描输入（使用通用扫描组件）
  Widget _buildScanInput(String placeholder) {
    final config = ScannerConfig().copyWith(
      placeholder: placeholder,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      height: 48,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (code) {
        _bloc.add(PerformBarcodeEvent(code));
      },
      onError: (message) {
        _showErrorDialog(context, message);
      },
    );
  }

  // 信息卡片（示例风格）
  Widget _buildInfoCard(CollectionState state) {
    debugPrint('-------------- ${state.currentBarcode} ------------------');

    final matCode = (state.currentBarcode?.matcode ?? '');
    final batchNo = (state.currentBarcode?.batchno ?? '');
    final sn = (state.currentBarcode?.sn ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            '库位：',
            state.storeSite,
            '库存：',
            state.repQty.toFormatString(),
          ),
          _buildDottedDivider(),
          _buildInfoRow(
            '采集数量：',
            state.collectQty == 0 ? '' : state.collectQty.toFormatString(),
            '物料：',
            matCode,
          ),
          _buildDottedDivider(),
          if (sn.isNotEmpty) _buildInfoRow('序列：', sn, '', ''),
          if (sn.isEmpty) _buildInfoRow('批次：', batchNo, '', ''),
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
              onPressed: () async {
                // 传入当前 stocks 的只读快照，结果页独立管理与删除
                final initStocks = List<CollectionStock>.from(
                  _bloc.state.stocks,
                );
                final res = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        OutboundCollectionResultPage(initialStocks: initStocks),
                  ),
                );
                if (!mounted) return;
                if (res is DeletedStocksPayload &&
                    res.deletedStocks.isNotEmpty) {
                  _bloc.add(UpdateFromResultEvent(res.deletedStocks));
                  LoadingDialogManager.instance.showSnackSuccessMsg(
                    context,
                    '删除成功',
                    duration: const Duration(milliseconds: 800),
                  );
                }
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
    const infoStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
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

  void _showCommitConfirmation(BuildContext context) {
    final state = _bloc.state;

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
              _bloc.add(CommitCollectionEvent());
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
        Modular.to.pushNamed(
          '/outbound/exception',
          arguments: ExceptionCollectionArgs(
            task: widget.task,
            trayNo: '',
            storeSite: _bloc.state.storeSite,
          ),
        );
        break;
      case 'shortage':
        _handleShortageAction(context);
        break;
    }
  }

  void _handleShortageAction(BuildContext context) {
    final state = _bloc.state;

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
              _bloc.add(ReportShortageEvent());
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    final state = _bloc.state;

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
  }
}
