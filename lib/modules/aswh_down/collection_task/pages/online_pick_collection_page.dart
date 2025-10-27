import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_config.dart';
import 'package:wms_app/common_widgets/scanner_widget/scanner_widget.dart';
import 'package:wms_app/modules/aswh_down/utils/online_pick_scanner_parser.dart';

import '../bloc/online_pick_collection_bloc.dart';
import '../bloc/online_pick_collection_event.dart';
import '../bloc/online_pick_collection_state.dart';
import '../../models/online_pick_collection_models.dart';

class OnlinePickCollectionPage extends StatefulWidget {
  const OnlinePickCollectionPage({
    super.key,
    required this.initialArgs,
  });

  final Map<String, dynamic> initialArgs;

  @override
  State<OnlinePickCollectionPage> createState() =>
      _OnlinePickCollectionPageState();
}

class _OnlinePickCollectionPageState extends State<OnlinePickCollectionPage>
    with SingleTickerProviderStateMixin {
  late final OnlinePickCollectionBloc _bloc;
  late final TabController _tabController;
  final ScannerController _scannerController = ScannerController();
  final TextEditingController _manualController = TextEditingController();
  final FocusNode _manualFocusNode = FocusNode();
  int _lastFocusSequence = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<OnlinePickCollectionBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
    _bloc.add(OnlinePickCollectionStarted(widget.initialArgs));
  }

  @override
  void dispose() {
    _manualController.dispose();
    _manualFocusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _bloc.state.collectedStocks.isEmpty,
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
            '在线拣选采集',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: _showMoreOptions,
              child: const Text(
                '更多',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
        body: BlocConsumer<OnlinePickCollectionBloc, OnlinePickCollectionState>(
        listener: (context, state) {
          _handleFocus(state);
          _handleStatusFeedback(context, state);
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state.status.isLoading)
                const LinearProgressIndicator(minHeight: 2),
              _buildScanInput(state),
              const SizedBox(height: 8),
              _buildInfoCard(state),
              const SizedBox(height: 8),
              Expanded(child: _buildTabs(state)),
              _buildBottomActions(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScanInput(OnlinePickCollectionState state) {
    final config = ScannerConfig().copyWith(
      placeholder: state.scannerPlaceholder,
      clearOnSubmit: true,
      autoFocus: false,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      height: 48,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      backgroundColor: Colors.white,
    );

    Widget? suffix;
    if (state.locationOptions.isNotEmpty) {
      suffix = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: '手动输入',
            icon: const Icon(Icons.keyboard_outlined),
            onPressed: _showManualInputDialog,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.place_outlined),
            tooltip: '选择库位',
            onSelected: (value) {
              _bloc.add(OnlinePickCollectionLocationSelected(value));
            },
            itemBuilder: (context) {
              return state.locationOptions
                  .map(
                    (option) => PopupMenuItem<String>(
                      value: option.value,
                      child: Text(option.label),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      );
    } else {
      suffix = IconButton(
        tooltip: '手动输入',
        icon: const Icon(Icons.keyboard_outlined),
        onPressed: _showManualInputDialog,
      );
    }

    return Container(
      color: Colors.white,
      child: ScannerWidget(
        controller: _scannerController,
        config: config,
        onScanResult: (value) {
          if (value.trim().isEmpty) return;
          _bloc.add(OnlinePickCollectionScanSubmitted(value));
        },
        onError: (message) {
          _showSnackBar(
            context,
            message,
            Colors.red.shade600,
          );
        },
        suffix: suffix,
      ),
    );
  }

  Widget _buildInfoCard(OnlinePickCollectionState state) {
    final materialName =
        state.barcodeContent?.materialName ?? state.barcodeContent?.materialCode ?? '';
    final qrBatch = state.barcodeContent?.batchNo ?? state.barcodeContent?.serialNumber ?? '';
    final quantity = state.pendingQuantity == null
        ? ''
        : _formatNumber(state.pendingQuantity!.toDouble());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Column(
        children: [
          _buildInfoRow('当前步骤：', state.currentStepLabel, '模式：', _modeLabel(state.currentMode)),
          _buildDottedDivider(),
          _buildInfoRow('库位：', state.currentLocation ?? '', '托盘：', state.currentTrayNo ?? ''),
          _buildDottedDivider(),
          _buildInfoRow('预计子库：', state.expectedErpStore, '采集数量：', quantity),
          _buildDottedDivider(),
          _buildInfoRow('物料：', materialName, '批次/序列：', qrBatch),
          _buildDottedDivider(),
          _buildInfoRow('下一步：', _nextStepDescription(state.nextExpectedScanType), '', ''),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    const labelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
    final textColor = Colors.grey.shade800;

    Widget buildCell(String label, String value) {
      return Row(
        children: [
          Container(
            width: 4,
            height: 10,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(label, style: labelStyle.copyWith(color: textColor)),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: labelStyle.copyWith(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Expanded(child: buildCell(label1, value1)),
          if (label2.isNotEmpty)
            const SizedBox(width: 16),
          if (label2.isNotEmpty) Expanded(child: buildCell(label2, value2)),
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
                decoration: BoxDecoration(color: Color(0xFF1976D2)),
              ),
            );
          }),
        );
      },
    );
  }

  String _modeLabel(OnlinePickCollectionModeType mode) {
    if (mode == OnlinePickCollectionModeType.inventory) {
      return '库存核对';
    }
    if (mode == OnlinePickCollectionModeType.exception) {
      return '异常采集';
    }
    return '出库采集';
  }

  Widget _buildTabs(OnlinePickCollectionState state) {
    return Column(
      children: [
        Container(
          height: 44,
          color: Colors.white,
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
              Tab(text: '任务明细'),
              Tab(text: '采集中'),
              Tab(text: '库存核对'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTaskItemsView(state),
              _buildCollectedStocksView(state),
              _buildInventoryRecordsView(state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(OnlinePickCollectionState state) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _navigateToCollectionResult(state),
              icon: const Icon(Icons.list_alt_outlined),
              label: const Text('采集结果'),
              style: _outlinedButtonStyle(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showCommandSheet(state),
              icon: const Icon(Icons.precision_manufacturing_outlined),
              label: const Text('下发指令'),
              style: _primaryButtonStyle(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _navigateToWcs(state),
              icon: const Icon(Icons.send_outlined),
              label: const Text('指令查询'),
              style: _primaryButtonStyle(),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _outlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1976D2),
      side: const BorderSide(color: Color(0xFF1976D2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12),
    );
  }

  ButtonStyle _primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        final state = _bloc.state;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '更多操作',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ...OnlinePickCollectionModeType.values.map(
                (mode) => ListTile(
                  leading: const Icon(Icons.tune, color: Color(0xFF1976D2)),
                  title: Text(_modeLabel(mode)),
                  trailing: mode == state.currentMode
                      ? const Icon(Icons.check, color: Color(0xFF1976D2))
                      : null,
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _bloc.add(OnlinePickCollectionModeChanged(mode));
                  },
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Color(0xFFEF5350)),
                title: const Text('清空缓存'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionCacheCleared());
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh, color: Color(0xFF1976D2)),
                title: const Text('重置采集步骤'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionStepResetRequested());
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt, color: Color(0xFF1976D2)),
                title: const Text('提交采集结果'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _bloc.add(const OnlinePickCollectionSubmitPressed());
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _navigateToCollectionResult(
    OnlinePickCollectionState state,
  ) async {
    final stocks = state.collectedStocks
        .map((stock) => stock.toJson())
        .toList(growable: false);

    final result = await Modular.to.pushNamed(
      '/aswh-down/collect/result',
      arguments: {
        'stocks': stocks,
        'task': state.task?.toJson(),
        'trayNo': state.currentTrayNo,
        'location': state.currentLocation,
      },
    );

    if (result is Map) {
      final stocksPayload = result['stocks'];
      if (stocksPayload is List) {
        final parsed = stocksPayload
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(
                  item.map(
                    (key, value) => MapEntry(key.toString(), value),
                  ),
                ))
            .toList();
        _bloc.add(OnlinePickCollectionStocksSynced(parsed));
      } else if (result['refresh'] == true) {
        _bloc.add(const OnlinePickCollectionReloadRequested());
      }
    }
  }

  void _showManualInputDialog() {
    _manualController.clear();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('手动输入条码'),
          content: TextField(
            controller: _manualController,
            focusNode: _manualFocusNode,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: '请输入条码或数量',
            ),
            onSubmitted: (value) => _submitManualInput(context),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _manualController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => _submitManualInput(context),
              child: const Text('确定'),
            ),
          ],
        );
      },
    ).then((_) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      _scannerController.requestFocus();
    });
  }

  void _submitManualInput(BuildContext dialogContext) {
    final value = _manualController.text.trim();
    if (value.isEmpty) {
      return;
    }
    Navigator.of(dialogContext).pop();
    _bloc.add(OnlinePickCollectionScanSubmitted(value));
  }

  Future<void> _navigateToWcs(OnlinePickCollectionState state) async {
    final result = await Modular.to.pushNamed(
      '/aswh-down/wcs',
      arguments: {
        'taskId': state.task?.outTaskId,
        'taskNo': state.task?.outTaskNo,
        'taskComment': state.task?.taskComment,
        'trayNo': state.currentTrayNo,
        'workStation': state.task?.workStation,
      },
    );

    if (result is Map && result['refresh'] == true) {
      _bloc.add(const OnlinePickCollectionReloadRequested());
    }
  }

  void _handleFocus(OnlinePickCollectionState state) {
    if (state.focusSequence != _lastFocusSequence) {
      _lastFocusSequence = state.focusSequence;
      _scannerController.clear();
      _scannerController.requestFocus();
    }
  }

  void _handleStatusFeedback(
    BuildContext context,
    OnlinePickCollectionState state,
  ) {
    final status = state.status;
    final message = status.message;
    if (message == null || message.isEmpty) {
      return;
    }

    if (status.isError) {
      _showSnackBar(context, message, Colors.red.shade600);
    } else if (status.isSuccess) {
      _showSnackBar(context, message, Colors.green.shade600);
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(milliseconds: 1200),
        ),
      );
  }

  void _handleBackPress(BuildContext context) {
    final state = _bloc.state;
    if (state.collectedStocks.isNotEmpty) {
      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text('当前采集记录尚未提交，确定退出采集吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Modular.to.pop();
                },
                child: const Text('确认'),
              ),
            ],
          );
        },
      );
    } else {
      Modular.to.pop();
    }
  }

  Widget _buildTaskItemsView(OnlinePickCollectionState state) {
    final items = state.taskItems;
    return _buildGridSection<OnlinePickTaskItem>(
      data: items,
      columns: _taskListColumns(),
      emptyMessage: '暂无任务明细',
    );
  }

  Widget _buildCollectedStocksView(OnlinePickCollectionState state) {
    final stocks = state.collectedStocks;
    return _buildGridSection<OnlinePickCollectionStock>(
      data: stocks,
      columns: _collectingColumns(),
      emptyMessage: '暂无采集记录',
    );
  }

  Widget _buildInventoryRecordsView(OnlinePickCollectionState state) {
    final records = state.inventoryRecords;
    return _buildGridSection<OnlinePickInventoryRecord>(
      data: records,
      columns: _inventoryColumns(),
      emptyMessage: '暂无库存核对信息',
    );
  }

  Widget _buildGridSection<T>({
    required List<T> data,
    required List<GridColumnConfig<T>> columns,
    required String emptyMessage,
  }) {
    final content = data.isEmpty
        ? _buildEmptyContent(emptyMessage)
        : CommonDataGrid<T>(
            columns: columns,
            datas: data,
            allowPager: false,
            allowSelect: false,
            onLoadData: (_) async {},
          );

    return _buildTableCard(content);
  }

  Widget _buildTableCard(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildEmptyContent(String message) {
    return SizedBox(
      height: 240,
      child: Center(
        child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey.shade600),
        ),
      ),
    );
  }

  List<GridColumnConfig<OnlinePickTaskItem>> _taskListColumns() {
    return [
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'storeSiteNo',
        headerText: '库位',
        width: 140,
        valueGetter: (item) => item.storeSiteNo ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'palletNo',
        headerText: '托盘',
        width: 140,
        valueGetter: (item) => item.palletNo ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 160,
        enableSelectableText: true,
        valueGetter: (item) => item.materialCode ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'materialName',
        headerText: '物料名称',
        width: 180,
        valueGetter: (item) => item.materialName ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (item) => item.taskQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'collectedQty',
        headerText: '已采集',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (item) => item.collectedQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'difference',
        headerText: '差异',
        width: 110,
        textAlign: TextAlign.right,
        textStyle: const TextStyle(color: Color(0xFFD32F2F)),
        valueGetter: (item) => item.taskQty - item.collectedQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'subInventoryCode',
        headerText: '子库',
        width: 120,
        valueGetter: (item) => item.subInventoryCode ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'batchOrSerial',
        headerText: '批次/序列',
        width: 160,
        valueGetter: (item) =>
            item.batchNo ?? item.serialNumber ?? item.hintBatchNo ?? '-',
      ),
      GridColumnConfig<OnlinePickTaskItem>(
        name: 'taskComment',
        headerText: '备注',
        width: 160,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        valueGetter: (item) => item.taskComment ?? '-',
      ),
    ];
  }

  List<GridColumnConfig<OnlinePickCollectionStock>> _collectingColumns() {
    return [
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'trayNo',
        headerText: '托盘',
        width: 140,
        valueGetter: (stock) => stock.trayNo ?? '-',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'storeSite',
        headerText: '库位',
        width: 140,
        valueGetter: (stock) => stock.storeSite ?? '-',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 160,
        enableSelectableText: true,
        valueGetter: (stock) => stock.materialCode,
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'batchOrSerial',
        headerText: '批次/序列',
        width: 160,
        valueGetter: (stock) => stock.batchNo ?? stock.serialNumber ?? '-',
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (stock) => stock.taskQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (stock) => stock.collectQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickCollectionStock>(
        name: 'erpStore',
        headerText: '子库',
        width: 120,
        valueGetter: (stock) => stock.erpStore ?? '-',
      ),
    ];
  }

  List<GridColumnConfig<OnlinePickInventoryRecord>> _inventoryColumns() {
    return [
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'storeSite',
        headerText: '库位',
        width: 140,
        valueGetter: (record) => record.storeSite ?? '-',
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'materialCode',
        headerText: '物料编码',
        width: 160,
        enableSelectableText: true,
        valueGetter: (record) => record.materialCode,
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'materialName',
        headerText: '物料名称',
        width: 180,
        valueGetter: (record) => record.materialName ?? '-',
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'taskQty',
        headerText: '任务数量',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (record) => record.taskQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'collectedQty',
        headerText: '已采集',
        width: 110,
        textAlign: TextAlign.right,
        valueGetter: (record) => record.collectedQty,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'difference',
        headerText: '差异',
        width: 110,
        textAlign: TextAlign.right,
        textStyle: const TextStyle(color: Color(0xFFD32F2F)),
        valueGetter: (record) => record.difference,
        formatter: (value, _) => _formatNumber(value as num?),
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'erpStore',
        headerText: '子库',
        width: 120,
        valueGetter: (record) => record.erpStore ?? '-',
      ),
      GridColumnConfig<OnlinePickInventoryRecord>(
        name: 'trayNo',
        headerText: '托盘',
        width: 140,
        valueGetter: (record) => record.trayNo ?? '-',
      ),
    ];
  }

  String _formatNumber(num? value) {
    if (value == null) {
      return '-';
    }
    final doubleValue = value.toDouble();
    if ((doubleValue - doubleValue.round()).abs() < 1e-6) {
      return doubleValue.toStringAsFixed(0);
    }
    var formatted = doubleValue.toStringAsFixed(3);
    while (formatted.contains('.') && formatted.endsWith('0')) {
      formatted = formatted.substring(0, formatted.length - 1);
    }
    if (formatted.endsWith('.')) {
      formatted = formatted.substring(0, formatted.length - 1);
    }
    return formatted;
  }

  String _nextStepDescription(OnlinePickScanType type) {
    switch (type) {
      case OnlinePickScanType.location:
        return '等待扫描库位';
      case OnlinePickScanType.tray:
        return '等待扫描托盘';
      case OnlinePickScanType.material:
        return '等待扫描物料二维码';
      case OnlinePickScanType.quantity:
        return '等待录入数量';
    }
  }

  Future<void> _showCommandSheet(OnlinePickCollectionState state) async {
    final options = [
      const _CommandOption(
        label: '单个来料盘',
        commandType: OnlinePickCommandType.downShelf,
        singleFlag: 'Y',
      ),
      const _CommandOption(
        label: '全部托盘',
        commandType: OnlinePickCommandType.downShelf,
        singleFlag: 'N',
      ),
      const _CommandOption(
        label: '盘点下架',
        commandType: OnlinePickCommandType.inventoryDownShelf,
      ),
      const _CommandOption(
        label: '空托盘下架',
        commandType: OnlinePickCommandType.emptyTray,
      ),
      const _CommandOption(
        label: '回库重置',
        commandType: OnlinePickCommandType.reset,
      ),
      const _CommandOption(
        label: '盘点回库',
        commandType: OnlinePickCommandType.inventoryReset,
      ),
    ];

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  '选择指令类型',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              for (final option in options)
                ListTile(
                  leading: const Icon(Icons.chevron_right),
                  title: Text(option.label),
                  onTap: () {
                    Navigator.of(context).pop();
                    _promptCommand(option, state);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _promptCommand(
    _CommandOption option,
    OnlinePickCollectionState state,
  ) async {
    final startController = TextEditingController();
    final endController = TextEditingController();
    final trayController =
        TextEditingController(text: state.currentTrayNo ?? '');

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(option.label),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startController,
                decoration: const InputDecoration(labelText: '起始地址'),
              ),
              TextField(
                controller: endController,
                decoration: const InputDecoration(labelText: '目标地址'),
              ),
              TextField(
                controller: trayController,
                decoration: const InputDecoration(labelText: '托盘号'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      startController.dispose();
      endController.dispose();
      trayController.dispose();
      return;
    }

    final start = startController.text.trim();
    final end = endController.text.trim();
    final tray = trayController.text.trim().isEmpty
        ? state.currentTrayNo
        : trayController.text.trim();

    startController.dispose();
    endController.dispose();
    trayController.dispose();

    if (start.isEmpty || end.isEmpty) {
      _showSnackBar(context, '请填写完整的起始地址和目标地址', Colors.orange.shade600);
      return;
    }

    _bloc.add(
      OnlinePickCollectionCommandSubmitted(
        commandType: option.commandType,
        startAddress: start,
        endAddress: end,
        trayNo: tray,
        singleFlag: option.singleFlag,
      ),
    );
  }
}

class _CommandOption {
  const _CommandOption({
    required this.label,
    required this.commandType,
    this.singleFlag = 'N',
  });

  final String label;
  final OnlinePickCommandType commandType;
  final String singleFlag;
}
