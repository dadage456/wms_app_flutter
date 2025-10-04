import 'package:flutter/material.dart';

class ReceiveBatchActionBar extends StatelessWidget {
  final int selectedCount;
  final int totalCount;
  final VoidCallback onConfirm;
  // final VoidCallback onClear;

  const ReceiveBatchActionBar({
    Key? key,
    required this.selectedCount,
    required this.totalCount,
    required this.onConfirm,
    // required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
            // TextButton(
            //   onPressed: onClear,
            //   child: const Text('清除'),
            // ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('接收'),
            ),
          ],
        ),
      ),
    );
  }
}
