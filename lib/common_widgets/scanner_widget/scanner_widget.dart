import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms_app/services/scanner_service.dart';
import 'scanner_config.dart';

/// 通用扫描组件
class ScannerWidget extends StatefulWidget {
  /// 扫描配置
  final ScannerConfig config;

  /// 扫描结果回调
  final ValueChanged<String> onScanResult;

  /// 错误回调
  final ValueChanged<String>? onError;

  /// 外部控制器（可选）
  final ScannerController? controller;

  final Widget? suffix;

  const ScannerWidget({
    super.key,
    required this.config,
    required this.onScanResult,
    this.onError,
    this.controller,
    this.suffix,
  });

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  StreamSubscription<String>? _scanSubscription;

  get isCurrent => ModalRoute.of(context)?.isCurrent ?? false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // 如果提供了外部控制器，则绑定
    if (widget.controller != null) {
      widget.controller!._attach(this);
    }

    // 订阅全局扫码服务
    _scanSubscription = ScannerService.instance.stream.listen(
      _handleScanResult,
      onError: (e) {
        if (mounted && isCurrent) {
          widget.onError?.call('扫码组件出错：$e');
        }
      },
    );

    // 自动聚焦
    if (widget.config.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && isCurrent) {
          _focusNode.requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    if (widget.controller != null) {
      widget.controller!._detach();
    }
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 处理扫描结果
  void _handleScanResult(String code) {
    // 仅在本页为当前可见路由时处理扫码
    if (code.isEmpty || !isCurrent) return;

    _processScanResult(code);
  }

  /// 处理手动输入
  void _handleManualInput(String value) {
    _processScanResult(value.trim());
  }

  /// 处理扫描结果的核心逻辑
  void _processScanResult(String code) {
    try {
      // 验证扫码内容
      if (widget.config.validator != null && !widget.config.validator!(code)) {
        widget.onError?.call('扫码内容格式不正确，请重新扫描');
        clear();
        return;
      }

      _controller.text = code;

      // 回调结果
      widget.onScanResult(code);
    } catch (e) {
      widget.onError?.call('处理扫码结果时出错：$e');
    }
  }

  /// 震动并清空输入框
  void _shakeAndClear() {
    _controller.clear();

    // 震动反馈
    if (widget.config.enableVibration) {
      HapticFeedback.heavyImpact();
    }
  }

  /// 请求焦点
  void requestFocus() {
    _focusNode.requestFocus();
  }

  /// 清空输入
  void clear() {
    _controller.clear();
  }

  /// 设置输入框文本
  void setText(String text) {
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.config.height,
      padding: widget.config.padding,
      decoration: BoxDecoration(color: widget.config.backgroundColor),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: widget.config.keyboardType,
              style: widget.config.textStyle,
              decoration: InputDecoration(
                hintText: widget.config.placeholder,
                hintStyle: widget.config.hintStyle,
                border: OutlineInputBorder(
                  borderRadius: widget.config.borderRadius,
                  borderSide: widget.config.border != null
                      ? widget.config.border!.top
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.config.borderRadius,
                  borderSide: widget.config.border != null
                      ? widget.config.border!.top
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.config.borderRadius,
                  borderSide: widget.config.border != null
                      ? widget.config.border!.top
                      : BorderSide.none,
                ),
                filled: true,
                fillColor: widget.config.fillColor ?? Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink() // 无文字时不显示
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            if (widget.config.clearOnSubmit) {
                              _handleManualInput('');
                              _focusNode.unfocus();
                            }
                          },
                        ),
                ),
              ),
              onSubmitted: _handleManualInput,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
            ),
          ),
          widget.suffix ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

/// 扫描组件控制器
class ScannerController {
  _ScannerWidgetState? _state;

  void _attach(_ScannerWidgetState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// 释放控制器，与组件解绑。
  void dispose() {
    _detach();
  }

  /// 请求焦点
  void requestFocus() {
    _state?.requestFocus();
  }

  /// 清空输入
  void clear() {
    _state?.clear();
  }

  /// 设置文本
  void setText(String text) {
    _state?.setText(text);
  }

  /// 检查是否已附加到组件
  bool get isAttached => _state != null;
}
