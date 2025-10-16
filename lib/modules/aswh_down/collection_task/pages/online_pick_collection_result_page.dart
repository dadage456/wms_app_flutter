import 'package:flutter/material.dart';
import 'package:wms_app/common_widgets/common_grid/common_data_grid.dart';
import 'package:wms_app/common_widgets/common_grid/selection_action_bar.dart';
import 'package:wms_app/modules/aswh_down/collection_task/config/online_pick_collection_result_grid_config.dart';
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
  List<int> _selectedRows = const [];

  @override
  void initState() {
    super.initState();
    _stocks = _parseStocks(widget.initialArgs['stocks']);
    _trayNo = widget.initialArgs['trayNo']?.toString() ?? '';
    _location = widget.initialArgs['location']?.toString() ?? '';
  }

  bool get _allSelected =>
      _stocks.isNotEmpty && _selectedRows.length == _stocks.length;

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
                tooltip: _allSelected ? '取消全选' : '全选',
                icon: Icon(
                  _allSelected ? Icons.check_box : Icons.check_box_outline_blank,
                ),
                onPressed: _toggleSelectAll,
              ),
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
                  : CommonDataGrid<OnlinePickCollectionStock>(
                      columns:
                          OnlinePickCollectionResultGridConfig.columns(),
                      datas: _stocks,
                      allowPager: false,
                      allowSelect: true,
                      selectedRows: _selectedRows,
                      onSelectionChanged: (rows) {
                        setState(() {
                          _selectedRows = rows;
                        });
                      },
                      onLoadData: (_) async {},
                    ),
            ),
            SelectionActionBar(
              selectedCount: _selectedRows.length,
              totalCount: _stocks.length,
              confirmLabel: '删除',
              onConfirm: _confirmDelete,
              onClear: () => setState(() => _selectedRows = const []),
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

  Future<void> _confirmDelete() async {
    if (_selectedRows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请先选择需要删除的记录')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('删除采集记录'),
            content: Text('确定要删除选中的 ${_selectedRows.length} 条记录吗？'),
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

    if (!confirmed) return;
    _performDelete();
  }

  void _performDelete() {
    final set = _selectedRows.toSet();
    final removedCount = set.length;
    final remaining = _stocks
        .asMap()
        .entries
        .where((entry) => !set.contains(entry.key))
        .map((entry) => entry.value)
        .toList();

    setState(() {
      _stocks = remaining;
      _selectedRows = const [];
      _modified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已删除 $removedCount 条采集记录'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _toggleSelectAll() {
    setState(() {
      if (_allSelected) {
        _selectedRows = const [];
      } else {
        _selectedRows =
            List<int>.generate(_stocks.length, (index) => index);
      }
    });
  }

  void _returnWithResult() {
    Navigator.of(context).pop({
      'refresh': _modified,
      'stocks': _stocks.map((e) => e.toJson()).toList(),
    });
  }
}
