import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/page_status.dart';
import '../../../../utils/error_handler.dart';
import '../../models/aswh_up_collection_models.dart';
import '../../models/aswh_up_task.dart';
import '../../services/aswh_up_task_service.dart';
import '../../task_details/models/aswh_up_task_detail_item.dart';

part 'aswh_up_collection_event.dart';
part 'aswh_up_collection_state.dart';

class AswhUpCollectionBloc
    extends Bloc<AswhUpCollectionEvent, AswhUpCollectionState> {
  AswhUpCollectionBloc({
    required AswhUpTask task,
    required AswhUpTaskService service,
  })  : _task = task,
        _service = service,
        super(AswhUpCollectionState.initial(task)) {
    on<InitializeAswhUpCollectionEvent>(_onInitialize);
    on<AswhUpPerformScanEvent>(_onPerformScan);
    on<AswhUpChangeTabEvent>(_onChangeTab);
    on<AswhUpUpdateSelectionEvent>(_onUpdateSelection);
    on<AswhUpSubmitEvent>(_onSubmit);
    on<AswhUpResetStatusEvent>(_onResetStatus);
    on<AswhUpRequestFocusEvent>(_onRequestFocus);
    on<AswhUpDeleteStocksEvent>(_onDeleteStocks);
    on<AswhUpUpdateFromResultEvent>(_onUpdateFromResult);
    on<AswhUpClearCacheEvent>(_onClearCacheFlag);
  }

  final AswhUpTask _task;
  final AswhUpTaskService _service;
  final Uuid _uuid = const Uuid();

  int? _userId;
  Box<dynamic>? _cacheBox;

  Future<void> _onInitialize(
    InitializeAswhUpCollectionEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    _userId = event.userId;
    await _openCacheBox();
    await _loadDetailList(emit, restoreCache: true);
  }

  Future<void> _openCacheBox() async {
    _cacheBox ??=
        await Hive.openBox('aswh_up_collect_${_task.inTaskId.toString()}');
  }

  AswhUpTaskDetailQuery _buildQuery() {
    return AswhUpTaskDetailQuery(
      inTaskId: _task.inTaskId,
      userId: (_userId ?? 0).toString(),
      workStation: _task.workStation,
      roomTag: '1',
      pageSize: 500,
    );
  }

  Future<void> _loadDetailList(
    Emitter<AswhUpCollectionState> emit, {
    bool restoreCache = false,
  }) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final response = await _service.fetchTaskItems(query: _buildQuery());
      final items = response.rows;

      emit(
        state.copyWith(
          status: CollectionStatus.success(),
          detailList: items,
          visibleDetails: _filterDetails(items, state.storeSite),
          placeholder: state.placeholder,
        ),
      );

      if (restoreCache) {
        await _restoreFromCache(emit);
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  List<AswhUpTaskDetailItem> _filterDetails(
    List<AswhUpTaskDetailItem> source,
    String storeSite,
  ) {
    if (storeSite.isEmpty) {
      return source;
    }
    final trimmed = storeSite.trim();
    return source
        .where(
          (item) => (item.storeSiteNo ?? '').trim() == trimmed,
        )
        .toList();
  }

  Future<void> _restoreFromCache(Emitter<AswhUpCollectionState> emit) async {
    final box = _cacheBox;
    if (box == null) return;

    try {
      final updateFlag = box.get('updateFlag', defaultValue: '0');
      if (updateFlag != '1') {
        return;
      }

      final cachedStocksRaw = List<dynamic>.from(
        box.get('stocks', defaultValue: const <dynamic>[]),
      );
      final cachedStocks = cachedStocksRaw
          .map(
            (item) => AswhUpCollectionStock.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();

      final collectedMapRaw = Map<String, dynamic>.from(
        box.get('collected', defaultValue: <String, dynamic>{}),
      );
      final collected = <int, double>{};
      collectedMapRaw.forEach((key, value) {
        final id = int.tryParse(key);
        if (id != null) {
          collected[id] = (value as num).toDouble();
        }
      });

      final serialRaw = Map<String, dynamic>.from(
        box.get('serialRecord', defaultValue: <String, dynamic>{}),
      );
      final serialRecord = <int, Set<String>>{};
      serialRaw.forEach((key, value) {
        final id = int.tryParse(key);
        if (id != null) {
          serialRecord[id] =
              Set<String>.from(List<dynamic>.from(value as List<dynamic>)
                  .map((item) => item.toString()));
        }
      });

      final trayNo = box.get('trayNo', defaultValue: '').toString();
      final storeSite = box.get('storeSite', defaultValue: '').toString();
      final scanStepIndex =
          int.tryParse(box.get('scanStep', defaultValue: '1').toString()) ?? 1;
      final capacity =
          double.tryParse(box.get('trayCapacity', defaultValue: '0').toString()) ??
              0;
      final used = cachedStocks.fold<double>(
        0,
        (prev, stock) => prev + (stock.collectQty),
      );

      emit(
        state.copyWith(
          trayNo: trayNo,
          storeSite: storeSite,
          visibleDetails: _filterDetails(state.detailList, storeSite),
          stocks: cachedStocks,
          collectedByItem: collected,
          serialRecord: serialRecord,
          trayCapacity: capacity,
          trayUsed: used,
          scanStep: AswhUpCollectionScanStep.values
              .elementAt(math.min(scanStepIndex, 2)),
          placeholder: _placeholderForStep(
            AswhUpCollectionScanStep.values
                .elementAt(math.min(scanStepIndex, 2)),
          ),
          message: cachedStocks.isEmpty ? null : '已恢复上次采集记录',
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status:
              CollectionStatus.error('恢复缓存失败：${error.toString()}'),
        ),
      );
    }
  }

  Future<void> _persistCache(AswhUpCollectionState newState) async {
    final box = _cacheBox;
    if (box == null) return;

    await box.put('updateFlag', '1');
    await box.put('trayNo', newState.trayNo);
    await box.put('storeSite', newState.storeSite);
    await box.put('scanStep', newState.scanStep.index.toString());
    await box.put('trayCapacity', newState.trayCapacity.toString());
    await box.put(
      'stocks',
      newState.stocks.map((e) => e.toJson()).toList(),
    );
    await box.put(
      'collected',
      newState.collectedByItem.map(
        (key, value) => MapEntry(key.toString(), value),
      ),
    );
    await box.put(
      'serialRecord',
      newState.serialRecord.map(
        (key, value) => MapEntry(key.toString(), value.toList()),
      ),
    );
  }

  Future<void> _onPerformScan(
    AswhUpPerformScanEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    final payload = event.payload.trim();
    if (payload.isEmpty) {
      emit(state.copyWith(message: '扫描内容为空'));
      return;
    }

    if (payload.contains('\$TP\$')) {
      await _handleTrayScan(payload, emit);
      return;
    }

    if (payload.contains('\$KW\$')) {
      _handleStoreSiteScan(payload, emit);
      return;
    }

    if (payload.contains('MC')) {
      await _handleMaterialScan(payload, emit);
      return;
    }

    if (state.scanStep == AswhUpCollectionScanStep.quantity ||
        _isNumeric(payload)) {
      await _handleQuantityInput(payload, emit);
      return;
    }

    emit(state.copyWith(message: '无法识别的条码：$payload'));
  }

  Future<void> _handleTrayScan(
    String payload,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    final trayNo = payload.replaceAll('\$TP\$', '').trim();
    if (trayNo.isEmpty) {
      emit(state.copyWith(message: '托盘条码格式不正确'));
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final trayInfo = await _service.checkBindingTray(trayNo);
      await _service.checkBindingTrayByTask(
        taskId: _task.inTaskId,
        trayNo: trayNo,
        taskType: 'ASWHUP',
      );
      final capacity = _parseDouble(trayInfo['capacity']) ??
          _parseDouble(trayInfo['trayMaxCapacity']) ??
          state.trayCapacity;

      final newState = state.copyWith(
        status: CollectionStatus.success('托盘校验通过'),
        trayNo: trayNo,
        trayCapacity: capacity,
        trayUsed: state.stocks.fold<double>(
          0,
          (prev, stock) => prev + stock.collectQty,
        ),
        scanStep: AswhUpCollectionScanStep.material,
        placeholder: '请扫描物料二维码',
        focus: true,
        message: '托盘 $trayNo 校验通过',
      );
      emit(newState);
      await _persistCache(newState);
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  void _handleStoreSiteScan(
    String payload,
    Emitter<AswhUpCollectionState> emit,
  ) {
    final site = payload.replaceAll('\$KW\$', '').trim();
    if (site.isEmpty) {
      emit(state.copyWith(message: '库位条码格式不正确'));
      return;
    }

    final filtered = _filterDetails(state.detailList, site);
    if (filtered.isEmpty) {
      emit(state.copyWith(message: '当前库位无待采集任务'));
      return;
    }

    final newState = state.copyWith(
      storeSite: site,
      visibleDetails: filtered,
      message: '已切换库位 $site',
      focus: true,
    );
    emit(newState);
    _persistCache(newState);
  }

  Future<void> _handleMaterialScan(
    String payload,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    if (state.trayNo.isEmpty) {
      emit(state.copyWith(message: '请先扫描托盘条码'));
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final barcode = await _service.getMaterialInfoByQR(payload);
      final materialCode = barcode.materialCode ?? '';
      if (materialCode.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('二维码未解析出物料编码'),
          ),
        );
        return;
      }

      final candidate = state.visibleDetails.firstWhere(
        (item) =>
            item.materialCode == materialCode ||
            (item.oldMaterialCode ?? '') == materialCode,
        orElse: () =>
            state.detailList.firstWhere(
              (item) =>
                  item.materialCode == materialCode ||
                  (item.oldMaterialCode ?? '') == materialCode,
              orElse: () => const AswhUpTaskDetailItem(
                inTaskItemId: 0,
                inTaskId: 0,
                materialCode: '',
              ),
            ),
      );

      if (candidate.inTaskItemId == 0) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('物料 $materialCode 不在任务明细中'),
          ),
        );
        return;
      }

      final matControl = await _service.getMatControl(materialCode);
      final seqCtrlFlag =
          (matControl['seqCtrl'] ?? matControl['seqctrl'] ?? '').toString();
      if (seqCtrlFlag.toUpperCase() == 'Y' &&
          (barcode.serialNo == null || barcode.serialNo!.isEmpty)) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('序列管控物料必须扫描序列号'),
          ),
        );
        return;
      }

      final serialNo = barcode.serialNo ?? '';
      if (serialNo.isNotEmpty) {
        final serialSet = state.serialRecord[candidate.inTaskItemId];
        if (serialSet != null && serialSet.contains(serialNo)) {
          emit(
            state.copyWith(
              status: CollectionStatus.error('序列号已采集，请勿重复扫描'),
            ),
          );
          return;
        }
      }

      emit(
        state.copyWith(
          status: CollectionStatus.success(),
          currentBarcode: barcode,
          currentItem: candidate,
          placeholder: '请输入采集数量',
          scanStep: AswhUpCollectionScanStep.quantity,
          focus: true,
          message: '扫描到物料 $materialCode',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _handleQuantityInput(
    String payload,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    final quantity = double.tryParse(payload);
    if (quantity == null || quantity <= 0) {
      emit(state.copyWith(message: '请输入合法的采集数量'));
      return;
    }

    if (state.trayNo.isEmpty) {
      emit(state.copyWith(message: '请先扫描托盘条码'));
      return;
    }

    final item = state.currentItem;
    final barcode = state.currentBarcode;
    if (item == null || barcode == null) {
      emit(state.copyWith(message: '请先扫描物料二维码'));
      return;
    }

    final collected = state.collectedByItem[item.inTaskItemId] ?? 0;
    final remain = (item.planQty) - collected;
    if (quantity > remain + 1e-6) {
      emit(state.copyWith(message: '采集数量超出任务剩余数量'));
      return;
    }

    final serialNo = barcode.serialNo ?? '';
    if (serialNo.isNotEmpty) {
      final serialSet = state.serialRecord[item.inTaskItemId];
      if (serialSet != null && serialSet.contains(serialNo)) {
        emit(state.copyWith(message: '序列号已采集，请勿重复提交'));
        return;
      }
    }

    final newStock = AswhUpCollectionStock(
      stockId: _uuid.v4(),
      trayNo: state.trayNo,
      materialCode: item.materialCode,
      materialName: barcode.materialName ?? item.materialName,
      batchNo: barcode.batchNo?.isNotEmpty == true
          ? barcode.batchNo
          : item.batchNo,
      serialNo: serialNo.isEmpty ? item.serialNo : serialNo,
      taskQty: item.planQty,
      collectQty: quantity,
      taskItemId: item.inTaskItemId.toString(),
      taskId: item.inTaskId.toString(),
      storeRoom: item.storeRoomNo ?? _task.storeRoomNo,
      storeSite: item.storeSiteNo ?? state.storeSite,
      erpStore: barcode.erpStore ?? item.erpStore,
      supplierCode: barcode.supplierCode,
      supplierName: barcode.supplierName ?? item.supplierName,
    );

    final updatedStocks = List<AswhUpCollectionStock>.from(state.stocks)
      ..add(newStock);
    final updatedCollected = Map<int, double>.from(state.collectedByItem)
      ..update(item.inTaskItemId, (value) => value + quantity,
          ifAbsent: () => quantity);
    final updatedSerial = Map<int, Set<String>>.from(state.serialRecord);
    if (serialNo.isNotEmpty) {
      final set = updatedSerial[item.inTaskItemId] ?? <String>{};
      set.add(serialNo);
      updatedSerial[item.inTaskItemId] = set;
    }

    final newState = state.copyWith(
      stocks: updatedStocks,
      collectedByItem: updatedCollected,
      serialRecord: updatedSerial,
      trayUsed: state.trayUsed + quantity,
      currentBarcode: null,
      currentItem: null,
      scanStep: AswhUpCollectionScanStep.material,
      placeholder: '请扫描物料二维码',
      focus: true,
      message: '采集成功，数量 ${quantity.toStringAsFixed(2)}',
    );
    emit(newState);
    await _persistCache(newState);
  }

  void _onChangeTab(
    AswhUpChangeTabEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onUpdateSelection(
    AswhUpUpdateSelectionEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) {
    emit(state.copyWith(selectedDetailIds: event.selectedIds, focus: false));
  }

  Future<void> _onSubmit(
    AswhUpSubmitEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    if (state.stocks.isEmpty) {
      emit(state.copyWith(message: '没有采集数据可提交'));
      return;
    }
    if (state.trayNo.isEmpty) {
      emit(state.copyWith(message: '请先扫描托盘条码'));
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final upShelvesInfos = state.stocks.map((stock) {
        return {
          'trayNo': state.trayNo,
          'taskNo': _task.inTaskNo,
          'matCode': stock.materialCode,
          'batchNo': stock.batchNo ?? '',
          'sn': stock.serialNo ?? '',
          'taskQty': stock.taskQty,
          'collectQty': stock.collectQty,
          'storeRoomNo': stock.storeRoom ?? _task.storeRoomNo ?? '',
          'storeSiteNo': stock.storeSite ?? state.storeSite,
          'taskid': int.tryParse(stock.taskId) ?? _task.inTaskId,
          'inTaskItemid': int.tryParse(stock.taskItemId) ?? 0,
          'supplierCode': stock.supplierCode ?? '',
          'supplierName': stock.supplierName ?? '',
          'erpStore': stock.erpStore ?? '',
        };
      }).toList();

      final itemListInfos = state.collectedByItem.entries.map((entry) {
        final detail = state.detailList.firstWhere(
          (element) => element.inTaskItemId == entry.key,
          orElse: () => AswhUpTaskDetailItem(
            inTaskItemId: entry.key,
            inTaskId: _task.inTaskId,
            materialCode: '',
          ),
        );
        return {
          'inTaskItemid': entry.key,
          'collectQty': entry.value,
          'matCode': detail.materialCode,
        };
      }).toList();

      final serialFilter = state.serialRecord.values
          .expand((value) => value)
          .map((sn) => '"$sn"')
          .join(',');

      await _service.commitUpShelves(
        upShelvesInfos: upShelvesInfos,
        itemListInfos: itemListInfos,
        filter: serialFilter,
        weight: event.weight ?? '0',
        capacity: event.capacity ?? state.trayCapacity.toString(),
      );

      await _service.commitUpWmsToWcs(
        taskId: _task.inTaskId,
        taskNo: _task.inTaskNo,
        trayNo: state.trayNo,
      );

      await _clearCache();

      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          stocks: const [],
          collectedByItem: const {},
          serialRecord: const {},
          trayUsed: 0,
          message: '组盘提交成功',
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _clearCache() async {
    final box = _cacheBox;
    if (box == null) return;
    await box.clear();
  }

  void _onResetStatus(
    AswhUpResetStatusEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) {
    if (!state.status.isNormal) {
      emit(state.copyWith(status: CollectionStatus.normal()));
    }
  }

  void _onRequestFocus(
    AswhUpRequestFocusEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) {
    emit(state.copyWith(focus: event.focused));
  }

  Future<void> _onDeleteStocks(
    AswhUpDeleteStocksEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    if (event.stockIds.isEmpty) {
      return;
    }

    final remaining = <AswhUpCollectionStock>[];
    final removed = <AswhUpCollectionStock>[];
    for (final stock in state.stocks) {
      if (event.stockIds.contains(stock.stockId)) {
        removed.add(stock);
      } else {
        remaining.add(stock);
      }
    }

    if (removed.isEmpty) {
      return;
    }

    final updatedCollected = Map<int, double>.from(state.collectedByItem);
    final updatedSerial = Map<int, Set<String>>.from(state.serialRecord);
    for (final stock in removed) {
      final itemId = int.tryParse(stock.taskItemId);
      if (itemId != null) {
        final current = updatedCollected[itemId] ?? 0;
        final newValue = (current - stock.collectQty).clamp(0, double.infinity);
        if (newValue == 0) {
          updatedCollected.remove(itemId);
        } else {
          updatedCollected[itemId] = newValue;
        }

        if (stock.serialNo?.isNotEmpty == true) {
          final serialSet = updatedSerial[itemId];
          serialSet?.remove(stock.serialNo);
          if (serialSet != null && serialSet.isEmpty) {
            updatedSerial.remove(itemId);
          }
        }
      }
    }

    final newState = state.copyWith(
      stocks: remaining,
      collectedByItem: updatedCollected,
      serialRecord: updatedSerial,
      trayUsed: remaining.fold<double>(
        0,
        (prev, stock) => prev + stock.collectQty,
      ),
      message: '已删除 ${removed.length} 条采集记录',
    );
    emit(newState);
    await _persistCache(newState);
  }

  Future<void> _onUpdateFromResult(
    AswhUpUpdateFromResultEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    if (event.deletedStocks.isEmpty) {
      return;
    }

    final ids = event.deletedStocks.map((e) => e.stockId).toList();
    await _onDeleteStocks(AswhUpDeleteStocksEvent(ids), emit);
  }

  Future<void> _onClearCacheFlag(
    AswhUpClearCacheEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    await _clearCache();
    emit(state.copyWith(message: '已清空缓存', focus: true));
  }

  String _placeholderForStep(AswhUpCollectionScanStep step) {
    switch (step) {
      case AswhUpCollectionScanStep.tray:
        return '请扫描托盘条码';
      case AswhUpCollectionScanStep.material:
        return '请扫描物料二维码';
      case AswhUpCollectionScanStep.quantity:
        return '请输入采集数量';
    }
  }

  double? _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String && value.isNotEmpty) {
      return double.tryParse(value);
    }
    return null;
  }

  bool _isNumeric(String value) {
    return double.tryParse(value) != null;
  }
}
