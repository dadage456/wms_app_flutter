import 'package:flutter/material.dart';

/// 扫描组件配置模型
class ScannerConfig {
  /// 输入框占位符文本
  final String placeholder;

  /// 键盘类型
  final TextInputType keyboardType;

  /// 是否自动聚焦
  final bool autoFocus;

  /// 背景颜色
  final Color backgroundColor;

  /// 输入框圆角
  final BorderRadius borderRadius;

  /// 输入框内边距
  final EdgeInsets padding;

  /// 输入框高度
  final double height;

  /// 文本样式
  final TextStyle textStyle;

  /// 占位符样式
  final TextStyle hintStyle;

  /// 边框样式
  final Border? border;

  /// 填充颜色
  final Color? fillColor;

  /// 扫码内容验证函数
  final bool Function(String)? validator;

  /// 是否启用震动反馈
  final bool enableVibration;

  /// 是否启用声音反馈
  final bool enableSoundFeedback;

  /// 清空内容是否自动提交
  /// 默认为false
  /// 如果为true，则清空内容时，会自动提交
  final bool clearOnSubmit;

  const ScannerConfig({
    this.placeholder = '请扫描或输入条码',
    this.keyboardType = TextInputType.number,
    this.autoFocus = false,
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.height = 54,
    this.textStyle = const TextStyle(fontSize: 14),
    this.hintStyle = const TextStyle(color: Colors.grey, fontSize: 14),
    this.border,
    this.fillColor = const Color(0xFFF5F5F5),
    this.validator,
    this.enableVibration = true,
    this.enableSoundFeedback = true,
    this.clearOnSubmit = false,
  });

  /// 复制并修改部分配置
  ScannerConfig copyWith({
    String? placeholder,
    TextInputType? keyboardType,
    bool? autoFocus,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? height,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    Border? border,
    Color? fillColor,
    bool Function(String)? validator,
    bool? enableVibration,
    bool? enableSoundFeedback,
    bool? clearOnSubmit,
  }) {
    return ScannerConfig(
      placeholder: placeholder ?? this.placeholder,
      keyboardType: keyboardType ?? this.keyboardType,
      autoFocus: autoFocus ?? this.autoFocus,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      height: height ?? this.height,
      textStyle: textStyle ?? this.textStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      border: border ?? this.border,
      fillColor: fillColor ?? this.fillColor,
      validator: validator ?? this.validator,
      enableVibration: enableVibration ?? this.enableVibration,
      enableSoundFeedback: enableSoundFeedback ?? this.enableSoundFeedback,
      clearOnSubmit: clearOnSubmit ?? this.clearOnSubmit,
    );
  }
}
