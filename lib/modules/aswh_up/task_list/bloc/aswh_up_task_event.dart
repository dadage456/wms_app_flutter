import 'package:equatable/equatable.dart';

abstract class AswhUpTaskEvent extends Equatable {
  const AswhUpTaskEvent();

  @override
  List<Object?> get props => [];
}

class SearchAswhUpTasksEvent extends AswhUpTaskEvent {
  const SearchAswhUpTasksEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class RefreshAswhUpTasksEvent extends AswhUpTaskEvent {
  const RefreshAswhUpTasksEvent();
}
