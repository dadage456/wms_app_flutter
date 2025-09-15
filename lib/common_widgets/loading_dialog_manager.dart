import 'package:flutter/material.dart';

/// 加载对话框管理器
/// 用于统一管理应用中的加载对话框显示和隐藏
class LoadingDialogManager {
  static LoadingDialogManager? _instance;
  bool _isDialogShowing = false;

  // 私有构造函数
  LoadingDialogManager._();

  // 单例模式
  static LoadingDialogManager get instance {
    _instance ??= LoadingDialogManager._();
    return _instance!;
  }

  /// 显示错误信息
  /// [context] - 上下文
  /// [message] - 错误信息
  void showSnackErrorMsg(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSnackWarningMsg(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.orange),
    );
  }

  /// 显示成功信息
  /// [context] - 上下文
  /// [message] - 成功信息
  void showSnackSuccessMsg(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration, // 外部可传，默认 2 秒
        behavior: SnackBarBehavior.floating, // 圆角悬浮样式，可选
      ),
    );
  }

  // 显示错误信息
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('错误'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  /// 显示加载对话框
  /// [context] - 上下文
  /// [message] - 加载提示文字，默认为"正在加载..."
  /// [barrierDismissible] - 是否可以通过点击背景关闭，默认为false
  void showLoadingDialog(
    BuildContext context, {
    String message = '正在加载...',
    bool barrierDismissible = false,
  }) {
    if (_isDialogShowing) {
      return; // 如果对话框已经显示，则不重复显示
    }

    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 隐藏加载对话框
  /// [context] - 上下文
  void hideLoadingDialog(BuildContext context) {
    if (!_isDialogShowing) {
      return; // 如果对话框没有显示，则不执行关闭操作
    }

    _isDialogShowing = false;

    // 安全地关闭对话框
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// 检查对话框是否正在显示
  bool get isDialogShowing => _isDialogShowing;

  /// 重置状态（用于特殊情况下的状态重置）
  void reset() {
    _isDialogShowing = false;
  }
}

/// 扩展方法，方便在BuildContext上直接调用
extension LoadingDialogExtension on BuildContext {
  /// 显示加载对话框
  void showLoadingDialog({String message = '正在加载...'}) {
    LoadingDialogManager.instance.showLoadingDialog(this, message: message);
  }

  /// 隐藏加载对话框
  void hideLoadingDialog() {
    LoadingDialogManager.instance.hideLoadingDialog(this);
  }

  /// 显示错误信息
  void showErrorDialog(String message) {
    LoadingDialogManager.instance.showErrorDialog(this, message);
  }

  /// 显示成功信息
  void showSuccessDialog(String message) {
    LoadingDialogManager.instance.showSnackSuccessMsg(this, message);
  }

  /// 显示警告信息
  void showWarningDialog(String message) {
    LoadingDialogManager.instance.showSnackWarningMsg(this, message);
  }
}
