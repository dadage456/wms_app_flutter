import 'package:equatable/equatable.dart';

abstract class AswhUpReceiveEvent extends Equatable {
  const AswhUpReceiveEvent();

  @override
  List<Object?> get props => [];
}

class SearchAswhUpReceiveTasksEvent extends AswhUpReceiveEvent {
  const SearchAswhUpReceiveTasksEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class RefreshAswhUpReceiveTasksEvent extends AswhUpReceiveEvent {
  const RefreshAswhUpReceiveTasksEvent();
}
