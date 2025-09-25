import 'dart:async';
import 'package:flutter/services.dart';

/// 全局扫码服务：
/// - 仅与原生 EventChannel 建立一次订阅
/// - 对外暴露 broadcast Stream，允许多个页面同时监听
class ScannerService {
  ScannerService._internal() {
    _ensureStarted();
  }

  static final ScannerService instance = ScannerService._internal();

  static const EventChannel _channel = EventChannel('com.example.wms_app/scanner');

  final StreamController<String> _controller = StreamController<String>.broadcast();
  StreamSubscription? _nativeSub;
  bool _started = false;

  /// 对外暴露的扫码事件流
  Stream<String> get stream => _controller.stream;

  /// 开始订阅原生扫码事件（仅首调生效）
  void _ensureStarted() {
    if (_started) return;
    _started = true;
    _nativeSub = _channel.receiveBroadcastStream().listen(
      (event) {
        final code = event?.toString() ?? '';
        if (code.isEmpty) return;
        if (!_controller.isClosed) {
          _controller.add(code);
        }
      },
      onError: (e, st) {
        // 将错误转发或记录日志
        // 这里选择忽略，但可根据需要：_controller.addError(e, st);
        // debugPrint('Scanner native error: $e');
      },
      cancelOnError: false,
    );
  }

  /// 可选：手动停止（通常无需调用，作为应用关闭时兜底）
  Future<void> dispose() async {
    await _nativeSub?.cancel();
    _nativeSub = null;
    if (!_controller.isClosed) {
      await _controller.close();
    }
    _started = false;
  }
}