import 'package:flutter/material.dart';

import '../../../common_widgets/common_grid/common_data_grid.dart';
import '../../../common_widgets/loading_dialog_manager.dart';
import 'models/inbound_collection_models.dart';
import 'models/inbound_deleted_payload.dart';

class GoodsUpCollectionResultPage extends StatefulWidget {
  const GoodsUpCollectionResultPage({super.key, required this.initialStocks});

  final List<InboundCollectionStock> initialStocks;

  @override
  State<GoodsUpCollectionResultPage> createState() =>
      _GoodsUpCollectionResultPageState();
}

class _GoodsUpCollectionResultPageState
    extends State<GoodsUpCollectionResultPage> {
  late List<InboundCollectionStock> _stocks;
  final List<InboundCollectionStock> _deletedBuffer = [];
  List<int> _selectedIndices = const [];

  @override
  void initState() {
    super.initState();
    _stocks = List<InboundCollectionStock>.from(widget.initialStocks);
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
            '平库上架采集结果',
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
              child: CommonDataGrid<InboundCollectionStock>(
                columns: _resultColumns(),
                datas: _stocks,
                allowPager: false,
                allowSelect: true,
                currentPage: 1,
                totalPages: 1,
                onLoadData: (_) async {},
                selectedRows: _selectedIndices,
                onSelectionChanged: (indices) {
                  setState(() {
                    _selectedIndices = indices;
                  });
                },
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
    final selected = _selectedIndices.length;
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
            onPressed:
                selected == 0 ? null : () => _confirmDelete(context),
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
    if (_selectedIndices.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请至少选择一行记录');
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('确认删除'),
        content:
            Text('确定要删除选中的 ${_selectedIndices.length} 条采集记录吗？'),
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
    final toDelete = _selectedIndices
        .where((index) => index >= 0 && index < _stocks.length)
        .map((index) => _stocks[index])
        .toList();

    if (toDelete.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请选择有效记录');
      return;
    }

    setState(() {
      _stocks = _stocks
          .asMap()
          .entries
          .where((entry) => !_selectedIndices.contains(entry.key))
          .map((entry) => entry.value)
          .toList();
      _selectedIndices = const [];
    });

    _deletedBuffer.addAll(toDelete);

    LoadingDialogManager.instance.showSnackSuccessMsg(
      context,
      '删除成功',
      duration: const Duration(milliseconds: 800),
    );
  }

  void _finishWithPayload() {
    Navigator.of(context).pop(
      InboundDeletedStocksPayload(List<InboundCollectionStock>.from(
        _deletedBuffer,
      )),
    );
  }

  List<GridColumnConfig<InboundCollectionStock>> _resultColumns() {
    return [
      GridColumnConfig<InboundCollectionStock>(
        name: 'storesite',
        headerText: '库位',
        valueGetter: (row) => row.storeSite ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'matcode',
        headerText: '物料编码',
        valueGetter: (row) => row.materialCode,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'taskQty',
        headerText: '任务数量',
        valueGetter: (row) => row.taskQty,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'collectQty',
        headerText: '采集数量',
        valueGetter: (row) => row.collectQty,
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'batchno',
        headerText: '批次',
        valueGetter: (row) => row.batchNo ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'sn',
        headerText: '序列',
        valueGetter: (row) => row.serialNo ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'erpStore',
        headerText: '子库',
        valueGetter: (row) => row.erpStore ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'storeRoom',
        headerText: '库房',
        valueGetter: (row) => row.storeRoom ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'pdate',
        headerText: '生产日期',
        valueGetter: (row) => row.productionDate ?? '',
      ),
      GridColumnConfig<InboundCollectionStock>(
        name: 'vdays',
        headerText: '有效期',
        valueGetter: (row) => row.expireDays ?? '',
      ),
    ];
  }
}
