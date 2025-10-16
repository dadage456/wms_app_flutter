import 'package:equatable/equatable.dart';

abstract class AswhInventoryPalletItemEvent extends Equatable {
  const AswhInventoryPalletItemEvent();

  @override
  List<Object?> get props => [];
}

class AswhInventoryPalletItemStarted extends AswhInventoryPalletItemEvent {
  const AswhInventoryPalletItemStarted({required this.trayNo});

  final String trayNo;

  @override
  List<Object?> get props => [trayNo];
}

class AswhInventoryPalletItemKeywordChanged
    extends AswhInventoryPalletItemEvent {
  const AswhInventoryPalletItemKeywordChanged(this.keyword);

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}

class AswhInventoryPalletItemRefreshRequested
    extends AswhInventoryPalletItemEvent {
  const AswhInventoryPalletItemRefreshRequested();
}
