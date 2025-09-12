import 'package:flutter/material.dart';

/// 筛选条件实体
@immutable
class OutboundTaskFilter {
  const OutboundTaskFilter(this.code, this.label, this.desc);

  final String code; // 对应 Radio 的 value
  final String label; // 标题
  final String desc; // 副标题
}

/// 出库任务筛选对话框（对外组件）
class OutboundTaskFilterDialog extends StatefulWidget {
  const OutboundTaskFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    this.options = _kDefaultOptions,
  });

  /// 当前选中的筛选 code
  final String currentFilter;

  /// 点击【确定】后的回调
  final ValueChanged<String> onFilterChanged;

  /// 可自定义的筛选选项，不传使用默认
  final List<OutboundTaskFilter> options;

  /// 默认选项
  static const List<OutboundTaskFilter> _kDefaultOptions = [
    OutboundTaskFilter('0', '采集中单据', '仅显示正在采集的任务'),
    OutboundTaskFilter('1', '所有单据', '显示所有状态的任务'),
  ];

  /// 快捷调用方法，返回选中的 code
  static Future<String?> show({
    required BuildContext context,
    required String currentFilter,
    required ValueChanged<String> onFilterChanged,
    List<OutboundTaskFilter>? options,
  }) => showDialog<String>(
    context: context,
    builder: (_) => OutboundTaskFilterDialog(
      currentFilter: currentFilter,
      onFilterChanged: onFilterChanged,
      options: options ?? _kDefaultOptions,
    ),
  );

  @override
  State<OutboundTaskFilterDialog> createState() =>
      _OutboundTaskFilterDialogState();
}

class _OutboundTaskFilterDialogState extends State<OutboundTaskFilterDialog> {
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
          const Text('请选择要显示的任务类型：', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          ...widget.options.map(
            (e) => RadioListTile<String>(
              title: Text(e.label),
              subtitle: Text(e.desc),
              value: e.code,
              groupValue: _selected,
              dense: true,
              onChanged: (v) => setState(() => _selected = v!),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
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
