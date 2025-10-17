import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_query_request.freezed.dart';
part 'inventory_query_request.g.dart';

/// 请求库存查询的参数模型。
@freezed
class InventoryQueryRequest with _$InventoryQueryRequest {
  const factory InventoryQueryRequest({
    /// 查询条件，物料/库位/托盘均通过 barcode 字段传递。
    @JsonKey(name: 'barcode') required String barcode,

    /// 查询类型，M=物料，S=库位，P=托盘。
    @JsonKey(name: 'currStep') required String queryType,

    /// 页码（后端接口使用大写字段名）。
    @JsonKey(name: 'PageIndex') @Default(1) int pageIndex,

    /// 页大小（后端接口使用大写字段名）。
    @JsonKey(name: 'PageSize') @Default(10000) int pageSize,
  }) = _InventoryQueryRequest;

  const InventoryQueryRequest._();

  factory InventoryQueryRequest.fromJson(Map<String, dynamic> json) =>
      _$InventoryQueryRequestFromJson(json);
}

/// 查询类型的枚举，便于在 BLoC 与 UI 层之间传递。
enum InventoryQueryMode { material, storeSite, tray }

extension InventoryQueryModeX on InventoryQueryMode {
  String get apiCode {
    switch (this) {
      case InventoryQueryMode.material:
        return 'M';
      case InventoryQueryMode.storeSite:
        return 'S';
      case InventoryQueryMode.tray:
        return 'P';
    }
  }

  String get displayName {
    switch (this) {
      case InventoryQueryMode.material:
        return '物料';
      case InventoryQueryMode.storeSite:
        return '库位';
      case InventoryQueryMode.tray:
        return '托盘';
    }
  }
}
