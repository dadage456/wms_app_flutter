import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../common_widgets/scanner_widget/scanner_config.dart';
import '../../../common_widgets/scanner_widget/scanner_widget.dart';
import '../../../utils/custom_extension.dart';
import 'bloc/transfer_collection_bloc.dart';
import 'bloc/transfer_collection_event.dart';
import 'bloc/transfer_collection_state.dart';
import 'models/transfer_collection_models.dart';

class TransferCollectionPage extends StatefulWidget {
  const TransferCollectionPage({
    super.key,
    this.initialStoreRoom = '',
    this.initialErpStore = '',
  });

  final String initialStoreRoom;
  final String initialErpStore;

  @override
  State<TransferCollectionPage> createState() => _TransferCollectionPageState();
}

class _TransferCollectionPageState extends State<TransferCollectionPage>
    with SingleTickerProviderStateMixin {
  late TransferCollectionBloc _bloc;
  late TabController _tabController;
  final ScannerController _scannerController = ScannerController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<TransferCollectionBloc>(context);
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(
        TransferStarted(
          storeRoom: widget.initialStoreRoom,
          erpStoreRoom: widget.initialErpStore,
        ),
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canPop() => _bloc.state.collectedItems.isEmpty;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _handleBackPress(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => _handleBackPress(context),
          ),
          title: const Text(
            '平库移库采集',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocConsumer<TransferCollectionBloc, TransferCollectionState>(
          listener: (context, state) {
            final status = state.status;
            final submitStatus = state.submitStatus;
            final isLoading = status.isLoading || submitStatus.isLoading;
            if (isLoading) {
              LoadingDialogManager.instance.showLoadingDialog(context);
            } else {
              LoadingDialogManager.instance.hideLoadingDialog(context);
            }

            if (status.isError && status.message != null) {
              LoadingDialogManager.instance
                  .showErrorDialog(context, status.message!);
              _bloc.add(const TransferStatusCleared());
            } else if (status.isSuccess && status.message != null) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                status.message!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const TransferStatusCleared());
            }

            if (submitStatus.isError && submitStatus.message != null) {
              LoadingDialogManager.instance
                  .showErrorDialog(context, submitStatus.message!);
              _bloc.add(const TransferStatusCleared());
            } else if (submitStatus.isSuccess && submitStatus.message != null) {
              LoadingDialogManager.instance.showSnackSuccessMsg(
                context,
                submitStatus.message!,
                duration: const Duration(milliseconds: 800),
              );
              _bloc.add(const TransferStatusCleared());
            }

            final tabIndex = state.activeTab.index;
            if (_tabController.index != tabIndex) {
              _tabController.index = tabIndex;
            }

            if (state.context.focus) {
              _scannerController.requestFocus();
              _bloc.add(const TransferFocusRequested(false));
            }

            _scannerController.clear();
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildScanInput(state.context.placeholder),
                _buildInfoCard(state),
                Container(
                  color: Colors.white,
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
                      Tab(text: '采集列表'),
                      Tab(text: '库存查询'),
                    ],
                    onTap: (index) =>
                        _bloc.add(TransferTabChanged(index)),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildCollectionGrid(state),
                      _buildInventoryGrid(state),
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

  void _handleBackPress(BuildContext context) {
    if (_bloc.state.collectedItems.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('提示'),
        content: const Text('当前存在未提交的采集记录，确认离开吗？'),
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
  }

  Widget _buildScanInput(String placeholder) {
    final config = ScannerConfig().copyWith(
      placeholder: placeholder,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      height: 56,
      keyboardType: TextInputType.text,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (code) {
        _bloc.add(ScanInputSubmitted(input: code));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildInfoCard(TransferCollectionState state) {
    final context = state.context;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _infoRow('库房', context.storeRoom, '子库', context.erpStoreRoom),
          _divider(),
          _infoRow('来源库位', context.sourceSite, '目标库位', context.targetSite),
          _divider(),
          _infoRow('物料', context.materialCode, '模式', context.mode.label),
          _divider(),
          _infoRow('批次', context.batchNo, '序列', context.serialNo),
          _divider(),
          _infoRow('供应商', context.supplier, '项目号', context.projectNumber),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _bloc.add(const InventoryQueryRequested());
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('库存查询'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 12, color: Color(0xFFE0E6ED));

  Widget _infoRow(String leftLabel, String leftValue, String rightLabel, String rightValue) {
    return Row(
      children: [
        Expanded(
          child: _infoCell(leftLabel, leftValue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _infoCell(rightLabel, rightValue),
        ),
      ],
    );
  }

  Widget _infoCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? '--' : value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget _buildCollectionGrid(TransferCollectionState state) {
    final columns = _collectionColumns();
    final selectedIndices = _selectedIndices(state.collectedItems, state.selectedIds);
    return CommonDataGrid<TransferCollectedItem>(
      columns: columns,
      datas: state.collectedItems,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: selectedIndices,
      onSelectionChanged: (indices) =>
          _onCollectionSelectionChanged(indices, state.collectedItems),
    );
  }

  Widget _buildInventoryGrid(TransferCollectionState state) {
    return CommonDataGrid<TransferInventoryRow>(
      columns: _inventoryColumns(),
      datas: state.inventoryRows,
      allowPager: false,
      allowSelect: false,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: const [],
    );
  }

  List<GridColumnConfig<TransferCollectedItem>> _collectionColumns() {
    return [
      GridColumnConfig(
        name: 'sourceSite',
        headerText: '来源库位',
        valueGetter: (row) => row.sourceSite,
        width: 160,
      ),
      GridColumnConfig(
        name: 'targetSite',
        headerText: '目标库位',
        valueGetter: (row) => row.targetSite,
        width: 160,
      ),
      GridColumnConfig(
        name: 'material',
        headerText: '物料',
        valueGetter: (row) => row.materialCode,
        width: 160,
      ),
      GridColumnConfig(
        name: 'batch',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'serial',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'qty',
        headerText: '数量',
        valueGetter: (row) => row.quantity.toFormatString(),
        textAlign: TextAlign.right,
        width: 100,
      ),
      GridColumnConfig(
        name: 'supplier',
        headerText: '供应商',
        valueGetter: (row) => row.supplier ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'erpRoom',
        headerText: '子库',
        valueGetter: (row) => row.erpRoom ?? '',
        width: 120,
      ),
      GridColumnConfig(
        name: 'project',
        headerText: '项目号',
        valueGetter: (row) => row.projectNumber ?? '',
        width: 140,
      ),
    ];
  }

  List<GridColumnConfig<TransferInventoryRow>> _inventoryColumns() {
    return [
      GridColumnConfig(
        name: 'material',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
        width: 160,
      ),
      GridColumnConfig(
        name: 'qty',
        headerText: '数量',
        valueGetter: (row) => row.quantity.toFormatString(),
        textAlign: TextAlign.right,
        width: 100,
      ),
      GridColumnConfig(
        name: 'batch',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'project',
        headerText: '项目号',
        valueGetter: (row) => row.projectNumber ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'storeSite',
        headerText: '库位',
        valueGetter: (row) => row.storeSiteNo,
        width: 140,
      ),
      GridColumnConfig(
        name: 'erpRoom',
        headerText: '子库',
        valueGetter: (row) => row.erpStoreRoom ?? '',
        width: 120,
      ),
      GridColumnConfig(
        name: 'pallet',
        headerText: '托盘',
        valueGetter: (row) => row.palletNo ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'serial',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
        width: 140,
      ),
      GridColumnConfig(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoomName ?? '',
        width: 120,
      ),
    ];
  }

  void _onCollectionSelectionChanged(
    List<int> indices,
    List<TransferCollectedItem> items,
  ) {
    final newSelection = <String>{};
    for (final index in indices) {
      if (index >= 0 && index < items.length) {
        newSelection.add(items[index].id);
      }
    }

    final currentSelection = _bloc.state.selectedIds;
    for (final id in currentSelection.difference(newSelection)) {
      _bloc.add(CollectedItemChecked(itemId: id, checked: false));
    }
    for (final id in newSelection.difference(currentSelection)) {
      _bloc.add(CollectedItemChecked(itemId: id, checked: true));
    }
  }

  List<int> _selectedIndices(
    List<TransferCollectedItem> items,
    Set<String> selectedIds,
  ) {
    final indices = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (selectedIds.contains(items[i].id)) {
        indices.add(i);
      }
    }
    return indices;
  }

  Widget _buildBottomBar(BuildContext context) {
    final hasSelection = _bloc.state.selectedIds.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showModeSelector(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2563EB),
                side: const BorderSide(color: Color(0xFF2563EB)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.swap_horiz),
                  SizedBox(width: 6),
                  Text('操作模式'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: hasSelection ? () => _confirmDelete(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF97316),
                foregroundColor: Colors.white,
              ),
              child: const Text('删除'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _confirmSubmit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                foregroundColor: Colors.white,
              ),
              child: const Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showModeSelector(BuildContext context) async {
    final result = await showModalBottomSheet<TransferMode>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: TransferMode.values
              .map(
                (mode) => ListTile(
                  title: Text(mode.label),
                  onTap: () => Navigator.of(sheetContext).pop(mode),
                ),
              )
              .toList(),
        ),
      ),
    );

    if (result != null) {
      _bloc.add(TransferModeToggled(result));
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('删除确认'),
        content: const Text('确定删除选中的采集明细吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _bloc.add(const CollectedItemsDeleted());
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _confirmSubmit(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('提交确认'),
        content: const Text('是否提交当前采集记录？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _bloc.add(const TransferSubmitRequested());
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
