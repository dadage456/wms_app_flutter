import 'package:flutter/material.dart';

import 'models/inventory_collect_models.dart';

class InventoryCollectResultPage extends StatefulWidget {
  const InventoryCollectResultPage({super.key, required this.initialRecords});

  final List<InventoryCollectRecord> initialRecords;

  @override
  State<InventoryCollectResultPage> createState() =>
      _InventoryCollectResultPageState();
}

class _InventoryCollectResultPageState extends State<InventoryCollectResultPage> {
  late List<InventoryCollectRecord> _records;
  final Set<int> _selected = <int>{};

  @override
  void initState() {
    super.initState();
    _records = List<InventoryCollectRecord>.from(widget.initialRecords);
  }

  @override
  Widget build(BuildContext context) {
    final hasRecords = _records.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('采集结果'),
      ),
      body: hasRecords
          ? ListView.separated(
              itemCount: _records.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final record = _records[index];
                final checked = _selected.contains(index);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selected.add(index);
                      } else {
                        _selected.remove(index);
                      }
                    });
                  },
                  title: Text('${record.materialCode}  ${record.materialName ?? ''}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('库位：${record.storeSiteNo}'),
                      Text('采集数量：${record.actualQuantity}'),
                      Text('差异：${record.difference.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text('暂无采集记录')),
      bottomNavigationBar: hasRecords
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('返回'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selected.isEmpty ? null : _onDeleteSelected,
                      child: const Text('删除选中'),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('返回'),
                ),
              ),
            ),
    );
  }

  void _onDeleteSelected() {
    final removed = _selected.map((index) => _records[index]).toList();
    Navigator.of(context).pop(removed);
  }
}
