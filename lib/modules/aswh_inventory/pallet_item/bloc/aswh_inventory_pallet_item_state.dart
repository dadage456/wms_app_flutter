import 'package:equatable/equatable.dart';

import '../models/inventory_pallet_item.dart';

enum AswhInventoryPalletItemStatus { initial, loading, success, failure }

class AswhInventoryPalletItemState extends Equatable {
  const AswhInventoryPalletItemState({
    this.status = AswhInventoryPalletItemStatus.initial,
    this.items = const [],
    this.filteredItems = const [],
    this.keyword = '',
    this.message,
    this.trayNo,
  });

  final AswhInventoryPalletItemStatus status;
  final List<InventoryPalletItem> items;
  final List<InventoryPalletItem> filteredItems;
  final String keyword;
  final String? message;
  final String? trayNo;

  bool get isEmpty =>
      status == AswhInventoryPalletItemStatus.success && filteredItems.isEmpty;

  AswhInventoryPalletItemState copyWith({
    AswhInventoryPalletItemStatus? status,
    List<InventoryPalletItem>? items,
    List<InventoryPalletItem>? filteredItems,
    String? keyword,
    String? message,
    bool clearMessage = false,
    String? trayNo,
  }) {
    return AswhInventoryPalletItemState(
      status: status ?? this.status,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      keyword: keyword ?? this.keyword,
      message: clearMessage ? null : message ?? this.message,
      trayNo: trayNo ?? this.trayNo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        filteredItems,
        keyword,
        message,
        trayNo,
      ];
}
