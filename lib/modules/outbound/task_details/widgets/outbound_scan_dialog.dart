import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 出库扫码对话框组件
class OutboundScanDialog extends StatefulWidget {
  final ValueChanged<String> onScanResult;

  const OutboundScanDialog({
    Key? key,
    required this.onScanResult,
  }) : super(key: key);

  @override
  State<OutboundScanDialog> createState() => _OutboundScanDialogState();
}

class _OutboundScanDialogState extends State<OutboundScanDialog> {
  final TextEditingController _inputController = TextEditingController();
  bool _isScanning = false;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// 处理扫码结果
  void _handleScanResult(String content) {
    if (content.trim().isEmpty) {
      _showErrorMessage('扫码内容为空，请重新扫描');
      return;
    }

    // 验证扫码内容格式
    if (!_isValidScanContent(content)) {
      _showErrorMessage('采集内容不合法，请重新扫描');
      return;
    }

    Navigator.of(context).pop();
    widget.onScanResult(content);
  }

  /// 验证扫码内容格式
  bool _isValidScanContent(String content) {
    // 支持新格式二维码（包含'MC'标识）
    if (content.contains('MC')) {
      return true;
    }
    
    // 支持旧格式条码（包含'\$KW\$'标识）
    if (content.contains(r'$KW$')) {
      return true;
    }
    
    // 支持直接的物料编码
    if (content.trim().isNotEmpty) {
      return true;
    }
    
    return false;
  }

  /// 显示错误消息
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 模拟扫码功能（实际项目中应该集成真实的扫码SDK）
  void _simulateScan() {
    setState(() {
      _isScanning = true;
    });

    // 模拟扫码延迟
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
        
        // 模拟扫码结果
        const mockScanResult = 'MC123456789';
        _handleScanResult(mockScanResult);
      }
    });
  }

  /// 处理手动输入
  void _handleManualInput() {
    final content = _inputController.text.trim();
    if (content.isEmpty) {
      _showErrorMessage('请输入扫码内容');
      return;
    }
    
    _handleScanResult(content);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '扫码搜索',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 扫码区域
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[50],
              ),
              child: _isScanning
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            '正在扫码...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '点击下方按钮开始扫码',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            // 手动输入区域
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: '或手动输入扫码内容',
                hintText: '请输入二维码或条码内容',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.edit),
              ),
              maxLines: 2,
              onSubmitted: (_) => _handleManualInput(),
            ),
          ],
        ),
      ),
      actions: [
        // 取消按钮
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        // 开始扫码按钮
        ElevatedButton(
          onPressed: _isScanning ? null : _simulateScan,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text(_isScanning ? '扫码中...' : '开始扫码'),
        ),
        // 确认输入按钮
        ElevatedButton(
          onPressed: _handleManualInput,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('确认输入'),
        ),
      ],
    );
  }
}