import 'package:flutter/material.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import '../../../utils/custom_extension.dart';
import '../models/aswh_up_collection_models.dart';
import 'models/aswh_up_deleted_payload.dart';

class AswhUpCollectionResultPage extends StatefulWidget {
  const AswhUpCollectionResultPage({super.key, required this.initialStocks});

  final List<AswhUpCollectionStock> initialStocks;

  @override
  State<AswhUpCollectionResultPage> createState() =>
      _AswhUpCollectionResultPageState();
}

class _AswhUpCollectionResultPageState
    extends State<AswhUpCollectionResultPage> {
  late List<AswhUpCollectionStock> _stocks;
  final List<AswhUpCollectionStock> _deleted = [];
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _stocks = List<AswhUpCollectionStock>.from(widget.initialStocks);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _finishWithPayload();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _finishWithPayload,
          ),
          centerTitle: true,
          title: const Text(
            '采集结果',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF6F6F6),
        body: Column(
          children: [
            Expanded(
              child: _stocks.isEmpty
                  ? const Center(child: Text('暂无采集结果'))
                  : CommonDataGrid<AswhUpCollectionStock>(
                      columns: _columns(),
                      datas: _stocks,
                      allowPager: false,
                      allowSelect: true,
                      currentPage: 1,
                      totalPages: 1,
                      onLoadData: (_) async {},
                      selectedRows: _selectedIndices(),
                      onSelectionChanged: _onSelectionChanged,
                    ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final total = _stocks.length;
    final selected = _selectedIds.length;
    if (total == 0) {
      return Container(
        height: 52,
        alignment: Alignment.center,
        color: Colors.white,
        child: const Text('暂无采集记录'),
      );
    }

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          Text('已选 $selected / $total', style: const TextStyle(fontSize: 14)),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: selected == 0 ? null : () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline),
            label: const Text('删除'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              minimumSize: const Size(96, 36),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    if (_selectedIds.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请至少选择一行记录');
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${_selectedIds.length} 条采集记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performDelete();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _performDelete() {
    final toRemove = _stocks
        .where((stock) => _selectedIds.contains(stock.stockId))
        .toList();

    if (toRemove.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请选择有效记录');
      return;
    }

    setState(() {
      _stocks.removeWhere((stock) => _selectedIds.contains(stock.stockId));
      _stocks = List<AswhUpCollectionStock>.from(_stocks);

      _deleted.addAll(toRemove);
      _selectedIds.clear();
    });

    LoadingDialogManager.instance.showSnackSuccessMsg(
      context,
      '删除成功',
      duration: const Duration(milliseconds: 800),
    );
  }

  void _finishWithPayload() {
    Navigator.of(context).pop(List<AswhUpCollectionStock>.from(_deleted));
  }

  List<GridColumnConfig<AswhUpCollectionStock>> _columns() {
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
    ];
  }

  List<int> _selectedIndices() {
    final indices = <int>[];
    for (var i = 0; i < _stocks.length; i++) {
      if (_selectedIds.contains(_stocks[i].stockId)) {
        indices.add(i);
      }
    }
    return indices;
  }

  void _onSelectionChanged(List<int> indices) {
    setState(() {
      _selectedIds
        ..clear()
        ..addAll(
          indices
              .where((index) => index >= 0 && index < _stocks.length)
              .map((index) => _stocks[index].stockId),
        );
    });
  }
}
