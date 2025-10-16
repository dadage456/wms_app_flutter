import 'package:equatable/equatable.dart';

abstract class OnlinePickWcsEvent extends Equatable {
  const OnlinePickWcsEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickWcsStarted extends OnlinePickWcsEvent {
  const OnlinePickWcsStarted(this.args);

  final Map<String, dynamic> args;

  @override
  List<Object?> get props => [args];
}

class OnlinePickWcsRefreshRequested extends OnlinePickWcsEvent {
  const OnlinePickWcsRefreshRequested();
}

class OnlinePickWcsSearchSubmitted extends OnlinePickWcsEvent {
  const OnlinePickWcsSearchSubmitted(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

class OnlinePickWcsResetCommandRequested extends OnlinePickWcsEvent {
  const OnlinePickWcsResetCommandRequested();
}

class OnlinePickWcsDownCommandRequested extends OnlinePickWcsEvent {
  const OnlinePickWcsDownCommandRequested();
}

class OnlinePickWcsStatusCleared extends OnlinePickWcsEvent {
  const OnlinePickWcsStatusCleared();
}

class OnlinePickWcsRecordCountChanged extends OnlinePickWcsEvent {
  const OnlinePickWcsRecordCountChanged(this.recordCount);

  final int recordCount;

  @override
  List<Object?> get props => [recordCount];
}
