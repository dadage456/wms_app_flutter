import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/online_pick_collection_grid_config.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionResultPage extends StatefulWidget {
  const OnlinePickCollectionResultPage({
    super.key,
    required this.initialStocks,
  });

  final List<OnlinePickCollectionStock> initialStocks;

  @override
  State<OnlinePickCollectionResultPage> createState() =>
      _OnlinePickCollectionResultPageState();
}

class _OnlinePickCollectionResultPageState
    extends State<OnlinePickCollectionResultPage> {
  late List<OnlinePickCollectionStock> _stocks;
  List<int> _selectedIndices = const [];
  final List<OnlinePickCollectionStock> _deletedBuffer = [];

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
        _finishWithPayload();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: _finishWithPayload,
          ),
          title: const Text(
            '采集结果',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF6F6F6),
        body: Column(
          children: [
            Expanded(
              child: CommonDataGrid<OnlinePickCollectionStock>(
                columns: OnlinePickCollectionGridConfig.collectedColumns(),
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
        height: 60,
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text('暂无采集记录'),
      );
    }

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Text('已选 $selected / $total'),
          const Spacer(),
          TextButton(
            onPressed: selected == total
                ? () => setState(() => _selectedIndices = const [])
                : () => setState(
                      () => _selectedIndices =
                          List<int>.generate(total, (index) => index),
                    ),
            child: Text(selected == total ? '取消全选' : '全选'),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: selected == 0 ? null : () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline),
            label: const Text('删除'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    if (_selectedIndices.isEmpty) {
      LoadingDialogManager.instance
          .showErrorDialog(context, '请选择需要删除的记录');
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('删除采集记录'),
        content: Text('确定要删除选中的 ${_selectedIndices.length} 条记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performDelete();
            },
            child: const Text('确认'),
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
      LoadingDialogManager.instance
          .showErrorDialog(context, '请选择有效的记录');
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
      '已删除 ${toDelete.length} 条记录',
    );
  }

  void _finishWithPayload() {
    Navigator.of(context).pop(_deletedBuffer);
  }
}
