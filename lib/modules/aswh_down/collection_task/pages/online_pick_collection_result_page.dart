import 'package:flutter/material.dart';
import 'package:wms_app/modules/aswh_down/models/online_pick_collection_models.dart';

class OnlinePickCollectionResultPage extends StatefulWidget {
  const OnlinePickCollectionResultPage({
    super.key,
    required this.initialArgs,
  });

  final Map<String, dynamic> initialArgs;

  @override
  State<OnlinePickCollectionResultPage> createState() =>
      _OnlinePickCollectionResultPageState();
}

class _OnlinePickCollectionResultPageState
    extends State<OnlinePickCollectionResultPage> {
  late List<OnlinePickCollectionStock> _stocks;
  late final String _trayNo;
  late final String _location;
  bool _modified = false;

  @override
  void initState() {
    super.initState();
    _stocks = _parseStocks(widget.initialArgs['stocks']);
    _trayNo = widget.initialArgs['trayNo']?.toString() ?? '';
    _location = widget.initialArgs['location']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _returnWithResult();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('采集结果'),
          actions: [
            if (_stocks.isNotEmpty)
              IconButton(
                tooltip: '同步采集页',
                icon: const Icon(Icons.check_circle_outline),
                onPressed: _returnWithResult,
              ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSummaryCard(theme),
            Expanded(
              child: _stocks.isEmpty
                  ? const Center(child: Text('当前暂无采集记录'))
                  : ListView.separated(
                      itemCount: _stocks.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final stock = _stocks[index];
                        return Dismissible(
                          key: ValueKey('${stock.stockId}-$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.redAccent,
                            child: const Icon(Icons.delete_outline, color: Colors.white),
                          ),
                          confirmDismiss: (_) => _confirmRemove(context, stock),
                          onDismissed: (_) => _removeStock(index, stock),
                          child: ListTile(
                            title: Text(
                              stock.materialCode,
                              style: theme.textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (stock.batchNo?.isNotEmpty ?? false)
                                  Text('批次：${stock.batchNo}')
                                else if (stock.serialNumber?.isNotEmpty ?? false)
                                  Text('序列：${stock.serialNumber}'),
                                Text('库位：${stock.storeSite ?? '-'}'),
                                if (stock.trayNo?.isNotEmpty ?? false)
                                  Text('托盘：${stock.trayNo}'),
                                if (stock.erpStore?.isNotEmpty ?? false)
                                  Text('子库：${stock.erpStore}'),
                              ],
                            ),
                            trailing: Text(
                              stock.collectQty.toString(),
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(ThemeData theme) {
    final totalQty = _stocks.fold<num>(0, (sum, stock) => sum + stock.collectQty);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '采集概览',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildSummaryChip('记录数', _stocks.length.toString()),
                _buildSummaryChip('合计数量', totalQty.toString()),
                if (_location.isNotEmpty)
                  _buildSummaryChip('库位', _location),
                if (_trayNo.isNotEmpty)
                  _buildSummaryChip('托盘', _trayNo),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryChip(String label, String value) {
    return Chip(
      backgroundColor: const Color(0xFFF1F5F9),
      label: Text('$label：$value'),
    );
  }

  List<OnlinePickCollectionStock> _parseStocks(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => OnlinePickCollectionStock.fromJson(
              Map<String, dynamic>.from(
                item.map(
                  (key, value) => MapEntry(key.toString(), value),
                ),
              ),
            ))
        .toList();
  }

  Future<bool> _confirmRemove(
    BuildContext context,
    OnlinePickCollectionStock stock,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('删除记录'),
            content: Text('确定移除物料【${stock.materialCode}】的采集记录吗？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('取消'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('删除'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _removeStock(int index, OnlinePickCollectionStock stock) {
    setState(() {
      _stocks.removeAt(index);
      _modified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已删除 ${stock.materialCode} 的采集记录'),
        action: SnackBarAction(
          label: '撤销',
          onPressed: () {
            setState(() {
              _stocks.insert(index, stock);
            });
          },
        ),
      ),
    );
  }

  void _returnWithResult() {
    Navigator.of(context).pop({
      'refresh': _modified,
      'stocks': _stocks.map((e) => e.toJson()).toList(),
    });
  }
}
