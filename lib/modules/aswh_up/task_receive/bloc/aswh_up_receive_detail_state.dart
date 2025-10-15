import 'package:equatable/equatable.dart';

class AswhUpReceiveDetailState extends Equatable {
  const AswhUpReceiveDetailState({this.errorMessage});

  final String? errorMessage;

  AswhUpReceiveDetailState copyWith({String? errorMessage}) {
    return AswhUpReceiveDetailState(
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [errorMessage];
}
