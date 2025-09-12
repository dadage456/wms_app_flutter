import 'package:flutter/material.dart';

/// 出库任务批量操作栏组件
class OutboundBatchActionBar extends StatelessWidget {
  final int selectedCount;
  final int totalCount;
  final VoidCallback onSelectAll;
  final VoidCallback onDeselectAll;
  final VoidCallback onCancelSelected;
  final VoidCallback onClearSelection;

  const OutboundBatchActionBar({
    Key? key,
    required this.selectedCount,
    required this.totalCount,
    required this.onSelectAll,
    required this.onDeselectAll,
    required this.onCancelSelected,
    required this.onClearSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAllSelected = selectedCount == totalCount && totalCount > 0;
    final hasSelection = selectedCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 选择状态显示
            Expanded(
              child: Text(
                '已选择 $selectedCount / $totalCount 项',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: hasSelection ? Colors.blue[700] : Colors.grey[600],
                ),
              ),
            ),
            // 全选/取消全选按钮
            // TextButton.icon(
            //   onPressed: totalCount > 0
            //       ? (isAllSelected ? onDeselectAll : onSelectAll)
            //       : null,
            //   icon: Icon(
            //     isAllSelected ? Icons.check_box : Icons.check_box_outline_blank,
            //     size: 20,
            //     color: totalCount > 0
            //         ? (isAllSelected ? Colors.blue : Colors.grey[600])
            //         : Colors.grey[400],
            //   ),
            //   label: Text(
            //     isAllSelected ? '取消全选' : '全选',
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: totalCount > 0
            //           ? (isAllSelected ? Colors.blue : Colors.grey[600])
            //           : Colors.grey[400],
            //     ),
            //   ),
            // ),
            // const SizedBox(width: 8),
            // // 清除选择按钮
            // if (hasSelection)
            //   TextButton.icon(
            //     onPressed: onClearSelection,
            //     icon: const Icon(
            //       Icons.clear,
            //       size: 20,
            //       color: Colors.orange,
            //     ),
            //     label: const Text(
            //       '清除',
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.orange,
            //       ),
            //     ),
            //   ),
            const SizedBox(width: 8),
            // 撤销按钮
            ElevatedButton.icon(
              onPressed: hasSelection ? () => _showCancelConfirmDialog(context) : null,
              icon: const Icon(
                Icons.delete_outline,
                size: 20,
              ),
              label: const Text(
                '撤销',
                style: TextStyle(fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: hasSelection ? Colors.red : Colors.grey[300],
                foregroundColor: hasSelection ? Colors.white : Colors.grey[500],
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示撤销确认对话框
  void _showCancelConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '撤销确认',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '确定要撤销选中的 $selectedCount 项任务吗？\n\n此操作不可撤销，请谨慎操作。',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                '取消',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancelSelected();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
              ),
              child: const Text(
                '确认撤销',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}