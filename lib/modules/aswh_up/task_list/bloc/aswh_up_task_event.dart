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

class ClearAswhUpTaskMessageEvent extends AswhUpTaskEvent {
  const ClearAswhUpTaskMessageEvent();
}

class _GridStateChangedEvent extends AswhUpTaskEvent {
  const _GridStateChangedEvent({
    required this.currentPage,
    required this.total,
    required this.showEmptyMessage,
  });

  final int currentPage;
  final int total;
  final bool showEmptyMessage;

  @override
  List<Object?> get props => [currentPage, total, showEmptyMessage];
}
