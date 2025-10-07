import 'package:flutter/material.dart';

/// 通用的列表选择操作栏，显示已选数量并提供确认按钮。
class SelectionActionBar extends StatelessWidget {
  const SelectionActionBar({
    super.key,
    required this.selectedCount,
    required this.totalCount,
    required this.onConfirm,
    this.onClear,
    this.confirmLabel = '确认',
    this.backgroundColor = Colors.white,
    this.confirmButtonColor = const Color(0xFF1E88E5),
    this.confirmTextColor = Colors.white,
  });

  /// 当前选中的数量
  final int selectedCount;

  /// 当前表格的数据量
  final int totalCount;

  /// 点击确认按钮的回调
  final VoidCallback onConfirm;

  /// 点击清除按钮的回调（可选）
  final VoidCallback? onClear;

  /// 确认按钮显示的文本
  final String confirmLabel;

  /// 操作栏背景色
  final Color backgroundColor;

  /// 确认按钮背景色
  final Color confirmButtonColor;

  /// 确认按钮文字颜色
  final Color confirmTextColor;

  @override
  Widget build(BuildContext context) {
    if (selectedCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '已选择 $selectedCount / $totalCount 项',
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (onClear != null) ...[
              TextButton(
                onPressed: onClear,
                child: const Text('清除'),
              ),
              const SizedBox(width: 8),
            ],
            ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmButtonColor,
                foregroundColor: confirmTextColor,
              ),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ),
    );
  }
}
