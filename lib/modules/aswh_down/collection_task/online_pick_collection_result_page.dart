import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/collection_result_grid_config.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionResultPage extends StatefulWidget {
  const OnlinePickCollectionResultPage({super.key, required this.initialStocks});

  final List<OnlinePickCollectionStock> initialStocks;

  @override
  State<OnlinePickCollectionResultPage> createState() =>
      _OnlinePickCollectionResultPageState();
}

class _OnlinePickCollectionResultPageState
    extends State<OnlinePickCollectionResultPage> {
  late List<OnlinePickCollectionStock> _stocks;
  final List<OnlinePickCollectionStock> _deleted = [];
  List<int> _selectedRows = const [];

  @override
  void initState() {
    super.initState();
    _stocks = List<OnlinePickCollectionStock>.from(widget.initialStocks);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _finish();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _finish,
          ),
          title: const Text('采集结果'),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF6F6F6),
        body: Column(
          children: [
            Expanded(
              child: CommonDataGrid<OnlinePickCollectionStock>(
                columns: OnlinePickCollectionResultGridConfig.columns(),
                datas: _stocks,
                allowPager: false,
                allowSelect: true,
                currentPage: 1,
                totalPages: 1,
                onLoadData: (_) async {},
                selectedRows: _selectedRows,
                onSelectionChanged: (indices) {
                  setState(() {
                    _selectedRows = indices;
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
    final selectedCount = _selectedRows.length;
    final total = _stocks.length;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, -1), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Text('已选 $selectedCount / $total'),
          const Spacer(),
          TextButton(
            onPressed: selectedCount == total && total > 0
                ? () => setState(() => _selectedRows = const [])
                : () => setState(
                      () => _selectedRows =
                          List<int>.generate(_stocks.length, (index) => index),
                    ),
            child: Text(selectedCount == total ? '取消全选' : '全选'),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: selectedCount == 0 ? null : _confirmDelete,
            icon: const Icon(Icons.delete_outline),
            label: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    if (_selectedRows.isEmpty) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${_selectedRows.length} 条采集记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteSelected();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _deleteSelected() {
    final toDelete = _selectedRows
        .where((index) => index >= 0 && index < _stocks.length)
        .map((index) => _stocks[index])
        .toList(growable: false);

    if (toDelete.isEmpty) return;

    setState(() {
      _deleted.addAll(toDelete);
      _stocks = _stocks
          .asMap()
          .entries
          .where((entry) => !_selectedRows.contains(entry.key))
          .map((entry) => entry.value)
          .toList(growable: false);
      _selectedRows = const [];
    });

    LoadingDialogManager.instance.showSnackSuccessMsg(
      context,
      '已删除 ${toDelete.length} 条记录',
      duration: const Duration(milliseconds: 600),
    );
  }

  void _finish() {
    Navigator.of(context).pop({
      'stocks': _stocks,
      'deleted': _deleted,
    });
  }
}
