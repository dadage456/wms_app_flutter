import 'package:equatable/equatable.dart';

abstract class GoodsUpTaskEvent extends Equatable {
  const GoodsUpTaskEvent();

  @override
  List<Object?> get props => [];
}

class SearchGoodsUpTasksEvent extends GoodsUpTaskEvent {
  const SearchGoodsUpTasksEvent(this.searchKey);

  final String searchKey;

  @override
  List<Object?> get props => [searchKey];
}

class RefreshGoodsUpTasksEvent extends GoodsUpTaskEvent {
  const RefreshGoodsUpTasksEvent();
}
