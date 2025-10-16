import 'package:flutter/material.dart';

class OnlinePickTaskDetailActionBar extends StatelessWidget {
  const OnlinePickTaskDetailActionBar({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onRefresh,
  });

  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = selectedCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: canSubmit ? onCancel : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('撤销（$selectedCount）'),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: onRefresh,
            child: const Text('刷新'),
          ),
        ],
      ),
    );
  }
}
