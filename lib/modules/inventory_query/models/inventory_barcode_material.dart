import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_barcode_material.freezed.dart';
part 'inventory_barcode_material.g.dart';

/// 解析条码后的物料信息。
@freezed
class InventoryBarcodeMaterial with _$InventoryBarcodeMaterial {
  const factory InventoryBarcodeMaterial({
    @Default('') String matcode,
    @Default('') String matname,
    @Default('') String qty,
    @Default('') String batchno,
    @Default('') String sn,
    @Default('') String pdate,
    @Default('') String vdays,
    @Default('') String seqctrl,
    @JsonKey(name: 'id_old') @Default('') String idOld,
  }) = _InventoryBarcodeMaterial;

  factory InventoryBarcodeMaterial.fromJson(Map<String, dynamic> json) =>
      _$InventoryBarcodeMaterialFromJson(json);
}
