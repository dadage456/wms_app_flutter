import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/loading_dialog_manager.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/collection_task/models/deleted_payload.dart';
import 'package:wms_app/modules/outbound/collection_task/config/collection_result_grid_config.dart';

/// 采集结果列表页面（独立管理，删除仅影响本页 UI；返回时回传删除载荷）
/// 不依赖采集页的 Bloc，不做实时联动
class OutboundCollectionResultPage extends StatefulWidget {
  final List<CollectionStock> initialStocks;

  const OutboundCollectionResultPage({Key? key, required this.initialStocks})
    : super(key: key);

  @override
  State<OutboundCollectionResultPage> createState() =>
      _OutboundCollectionResultPageState();
}

class _OutboundCollectionResultPageState
    extends State<OutboundCollectionResultPage> {
  // 可见数据
  late List<CollectionStock> _stocks;
  // 删除缓冲区：本页确认删除后先放入这里，返回采集页时统一回传
  final List<CollectionStock> _deletedBuffer = [];
  // 表格“索引选中”集合
  List<int> _selectedIndices = const [];

  @override
  void initState() {
    super.initState();
    // 使用传入快照初始化本页可见列表
    _stocks = List<CollectionStock>.from(widget.initialStocks);
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
            '平库下架采集结果',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.delete_outline, color: Colors.white),
            //   tooltip: '删除选中',
            //   onPressed: _selectedIndices.isEmpty
            //       ? null
            //       : () => _confirmDelete(context),
            // ),
          ],
        ),
        backgroundColor: const Color(0xFFF6F6F6),
        body: Column(
          children: [
            Expanded(
              child: CommonDataGrid<CollectionStock>(
                columns: CollectionResultGridConfig.getColumns(),
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
    if (total == 0) return const SizedBox.shrink();

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
          // TextButton(
          //   onPressed: selected == total
          //       ? () => setState(() => _selectedIndices = [])
          //       : () => setState(
          //           () =>
          //               _selectedIndices = List<int>.generate(total, (i) => i),
          //         ),
          //   child: Text(selected == total ? '取消全选' : '全选'),
          // ),
          const SizedBox(width: 8),
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
      LoadingDialogManager.instance.showErrorDialog(context, '请至少选择一行记录');
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 ${_selectedIndices.length} 条采集记录吗？'),
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
    // 将选中的索引映射到当前可见列表中的项
    final toDelete = _selectedIndices
        .where((i) => i >= 0 && i < _stocks.length)
        .map((i) => _stocks[i])
        .toList();

    if (toDelete.isEmpty) {
      LoadingDialogManager.instance.showErrorDialog(context, '请选择有效记录');
      return;
    }

    // 本页 UI 立即移除
    setState(() {
      _stocks = _stocks
          .asMap()
          .entries
          .where((e) => !_selectedIndices.contains(e.key))
          .map((e) => e.value)
          .toList();
      _selectedIndices = const [];
    });

    // 加入删除缓冲区
    _deletedBuffer.addAll(toDelete);

    // 成功提示（仅本页）
    LoadingDialogManager.instance.showSnackSuccessMsg(
      context,
      '删除成功',
      duration: const Duration(milliseconds: 800),
    );
  }

  void _finishWithPayload() {
    // 回传所有已删除记录
    Navigator.of(
      context,
    ).pop(DeletedStocksPayload(List.unmodifiable(_deletedBuffer)));
  }
}
