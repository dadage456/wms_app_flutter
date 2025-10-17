import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../utils/error_handler.dart';
import '../models/inventory_barcode_material.dart';
import '../models/inventory_query_request.dart';
import '../models/inventory_record.dart';
import '../models/inventory_summary.dart';
import '../services/inventory_query_service.dart';
import 'inventory_query_event.dart';
import 'inventory_query_state.dart';

class InventoryQueryBloc
    extends Bloc<InventoryQueryEvent, InventoryQueryState> {
  InventoryQueryBloc({required InventoryQueryService service})
    : _service = service,
      super(const InventoryQueryState()) {
    on<InventoryQueryEvent>(_onEvent);
  }

  final InventoryQueryService _service;

  Future<void> _onEvent(
    InventoryQueryEvent event,
    Emitter<InventoryQueryState> emit,
  ) async {
    await event.map(
      initialized: (_) => _handleInitialized(emit),
      modeChanged: (value) => _handleModeChanged(value.mode, emit),
      barcodeScanned: (value) => _handleBarcodeScanned(value.raw, emit),
      manualSubmitted: (value) => _handleManualSubmitted(value.input, emit),
      pageChanged: (value) => _handlePageChanged(value.pageIndex, emit),
      resetRequested: (_) => _handleResetRequested(emit),
    );
  }

  Future<void> _handleInitialized(Emitter<InventoryQueryState> emit) async {
    emit(state.copyWith(focusTick: state.focusTick + 1));
  }

  Future<void> _handleModeChanged(
    InventoryQueryMode mode,
    Emitter<InventoryQueryState> emit,
  ) async {
    emit(state.copyWith(selectedMode: mode));
  }

  Future<void> _handleBarcodeScanned(
    String raw,
    Emitter<InventoryQueryState> emit,
  ) async {
    await _performQuery(
      emit: emit,
      rawInput: raw,
      detectedMode: null,
      targetPage: 1,
    );
  }

  Future<void> _handleManualSubmitted(
    String input,
    Emitter<InventoryQueryState> emit,
  ) async {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      emit(
        state.copyWith(
          status: PageStatus.failure,
          errorMessage: '采集内容为空，请重新采集',
          records: const [],
          total: 0,
          focusTick: state.focusTick + 1,
        ),
      );
      return;
    }

    await _performQuery(
      emit: emit,
      rawInput: trimmed,
      detectedMode: state.selectedMode,
      targetPage: 1,
    );
  }

  Future<void> _handlePageChanged(
    int pageIndex,
    Emitter<InventoryQueryState> emit,
  ) async {
    if (state.queryValue == null) {
      emit(
        state.copyWith(
          status: PageStatus.failure,
          errorMessage: '请先扫描或输入查询条件',
          focusTick: state.focusTick + 1,
        ),
      );
      return;
    }

    await _performQuery(
      emit: emit,
      rawInput: state.queryValue!,
      detectedMode: state.selectedMode,
      targetPage: pageIndex,
      useCachedValue: true,
    );
  }

  Future<void> _handleResetRequested(Emitter<InventoryQueryState> emit) async {
    emit(const InventoryQueryState());
    emit(state.copyWith(focusTick: state.focusTick + 1));
  }

  Future<void> _performQuery({
    required Emitter<InventoryQueryState> emit,
    required String rawInput,
    InventoryQueryMode? detectedMode,
    required int targetPage,
    bool useCachedValue = false,
  }) async {
    try {
      final mode = detectedMode ?? _resolveMode(rawInput);
      String normalizedValue = rawInput;
      InventoryBarcodeMaterial? barcodeMaterial;
      InventorySummary summary = const InventorySummary();

      if (!useCachedValue) {
        switch (mode) {
          case InventoryQueryMode.material:
            final material = await _service.getMaterialInfoByQr(rawInput);
            barcodeMaterial = material;
            normalizedValue = material.matcode;
            summary = summary.copyWith(
              materialCode: material.matcode,
              materialName: material.matname,
            );
            break;
          case InventoryQueryMode.storeSite:
            normalizedValue = _extractByDelimiter(rawInput, '库位号不能为空!');
            summary = summary.copyWith(storeSite: normalizedValue);
            break;
          case InventoryQueryMode.tray:
            normalizedValue = _extractByDelimiter(rawInput, '托盘号不能为空!');
            summary = summary.copyWith(trayNo: normalizedValue);
            break;
        }
      } else {
        summary = state.summary;
        barcodeMaterial = state.barcodeMaterial;
        normalizedValue = state.queryValue ?? rawInput;
      }

      if (normalizedValue.isEmpty) {
        throw Exception('采集内容不合法');
      }

      emit(
        state.copyWith(
          status: PageStatus.loading,
          errorMessage: null,
          currentPage: targetPage,
          records: const [],
          total: 0,
          barcodeMaterial: barcodeMaterial,
          selectedMode: mode,
          summary: summary,
        ),
      );

      final response = await _service.getInventoryByBarcode(
        InventoryQueryRequest(
          barcode: normalizedValue,
          queryType: mode.apiCode,
          pageIndex: targetPage,
          pageSize: state.pageSize,
        ),
      );

      final totalQuantity = response.rows.fold<double>(
        0,
        (previousValue, element) => previousValue + element.repqty,
      );

      final updatedSummary = summary.copyWith(totalQuantity: totalQuantity);

      emit(
        state.copyWith(
          status: PageStatus.success,
          barcodeMaterial: barcodeMaterial,
          summary: updatedSummary,
          records: response.rows,
          total: response.total,
          queryValue: normalizedValue,
          currentPage: targetPage,
          selectedMode: mode,
          focusTick: state.focusTick + 1,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: PageStatus.failure,
          errorMessage: ErrorHandler.handleError(error),
          records: const [],
          total: 0,
          focusTick: state.focusTick + 1,
        ),
      );
    }
  }

  InventoryQueryMode _resolveMode(String raw) {
    final upper = raw.toUpperCase();
    if (upper.contains('MC')) {
      return InventoryQueryMode.material;
    }
    if (upper.contains(r'$KW$')) {
      return InventoryQueryMode.storeSite;
    }
    if (upper.contains(r'$TP$')) {
      return InventoryQueryMode.tray;
    }
    throw Exception('采集内容不合法');
  }

  String _extractByDelimiter(String raw, String emptyMessage) {
    final segments = raw.split(r'$');
    if (segments.length < 3 || segments[2].trim().isEmpty) {
      throw Exception(emptyMessage);
    }
    return segments[2].trim();
  }
}
