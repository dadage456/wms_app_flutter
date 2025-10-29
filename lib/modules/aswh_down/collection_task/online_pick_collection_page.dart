import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_bloc.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_event.dart';
import 'package:wms_app/modules/aswh_down/collection_task/bloc/online_pick_collection_state.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/collection_grid_config.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_item_models.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_task_models.dart';
import 'package:wms_app/utils/custom_extension.dart';

class OnlinePickCollectionPage extends StatefulWidget {
  const OnlinePickCollectionPage({super.key, required this.task});

  final OnlinePickTask task;

  @override
  State<OnlinePickCollectionPage> createState() =>
      _OnlinePickCollectionPageState();
}

class _OnlinePickCollectionPageState extends State<OnlinePickCollectionPage>
    with SingleTickerProviderStateMixin {
  static const List<OnlinePickCollectionMode> _availableModes = [
    OnlinePickCollectionMode(
      code: 'outbound',
      label: '正常出库',
      type: OnlinePickCollectionModeType.outbound,
    ),
    OnlinePickCollectionMode(
      code: 'inventory',
      label: '库存核对',
      type: OnlinePickCollectionModeType.inventory,
    ),
    OnlinePickCollectionMode(
      code: 'exception',
      label: '异常处理',
      type: OnlinePickCollectionModeType.exception,
    ),
  ];

  late final TabController _tabController;
  late final ScannerController _scannerController;
  late OnlinePickCollectionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scannerController = ScannerController();
    _tabController = TabController(length: 3, vsync: this);
    _bloc = BlocProvider.of<OnlinePickCollectionBloc>(context);
    _bloc.add(OnlinePickCollectionInitialized(widget.task));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canPop(OnlinePickCollectionState state) {
    return state.collectedStocks.isEmpty;
  }

  void _handleBack(OnlinePickCollectionState state) {
    if (_canPop(state)) {
      Modular.to.pop();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认退出'),
        content: const Text('存在未提交的采集数据，确认要返回吗？'),
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
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnlinePickCollectionBloc, OnlinePickCollectionState>(
      listener: (context, state) {
        LoadingDialogManager.instance.hideLoadingDialog(context);

        if (state.status.isLoading) {
          LoadingDialogManager.instance.showLoadingDialog(context);
        } else if (state.status.isError) {
          LoadingDialogManager.instance.showErrorDialog(
            context,
            state.status.message ?? '操作失败',
          );
          _bloc.add(const OnlinePickCollectionStatusResetRequested());
        } else if (state.status.isSuccess && state.status.message != null) {
          LoadingDialogManager.instance.showSnackSuccessMsg(
            context,
            state.status.message!,
            duration: const Duration(milliseconds: 800),
          );
          _bloc.add(const OnlinePickCollectionStatusResetRequested());
        }

        if (state.currentTab != _tabController.index) {
          _tabController.index = state.currentTab;
        }

        if (state.isScannerFocused) {
          _scannerController.requestFocus();
          _bloc.add(const OnlinePickCollectionFocusRequested(false));
        }

        _scannerController.clear();
      },
      builder: (context, state) {
        return PopScope(
          canPop: _canPop(state),
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            _handleBack(state);
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            appBar: AppBar(
              title: const Text('自动化仓库拣选'),
              centerTitle: true,
              backgroundColor: const Color(0xFF1976D2),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => _handleBack(state),
              ),
              actions: [_buildModeAction(state.currentMode)],
            ),
            body: Column(
              children: [
                _buildScanInput(state.placeholder),
                _buildInfoCard(state),
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF1976D2),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: const Color(0xFF1976D2),
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: '任务列表'),
                      Tab(text: '正在采集'),
                      Tab(text: '库存核对'),
                    ],
                    onTap: (index) =>
                        _bloc.add(OnlinePickCollectionTabChanged(index)),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTaskGrid(state),
                      _buildCollectingGrid(state),
                      _buildInventoryGrid(state.inventoryCheckDetails),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomBar(state),
          ),
        );
      },
    );
  }

  Widget _buildScanInput(String placeholder) {
    final config = ScannerConfig().copyWith(
      placeholder: placeholder,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      height: 48,
    );

    return ScannerWidget(
      config: config,
      controller: _scannerController,
      onScanResult: (value) {
        _bloc.add(OnlinePickCollectionScanSubmitted(value));
      },
      onError: (message) {
        LoadingDialogManager.instance.showErrorDialog(context, message);
      },
    );
  }

  Widget _buildInfoCard(OnlinePickCollectionState state) {
    final barcode = state.barcodeContent;
    final destinationLabel = _destinationLabel(state);
    final inventoryCount = state.inventoryCheckDetails.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildModeChip(state.currentMode),
              const Spacer(),
              Text(
                '库存核对：$inventoryCount',
                style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: '拣选口：',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF555555),
                    ),
                    children: [
                      TextSpan(
                        text: destinationLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit_location_alt,
                  color: Color(0xFF1976D2),
                ),
                tooltip: '选择拣选口',
                onPressed: () => _selectDestination(state),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildInfoRow('库位', state.currentLocation, '托盘', state.currentTray),
          const SizedBox(height: 8),
          _buildInfoRow(
            '物料',
            barcode?.materialCode ?? '-',
            '子库',
            state.expectedErpStore ?? '-',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            '批次',
            barcode?.batchNo ?? '-',
            '序列',
            barcode?.serialNumber ?? '-',
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            '数量',
            (state.pendingQuantity ?? 0).toDouble().toFormatString(),
            '已采集',
            state.collectedStocks.length.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String leftLabel,
    String leftValue,
    String rightLabel,
    String rightValue,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$leftLabel：',
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
              children: [
                TextSpan(
                  text: leftValue.isEmpty ? '-' : leftValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$rightLabel：',
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
              children: [
                TextSpan(
                  text: rightValue.isEmpty ? '-' : rightValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeChip(OnlinePickCollectionMode mode) {
    Color background;
    switch (mode.type) {
      case OnlinePickCollectionModeType.inventory:
        background = const Color(0xFFFF9800);
        break;
      case OnlinePickCollectionModeType.exception:
        background = const Color(0xFFE53935);
        break;
      case OnlinePickCollectionModeType.outbound:
      default:
        background = const Color(0xFF1976D2);
        break;
    }

    return Chip(
      label: Text(
        mode.label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: background,
      visualDensity: VisualDensity.compact,
    );
  }

  List<int> _selectedRowsFor(
    List<OnlinePickTaskItem> items,
    int? selectedId,
  ) {
    if (selectedId == null) {
      return const <int>[];
    }

    final index = items.indexWhere((item) => item.outTaskItemId == selectedId);
    if (index < 0) {
      return const <int>[];
    }

    return <int>[index];
  }

  Widget _buildTaskGrid(OnlinePickCollectionState state) {
    final items = state.taskItems;
    final selectedRows = _selectedRowsFor(items, state.selectedTaskItemId);

    return CommonDataGrid<OnlinePickTaskItem>(
      columns: OnlinePickCollectionGridConfig.taskColumns(),
      datas: items,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: selectedRows,
      onSelectionChanged: (rows) {
        if (rows.isEmpty) {
          _bloc.add(const OnlinePickCollectionTaskSelectionChanged());
          return;
        }

        final index = rows.last;
        if (index < 0 || index >= items.length) {
          return;
        }

        final selectedItem = items[index];
        _bloc.add(
          OnlinePickCollectionTaskSelectionChanged(
            selectedItemId: selectedItem.outTaskItemId,
          ),
        );
      },
    );
  }

  Widget _buildCollectingGrid(OnlinePickCollectionState state) {
    final items = state.collectingItems;
    if (items.isEmpty) {
      return const Center(child: Text('暂无采集中记录'));
    }

    final selectedRows =
        _selectedRowsFor(items, state.selectedCollectingItemId);

    return CommonDataGrid<OnlinePickTaskItem>(
      columns: OnlinePickCollectionGridConfig.taskColumns(),
      datas: items,
      allowPager: false,
      allowSelect: true,
      currentPage: 1,
      totalPages: 1,
      onLoadData: (_) async {},
      selectedRows: selectedRows,
      onSelectionChanged: (rows) {
        if (rows.isEmpty) {
          _bloc.add(const OnlinePickCollectionCollectingSelectionChanged());
          return;
        }

        final index = rows.last;
        if (index < 0 || index >= items.length) {
          return;
        }

        final selectedItem = items[index];
        _bloc.add(
          OnlinePickCollectionCollectingSelectionChanged(
            selectedItemId: selectedItem.outTaskItemId,
          ),
        );
      },
    );
  }

  Widget _buildInventoryGrid(
    List<OnlinePickInventoryCheckDetail> details,
  ) {
    if (details.isEmpty) {
      return const Center(child: Text('暂无结余记录'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (context, index) {
        final detail = details[index];
        final subtitleParts = <String>[];
        if (detail.batchNo?.isNotEmpty ?? false) {
          subtitleParts.add('批次 ${detail.batchNo}');
        }
        if (detail.trayNo?.isNotEmpty ?? false) {
          subtitleParts.add('托盘 ${detail.trayNo}');
        }
        return ListTile(
          dense: true,
          title: Text(
            '库位 ${detail.storeSite} · 物料 ${detail.materialCode}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          subtitle: subtitleParts.isEmpty
              ? null
              : Text(
                  subtitleParts.join(' · '),
                  style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
                ),
          trailing: Text(
            detail.quantity.toFormatString(),
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1976D2),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: details.length,
    );
  }

  Widget _buildBottomBar(OnlinePickCollectionState state) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: state.collectedStocks.isEmpty
                  ? null
                  : () => _openCollectionResult(state),
              icon: const Icon(Icons.list_alt),
              label: Text('采集结果(${state.collectedStocks.length})'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _openInventoryDialog(state),
              icon: const Icon(Icons.inventory_2_outlined),
              label: Text('库存核对(${state.inventoryQtyMap.length})'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed:
                  state.collectedStocks.isEmpty || state.inventoryQtyMap.isEmpty
                  ? null
                  : () =>
                        _bloc.add(const OnlinePickCollectionCommitRequested()),
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('提交'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _openMoreActions(state),
              icon: const Icon(Icons.more_horiz),
              label: const Text('更多'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openCollectionResult(OnlinePickCollectionState state) async {
    final result = await Modular.to.pushNamed<Map<String, dynamic>>(
      '/aswh-down/collect/result',
      arguments: {'stocks': state.collectedStocks},
    );

    if (result == null) return;

    final remaining =
        (result['stocks'] as List?)
            ?.whereType<OnlinePickCollectionStock>()
            .toList(growable: false) ??
        const <OnlinePickCollectionStock>[];
    final deleted =
        (result['deleted'] as List?)
            ?.whereType<OnlinePickCollectionStock>()
            .toList(growable: false) ??
        const <OnlinePickCollectionStock>[];

    if (deleted.isNotEmpty) {
      _bloc.add(OnlinePickCollectionStocksDeleted(deleted));
    }

    _bloc.add(OnlinePickCollectionStocksSynced(remaining, shouldReplace: true));
  }

  Future<void> _openInventoryDialog(OnlinePickCollectionState state) async {
    if (state.collectedStocks.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '暂无采集数据，无法核对库存');
      return;
    }

    final optionsMap = LinkedHashMap<String, _InventoryOption>();
    final detailMap = {
      for (final detail in state.inventoryCheckDetails) detail.key: detail,
    };
    for (final stock in state.collectedStocks) {
      final site = (stock.storeSite ?? '').trim();
      final material = (stock.materialCode).trim();
      if (site.isEmpty || material.isEmpty) {
        continue;
      }
      final batch = (stock.batchNo ?? '').trim();
      final tray = (stock.trayNo ?? '').trim();
      final key =
          '${site.toUpperCase()}|${material.toUpperCase()}|${batch.toUpperCase()}|${tray.toUpperCase()}';
      optionsMap.putIfAbsent(
        key,
        () => _InventoryOption(
          key: key,
          storeSite: site.toUpperCase(),
          materialCode: material.toUpperCase(),
          batchNo: batch.toUpperCase(),
          trayNo: tray.toUpperCase(),
        ),
      );
    }

    for (final detail in state.inventoryCheckDetails) {
      optionsMap.putIfAbsent(
        detail.key,
        () => _InventoryOption(
          key: detail.key,
          storeSite: detail.storeSite,
          materialCode: detail.materialCode,
          batchNo: detail.batchNo ?? '',
          trayNo: detail.trayNo ?? '',
        ),
      );
    }

    if (optionsMap.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(
        context,
        '当前采集记录缺少库位或物料信息，无法核对库存',
      );
      return;
    }

    String selectedKey = optionsMap.keys.first;
    final controller = TextEditingController(text: '0');
    String? errorText;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('库存核对'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedKey,
                    decoration: const InputDecoration(labelText: '选择核对对象'),
                    items: optionsMap.values
                        .map(
                          (option) => DropdownMenuItem<String>(
                            value: option.key,
                            child: Text(option.displayLabel),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedKey = value;
                        final detail = detailMap[selectedKey];
                        controller.text = '0';
                        errorText = null;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: '新增结余数量',
                      hintText: '请输入本次新增的结余数量',
                      errorText: errorText,
                    ),
                  ),
                  if (state.inventoryCheckDetails.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      '已记录的结余：',
                      style: TextStyle(fontSize: 12, color: Color(0xFF666666)),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemCount: state.inventoryCheckDetails.length,
                        itemBuilder: (context, index) {
                          final detail = state.inventoryCheckDetails[index];
                          return ListTile(
                            dense: true,
                            title: Text(
                              '库位 ${detail.storeSite} · 物料 ${detail.materialCode}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            subtitle:
                                (detail.batchNo?.isNotEmpty ?? false) ||
                                    (detail.trayNo?.isNotEmpty ?? false)
                                ? Text(
                                    [
                                      if (detail.batchNo?.isNotEmpty ?? false)
                                        '批次 ${detail.batchNo}',
                                      if (detail.trayNo?.isNotEmpty ?? false)
                                        '托盘 ${detail.trayNo}',
                                    ].join(' · '),
                                    style: const TextStyle(fontSize: 12),
                                  )
                                : null,
                            trailing: Text(
                              detail.quantity.toFormatString(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    final raw = controller.text.trim();
                    final value = double.tryParse(raw);
                    if (value == null) {
                      setState(() {
                        errorText = '请输入有效的数字';
                      });
                      return;
                    }
                    Navigator.of(
                      context,
                    ).pop({'key': selectedKey, 'quantity': value});
                  },
                  child: const Text('保存'),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();

    if (result == null) {
      return;
    }

    final key = result['key'] as String? ?? selectedKey;
    final quantity = result['quantity'] as double?;
    if (quantity == null) {
      return;
    }

    final option = optionsMap[key];
    if (option == null) {
      return;
    }

    _bloc.add(
      OnlinePickCollectionInventoryRecorded(
        materialCode: option.materialCode,
        storeSite: option.storeSite,
        batchNo: option.batchNo.isEmpty ? null : option.batchNo,
        trayNo: option.trayNo.isEmpty ? null : option.trayNo,
        quantity: quantity,
      ),
    );
  }

  String _destinationLabel(OnlinePickCollectionState state) {
    if (state.locationOptions.isEmpty) {
      return state.selectedDestination.isEmpty
          ? '未维护'
          : state.selectedDestination;
    }

    final normalized = state.selectedDestination.trim().toUpperCase();
    if (normalized.isEmpty) {
      return '未选择';
    }

    final option = state.locationOptions.firstWhere(
      (element) => element.value.trim().toUpperCase() == normalized,
      orElse: () => state.locationOptions.first,
    );
    return option.label;
  }

  Future<void> _selectDestination(OnlinePickCollectionState state) async {
    if (state.locationOptions.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '立体库进出口相关位置未维护!');
      return;
    }

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('选择拣选口'),
          children: state.locationOptions
              .map(
                (option) => SimpleDialogOption(
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(option.value),
                  child: Text(option.label),
                ),
              )
              .toList(),
        );
      },
    );

    if (selected == null || selected.isEmpty) {
      return;
    }

    _bloc.add(OnlinePickCollectionDestinationUpdated(selected));
  }

  Future<void> _openMoreActions(OnlinePickCollectionState state) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.place_outlined),
                title: const Text('拣选位置'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _selectDestination(state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.tune),
                title: const Text('采集模式'),
                subtitle: Text(state.currentMode.label),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _showModeSelector(state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('查询指令'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _navigateToWcs(state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('空盘出库'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionEmptyTrayOutRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.download_outlined),
                title: const Text('空盘入库'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionEmptyTrayInRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.move_to_inbox),
                title: const Text('单个托盘'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionSingleTrayRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment_return_outlined),
                title: const Text('回库'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionReturnTrayRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.all_inbox),
                title: const Text('全部托盘'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _promptAllTrayCount();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _navigateToWcs(OnlinePickCollectionState state) async {
    if (state.collectedStocks.isNotEmpty) {
      LoadingDialogManager.instance.showErrorDialog(
        context,
        '采集数据未提交,不允许查看指令！',
      );
      return;
    }

    await Modular.to.pushNamed(
      '/aswh-down/wcs',
      arguments: {
        'taskComment': widget.task.taskComment ?? '',
        'taskId': widget.task.outTaskId.toString(),
        'taskType': '00',
      },
    );
  }

  Future<void> _promptAllTrayCount() async {
    final controller = TextEditingController(text: '1');
    String? errorText;

    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('获取来料托盘数量'),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '托盘数量',
                  errorText: errorText,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    final value = int.tryParse(controller.text.trim());
                    if (value == null || value <= 0) {
                      setState(() {
                        errorText = '请输入大于 0 的整数';
                      });
                      return;
                    }
                    Navigator.of(dialogContext).pop(value);
                  },
                  child: const Text('确定'),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();

    if (result == null) {
      return;
    }

    _bloc.add(OnlinePickCollectionAllTrayRequested(result));
  }

  Future<void> _showModeSelector(OnlinePickCollectionState state) async {
    final selected = await showDialog<OnlinePickCollectionMode>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('选择采集模式'),
          children: _availableModes
              .map(
                (mode) => SimpleDialogOption(
                  onPressed: () => Navigator.of(dialogContext).pop(mode),
                  child: Row(
                    children: [
                      if (mode.code == state.currentMode.code)
                        const Icon(
                          Icons.check,
                          color: Color(0xFF1976D2),
                        )
                      else
                        const SizedBox(width: 24),
                      const SizedBox(width: 8),
                      Text(mode.label),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );

    if (selected == null) {
      return;
    }

    _bloc.add(OnlinePickCollectionModeChanged(selected));
  }

  Widget _buildModeAction(OnlinePickCollectionMode currentMode) {
    return PopupMenuButton<OnlinePickCollectionMode>(
      tooltip: '切换模式',
      icon: const Icon(Icons.tune, color: Colors.white),
      onSelected: (mode) => _bloc.add(OnlinePickCollectionModeChanged(mode)),
      itemBuilder: (context) {
        return _availableModes
            .map(
              (mode) => PopupMenuItem<OnlinePickCollectionMode>(
                value: mode,
                child: Row(
                  children: [
                    if (mode.code == currentMode.code)
                      const Icon(
                        Icons.check,
                        color: Color(0xFF1976D2),
                        size: 18,
                      )
                    else
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    Text(mode.label),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }
}

class _InventoryOption {
  _InventoryOption({
    required this.key,
    required this.storeSite,
    required this.materialCode,
    required this.batchNo,
    required this.trayNo,
  });

  final String key;
  final String storeSite;
  final String materialCode;
  final String batchNo;
  final String trayNo;

  String get displayLabel {
    final buffer = StringBuffer('库位 $storeSite · 物料 $materialCode');
    if (batchNo.isNotEmpty) {
      buffer.write(' · 批次 $batchNo');
    }
    if (trayNo.isNotEmpty) {
      buffer.write(' · 托盘 $trayNo');
    }
    return buffer.toString();
  }
}
