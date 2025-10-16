// ignore_for_file: invalid_annotation_target
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_sign_detail.freezed.dart';
part 'arrival_sign_detail.g.dart';

/// 到货任务明细数据
@freezed
class ArrivalSignDetail with _$ArrivalSignDetail {
  const factory ArrivalSignDetail({
    @JsonKey(name: 'matcode') required String materialCode,
    @JsonKey(name: 'matname') required String materialName,
    @JsonKey(name: 'parname') String? supplierName,
    @JsonKey(name: 'qty') @Default(0) num quantity,
    @JsonKey(name: 'goodqty') @Default(0) num goodQuantity,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNumber,
    @JsonKey(name: 'subinventoryCode') String? subInventoryCode,
    @JsonKey(name: 'posnr') String? position,
    @JsonKey(name: 'matcodecontrol') String? controlType,
    @JsonKey(name: 'orderno') String? orderNo,
    @JsonKey(name: 'arrivalsBillno') String? arrivalsBillNo,
    @JsonKey(name: 'pdate') String? productionDate,
    @JsonKey(name: 'vdays') String? validDays,
  }) = _ArrivalSignDetail;

  factory ArrivalSignDetail.fromJson(Map<String, dynamic> json) =>
      _$ArrivalSignDetailFromJson(json);
}

/// 到货任务明细分页数据
@freezed
class ArrivalSignDetailPage with _$ArrivalSignDetailPage {
  const factory ArrivalSignDetailPage({
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'rows')
    @Default(<ArrivalSignDetail>[])
    List<ArrivalSignDetail> rows,
  }) = _ArrivalSignDetailPage;

  factory ArrivalSignDetailPage.fromJson(Map<String, dynamic> json) =>
      _$ArrivalSignDetailPageFromJson(json);
}

class ArrivalSignDetailQuery extends Equatable {
  const ArrivalSignDetailQuery({
    required this.arrivalsBillId,
    this.searchKey = '',
    this.pageIndex = 1,
    this.pageSize = 100,
  });

  final String arrivalsBillId;
  final String searchKey;
  final int pageIndex;
  final int pageSize;

  ArrivalSignDetailQuery copyWith({
    String? arrivalsBillId,
    String? searchKey,
    int? pageIndex,
    int? pageSize,
  }) {
    return ArrivalSignDetailQuery(
      arrivalsBillId: arrivalsBillId ?? this.arrivalsBillId,
      searchKey: searchKey ?? this.searchKey,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'arrivalsBillid': arrivalsBillId,
      'searchKey': searchKey,
      'pageIndex': pageIndex,
      'pageSize': pageSize,
    };
  }

  @override
  List<Object?> get props => [arrivalsBillId, searchKey, pageIndex, pageSize];
}
