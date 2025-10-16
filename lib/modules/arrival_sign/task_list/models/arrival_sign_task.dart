// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';

part 'arrival_sign_task.freezed.dart';
part 'arrival_sign_task.g.dart';

/// 到货签收任务列表数据模型
@freezed
class ArrivalSignTask with _$ArrivalSignTask {
  const factory ArrivalSignTask({
    @JsonKey(name: 'arrivalsBillid') required String arrivalsBillId,
    @JsonKey(name: 'arrivalsBillno') required String arrivalsBillNo,
    @JsonKey(name: 'orderno') required String orderNo,
    @JsonKey(name: 'poNumber') required String poNumber,
    @JsonKey(name: 'createdate') required String createDate,
    @JsonKey(name: 'werks') required String plant,
    @JsonKey(name: 'parname') required String supplierName,
    @JsonKey(name: 'status') String? status,
  }) = _ArrivalSignTask;

  factory ArrivalSignTask.fromJson(Map<String, dynamic> json) =>
      _$ArrivalSignTaskFromJson(json);
}

/// 到货签收任务分页数据
@freezed
class ArrivalSignTaskPage with _$ArrivalSignTaskPage {
  const factory ArrivalSignTaskPage({
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'rows') @Default(<ArrivalSignTask>[]) List<ArrivalSignTask> rows,
  }) = _ArrivalSignTaskPage;

  factory ArrivalSignTaskPage.fromJson(Map<String, dynamic> json) =>
      _$ArrivalSignTaskPageFromJson(json);
}

/// 到货签收任务列表查询参数
class ArrivalSignTaskQuery extends Equatable {
  const ArrivalSignTaskQuery({
    required this.userId,
    required this.roleOrUserId,
    this.searchKey = '',
    this.pageIndex = 1,
    this.pageSize = 100,
    this.sortType = '',
    this.sortColumn = '',
  });

  final String userId;
  final String roleOrUserId;
  final String searchKey;
  final int pageIndex;
  final int pageSize;
  final String sortType;
  final String sortColumn;

  ArrivalSignTaskQuery copyWith({
    String? userId,
    String? roleOrUserId,
    String? searchKey,
    int? pageIndex,
    int? pageSize,
    String? sortType,
    String? sortColumn,
  }) {
    return ArrivalSignTaskQuery(
      userId: userId ?? this.userId,
      roleOrUserId: roleOrUserId ?? this.roleOrUserId,
      searchKey: searchKey ?? this.searchKey,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      sortType: sortType ?? this.sortType,
      sortColumn: sortColumn ?? this.sortColumn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'roleoRuserId': roleOrUserId,
      'searchKey': searchKey,
      'pageIndex': pageIndex,
      'pageSize': pageSize,
      'sortType': sortType,
      'sortColumn': sortColumn,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        roleOrUserId,
        searchKey,
        pageIndex,
        pageSize,
        sortType,
        sortColumn,
      ];
}
