import 'package:freezed_annotation/freezed_annotation.dart';

import 'arrival_collect_progress.dart';

part 'arrival_collect_submit_request.freezed.dart';
part 'arrival_collect_submit_request.g.dart';

@freezed
class ArrivalCollectSubmitRequest with _$ArrivalCollectSubmitRequest {
  const factory ArrivalCollectSubmitRequest({
    @JsonKey(name: 'upShelvesInfos')
    @Default(<ArrivalCollectSubmitItem>[])
    List<ArrivalCollectSubmitItem> upShelvesInfos,
    @JsonKey(name: 'itemListInfos')
    @Default(<ArrivalCollectSubmitItem>[])
    List<ArrivalCollectSubmitItem> itemListInfos,
    @JsonKey(name: 'filter') ArrivalCollectSubmitFilter? filter,
  }) = _ArrivalCollectSubmitRequest;

  factory ArrivalCollectSubmitRequest.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectSubmitRequestFromJson(json);

  factory ArrivalCollectSubmitRequest.fromProgressList({
    required List<ArrivalCollectProgress> progresses,
    required String? userCode,
    required String? arrivalsBillId,
  }) {
    final items = progresses
        .map(
          (progress) => ArrivalCollectSubmitItem(
            matCode: progress.task.materialCode,
            batchNo: progress.batchNo ?? progress.task.batchNo,
            serialNumber: progress.serialNumber ?? progress.task.serialNumber,
            quantity: progress.collectQty,
          ),
        )
        .toList();

    return ArrivalCollectSubmitRequest(
      upShelvesInfos: items,
      itemListInfos: items,
      filter: ArrivalCollectSubmitFilter(
        userCode: userCode ?? '',
        arrivalsBillId: arrivalsBillId ?? '',
      ),
    );
  }
}

@freezed
class ArrivalCollectSubmitItem with _$ArrivalCollectSubmitItem {
  const factory ArrivalCollectSubmitItem({
    @JsonKey(name: 'matcode') required String matCode,
    @JsonKey(name: 'batchno') String? batchNo,
    @JsonKey(name: 'sn') String? serialNumber,
    @JsonKey(name: 'qty') required double quantity,
  }) = _ArrivalCollectSubmitItem;

  factory ArrivalCollectSubmitItem.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectSubmitItemFromJson(json);
}

@freezed
class ArrivalCollectSubmitFilter with _$ArrivalCollectSubmitFilter {
  const factory ArrivalCollectSubmitFilter({
    @JsonKey(name: 'userCode') required String userCode,
    @JsonKey(name: 'arrivalsBillid') required String arrivalsBillId,
  }) = _ArrivalCollectSubmitFilter;

  factory ArrivalCollectSubmitFilter.fromJson(Map<String, dynamic> json) =>
      _$ArrivalCollectSubmitFilterFromJson(json);
}
