import 'package:equatable/equatable.dart';

class GoodsUpTaskState extends Equatable {
  const GoodsUpTaskState({this.finishFlag = '0'});

  final String finishFlag;

  GoodsUpTaskState copyWith({String? finishFlag}) {
    return GoodsUpTaskState(finishFlag: finishFlag ?? this.finishFlag);
  }

  @override
  List<Object?> get props => [finishFlag];
}
