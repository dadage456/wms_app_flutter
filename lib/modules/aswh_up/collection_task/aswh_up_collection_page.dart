import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/modules/aswh_up/task_details/models/aswh_up_task_detail_item.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../../../services/user_manager.dart';
import '../../../utils/custom_extension.dart';
import 'bloc/aswh_up_collection_bloc.dart';
import '../models/aswh_up_collection_models.dart';

class AswhUpCollectionPage extends StatefulWidget {
  const AswhUpCollectionPage({super.key});

  @override
  State<AswhUpCollectionPage> createState() => _AswhUpCollectionPageState();
}

class _AswhUpCollectionPageState extends State<AswhUpCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AswhUpCollectionBloc _bloc;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AswhUpCollectionBloc>(context);
    _tabController = TabController(length: 2, vsync: this);

    final userInfo = Modular.get<UserManager>().userInfo;
    if (userInfo != null) {
      _bloc.add(InitializeAswhUpCollectionEvent(userId: userInfo.userId));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canPop() {
    return _bloc.state.stocks.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final task = _bloc.state.task;
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
            '立库组盘采集',
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
        body: BlocConsumer<AswhUpCollectionBloc, AswhUpCollectionState>(
          listener: (context, state) {
            LoadingDialogManager.instance.hideLoadingDialog(context);

            if (state.status.isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else if (state.status.isError) {
              LoadingDialogManager.instance.showErrorDialog(
                context,
                state.status.message ?? '操作失败',
              );
              _bloc.add(const AswhUpResetStatusEvent());
            } else if (state.status.isSuccess &&
                state.status.message?.isNotEmpty == true) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                state.status.message!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const AswhUpResetStatusEvent());
            }

            if (state.message?.isNotEmpty == true) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message!)));
            }

            if (state.currentTab != _tabController.index) {
              _tabController.index = state.currentTab;
            }

            if (state.focus) {
              _scannerController.requestFocus();
              _bloc.add(const AswhUpRequestFocusEvent(false));
            }

            if (state.showTrayChangeDialog && state.pendingTrayNo != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                final confirmed =
                    await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('更换托盘确认'),
                          content: Text(
                            '更换托盘将清空当前采集记录，是否切换至托盘 ${state.pendingTrayNo}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                              child: const Text('取消'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(true),
                              child: const Text('确认'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;

                _bloc.add(AswhUpConfirmTrayChangeEvent(confirmed: confirmed));
              });
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
                    controller: _tabController,
                    dividerHeight: 0,
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
                    onTap: (index) => _bloc.add(AswhUpChangeTabEvent(index)),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDetailGrid(state),
                      _buildFiltedGrid(state),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildScanInput(String placeholder) {
    final config = ScannerConfig().copyWith(
      placeholder: placeholder,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      height: 48,
      keyboardType: TextInputType.number,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (code) {
        _bloc.add(AswhUpPerformScanEvent(code));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildInfoCard(AswhUpCollectionState state) {
    final barcode = state.currentBarcode;
    final materialCode = barcode?.materialCode;
    final materialName = barcode?.materialName;
    final batch = barcode?.batchNo;
    final serial = barcode?.serialNo;

    double? collectedQty;
    final item = state.currentItem;
    final itemId = item?.inTaskItemId;
    if (itemId != null) {
      collectedQty = state.collectedByItem[itemId] ?? item?.collectedQty;
    }
    final collectedText = (collectedQty == null || collectedQty == 0)
        ? ''
        : collectedQty.toFormatString();

    final unitCapacityText = state.currentMaterialCapacity <= 0
        ? ''
        : state.currentMaterialCapacity.toFormatString();
    final unitWeightText = state.currentMaterialWeight <= 0
        ? ''
        : state.currentMaterialWeight.toFormatString();

    final trayNo = state.trayNo.isEmpty ? '-' : state.trayNo;
    final capacityText = (state.trayCapacity - state.trayUsed).toFormatString();

    final weightText = state.trayMaxWeight > 0
        ? '${state.trayCurrentWeight.toFormatString()} / ${state.trayMaxWeight.toFormatString()}'
        : state.trayCurrentWeight.toFormatString();

    final sections = <Widget>[];
    void addSectionIf(
      bool condition,
      String label1,
      String value1,
      String label2,
      String value2,
    ) {
      if (!condition) return;
      if (sections.isNotEmpty) {
        sections.add(_buildDottedDivider());
      }
      sections.add(_buildInfoRow(label1, value1, label2, value2));
    }

    addSectionIf(true, '托盘：', trayNo, '剩余容量：', capacityText);
    addSectionIf(true, '物料：', materialCode ?? '', '采集数量：', collectedText);
    addSectionIf(true, '名称：', materialName ?? '', '批次：', batch ?? '');
    addSectionIf(true, '序列：', serial ?? '', '', '');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(children: sections),
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

  Widget _buildDetailGrid(AswhUpCollectionState state) {
    final columns = _detailColumns();
    final selected = _selectedIndicesFor(
      state.detailList,
      state.selectedDetailIds,
    );

    return CommonDataGrid<AswhUpTaskDetailItem>(
      columns: columns,
      datas: state.detailList,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: selected,
      onSelectionChanged: (indices) {
        final ids = indices
            .where((index) => index >= 0 && index < state.visibleDetails.length)
            .map((index) => state.visibleDetails[index].inTaskItemId)
            .toList();
        _bloc.add(AswhUpUpdateSelectionEvent(ids));
      },
    );
  }

  Widget _buildFiltedGrid(AswhUpCollectionState state) {
    final columns = _detailColumns();

    return CommonDataGrid<AswhUpTaskDetailItem>(
      columns: columns,
      datas: state.visibleDetails,
      allowPager: false,
      allowSelect: false,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final state = BlocProvider.of<AswhUpCollectionBloc>(context).state;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const BoxDecoration(color: Colors.white),
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: state.stocks.isEmpty ? null : _openResultPage,
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
              onPressed: state.stocks.isEmpty
                  ? null
                  : () => _bloc.add(const AswhUpSubmitEvent()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('组盘提交'),
            ),
          ),
        ],
      ),
    );
  }

  List<GridColumnConfig<AswhUpTaskDetailItem>> _detailColumns() {
    return [
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'matCode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'matName',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'subInventory',
        headerText: '子库',
        valueGetter: (row) => row.subInventoryCode ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoomNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (row) => row.planQty.toFormatString(),
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'collectedQty',
        headerText: '已采集',
        valueGetter: (row) => row.collectedQty.toFormatString(),
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'repQty',
        headerText: '库存数量',
        valueGetter: (row) => row.repertoryQty.toFormatString(),
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'batch',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'sn',
        headerText: '序列号',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<AswhUpTaskDetailItem>(
        name: 'inboundOrder',
        headerText: '入库单号',
        valueGetter: (row) => row.inboundOrderNo ?? '',
      ),
    ];
  }

  List<int> _selectedIndicesFor(
    List<AswhUpTaskDetailItem> items,
    List<int> selectedIds,
  ) {
    final indices = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (selectedIds.contains(items[i].inTaskItemId)) {
        indices.add(i);
      }
    }
    return indices;
  }

  Future<void> _openResultPage() async {
    final state = _bloc.state;
    final result = await Modular.to.pushNamed(
      '/aswh-up/collect/result',
      arguments: {'stocks': state.stocks},
    );
    if (result is List<AswhUpCollectionStock>) {
      _bloc.add(AswhUpUpdateFromResultEvent(result));
    }
  }

  void _handleException() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('异常处理暂未开放')));
  }

  void _handleQuerySubmit() {
    if (_bloc.state.stocks.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('采集数据未提交,不允许托盘上架！')));
      return;
    }
    final trayNo = _bloc.state.trayNo;
    if (trayNo.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先扫描托盘号')));
      return;
    }
    Modular.to.pushNamed(
      '/aswh-up/pallet-item',
      arguments: {'trayNo': trayNo, 'task': _bloc.state.task},
    );
  }

  void _handleQueryInstruction() {
    if (_bloc.state.stocks.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('采集数据未提交,不允许查看指令！')));
      return;
    }
    Modular.to.pushNamed(
      '/aswh-up/wcs-instruction',
      arguments: {
        'taskId': _bloc.state.task.inTaskId,
        'taskComment': _bloc.state.task.taskComment,
        'taskType': '00',
      },
    );
  }

  void _handleBackPress(BuildContext context) {
    if (_bloc.state.stocks.isEmpty) {
      Navigator.of(context).maybePop();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交，确定要退出吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.of(context).maybePop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.error_outline),
                title: const Text('异常处理'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('异常处理暂未开放')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory_2_outlined),
                title: const Text('查询提交'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  if (_bloc.state.stocks.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('采集数据未提交,不允许托盘上架！')),
                    );
                    return;
                  }
                  final trayNo = _bloc.state.trayNo;
                  if (trayNo.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('请先扫描托盘号')));
                    return;
                  }
                  Modular.to.pushNamed(
                    '/aswh-up/pallet-item',
                    arguments: {'trayNo': trayNo, 'task': _bloc.state.task},
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.sync_alt),
                title: const Text('查询指令'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  if (_bloc.state.stocks.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('采集数据未提交,不允许查看指令！')),
                    );
                    return;
                  }
                  Modular.to.pushNamed(
                    '/aswh-up/wcs-instruction',
                    arguments: {
                      'taskId': _bloc.state.task.inTaskId,
                      'taskComment': _bloc.state.task.taskComment,
                      'taskType': '00',
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.flight_takeoff_outlined),
                title: const Text('托盘上架'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _bloc.add(const AswhUpRaiseTrayEvent());
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.delete_sweep_outlined),
              //   title: const Text('清除缓存'),
              //   onTap: () {
              //     Navigator.pop(sheetContext);
              //     _bloc.add(const AswhUpClearCacheEvent());
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
