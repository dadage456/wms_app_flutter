import 'package:flutter/material.dart';

/// 出库任务筛选对话框
class OutboundTaskFilterDialog extends StatefulWidget {
  const OutboundTaskFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final String currentFilter;
  final ValueChanged<String> onFilterChanged;

  @override
  State<OutboundTaskFilterDialog> createState() => _OutboundTaskFilterDialogState();
}

class _OutboundTaskFilterDialogState extends State<OutboundTaskFilterDialog> {
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('筛选条件'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '请选择要显示的任务类型：',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          
          // 采集中单据选项
          RadioListTile<String>(
            title: const Text('采集中单据'),
            subtitle: const Text('仅显示正在采集的任务'),
            value: '0',
            groupValue: _selectedFilter,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedFilter = value;
                });
              }
            },
          ),
          
          // 所有单据选项
          RadioListTile<String>(
            title: const Text('所有单据'),
            subtitle: const Text('显示所有状态的任务'),
            value: '1',
            groupValue: _selectedFilter,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedFilter = value;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onFilterChanged(_selectedFilter);
            Navigator.of(context).pop();
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}