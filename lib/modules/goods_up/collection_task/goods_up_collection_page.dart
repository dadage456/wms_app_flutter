import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../../../services/user_manager.dart';
import '../../../utils/custom_extension.dart';
import 'bloc/inbound_collection_bloc.dart';
import 'bloc/inbound_collection_event.dart';
import 'bloc/inbound_collection_state.dart';
import 'models/inbound_collection_models.dart';
import 'models/inbound_deleted_payload.dart';
import '../task_list/models/goods_up_task.dart';

class GoodsUpCollectionPage extends StatefulWidget {
  const GoodsUpCollectionPage({super.key, required this.task});

  final GoodsUpTask task;

  @override
  State<GoodsUpCollectionPage> createState() => _GoodsUpCollectionPageState();
}

class _GoodsUpCollectionPageState extends State<GoodsUpCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late InboundCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<InboundCollectionBloc>(context);
    _tabController = TabController(length: 2, vsync: this);

    final userInfo = Modular.get<UserManager>().userInfo;
    if (userInfo != null) {
      _bloc.add(
        InitializeInboundCollectionEvent(
          task: widget.task,
          userId: userInfo.userId,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canPop() {
    final state = _bloc.state;
    return state.stocks.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
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
            '平库上架采集',
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
        body: BlocConsumer<InboundCollectionBloc, InboundCollectionState>(
          listener: (context, state) {
            LoadingDialogManager.instance.hideLoadingDialog(context);

            if (state.status.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else if (state.status.isError) {
              LoadingDialogManager.instance.showErrorDialog(
                context,
                state.status.message ?? '操作失败',
              );
              _bloc.add(const ResetInboundStatusEvent());
            } else if (state.status.isSuccess &&
                state.status.message != null) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                state.status.message!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const ResetInboundStatusEvent());
            }

            if (state.currentTab != _tabController.index) {
              _tabController.index = state.currentTab;
            }

            if (state.focus) {
              _scannerController.requestFocus();
              _bloc.add(const RequestInboundFocusEvent(false));
            }

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildScanInput(state.placeholder),
                _buildInfoCard(state),
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
                    onTap: (index) =>
                        _bloc.add(ChangeInboundTabEvent(index)),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      CommonDataGrid<InboundCollectTaskItem>(
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
                        onSelectionChanged: (indices) =>
                            _onGridSelectionChanged(indices, state.detailList),
                      ),
                      CommonDataGrid<InboundCollectTaskItem>(
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

  void _handleBackPress(BuildContext context) {
    if (_bloc.state.stocks.isNotEmpty) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前有未提交的采集记录，确定要退出吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete_sweep_outlined),
                title: const Text('清空本地缓存'),
                onTap: () {
                  Navigator.of(context).pop();
                  _bloc.add(const ClearInboundCacheEvent());
                  LoadingDialogManager.instance.showSnackSuccessMsg(
                    context,
                    '缓存清理完成',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
        _bloc.add(PerformInboundScanEvent(code));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildInfoCard(InboundCollectionState state) {
    final barcode = state.currentBarcode;
    final material = barcode?.materialCode ?? state.currentItem?.materialCode;
    final batchNo = barcode?.batchNo ?? state.currentItem?.batchNo;
    final serial = barcode?.serialNo ?? state.currentItem?.serialNo;
    final productionDate =
        barcode?.productionDate ?? state.currentItem?.productionDate ?? '';
    final expireDays = barcode?.expireDays ?? state.currentItem?.expireDays;

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
            material ?? '',
          ),
          _buildDottedDivider(),
          if ((serial ?? '').isNotEmpty)
            _buildInfoRow('序列：', serial ?? '', '', '')
          else
            _buildInfoRow('批次：', batchNo ?? '', '', ''),
          _buildDottedDivider(),
          _buildInfoRow(
            '生产日期：',
            productionDate,
            '有效期(天)：',
            expireDays == null ? '' : expireDays.toString(),
          ),
          _buildDottedDivider(),
          _buildInfoRow('名称：', barcode?.materialName ?? '', '', ''),
        ],
      ),
    );
  }

  Widget _buildDottedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashSpace = 3.0;
        final dashCount = (width / (dashWidth + dashSpace)).floor();
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

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final stocks = _bloc.state.stocks;
                if (stocks.isEmpty) {
                  LoadingDialogManager.instance.showErrorDialog(
                    context,
                    '暂无采集记录',
                  );
                  return;
                }
                final res = await Modular.to.pushNamed(
                  '/goods-up/collect/result',
                  arguments: {'stocks': stocks},
                );
                if (res is InboundDeletedStocksPayload &&
                    res.deletedStocks.isNotEmpty) {
                  _bloc.add(UpdateInboundFromResultEvent(res.deletedStocks));
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1976D2),
                side: const BorderSide(color: Color(0xFF1976D2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('采集结果'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showCommitConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  void _showCommitConfirmation(BuildContext context) {
    final state = _bloc.state;
    if (state.stocks.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(
        context,
        '暂无采集数据',
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('提交确认'),
        content: const Text('是否确认提交当前采集数据？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _bloc.add(const CommitInboundCollectionEvent());
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  List<GridColumnConfig<InboundCollectTaskItem>> _collectionColumns() {
    return [
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'storesiteno',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'qty',
        headerText: '任务数量',
        valueGetter: (row) => row.planQty,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'collectedqty',
        headerText: '已采集',
        valueGetter: (row) => row.collectedQty,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'repqty',
        headerText: '库存数量',
        valueGetter: (row) => row.repertoryQty,
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'subinventoryCode',
        headerText: '子库',
        valueGetter: (row) => row.subInventoryCode ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'unit',
        headerText: '单位',
        valueGetter: (row) => row.unit ?? '',
      ),
      GridColumnConfig<InboundCollectTaskItem>(
        name: 'index',
        headerText: '序号',
        valueGetter: (row) {
          final index = _bloc.state.detailList.indexWhere(
            (element) => element.inTaskItemId == row.inTaskItemId,
          );
          return index + 1;
        },
      ),
    ];
  }

  List<int> _selectedIndicesFor(
    List<InboundCollectTaskItem> items,
    List<int> checkedIds,
  ) {
    final ids = checkedIds.toSet();
    final result = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (ids.contains(items[i].inTaskItemId)) {
        result.add(i);
      }
    }
    return result;
  }

  void _onGridSelectionChanged(
    List<int> indices,
    List<InboundCollectTaskItem> items,
  ) {
    final ids = indices
        .where((i) => i >= 0 && i < items.length)
        .map((i) => items[i].inTaskItemId)
        .toList();
    _bloc.add(UpdateInboundSelectionEvent(ids));
  }
}
