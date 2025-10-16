import 'dart:math';

/// 采集扫码类型。
enum OnlinePickScanType {
  location,
  material,
  tray,
  quantity,
}

/// 扫码解析结果。
class OnlinePickScanResult {
  const OnlinePickScanResult._({
    required this.type,
    required this.rawValue,
    required this.normalizedValue,
    this.quantity,
  });

  /// 扫码分类。
  final OnlinePickScanType type;

  /// 原始扫码内容。
  final String rawValue;

  /// 去除前后缀后的规范化内容。
  final String normalizedValue;

  /// 数量类型扫码解析出的值。
  final num? quantity;

  factory OnlinePickScanResult.location({
    required String raw,
    required String location,
  }) =>
      OnlinePickScanResult._(
        type: OnlinePickScanType.location,
        rawValue: raw,
        normalizedValue: location,
      );

  factory OnlinePickScanResult.material({
    required String raw,
    required String materialCode,
  }) =>
      OnlinePickScanResult._(
        type: OnlinePickScanType.material,
        rawValue: raw,
        normalizedValue: materialCode,
      );

  factory OnlinePickScanResult.tray({
    required String raw,
    required String trayNo,
  }) =>
      OnlinePickScanResult._(
        type: OnlinePickScanType.tray,
        rawValue: raw,
        normalizedValue: trayNo,
      );

  factory OnlinePickScanResult.quantity({
    required String raw,
    required num qty,
  }) =>
      OnlinePickScanResult._(
        type: OnlinePickScanType.quantity,
        rawValue: raw,
        normalizedValue: qty.toString(),
        quantity: qty,
      );
}

/// 在线拣选扫码解析工具。
class OnlinePickScannerParser {
  static const String _trayMarker = r'$TP$';
  static const String _locationMarker = r'$KW$';
  static final RegExp _quantityRegExp = RegExp(r'^-?\d+(?:\.\d+)?$');

  /// 尝试解析扫码内容，返回分类结果。
  /// - 物料二维码：包含 `MC`
  /// - 托盘：包含 `$TP$`
  /// - 库位：包含 `$KW$`
  /// - 数量：纯数字（支持小数）
  static OnlinePickScanResult parse(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      throw const FormatException('采集内容为空');
    }

    final upper = trimmed.toUpperCase();

    if (upper.contains(_locationMarker)) {
      return OnlinePickScanResult.location(
        raw: trimmed,
        location: _extractAfterMarker(trimmed, _locationMarker),
      );
    }

    if (upper.contains(_trayMarker)) {
      return OnlinePickScanResult.tray(
        raw: trimmed,
        trayNo: _extractAfterMarker(trimmed, _trayMarker),
      );
    }

    if (_looksLikeMaterial(upper)) {
      return OnlinePickScanResult.material(
        raw: trimmed,
        materialCode: _extractMaterialCode(trimmed),
      );
    }

    if (_quantityRegExp.hasMatch(trimmed)) {
      final qty = num.parse(trimmed);
      return OnlinePickScanResult.quantity(raw: trimmed, qty: qty);
    }

    throw FormatException('无法识别的采集内容：$input');
  }

  /// 判断是否为物料二维码，根据 `MC` 关键字。
  static bool _looksLikeMaterial(String upperCaseValue) {
    final index = upperCaseValue.indexOf('MC');
    if (index == -1) {
      return false;
    }
    // MC 需出现并且不是托盘/库位标识的一部分。
    return true;
  }

  /// 提取物料编码，以 `MC` 起始或包含时截取后续字段。
  static String _extractMaterialCode(String value) {
    final upper = value.toUpperCase();
    final index = upper.indexOf('MC');
    if (index == -1) {
      return value;
    }
    final candidate = value.substring(index + 2);
    if (candidate.isEmpty) {
      return value;
    }
    // 旧二维码可能使用分隔符 `|` 或 `,`。
    final separators = ['|', ',', ';', '\$', '#'];
    final separatorIndex = separators
        .map((separator) => candidate.indexOf(separator))
        .where((i) => i >= 0)
        .fold<int>(
          candidate.length,
          (previousValue, element) => min(previousValue, element),
        );

    final material = candidate.substring(0, separatorIndex).trim();
    return material.isEmpty ? value.trim() : material;
  }

  /// 提取 `$KW$`、`$TP$` 等标识后的值。
  static String _extractAfterMarker(String value, String marker) {
    final upper = value.toUpperCase();
    final markerIndex = upper.indexOf(marker);
    if (markerIndex == -1) {
      return value.trim();
    }
    final start = markerIndex + marker.length;
    final result = value.substring(start).trim();
    if (result.isEmpty) {
      return value.trim();
    }
    // 移除常见的多余分隔符。
    return result
        .replaceAll(RegExp(r'^[\:\-\|\,]+'), '')
        .replaceAll(RegExp(r'[\r\n]'), '')
        .trim();
  }
}
