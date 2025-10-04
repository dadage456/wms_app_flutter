import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/exception_collection/models/exception_collection_models.dart';

class ExceptionCollectionState {
  final String placeholder;
  final bool focus;
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final String storeSite;
  final String trayNo;
  final BarcodeContent? barcodeContent;
  final double collectQty;
  final String exceptionType;
  final String exceptionName;
  final List<ExceptionCollectionItem> items;
  final List<String> selectedIds;
  final List<ExceptionStock> stocks;
  final String matCode;
  final String batchNo;
  final String sn;
  final String matControlFlag;

  const ExceptionCollectionState({
    this.placeholder = '请扫描库位',
    this.focus = false,
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.storeSite = '',
    this.trayNo = '',
    this.barcodeContent,
    this.collectQty = 0,
    this.exceptionType = '',
    this.exceptionName = '',
    this.items = const [],
    this.selectedIds = const [],
    this.stocks = const [],
    this.matCode = '',
    this.batchNo = '',
    this.sn = '',
    this.matControlFlag = '',
  });

  static const _undefined = Object();

  ExceptionCollectionState copyWith({
    String? placeholder,
    bool? focus,
    bool? isLoading,
    Object? error = _undefined,
    Object? successMessage = _undefined,
    String? storeSite,
    String? trayNo,
    Object? barcodeContent = _undefined,
    double? collectQty,
    String? exceptionType,
    String? exceptionName,
    List<ExceptionCollectionItem>? items,
    List<String>? selectedIds,
    List<ExceptionStock>? stocks,
    String? matCode,
    String? batchNo,
    String? sn,
    String? matControlFlag,
  }) {
    return ExceptionCollectionState(
      placeholder: placeholder ?? this.placeholder,
      focus: focus ?? this.focus,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _undefined) ? this.error : error as String?,
      successMessage: identical(successMessage, _undefined)
          ? this.successMessage
          : successMessage as String?,
      storeSite: storeSite ?? this.storeSite,
      trayNo: trayNo ?? this.trayNo,
      barcodeContent: identical(barcodeContent, _undefined)
          ? this.barcodeContent
          : barcodeContent as BarcodeContent?,
      collectQty: collectQty ?? this.collectQty,
      exceptionType: exceptionType ?? this.exceptionType,
      exceptionName: exceptionName ?? this.exceptionName,
      items: items ?? this.items,
      selectedIds: selectedIds ?? this.selectedIds,
      stocks: stocks ?? this.stocks,
      matCode: matCode ?? this.matCode,
      batchNo: batchNo ?? this.batchNo,
      sn: sn ?? this.sn,
      matControlFlag: matControlFlag ?? this.matControlFlag,
    );
  }
}
