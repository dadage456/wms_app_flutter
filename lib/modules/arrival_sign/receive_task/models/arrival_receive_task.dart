// ignore_for_file: invalid_annotation_target
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'arrival_receive_task.freezed.dart';
part 'arrival_receive_task.g.dart';

/// 接收到货任务数据模型
@freezed
class ArrivalReceiveTask with _$ArrivalReceiveTask {
  const factory ArrivalReceiveTask({
    @JsonKey(name: 'arrivalsBillid') required String arrivalsBillId,
    @JsonKey(name: 'arrivalsBillno') required String arrivalsBillNo,
    @JsonKey(name: 'orderno') required String orderNo,
    @JsonKey(name: 'poNumber') required String poNumber,
    @JsonKey(name: 'createdate') required String createDate,
    @JsonKey(name: 'werks') required String plant,
    @JsonKey(name: 'parname') required String supplierName,
  }) = _ArrivalReceiveTask;

  factory ArrivalReceiveTask.fromJson(Map<String, dynamic> json) =>
      _$ArrivalReceiveTaskFromJson(json);
}

@freezed
class ArrivalReceiveTaskPage with _$ArrivalReceiveTaskPage {
  const factory ArrivalReceiveTaskPage({
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'rows')
    @Default(<ArrivalReceiveTask>[])
    List<ArrivalReceiveTask> rows,
  }) = _ArrivalReceiveTaskPage;

  factory ArrivalReceiveTaskPage.fromJson(Map<String, dynamic> json) =>
      _$ArrivalReceiveTaskPageFromJson(json);
}

class ArrivalReceiveTaskQuery extends Equatable {
  const ArrivalReceiveTaskQuery({
    required this.userId,
    required this.roleOrUserId,
    this.searchKey = '',
    this.pageIndex = 1,
    this.pageSize = 100,
  });

  final String userId;
  final String roleOrUserId;
  final String searchKey;
  final int pageIndex;
  final int pageSize;

  ArrivalReceiveTaskQuery copyWith({
    String? userId,
    String? roleOrUserId,
    String? searchKey,
    int? pageIndex,
    int? pageSize,
  }) {
    return ArrivalReceiveTaskQuery(
      userId: userId ?? this.userId,
      roleOrUserId: roleOrUserId ?? this.roleOrUserId,
      searchKey: searchKey ?? this.searchKey,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'roleoRuserId': roleOrUserId,
      'searchKey': searchKey,
      'pageIndex': pageIndex,
      'pageSize': pageSize,
    };
  }

  @override
  List<Object?> get props => [userId, roleOrUserId, searchKey, pageIndex, pageSize];
}
