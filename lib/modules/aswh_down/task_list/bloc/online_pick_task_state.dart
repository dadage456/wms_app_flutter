import 'package:equatable/equatable.dart';
import 'package:wms_app/models/page_status.dart';

class OnlinePickTaskState extends Equatable {
  const OnlinePickTaskState({
    this.status = const CollectionStatus(CollectionStatusType.normal),
    this.searchKeyword = '',
    this.finishFlag = '0',
  });

  final CollectionStatus status;
  final String searchKeyword;
  final String finishFlag;

  OnlinePickTaskState copyWith({
    CollectionStatus? status,
    String? searchKeyword,
    String? finishFlag,
  }) {
    return OnlinePickTaskState(
      status: status ?? this.status,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      finishFlag: finishFlag ?? this.finishFlag,
    );
  }

  @override
  List<Object?> get props => [status, searchKeyword, finishFlag];
}
