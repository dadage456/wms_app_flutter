import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/inventory_pallet_item.dart';
import '../services/aswh_inventory_pallet_service.dart';
import 'aswh_inventory_pallet_item_event.dart';
import 'aswh_inventory_pallet_item_state.dart';

class AswhInventoryPalletItemBloc
    extends Bloc<AswhInventoryPalletItemEvent, AswhInventoryPalletItemState> {
  AswhInventoryPalletItemBloc({
    required AswhInventoryPalletService service,
  })  : _service = service,
        super(const AswhInventoryPalletItemState()) {
    on<AswhInventoryPalletItemStarted>(_onStarted);
    on<AswhInventoryPalletItemKeywordChanged>(_onKeywordChanged);
    on<AswhInventoryPalletItemRefreshRequested>(_onRefreshRequested);
  }

  final AswhInventoryPalletService _service;

  Future<void> _onStarted(
    AswhInventoryPalletItemStarted event,
    Emitter<AswhInventoryPalletItemState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AswhInventoryPalletItemStatus.loading,
        trayNo: event.trayNo,
        clearMessage: true,
      ),
    );
    await _loadItems(event.trayNo, emit);
  }

  Future<void> _onRefreshRequested(
    AswhInventoryPalletItemRefreshRequested event,
    Emitter<AswhInventoryPalletItemState> emit,
  ) async {
    final trayNo = state.trayNo;
    if (trayNo == null || trayNo.isEmpty) {
      return;
    }
    emit(
      state.copyWith(
        status: AswhInventoryPalletItemStatus.loading,
        clearMessage: true,
      ),
    );
    await _loadItems(trayNo, emit);
  }

  void _onKeywordChanged(
    AswhInventoryPalletItemKeywordChanged event,
    Emitter<AswhInventoryPalletItemState> emit,
  ) {
    final keyword = event.keyword.trim();
    final filtered = _filterItems(keyword, state.items);
    emit(
      state.copyWith(
        keyword: keyword,
        filteredItems: filtered,
        clearMessage: true,
      ),
    );
  }

  Future<void> _loadItems(
    String trayNo,
    Emitter<AswhInventoryPalletItemState> emit,
  ) async {
    try {
      final items = await _service.fetchPalletItems(trayNo: trayNo);
      emit(
        state.copyWith(
          status: AswhInventoryPalletItemStatus.success,
          items: items,
          filteredItems: _filterItems(state.keyword, items),
          clearMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AswhInventoryPalletItemStatus.failure,
          message: '托盘明细加载失败：${error.toString()}',
        ),
      );
    }
  }

  List<InventoryPalletItem> _filterItems(
    String keyword,
    List<InventoryPalletItem> source,
  ) {
    if (keyword.isEmpty) {
      return List<InventoryPalletItem>.unmodifiable(source);
    }
    final lower = keyword.toLowerCase();
    return source
        .where((item) {
          return (item.palletNo ?? '').toLowerCase().contains(lower) ||
              (item.materialCode ?? '').toLowerCase().contains(lower) ||
              (item.materialName ?? '').toLowerCase().contains(lower) ||
              (item.batchNo ?? '').toLowerCase().contains(lower) ||
              (item.serialNo ?? '').toLowerCase().contains(lower) ||
              item.displayProofNo.toLowerCase().contains(lower);
        })
        .toList(growable: false);
  }
}
