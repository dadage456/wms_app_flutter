import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_pick_wcs_models.freezed.dart';
part 'online_pick_wcs_models.g.dart';

/// WMS ↔ WCS 指令记录。
@freezed
class OnlinePickWcsCommand with _$OnlinePickWcsCommand {
  const factory OnlinePickWcsCommand({
    @JsonKey(name: 'interfaceWmsToWcsId') String? commandId,
    @JsonKey(name: 'taskId') String? taskId,
    @JsonKey(name: 'taskNo') String? taskNo,
    @JsonKey(name: 'proofno') String? proofNo,
    @JsonKey(name: 'proofid') String? proofId,
    @JsonKey(name: 'palno') String? palletNo,
    @JsonKey(name: 'saddr') String? startAddress,
    @JsonKey(name: 'daddr') String? destinationAddress,
    @JsonKey(name: 'dvno') String? stackerNo,
    @JsonKey(name: 'sendtime2') String? sendTime,
    @JsonKey(name: 'state2') String? state,
    @JsonKey(name: 'tasktype2') String? taskType,
    @JsonKey(name: 'changetype2') String? changeType,
    @JsonKey(name: 'typ2') String? ioType,
    @JsonKey(name: 'weightGrade2') String? weightGrade,
    @JsonKey(name: 'highGrade2') String? heightGrade,
    @JsonKey(name: 'wcsErrMessage2') String? errorMessage,
  }) = _OnlinePickWcsCommand;

  factory OnlinePickWcsCommand.fromJson(Map<String, dynamic> json) =>
      _$OnlinePickWcsCommandFromJson(json);
}
