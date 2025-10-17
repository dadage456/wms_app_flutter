part of 'aswh_up_collection_bloc.dart';

abstract class AswhUpCollectionEvent extends Equatable {
  const AswhUpCollectionEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAswhUpCollectionEvent extends AswhUpCollectionEvent {
  const InitializeAswhUpCollectionEvent({required this.userId});

  final int userId;

  @override
  List<Object?> get props => [userId];
}

class AswhUpPerformScanEvent extends AswhUpCollectionEvent {
  const AswhUpPerformScanEvent(this.payload);

  final String payload;

  @override
  List<Object?> get props => [payload];
}

class AswhUpChangeTabEvent extends AswhUpCollectionEvent {
  const AswhUpChangeTabEvent(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class AswhUpUpdateSelectionEvent extends AswhUpCollectionEvent {
  const AswhUpUpdateSelectionEvent(this.selectedIds);

  final List<int> selectedIds;

  @override
  List<Object?> get props => [selectedIds];
}

class AswhUpSubmitEvent extends AswhUpCollectionEvent {
  const AswhUpSubmitEvent({this.weight, this.capacity});

  final String? weight;
  final String? capacity;

  @override
  List<Object?> get props => [weight, capacity];
}

class AswhUpResetStatusEvent extends AswhUpCollectionEvent {
  const AswhUpResetStatusEvent();
}

class AswhUpRequestFocusEvent extends AswhUpCollectionEvent {
  const AswhUpRequestFocusEvent(this.focused);

  final bool focused;

  @override
  List<Object?> get props => [focused];
}

class AswhUpDeleteStocksEvent extends AswhUpCollectionEvent {
  const AswhUpDeleteStocksEvent(this.stockIds);

  final List<String> stockIds;

  @override
  List<Object?> get props => [stockIds];
}

class AswhUpUpdateFromResultEvent extends AswhUpCollectionEvent {
  const AswhUpUpdateFromResultEvent(this.deletedStocks);

  final List<AswhUpCollectionStock> deletedStocks;

  @override
  List<Object?> get props => [deletedStocks];
}

class AswhUpClearCacheEvent extends AswhUpCollectionEvent {
  const AswhUpClearCacheEvent();
}

class AswhUpConfirmTrayChangeEvent extends AswhUpCollectionEvent {
  const AswhUpConfirmTrayChangeEvent({required this.confirmed});

  final bool confirmed;

  @override
  List<Object?> get props => [confirmed];
}
