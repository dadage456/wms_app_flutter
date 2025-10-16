import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';

class OnlinePickReceiveState extends Equatable {
  const OnlinePickReceiveState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.searchKeyword = '',
    this.recordCount = 0,
  });

  final CollectionStatus status;
  final String searchKeyword;
  final int recordCount;

  OnlinePickReceiveState copyWith({
    CollectionStatus? status,
    String? searchKeyword,
    int? recordCount,
  }) {
    return OnlinePickReceiveState(
      status: status ?? this.status,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      recordCount: recordCount ?? this.recordCount,
    );
  }

  @override
  List<Object?> get props => [status, searchKeyword, recordCount];
}
