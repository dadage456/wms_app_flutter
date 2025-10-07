import 'package:flutter/material.dart';

class GoodsUpTaskFilterOption {
  const GoodsUpTaskFilterOption(this.code, this.label, this.desc);

  final String code;
  final String label;
  final String desc;
}

class GoodsUpTaskFilterDialog extends StatefulWidget {
  const GoodsUpTaskFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    this.options = defaultOptions,
  });

  final String currentFilter;
  final ValueChanged<String> onFilterChanged;
  final List<GoodsUpTaskFilterOption> options;

  static const List<GoodsUpTaskFilterOption> defaultOptions = [
    GoodsUpTaskFilterOption('0', '采集中任务', '仅显示未完成的上架任务'),
    GoodsUpTaskFilterOption('1', '全部任务', '显示所有状态的任务'),
  ];

  static Future<void> show({
    required BuildContext context,
    required String currentFilter,
    required ValueChanged<String> onFilterChanged,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => GoodsUpTaskFilterDialog(
        currentFilter: currentFilter,
        onFilterChanged: onFilterChanged,
      ),
    );
  }

  @override
  State<GoodsUpTaskFilterDialog> createState() =>
      _GoodsUpTaskFilterDialogState();
}

class _GoodsUpTaskFilterDialogState extends State<GoodsUpTaskFilterDialog> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('筛选条件'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择要显示的任务类型：'),
          const SizedBox(height: 12),
          ...widget.options.map(
            (option) => RadioListTile<String>(
              value: option.code,
              groupValue: _selected,
              dense: true,
              title: Text(option.label),
              subtitle: Text(option.desc),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selected = value);
                }
              },
            ),
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
            widget.onFilterChanged(_selected);
            Navigator.of(context).pop();
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
