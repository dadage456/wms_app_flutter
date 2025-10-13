import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/goods_up/collection_task/config/inbound_collection_grid_config.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_deleted_payload.dart';

class InboundCollectionResultPage extends StatefulWidget {
  const InboundCollectionResultPage({super.key, required this.initialStocks});

  final List<InboundCollectionStock> initialStocks;

  @override
  State<InboundCollectionResultPage> createState() =>
      _InboundCollectionResultPageState();
}

class _InboundCollectionResultPageState
    extends State<InboundCollectionResultPage> {
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
                columns: InboundCollectionGridConfig.resultColumns(),
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
    if (_stocks.isEmpty) {
      return const SizedBox(height: 0);
    }

    final selected = _selectedIndices.length;
    final total = _stocks.length;

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
    if (_selectedIndices.isEmpty) {
      LoadingDialogManager.instance
          .showErrorDialog(context, '请至少选择一条采集记录');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定删除选中的 ${_selectedIndices.length} 条采集记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
        .where((i) => i >= 0 && i < _stocks.length)
        .map((i) => _stocks[i])
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
      InboundDeletedStocksPayload(List<InboundCollectionStock>.from(_deletedBuffer)),
    );
  }
}
