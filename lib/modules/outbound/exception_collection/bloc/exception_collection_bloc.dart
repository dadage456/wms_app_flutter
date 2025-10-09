import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/collection_task/services/collection_service.dart';
import 'package:wms_app/modules/outbound/exception_collection/models/exception_collection_models.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/utils/error_handler.dart';

import 'exception_collection_event.dart';
import 'exception_collection_state.dart';

class ExceptionCollectionBloc
    extends Bloc<ExceptionCollectionEvent, ExceptionCollectionState> {
  final CollectionService _service;
  static const String _defaultProType = '平库下架';
  late OutboundTask _task;

  ExceptionCollectionBloc(this._service)
    : super(const ExceptionCollectionState()) {
    on<InitializeExceptionCollectionEvent>(_onInitialize);
    on<ExceptionTypeChangedEvent>(_onTypeChanged);
    on<ExceptionPerformScanEvent>(_onPerformScan);
    on<ExceptionSelectionChangedEvent>(_onSelectionChanged);
    on<ExceptionDeleteSelectedEvent>(_onDeleteSelected);
    on<ExceptionCommitRequestedEvent>(_onCommitRequested);
    on<ExceptionClearErrorEvent>(_onClearError);
    on<ExceptionClearMessageEvent>(_onClearMessage);
  }

  void _onInitialize(
    InitializeExceptionCollectionEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    _task = event.task;
    var nextState = state.copyWith(
      trayNo: event.trayNo,
      storeSite: event.initialStoreSite,
      barcodeContent: BarcodeContent.fromJson({}),
      collectQty: 0,
      matCode: '',
      batchNo: '',
      sn: '',
      matControlFlag: '',
    );
    nextState = _applyPlaceholder(nextState);
    emit(nextState);
  }

  void _onTypeChanged(
    ExceptionTypeChangedEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    emit(state.copyWith(exceptionType: event.type, exceptionName: event.name));
  }

  Future<void> _onPerformScan(
    ExceptionPerformScanEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) async {
    final barcode = event.barcode.trim();

    if (state.exceptionType.isEmpty) {
      emit(state.copyWith(error: '请指定异常类型!'));
      return;
    }

    if (barcode.isEmpty) {
      emit(state.copyWith(error: '采集内容为空,请重新采集!'));
      return;
    }

    try {
      var workingState = state;

      if (barcode.contains('MC')) {
        emit(workingState.copyWith(isLoading: true, error: null));
        final barcodeContent = await _service.getMaterialInfoByQR(barcode);
        workingState = state; // 更新为加载状态
        workingState = _handleQRCode(
          workingState.copyWith(isLoading: false),
          barcodeContent,
        );
      } else if (barcode.contains(r'$KW$')) {
        workingState = _handleSite(workingState.copyWith(error: null), barcode);
      } else if (barcode.contains(r'$TP$')) {
        emit(workingState.copyWith(isLoading: true, error: null));
        workingState = state;
        workingState = await _handleTray(
          workingState.copyWith(isLoading: false),
          barcode,
        );
      } else if (_isNumeric(barcode)) {
        workingState = _handleQuantity(workingState, barcode);
      } else {
        throw Exception('采集内容不合法!');
      }

      workingState = _applyPlaceholder(workingState);
      if (workingState.placeholder.isEmpty) {
        workingState = _finalizeCollection(workingState);
      }

      emit(workingState);
    } catch (e) {
      var resetState = state.copyWith(
        isLoading: false,
        error: _formatError(e),
        barcodeContent: BarcodeContent.fromJson({}),
        collectQty: 0,
        matCode: '',
        batchNo: '',
        sn: '',
        matControlFlag: '',
      );
      resetState = _applyPlaceholder(resetState);
      emit(resetState);
    }
  }

  ExceptionCollectionState _handleQRCode(
    ExceptionCollectionState current,
    BarcodeContent barcodeContent,
  ) {
    final matControl = barcodeContent.seqctrl?.toString() ?? '';
    final newMartTask = barcodeContent.id_old?.toString() ?? '';

    String newBatchNo = current.batchNo;
    String newSn = current.sn;
    double newCollectQty = current.collectQty;

    if (matControl == '0') {
      final snValue = barcodeContent.sn?.trim() ?? '';
      if (snValue.isEmpty) {
        throw Exception('物料【${barcodeContent.matcode ?? ''}】序列号不能为空');
      }
      newSn = snValue;
      newBatchNo = newMartTask == '1' ? (barcodeContent.batchno ?? '') : '';
      newCollectQty = 1;
    } else if (matControl == '1' || matControl == '2') {
      final batchValue = newMartTask == '1'
          ? (barcodeContent.batchno ?? '')
          : (barcodeContent.sn ?? '');
      if (batchValue.isEmpty) {
        throw Exception('物料【${barcodeContent.matcode ?? ''}】批次号不能为空');
      }
      newBatchNo = batchValue;
      newSn = newMartTask == '1' ? (barcodeContent.sn ?? '') : '';
      newCollectQty = 0;
    } else {
      throw Exception('物料${barcodeContent.matcode ?? ''}编码控制维护值维护不合法');
    }

    return current.copyWith(
      barcodeContent: barcodeContent,
      matCode: barcodeContent.matcode ?? '',
      matControlFlag: matControl,
      batchNo: newBatchNo,
      sn: newSn,
      collectQty: newCollectQty,
    );
  }

  ExceptionCollectionState _handleSite(
    ExceptionCollectionState current,
    String barcode,
  ) {
    final parts = barcode.split(r'$');
    if (parts.length < 3 || parts[2].isEmpty) {
      throw Exception('库位编码不合法');
    }
    return current.copyWith(storeSite: parts[2]);
  }

  Future<ExceptionCollectionState> _handleTray(
    ExceptionCollectionState current,
    String barcode,
  ) async {
    final parts = barcode.split(r'$');
    if (parts.length < 3 || parts[2].isEmpty) {
      throw Exception('托盘号不能为空');
    }
    final trayNo = parts[2];
    final storeSite = await _service.getPalletStoreSite(trayNo);
    if (storeSite == null || storeSite.isEmpty) {
      throw Exception('托盘未绑定库位');
    }
    return current.copyWith(trayNo: trayNo, storeSite: storeSite);
  }

  ExceptionCollectionState _handleQuantity(
    ExceptionCollectionState current,
    String barcode,
  ) {
    if (current.matCode.isEmpty) {
      throw Exception('请先扫描二维码');
    }
    if (current.matControlFlag == '0') {
      throw Exception('已采集序列号无需采集数量，请扫描二维码');
    }
    final qty = double.tryParse(barcode);
    if (qty == null || qty <= 0) {
      throw Exception('采集数量必须大于0');
    }
    return current.copyWith(collectQty: qty);
  }

  ExceptionCollectionState _finalizeCollection(
    ExceptionCollectionState current,
  ) {
    if (current.matCode.isEmpty) {
      throw Exception('请先扫描二维码');
    }
    if (current.collectQty <= 0) {
      throw Exception('采集数量必须大于0');
    }

    final id = const Uuid().v4();
    final item = ExceptionCollectionItem(
      id: id,
      matCode: current.matCode,
      storeSite: current.storeSite,
      exceptionName: current.exceptionName,
      qty: current.collectQty,
      batchNo: current.batchNo,
      sn: current.sn,
      storeRoom: _task.storeRoomNo,
      proType: _defaultProType,
      taskId: _task.outTaskId.toString(),
    );

    final stock = ExceptionStock(
      id: id,
      matCode: current.matCode,
      batchNo: current.batchNo,
      sn: current.sn,
      taskQty: 0,
      collectQty: current.collectQty,
      storeRoom: _task.storeRoomNo,
      storeSite: current.storeSite,
      taskId: _task.outTaskId.toString(),
      exceptionType: current.exceptionType,
    );

    final updatedItems = List<ExceptionCollectionItem>.from(current.items)
      ..add(item);
    final updatedStocks = List<ExceptionStock>.from(current.stocks)..add(stock);

    var nextState = current.copyWith(
      items: List.unmodifiable(updatedItems),
      stocks: List.unmodifiable(updatedStocks),
      selectedIds: const [],
      barcodeContent: BarcodeContent.fromJson({}),
      collectQty: 0,
      matCode: '',
      batchNo: '',
      sn: '',
      matControlFlag: '',
    );
    nextState = _applyPlaceholder(nextState);
    return nextState;
  }

  void _onSelectionChanged(
    ExceptionSelectionChangedEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    emit(state.copyWith(selectedIds: List.unmodifiable(event.selectedIds)));
  }

  void _onDeleteSelected(
    ExceptionDeleteSelectedEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    if (state.selectedIds.isEmpty) {
      emit(state.copyWith(error: '请至少选择一行记录'));
      return null;
    }

    final idSet = state.selectedIds.toSet();
    final remainingItems = state.items
        .where((item) => !idSet.contains(item.id))
        .toList();
    final remainingStocks = state.stocks
        .where((stock) => !idSet.contains(stock.id))
        .toList();

    emit(
      state.copyWith(
        items: List.unmodifiable(remainingItems),
        stocks: List.unmodifiable(remainingStocks),
        selectedIds: const [],
      ),
    );
  }

  Future<void> _onCommitRequested(
    ExceptionCommitRequestedEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) async {
    if (state.stocks.isEmpty) {
      emit(state.copyWith(error: '本次采集明细，请确认！'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final payload = state.stocks
          .map(
            (stock) => stock.toPayload(
              taskNo: _task.outTaskNo,
              proType: _defaultProType,
              proofNo: _task.taskComment,
            ),
          )
          .toList();

      await _service.commitExceptionShelves(payload);

      var clearedState = state.copyWith(
        isLoading: false,
        successMessage: '提交成功',
        items: const [],
        stocks: const [],
        selectedIds: const [],
        barcodeContent: BarcodeContent.fromJson({}),
        collectQty: 0,
        matCode: '',
        batchNo: '',
        sn: '',
        matControlFlag: '',
        storeSite: '',
      );
      clearedState = _applyPlaceholder(clearedState);
      emit(clearedState);
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: '提交异常：${ErrorHandler.handleError(e)}',
        ),
      );
    }
  }

  void _onClearError(
    ExceptionClearErrorEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    emit(state.copyWith(error: null));
  }

  void _onClearMessage(
    ExceptionClearMessageEvent event,
    Emitter<ExceptionCollectionState> emit,
  ) {
    emit(state.copyWith(successMessage: null));
  }

  ExceptionCollectionState _applyPlaceholder(ExceptionCollectionState current) {
    final placeholder = _computePlaceholder(current);
    return current.copyWith(
      placeholder: placeholder,
      focus: placeholder == '请输入数量',
    );
  }

  String _computePlaceholder(ExceptionCollectionState current) {
    if (current.storeSite.isEmpty) {
      return '请扫描库位';
    }
    if (current.matCode.isEmpty) {
      return '请扫描二维码';
    }
    if (current.matControlFlag == '0') {
      return '';
    }
    if (current.collectQty <= 0) {
      return '请输入数量';
    }
    return '';
  }

  String _formatError(Object error) {
    final message = error.toString();
    return message.replaceFirst('Exception: ', '');
  }

  bool _isNumeric(String value) {
    return RegExp(r'^[0-9]+(\.[0-9]+)?$').hasMatch(value);
  }
}
