import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_pallet_item.freezed.dart';
part 'inventory_pallet_item.g.dart';

@freezed
class InventoryPalletItem with _$InventoryPalletItem {
  const factory InventoryPalletItem({
    @JsonKey(name: 'palletNo') String? palletNo,
    @JsonKey(name: 'matcode') String? materialCode,
    @JsonKey(name: 'matname') String? materialName,
    @JsonKey(name: 'itemBatch') String? batchNo,
    @JsonKey(name: 'itemSn') String? serialNo,
    @JsonKey(name: 'itemQty', fromJson: _toDouble, toJson: _doubleToJson)
    double? quantity,
    @JsonKey(name: 'proofno') String? proofNo,
    @JsonKey(name: 'proofNo') String? proofNoAlt,
    @JsonKey(name: 'storesite') String? storeSite,
    @JsonKey(name: 'storeroomno') String? storeRoom,
  }) = _InventoryPalletItem;

  const InventoryPalletItem._();

  String get displayProofNo => proofNo ?? proofNoAlt ?? '';

  factory InventoryPalletItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryPalletItemFromJson(json);
}

double? _toDouble(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse(value.toString());
}

Object? _doubleToJson(double? value) => value;
