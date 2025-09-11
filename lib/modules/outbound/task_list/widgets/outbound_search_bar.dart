import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 出库任务搜索栏
class OutboundSearchBar extends HookWidget {
  const OutboundSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onScanCode,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onScanCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 搜索输入框
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '扫码或输入单号搜索',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
              onSubmitted: onSearch,
              textInputAction: TextInputAction.search,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 扫码按钮
          IconButton(
            onPressed: () => _handleScanCode(context),
            icon: const Icon(Icons.qr_code_scanner),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.all(12),
            ),
            tooltip: '扫码',
          ),
          
          const SizedBox(width: 8),
          
          // 搜索按钮
          IconButton(
            onPressed: () => onSearch(controller.text),
            icon: const Icon(Icons.search),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              padding: const EdgeInsets.all(12),
            ),
            tooltip: '搜索',
          ),
        ],
      ),
    );
  }
  
  /// 处理扫码
  void _handleScanCode(BuildContext context) {
    // TODO: 集成扫码功能
    // 这里暂时模拟扫码结果
    _showScanCodeDialog(context);
  }
  
  /// 显示扫码对话框（模拟）
  void _showScanCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('扫码功能'),
        content: const Text('扫码功能待集成，请手动输入单号进行搜索。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}