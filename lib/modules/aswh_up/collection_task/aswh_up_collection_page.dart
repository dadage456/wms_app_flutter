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
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '立库组盘采集',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (task.inTaskNo.isNotEmpty)
                Text(
                  '任务号：${task.inTaskNo}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
            ],
          ),
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
                final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('更换托盘确认'),
                          content: Text(
                              '更换托盘将清空当前采集记录，是否切换至托盘 ${state.pendingTrayNo}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(dialogContext).pop(false),
                              child: const Text('取消'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(dialogContext).pop(true),
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
                  height: 44,
                  decoration: const BoxDecoration(color: Colors.white),
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
                    children: [_buildDetailGrid(state), _buildStockGrid(state)],
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: ScannerWidget(
        controller: _scannerController,
        config: ScannerConfig(placeholder: placeholder),
        onScanResult: (String value) {
          _bloc.add(AswhUpPerformScanEvent(value));
        },
      ),
    );
  }

  Widget _buildInfoCard(AswhUpCollectionState state) {
    final barcode = state.currentBarcode;
    final item = state.currentItem;
    final materialCode = barcode?.materialCode ?? item?.materialCode ?? '';
    final materialName = barcode?.materialName ?? item?.materialName ?? '';
    final batch = barcode?.batchNo ?? item?.batchNo ?? '';
    final serial = barcode?.serialNo ?? item?.serialNo ?? '';
    final subInventory = item?.subInventoryCode ?? '';
    final storeRoom = item?.storeRoomNo ?? state.task.storeRoomNo ?? '';
    final erpStore = barcode?.erpStore ?? item?.erpStore ?? '';

    double? collectedQty;
    final itemId = item?.inTaskItemId;
    if (itemId != null) {
      collectedQty = state.collectedByItem[itemId] ?? item?.collectedQty;
    }
    final collectedText =
        (collectedQty == null || collectedQty == 0) ? '' : collectedQty.toFormatString();

    final unitCapacityText = state.currentMaterialCapacity <= 0
        ? ''
        : state.currentMaterialCapacity.toFormatString();
    final unitWeightText = state.currentMaterialWeight <= 0
        ? ''
        : state.currentMaterialWeight.toFormatString();

    final batchLabel = serial.isNotEmpty ? '序列：' : '批次：';
    final batchValue = serial.isNotEmpty ? serial : batch;

    final trayNo = state.trayNo.isEmpty ? '-' : state.trayNo;
    final storeSite = state.storeSite.isEmpty ? '-' : state.storeSite;
    final capacityText =
        '${state.trayUsed.toFormatString()} / ${state.trayCapacity.toFormatString()}';
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

    addSectionIf(true, '托盘：', trayNo, '库位：', storeSite);
    addSectionIf(true, '容量：', capacityText, '重量：', weightText);
    addSectionIf(true, '物料：', materialCode, '名称：', materialName);
    addSectionIf(
      collectedText.isNotEmpty || subInventory.isNotEmpty,
      '采集数量：',
      collectedText,
      '子库：',
      subInventory,
    );
    addSectionIf(
      batchValue.isNotEmpty || storeRoom.isNotEmpty,
      batchLabel,
      batchValue,
      '库房：',
      storeRoom,
    );
    addSectionIf(
      erpStore.isNotEmpty || unitCapacityText.isNotEmpty,
      'ERP库：',
      erpStore,
      '单位容量：',
      unitCapacityText,
    );
    addSectionIf(
      unitWeightText.isNotEmpty,
      '单位重量：',
      unitWeightText,
      '',
      '',
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFF1976D2)),
                ),
              );
            }),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: _buildInfoCell(label1, value1)),
          if (label2.isNotEmpty || value2.isNotEmpty)
            Expanded(child: _buildInfoCell(label2, value2)),
        ],
      ),
    );
  }

  Widget _buildInfoCell(String label, String value) {
    const labelStyle = TextStyle(fontSize: 13, color: Color(0xFF666666));
    const valueStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF333333),
    );
    final displayValue = value.isEmpty ? '-' : value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          height: 12,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1976D2),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(label, style: labelStyle),
        Expanded(
          child: Text(
            displayValue,
            style: valueStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailGrid(AswhUpCollectionState state) {
    final columns = _detailColumns();
    final selected = _selectedIndicesFor(
      state.visibleDetails,
      state.selectedDetailIds,
    );

    return CommonDataGrid<AswhUpTaskDetailItem>(
      columns: columns,
      datas: state.visibleDetails,
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

  Widget _buildStockGrid(AswhUpCollectionState state) {
    return CommonDataGrid<AswhUpCollectionStock>(
      columns: _stockColumns(),
      datas: state.stocks,
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
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text('采集结果'),
              onPressed: state.stocks.isEmpty ? null : _openResultPage,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('组盘提交'),
              onPressed: state.stocks.isEmpty
                  ? null
                  : () => _bloc.add(const AswhUpSubmitEvent()),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.more_horiz),
              label: const Text('更多'),
              onPressed: () => _showMoreOptions(context),
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

  List<GridColumnConfig<AswhUpCollectionStock>> _stockColumns() {
    return [
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'trayNo',
        headerText: '托盘号',
        valueGetter: (row) => row.trayNo,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'matCode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'matName',
        headerText: '物料名称',
        valueGetter: (row) => row.materialName ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectQty.toFormatString(),
        textAlign: TextAlign.right,
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'batch',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'serial',
        headerText: '序列号',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSite ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoom ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'erpStore',
        headerText: 'ERP库',
        valueGetter: (row) => row.erpStore ?? '',
      ),
      GridColumnConfig<AswhUpCollectionStock>(
        name: 'supplier',
        headerText: '供应商',
        valueGetter: (row) => row.supplierName ?? '',
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
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text('采集数据未提交,不允许托盘上架！'),
                      ),
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
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text('采集数据未提交,不允许查看指令！'),
                      ),
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
              ListTile(
                leading: const Icon(Icons.delete_sweep_outlined),
                title: const Text('清除缓存'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _bloc.add(const AswhUpClearCacheEvent());
                },
              ),
            ],
          ),
        );
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
}
