extension DoubleExtension on double {
  bool isInteger() => isFinite && this % 1 == 0;

  /// 有小数点时，保留小数，否则保留整数
  String toFormatString() {
    if (isInteger()) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}
