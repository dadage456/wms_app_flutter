import 'package:flutter/material.dart';

@immutable
class OnlinePickTaskFilter {
  const OnlinePickTaskFilter(this.code, this.label, this.desc);

  final String code;
  final String label;
  final String desc;
}

class OnlinePickTaskFilterDialog extends StatefulWidget {
  const OnlinePickTaskFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    this.options = _defaultOptions,
  });

  final String currentFilter;
  final ValueChanged<String> onFilterChanged;
  final List<OnlinePickTaskFilter> options;

  static const List<OnlinePickTaskFilter> _defaultOptions = [
    OnlinePickTaskFilter('0', '采集中单据', '仅显示正在采集的任务'),
    OnlinePickTaskFilter('1', '所有单据', '显示所有状态的任务'),
  ];

  static Future<void> show({
    required BuildContext context,
    required String currentFilter,
    required ValueChanged<String> onFilterChanged,
    List<OnlinePickTaskFilter>? options,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => OnlinePickTaskFilterDialog(
        currentFilter: currentFilter,
        onFilterChanged: onFilterChanged,
        options: options ?? _defaultOptions,
      ),
    );
  }

  @override
  State<OnlinePickTaskFilterDialog> createState() =>
      _OnlinePickTaskFilterDialogState();
}

class _OnlinePickTaskFilterDialogState
    extends State<OnlinePickTaskFilterDialog> {
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
        children: widget.options
            .map(
              (option) => RadioListTile<String>(
                title: Text(option.label),
                subtitle: Text(option.desc),
                value: option.code,
                groupValue: _selected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selected = value);
                  }
                },
              ),
            )
            .toList(),
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
