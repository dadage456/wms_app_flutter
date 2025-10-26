import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'aswh_up_task.freezed.dart';
part 'aswh_up_task.g.dart';

@freezed
@HiveType(typeId: 20)
class AswhUpTask extends HiveObject with _$AswhUpTask {
  AswhUpTask._();

  factory AswhUpTask({
    @JsonKey(name: 'intaskid') @HiveField(0) @Default(0) int inTaskId,
    @JsonKey(name: 'intaskno') @HiveField(1) @Default('') String inTaskNo,
    @JsonKey(name: 'data2') @HiveField(2) String? inboundOrderNo,
    @JsonKey(name: 'data3') @HiveField(3) String? sourceOrderNo,
    @JsonKey(name: 'storeroomno') @HiveField(4) String? storeRoomNo,
    @JsonKey(name: 'workstation') @HiveField(5) String? workStation,
    @JsonKey(name: 'parname') @HiveField(6) String? partnerName,
    @JsonKey(name: 'taskcomment') @HiveField(7) String? taskComment,
    @JsonKey(name: 'taskqty') @HiveField(8) @Default(0) num taskQty,
    @JsonKey(name: 'finishqty') @HiveField(9) @Default(0) num finishQty,
  }) = _AswhUpTask;

  factory AswhUpTask.fromJson(Map<String, dynamic> json) =>
      _$AswhUpTaskFromJson(json);
}

@freezed
class AswhUpTaskListData with _$AswhUpTaskListData {
  const factory AswhUpTaskListData({
    @Default(0) int total,
    @Default(<AswhUpTask>[]) List<AswhUpTask> rows,
  }) = _AswhUpTaskListData;

  factory AswhUpTaskListData.fromJson(Map<String, dynamic> json) =>
      _$AswhUpTaskListDataFromJson(json);
}

int _stringToInt(Object? value) {
  if (value == null) {
    return 0;
  }
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String && value.isNotEmpty) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

String _intToString(int value) => value.toString();

@freezed
class AswhUpTaskQuery with _$AswhUpTaskQuery {
  const factory AswhUpTaskQuery({
    @JsonKey(includeToJson: false) @Default('') String sortType,
    @JsonKey(includeToJson: false) @Default('') String sortColumn,
    @Default('') String searchKey,
    @Default('') String userId,
    @JsonKey(name: 'roleoRuserId') @Default('') String roleOrUserId,
    @JsonKey(name: 'roomTag') @Default('0') String roomTag,
    @JsonKey(name: 'batchflag') @Default('0') String batchFlag,
    @Default('0') String transferType,
    @JsonKey(name: 'beatflag') @Default('N') String beatFlag,
    @JsonKey(name: 'PageIndex', fromJson: _stringToInt, toJson: _intToString)
    @Default(1)
    int pageIndex,
    @JsonKey(name: 'PageSize', fromJson: _stringToInt, toJson: _intToString)
    @Default(100)
    int pageSize,
    @JsonKey(name: 'finshFlg') @Default('0') String finishFlag,
  }) = _AswhUpTaskQuery;

  factory AswhUpTaskQuery.fromJson(Map<String, dynamic> json) =>
      _$AswhUpTaskQueryFromJson(json);
}
