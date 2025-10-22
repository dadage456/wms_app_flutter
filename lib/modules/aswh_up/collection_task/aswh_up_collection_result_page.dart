import 'package:flutter/material.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../utils/custom_extension.dart';
import '../models/aswh_up_collection_models.dart';

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
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pop(_deleted);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(_deleted);
            },
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
        body: _stocks.isEmpty
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
        bottomNavigationBar: _stocks.isEmpty
            ? null
            : Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('删除选中'),
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () => _deleteSelected(context),
                ),
              ),
      ),
    );
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

  void _deleteSelected(BuildContext context) {
    final toRemove = _stocks
        .where((stock) => _selectedIds.contains(stock.stockId))
        .toList();
    if (toRemove.isEmpty) {
      return;
    }

    setState(() {
      _stocks.removeWhere((stock) => _selectedIds.contains(stock.stockId));
      _deleted.addAll(toRemove);
      _selectedIds.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('已删除 ${toRemove.length} 条采集记录')));
  }
}
