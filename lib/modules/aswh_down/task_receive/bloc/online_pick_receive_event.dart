import 'package:equatable/equatable.dart';

abstract class OnlinePickReceiveEvent extends Equatable {
  const OnlinePickReceiveEvent();

  @override
  List<Object?> get props => [];
}

class OnlinePickReceiveStarted extends OnlinePickReceiveEvent {
  const OnlinePickReceiveStarted();
}

class OnlinePickReceiveSearchRequested extends OnlinePickReceiveEvent {
  const OnlinePickReceiveSearchRequested(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

class OnlinePickReceiveRefreshRequested extends OnlinePickReceiveEvent {
  const OnlinePickReceiveRefreshRequested();
}

class OnlinePickReceiveStatusCleared extends OnlinePickReceiveEvent {
  const OnlinePickReceiveStatusCleared();
}

class OnlinePickReceiveRecordCountChanged extends OnlinePickReceiveEvent {
  const OnlinePickReceiveRecordCountChanged(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}
