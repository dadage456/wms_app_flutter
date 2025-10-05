enum CollectionStatusType {
  normal,
  // 加载中
  loading,
  // 错误
  error,
  // 成功
  success,
}

class CollectionStatus {
  final CollectionStatusType type;
  final String? message;

  const CollectionStatus(this.type, [this.message]);

  factory CollectionStatus.normal() {
    return const CollectionStatus(CollectionStatusType.normal);
  }

  factory CollectionStatus.loading() {
    return const CollectionStatus(CollectionStatusType.loading);
  }

  factory CollectionStatus.error([String? message]) {
    return CollectionStatus(CollectionStatusType.error, message);
  }

  factory CollectionStatus.success([String? message]) {
    return CollectionStatus(CollectionStatusType.success, message);
  }

  CollectionStatus copyWith({CollectionStatusType? type, String? message}) {
    return CollectionStatus(type ?? this.type, message ?? this.message);
  }

  bool get isNormal => type == CollectionStatusType.normal;
  bool get isLoading => type == CollectionStatusType.loading;
  bool get isError => type == CollectionStatusType.error;
  bool get isSuccess => type == CollectionStatusType.success;
}
