import 'dart:async';
import 'dart:math';
import 'dart:math' as math;

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
  }) : _task = task,
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
    on<AswhUpConfirmTrayChangeEvent>(_onConfirmTrayChange);
    on<AswhUpRaiseTrayEvent>(_onRaiseTray);
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
    _cacheBox ??= await Hive.openBox(
      'aswh_up_collect_${_task.inTaskId.toString()}',
    );
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
      final shouldCheckBatch = _shouldCheckBatchByItems(items);
      final shouldCheckSupplier = _shouldCheckSupplierByItems(items);
      final restrictMaterialMixing = _shouldRestrictMaterialMixing(items);

      emit(
        state.copyWith(
          status: CollectionStatus.success(),
          detailList: items,
          visibleDetails: _filterDetails(items, state.storeSite),
          placeholder: state.placeholder,
          shouldCheckBatch: shouldCheckBatch,
          shouldCheckSupplier: shouldCheckSupplier,
          restrictMaterialMixing: restrictMaterialMixing,
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
        .where((item) => (item.storeSiteNo ?? '').trim() == trimmed)
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
          serialRecord[id] = Set<String>.from(
            List<dynamic>.from(
              value as List<dynamic>,
            ).map((item) => item.toString()),
          );
        }
      });

      final dicMtlQtyRaw = Map<String, dynamic>.from(
        box.get('dicMtlQty', defaultValue: <String, dynamic>{}),
      );
      final dicMtlQty = <int, List<dynamic>>{};
      dicMtlQtyRaw.forEach((key, value) {
        final id = int.tryParse(key);
        if (id != null) {
          dicMtlQty[id] = List<dynamic>.from(value as List<dynamic>);
        }
      });

      final capacityUsageRaw = Map<String, dynamic>.from(
        box.get('capacityUsage', defaultValue: <String, dynamic>{}),
      );
      final capacityUsage = <String, double>{};
      capacityUsageRaw.forEach((key, value) {
        if (value is num) {
          capacityUsage[key] = value.toDouble();
        } else {
          final parsed = double.tryParse(value.toString());
          if (parsed != null) {
            capacityUsage[key] = parsed;
          }
        }
      });

      final weightUsageRaw = Map<String, dynamic>.from(
        box.get('weightUsage', defaultValue: <String, dynamic>{}),
      );
      final weightUsage = <String, double>{};
      weightUsageRaw.forEach((key, value) {
        if (value is num) {
          weightUsage[key] = value.toDouble();
        } else {
          final parsed = double.tryParse(value.toString());
          if (parsed != null) {
            weightUsage[key] = parsed;
          }
        }
      });

      final trayNo = box.get('trayNo', defaultValue: '').toString();
      final storeSite = box.get('storeSite', defaultValue: '').toString();
      final scanStepIndex =
          int.tryParse(box.get('scanStep', defaultValue: '1').toString()) ?? 1;
      final capacity =
          double.tryParse(
            box.get('trayCapacity', defaultValue: '0').toString(),
          ) ??
          0;
      final trayMaxWeight =
          double.tryParse(
            box.get('trayMaxWeight', defaultValue: '0').toString(),
          ) ??
          0;
      final storedWeight =
          double.tryParse(
            box.get('trayCurrentWeight', defaultValue: '0').toString(),
          ) ??
          0;

      var used = capacityUsage.values.fold<double>(
        0,
        (prev, value) => prev + value,
      );
      if (used <= 0 && cachedStocks.isNotEmpty) {
        used = cachedStocks.fold<double>(
          0,
          (prev, stock) => prev + stock.collectQty,
        );
      }

      var trayCurrentWeight = weightUsage.values.fold<double>(
        0,
        (prev, value) => prev + value,
      );
      if (trayCurrentWeight <= 0) {
        trayCurrentWeight = storedWeight;
      }

      final trayMaterialKeyRaw = box
          .get('trayMaterialKey', defaultValue: '')
          .toString();
      final trayMaterialKey = trayMaterialKeyRaw.isEmpty
          ? _resolveTrayMaterialKeyFromStocks(
              cachedStocks,
              state.restrictMaterialMixing,
              state.shouldCheckBatch,
            )
          : trayMaterialKeyRaw;

      final updatedDetailList = state.detailList.map((detail) {
        final addition = collected[detail.inTaskItemId] ?? 0;
        if (addition <= 0) {
          return detail;
        }
        return _cloneDetail(
          detail,
          collectedQty: detail.collectedQty + addition,
        );
      }).toList();

      emit(
        state.copyWith(
          trayNo: trayNo,
          storeSite: storeSite,
          detailList: updatedDetailList,
          visibleDetails: _filterDetails(updatedDetailList, storeSite),
          stocks: cachedStocks,
          collectedByItem: collected,
          serialRecord: serialRecord,
          dicMtlQty: dicMtlQty,
          capacityUsageByStock: capacityUsage,
          weightUsageByStock: weightUsage,
          trayCapacity: capacity,
          trayUsed: used,
          trayMaxWeight: trayMaxWeight,
          trayCurrentWeight: trayCurrentWeight,
          scanStep: AswhUpCollectionScanStep.values.elementAt(
            math.min(scanStepIndex, 2),
          ),
          placeholder: _placeholderForStep(
            AswhUpCollectionScanStep.values.elementAt(
              math.min(scanStepIndex, 2),
            ),
          ),
          trayMaterialKey: trayMaterialKey,
          message: cachedStocks.isEmpty ? null : '已恢复上次采集记录',
          focus: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('恢复缓存失败：${error.toString()}'),
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
    await box.put('trayMaxWeight', newState.trayMaxWeight.toString());
    await box.put('trayCurrentWeight', newState.trayCurrentWeight.toString());
    await box.put('stocks', newState.stocks.map((e) => e.toJson()).toList());
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
    await box.put(
      'dicMtlQty',
      newState.dicMtlQty.map(
        (key, value) => MapEntry(key.toString(), List<dynamic>.from(value)),
      ),
    );
    await box.put(
      'capacityUsage',
      newState.capacityUsageByStock.map((key, value) => MapEntry(key, value)),
    );
    await box.put(
      'weightUsage',
      newState.weightUsageByStock.map((key, value) => MapEntry(key, value)),
    );
    await box.put('trayMaterialKey', newState.trayMaterialKey ?? '');
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

    final hasExistingData =
        state.stocks.isNotEmpty || state.collectedByItem.isNotEmpty;

    if (state.trayNo.isNotEmpty && state.trayNo == trayNo) {
      await _applyTrayScan(trayNo, emit, resetExisting: false);
      return;
    }

    if (hasExistingData && state.trayNo.isNotEmpty && state.trayNo != trayNo) {
      emit(
        state.copyWith(
          pendingTrayNo: trayNo,
          showTrayChangeDialog: true,
          message: '更换托盘前将清空当前采集记录，是否继续？',
          focus: false,
        ),
      );
      return;
    }

    await _applyTrayScan(
      trayNo,
      emit,
      resetExisting: state.trayNo != trayNo && hasExistingData,
    );
  }

  Future<void> _applyTrayScan(
    String trayNo,
    Emitter<AswhUpCollectionState> emit, {
    required bool resetExisting,
  }) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final trayInfo = await _service.checkBindingTray(trayNo);
      await _service.checkBindingTrayByTask(
        taskId: _task.inTaskId,
        trayNo: trayNo,
        // UniApp 实现传递的 taskType 固定为 '00'，后台以此判定立库托盘绑定
        // 校验场景，这里保持一致以避免接口校验失败。
        taskType: '00',
      );

      final capacity =
          _parseDouble(trayInfo['capacity']) ??
          _parseDouble(trayInfo['trayMaxCapacity']) ??
          _parseDouble(trayInfo['trayCapacity']) ??
          state.trayCapacity;
      final trayMaxWeight =
          _parseDouble(trayInfo['trayMaxWeight']) ??
          _parseDouble(trayInfo['maxWeight']) ??
          _parseDouble(trayInfo['maxweight']) ??
          state.trayMaxWeight;

      List<AswhUpTaskDetailItem> detailList = state.detailList;
      List<AswhUpTaskDetailItem> visibleDetails = state.visibleDetails;
      List<AswhUpCollectionStock> stocks = state.stocks;
      Map<int, double> collected = state.collectedByItem;
      Map<int, Set<String>> serialRecord = state.serialRecord;
      Map<int, List<dynamic>> dicMtlQty = state.dicMtlQty;
      Map<String, double> capacityUsage = state.capacityUsageByStock;
      Map<String, double> weightUsage = state.weightUsageByStock;
      double trayUsed = state.trayUsed;
      double trayCurrentWeight = state.trayCurrentWeight;
      String? trayMaterialKey = state.trayMaterialKey;

      if (resetExisting) {
        detailList = state.detailList.map((detail) {
          final delta = state.collectedByItem[detail.inTaskItemId] ?? 0;
          if (delta <= 0) {
            return detail;
          }
          final double reverted = (detail.collectedQty - delta).clamp(
            0,
            detail.planQty,
          );
          return _cloneDetail(detail, collectedQty: reverted);
        }).toList();
        visibleDetails = _filterDetails(detailList, state.storeSite);
        stocks = const [];
        collected = const {};
        serialRecord = const {};
        dicMtlQty = const {};
        capacityUsage = const {};
        weightUsage = const {};
        trayUsed = 0;
        trayCurrentWeight = 0;
        trayMaterialKey = null;
      }

      final newState = state.copyWith(
        status: CollectionStatus.success('托盘校验通过'),
        trayNo: trayNo,
        trayCapacity: capacity,
        trayMaxWeight: trayMaxWeight,
        trayUsed: trayUsed,
        trayCurrentWeight: trayCurrentWeight,
        detailList: detailList,
        visibleDetails: visibleDetails,
        stocks: stocks,
        collectedByItem: collected,
        serialRecord: serialRecord,
        dicMtlQty: dicMtlQty,
        capacityUsageByStock: capacityUsage,
        weightUsageByStock: weightUsage,
        trayMaterialKey:
            trayMaterialKey ??
            _resolveTrayMaterialKeyFromStocks(
              stocks,
              state.restrictMaterialMixing,
              state.shouldCheckBatch,
            ),
        scanStep: AswhUpCollectionScanStep.material,
        placeholder: '请扫描物料二维码',
        focus: true,
        pendingTrayNo: null,
        showTrayChangeDialog: false,
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

  Future<void> _onConfirmTrayChange(
    AswhUpConfirmTrayChangeEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    final pendingTray = state.pendingTrayNo;
    if (pendingTray == null) {
      emit(state.copyWith(showTrayChangeDialog: false, focus: true));
      return;
    }

    if (!event.confirmed) {
      emit(
        state.copyWith(
          pendingTrayNo: null,
          showTrayChangeDialog: false,
          focus: true,
          message: '已取消托盘更换',
        ),
      );
      return;
    }

    await _applyTrayScan(pendingTray, emit, resetExisting: true);
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
        emit(state.copyWith(status: CollectionStatus.error('二维码未解析出物料编码')));
        return;
      }

      final candidates = state.detailList.where((item) {
        final codeMatch =
            item.materialCode == materialCode ||
            (item.oldMaterialCode ?? '') == materialCode;
        if (!codeMatch) {
          return false;
        }
        final remain = item.planQty - item.collectedQty;
        return remain > 1e-6;
      }).toList();

      if (candidates.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('物料 $materialCode 不在任务明细中'),
          ),
        );
        return;
      }

      final matControlRaw = await _service.getMatControl(materialCode);
      final matControl = _parseMatControlInfo(matControlRaw);
      final seqCtrlFlag =
          (matControl['seqctrl'] ??
                  matControl['seqCtrl'] ??
                  barcode.seqCtrl ??
                  '')
              .toString();
      final bool serialControl = _isSerialControlled(seqCtrlFlag);
      final serialNo = barcode.serialNo?.trim() ?? '';

      if (serialControl && serialNo.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('序列管控物料必须扫描序列号')));
        return;
      }

      String resolvedBatch = (barcode.batchNo ?? '').trim();

      final filteredCandidates = candidates.where((detail) {
        if (state.shouldCheckBatch) {
          final detailBatch = (detail.batchNo ?? '').trim();
          if (resolvedBatch.isNotEmpty && detailBatch != resolvedBatch) {
            return false;
          }
        }
        if (serialControl && serialNo.isNotEmpty) {
          final detailSerial = (detail.serialNo ?? '').trim();
          if (detailSerial.isNotEmpty && detailSerial != serialNo) {
            return false;
          }
        }
        return true;
      }).toList();

      if (filteredCandidates.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('任务明细中物料批次不匹配')));
        return;
      }

      final candidate = _selectCandidate(
        filteredCandidates,
        state.visibleDetails,
      );
      if (state.shouldCheckBatch && resolvedBatch.isEmpty) {
        resolvedBatch = (candidate.batchNo ?? '').trim();
      }

      if (state.shouldCheckBatch) {
        final hasBatch = filteredCandidates.any(
          (detail) => (detail.batchNo ?? '').trim() == resolvedBatch,
        );
        if (!hasBatch && resolvedBatch.isNotEmpty) {
          emit(state.copyWith(status: CollectionStatus.error('扫描批次与任务明细不匹配')));
          return;
        }
      }

      if (state.shouldCheckSupplier) {
        final supplierName =
            (barcode.supplierName ?? barcode.supplierCode ?? '').trim();
        final detailSupplier = (candidate.supplierName ?? '').trim();
        if (supplierName.isNotEmpty &&
            detailSupplier.isNotEmpty &&
            supplierName != detailSupplier) {
          emit(state.copyWith(status: CollectionStatus.error('供应商信息不匹配')));
          return;
        }
      }

      if (serialNo.isNotEmpty) {
        final serialSet = state.serialRecord[candidate.inTaskItemId];
        if (serialSet != null && serialSet.contains(serialNo)) {
          emit(state.copyWith(status: CollectionStatus.error('序列号已采集，请勿重复扫描')));
          return;
        }
      }

      final mixingKey = _buildTrayMaterialKey(
        candidate.materialCode,
        state.shouldCheckBatch ? resolvedBatch : null,
        state.restrictMaterialMixing,
        state.shouldCheckBatch,
      );
      final trayKey = state.trayMaterialKey;
      if (state.restrictMaterialMixing &&
          trayKey != null &&
          trayKey.isNotEmpty &&
          mixingKey.isNotEmpty &&
          trayKey != mixingKey) {
        final msg = state.shouldCheckBatch
            ? '扫描物料【${candidate.materialCode}】批次【$resolvedBatch】与当前托盘不一致'
            : '扫描物料【${candidate.materialCode}】与当前托盘不一致';
        emit(state.copyWith(status: CollectionStatus.error(msg)));
        return;
      }

      final materialCapacity =
          _extractMaterialCapacity(matControl) ?? state.currentMaterialCapacity;
      final materialWeight =
          _extractMaterialWeight(matControl) ?? state.currentMaterialWeight;

      final normalizedBarcode = barcode.copyWith(
        batchNo: resolvedBatch.isNotEmpty ? resolvedBatch : barcode.batchNo,
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success(),
          currentBarcode: normalizedBarcode,
          currentItem: candidate,
          currentMaterialCapacity: materialCapacity,
          currentMaterialWeight: materialWeight,
          placeholder: '请输入采集数量',
          scanStep: AswhUpCollectionScanStep.quantity,
          focus: !serialControl,
          message: '扫描到物料 $materialCode',
        ),
      );

      if (serialControl) {
        await _handleQuantityInput('1', emit);
      }
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

    final serialNo = barcode.serialNo ?? '';
    if (serialNo.isNotEmpty) {
      if ((quantity - 1).abs() > 1e-6) {
        emit(state.copyWith(message: '序列管控物料采集数量必须为1'));
        return;
      }
      final serialSet = state.serialRecord[item.inTaskItemId];
      if (serialSet != null && serialSet.contains(serialNo)) {
        emit(state.copyWith(message: '序列号已采集，请勿重复提交'));
        return;
      }
    }

    final detailBeforeUpdate = state.detailList.firstWhere(
      (detail) => detail.inTaskItemId == item.inTaskItemId,
      orElse: () => item,
    );

    final remain = detailBeforeUpdate.planQty - detailBeforeUpdate.collectedQty;
    if (quantity > remain + 1e-6) {
      emit(state.copyWith(message: '采集数量超出任务剩余数量'));
      return;
    }

    final resolvedBatch = barcode.batchNo?.isNotEmpty == true
        ? barcode.batchNo!
        : (item.batchNo ?? '');
    final mixingKey = _buildTrayMaterialKey(
      item.materialCode,
      state.shouldCheckBatch ? resolvedBatch : null,
      state.restrictMaterialMixing,
      state.shouldCheckBatch,
    );
    final trayKey = state.trayMaterialKey;
    if (state.restrictMaterialMixing &&
        trayKey != null &&
        trayKey.isNotEmpty &&
        mixingKey.isNotEmpty &&
        trayKey != mixingKey) {
      final msg = state.shouldCheckBatch
          ? '扫描物料【${item.materialCode}】批次【$resolvedBatch】与当前托盘不一致'
          : '扫描物料【${item.materialCode}】与当前托盘不一致';
      emit(state.copyWith(message: msg));
      return;
    }

    final unitCapacity = state.currentMaterialCapacity;
    final unitWeight = state.currentMaterialWeight;
    final capacityUsage = unitCapacity > 0 ? unitCapacity * quantity : quantity;
    final newTrayUsed = state.trayUsed + capacityUsage;
    if (state.trayCapacity > 0 && newTrayUsed - state.trayCapacity > 1e-6) {
      emit(state.copyWith(message: '物料容量超出托盘最大容量'));
      return;
    }

    final double weightUsage = unitWeight > 0 ? unitWeight * quantity : 0;
    final newTrayWeight = state.trayCurrentWeight + weightUsage;
    if (state.trayMaxWeight > 0 && newTrayWeight - state.trayMaxWeight > 1e-6) {
      emit(state.copyWith(message: '物料重量超出托盘承重'));
      return;
    }

    final erpStore = (barcode.erpStore ?? item.erpStore ?? '').trim();
    final taskStore = (item.storeRoomNo ?? _task.storeRoomNo ?? '').trim();
    if (erpStore.isNotEmpty &&
        taskStore.isNotEmpty &&
        !_equalsIgnoreCase(erpStore, taskStore)) {
      emit(state.copyWith(message: '库房【$erpStore】与任务库房【$taskStore】不一致'));
      return;
    }

    final storeSite = (item.storeSiteNo ?? state.storeSite).trim();
    if (storeSite.isNotEmpty) {
      try {
        final repertoryList = await _service.getMtlRepertoryByStoresiteNo(
          storeSite: storeSite,
          materialCode: item.materialCode,
        );

        if (repertoryList.isNotEmpty) {
          final inventory = repertoryList.first;
          final inventoryStore = _readString(inventory, 'erpStoreroom');
          final targetSubInventory = (item.subInventoryCode ?? '').trim();
          final storeRoom = (item.storeRoomNo ?? _task.storeRoomNo ?? '').trim();
          final shouldSkipSubInventoryCheck = state.shouldCheckSupplier &&
              _equalsIgnoreCase(storeRoom, 'XN-BL');

          if (!shouldSkipSubInventoryCheck &&
              targetSubInventory.isNotEmpty &&
              inventoryStore.isNotEmpty &&
              !_equalsIgnoreCase(inventoryStore, targetSubInventory)) {
            emit(
              state.copyWith(
                message: '此物料在当前货位存在其他物权属性的库存，请选择其他上架库位',
              ),
            );
            return;
          }

          if (state.shouldCheckSupplier &&
              _equalsIgnoreCase(storeRoom, 'XN-BL')) {
            final inventoryOwner = _readString(inventory, 'parno');
            final expectedOwner = _resolveExpectedOwner(barcode, item);
            if (inventoryOwner.isNotEmpty &&
                expectedOwner.isNotEmpty &&
                !_equalsIgnoreCase(inventoryOwner, expectedOwner)) {
              emit(
                state.copyWith(
                  message:
                      '物料对应的拥有方【$expectedOwner】与库位物料拥有方【$inventoryOwner】不一致，请确认',
                ),
              );
              return;
            }
          }
        }
      } catch (error) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(ErrorHandler.handleError(error)),
          ),
        );
        return;
      }
    }

    final newStock = AswhUpCollectionStock(
      stockId: _uuid.v4(),
      trayNo: state.trayNo,
      materialCode: item.materialCode,
      materialName: barcode.materialName ?? item.materialName,
      batchNo: resolvedBatch.isNotEmpty ? resolvedBatch : item.batchNo,
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
      ..update(
        item.inTaskItemId,
        (value) => value + quantity,
        ifAbsent: () => quantity,
      );
    final updatedSerial = Map<int, Set<String>>.from(state.serialRecord);
    if (serialNo.isNotEmpty) {
      final set = updatedSerial[item.inTaskItemId] ?? <String>{};
      set.add(serialNo);
      updatedSerial[item.inTaskItemId] = set;
    }

    final updatedCapacityUsage = Map<String, double>.from(
      state.capacityUsageByStock,
    )..[newStock.stockId] = capacityUsage;
    final updatedWeightUsage = Map<String, double>.from(
      state.weightUsageByStock,
    )..[newStock.stockId] = weightUsage;

    final updatedDicMtlQty = Map<int, List<dynamic>>.from(state.dicMtlQty);
    final existingEntry = updatedDicMtlQty[item.inTaskItemId];
    final originalCollected = existingEntry == null
        ? detailBeforeUpdate.collectedQty
        : (existingEntry[0] as num?)?.toDouble() ??
              detailBeforeUpdate.collectedQty;
    final previousNewValue = existingEntry == null
        ? detailBeforeUpdate.collectedQty
        : (existingEntry.length > 1
                  ? (existingEntry[1] as num?)?.toDouble()
                  : null) ??
              detailBeforeUpdate.collectedQty;
    final double newCollectedValue = (previousNewValue + quantity).clamp(
      0,
      detailBeforeUpdate.planQty,
    );
    updatedDicMtlQty[item.inTaskItemId] = <dynamic>[
      originalCollected,
      newCollectedValue,
      existingEntry != null && existingEntry.length > 2
          ? existingEntry[2]
          : item.materialCode,
    ];

    final updatedDetailList = state.detailList.map((detail) {
      if (detail.inTaskItemId != item.inTaskItemId) {
        return detail;
      }
      return _cloneDetail(detail, collectedQty: newCollectedValue);
    }).toList();

    final updatedVisible = _filterDetails(updatedDetailList, state.storeSite);

    final newTrayKey = state.restrictMaterialMixing
        ? ((state.trayMaterialKey != null && state.trayMaterialKey!.isNotEmpty)
              ? state.trayMaterialKey
              : mixingKey)
        : state.trayMaterialKey;

    final newState = state.copyWith(
      detailList: updatedDetailList,
      visibleDetails: updatedVisible,
      stocks: updatedStocks,
      collectedByItem: updatedCollected,
      serialRecord: updatedSerial,
      dicMtlQty: updatedDicMtlQty,
      trayUsed: newTrayUsed,
      trayCurrentWeight: newTrayWeight,
      capacityUsageByStock: updatedCapacityUsage,
      weightUsageByStock: updatedWeightUsage,
      trayMaterialKey: newTrayKey,
      currentBarcode: null,
      currentItem: null,
      currentMaterialCapacity: 0,
      currentMaterialWeight: 0,
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

    final taskNo = _task.inTaskNo.trim();
    if (taskNo.isEmpty) {
      emit(state.copyWith(message: '任务号为空，请确认'));
      return;
    }

    final voucherNo = (_task.taskComment ?? '').trim();
    if (voucherNo.isEmpty) {
      emit(state.copyWith(message: '凭证号为空，请确认'));
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

      final itemListInfosSource = state.dicMtlQty.isNotEmpty
          ? state.dicMtlQty.entries
          : state.collectedByItem
                .map(
                  (key, value) => MapEntry(key, <dynamic>[
                    state.detailList
                            .firstWhere(
                              (element) => element.inTaskItemId == key,
                              orElse: () => AswhUpTaskDetailItem(
                                inTaskItemId: key,
                                inTaskId: _task.inTaskId,
                                materialCode: '',
                              ),
                            )
                            .collectedQty -
                        value,
                    state.detailList
                        .firstWhere(
                          (element) => element.inTaskItemId == key,
                          orElse: () => AswhUpTaskDetailItem(
                            inTaskItemId: key,
                            inTaskId: _task.inTaskId,
                            materialCode: '',
                          ),
                        )
                        .collectedQty,
                    state.detailList
                        .firstWhere(
                          (element) => element.inTaskItemId == key,
                          orElse: () => AswhUpTaskDetailItem(
                            inTaskItemId: key,
                            inTaskId: _task.inTaskId,
                            materialCode: '',
                          ),
                        )
                        .materialCode,
                  ]),
                )
                .entries;

      final itemListInfos = itemListInfosSource.map((entry) {
        final itemId = entry.key;
        final values = entry.value;
        final oldQty = values.isNotEmpty
            ? (values[0] as num?)?.toDouble() ?? 0
            : 0;
        final newQty = values.length > 1
            ? (values[1] as num?)?.toDouble() ?? oldQty
            : oldQty;
        String matCode = values.length > 2 ? values[2].toString() : '';
        if (matCode.isEmpty) {
          final detail = state.detailList.firstWhere(
            (element) => element.inTaskItemId == itemId,
            orElse: () => AswhUpTaskDetailItem(
              inTaskItemId: itemId,
              inTaskId: _task.inTaskId,
              materialCode: '',
            ),
          );
          matCode = detail.materialCode;
        }

        return {
          'inTaskItemid': itemId,
          'mtlQty': [oldQty, newQty],
          'matCode': matCode,
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
        weight: event.weight ?? state.trayCurrentWeight.toString(),
        capacity: event.capacity ?? state.trayUsed.toString(),
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
          dicMtlQty: const {},
          capacityUsageByStock: const {},
          weightUsageByStock: const {},
          trayUsed: 0,
          trayCurrentWeight: 0,
          trayMaterialKey: null,
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

  Future<void> _onRaiseTray(
    AswhUpRaiseTrayEvent event,
    Emitter<AswhUpCollectionState> emit,
  ) async {
    if (state.stocks.isNotEmpty) {
      emit(state.copyWith(message: '采集数据未提交,不允许托盘上架！'));
      return;
    }

    if (state.trayNo.isEmpty) {
      emit(state.copyWith(message: '请先扫描托盘条码'));
      return;
    }

    if (_task.inTaskNo.isEmpty) {
      emit(state.copyWith(message: '任务信息缺失，无法提交托盘上架'));
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      await _service.commitUpWmsToWcs(
        taskId: _task.inTaskId,
        taskNo: _task.inTaskNo,
        trayNo: state.trayNo,
      );
      emit(
        state.copyWith(
          status: CollectionStatus.success('托盘上架提交成功'),
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
    final updatedCapacityUsage = Map<String, double>.from(
      state.capacityUsageByStock,
    );
    final updatedWeightUsage = Map<String, double>.from(
      state.weightUsageByStock,
    );
    final quantityReduction = <int, double>{};
    for (final stock in removed) {
      final itemId = int.tryParse(stock.taskItemId);
      if (itemId != null) {
        final current = updatedCollected[itemId] ?? 0;
        final double newValue = (current - stock.collectQty).clamp(
          0,
          double.infinity,
        );
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

        quantityReduction[itemId] =
            (quantityReduction[itemId] ?? 0) + stock.collectQty;
      }

      final capacityValue = updatedCapacityUsage.remove(stock.stockId) ?? 0;
      final weightValue = updatedWeightUsage.remove(stock.stockId) ?? 0;
    }

    final updatedDicMtlQty = Map<int, List<dynamic>>.from(state.dicMtlQty);
    quantityReduction.forEach((itemId, removedQty) {
      final entry = updatedDicMtlQty[itemId];
      if (entry == null) {
        return;
      }
      final oldVal = (entry[0] as num?)?.toDouble() ?? 0;
      final previousNew =
          (entry.length > 1 ? (entry[1] as num?)?.toDouble() : null) ?? oldVal;
      final newVal = (previousNew - removedQty).clamp(oldVal, double.infinity);
      if (newVal <= oldVal + 1e-6) {
        updatedDicMtlQty.remove(itemId);
      } else {
        updatedDicMtlQty[itemId] = <dynamic>[
          oldVal,
          newVal,
          entry.length > 2 ? entry[2] : '',
        ];
      }
    });

    final updatedDetailList = state.detailList.map((detail) {
      final reduce = quantityReduction[detail.inTaskItemId] ?? 0;
      if (reduce <= 0) {
        return detail;
      }
      final double newCollected = (detail.collectedQty - reduce).clamp(
        0,
        detail.planQty,
      );
      return _cloneDetail(detail, collectedQty: newCollected);
    }).toList();

    final recalculatedTrayUsed = updatedCapacityUsage.values.fold<double>(
      0,
      (prev, value) => prev + value,
    );
    final recalculatedTrayWeight = updatedWeightUsage.values.fold<double>(
      0,
      (prev, value) => prev + value,
    );

    final newTrayKey = remaining.isEmpty
        ? null
        : _resolveTrayMaterialKeyFromStocks(
            remaining,
            state.restrictMaterialMixing,
            state.shouldCheckBatch,
          );

    final newState = state.copyWith(
      detailList: updatedDetailList,
      visibleDetails: _filterDetails(updatedDetailList, state.storeSite),
      stocks: remaining,
      collectedByItem: updatedCollected,
      serialRecord: updatedSerial,
      dicMtlQty: updatedDicMtlQty,
      capacityUsageByStock: updatedCapacityUsage,
      weightUsageByStock: updatedWeightUsage,
      trayUsed: recalculatedTrayUsed,
      trayCurrentWeight: recalculatedTrayWeight,
      trayMaterialKey: newTrayKey,
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

  AswhUpTaskDetailItem _cloneDetail(
    AswhUpTaskDetailItem detail, {
    double? collectedQty,
  }) {
    return AswhUpTaskDetailItem(
      inTaskItemId: detail.inTaskItemId,
      inTaskId: detail.inTaskId,
      materialCode: detail.materialCode,
      materialName: detail.materialName,
      storeSiteNo: detail.storeSiteNo,
      storeRoomNo: detail.storeRoomNo,
      subInventoryCode: detail.subInventoryCode,
      batchNo: detail.batchNo,
      serialNo: detail.serialNo,
      planQty: detail.planQty,
      collectedQty: collectedQty ?? detail.collectedQty,
      repertoryQty: detail.repertoryQty,
      unit: detail.unit,
      expireDays: detail.expireDays,
      productionDate: detail.productionDate,
      proType: detail.proType,
      erpStore: detail.erpStore,
      supplierName: detail.supplierName,
      inTaskNo: detail.inTaskNo,
      taskComment: detail.taskComment,
      oldMaterialCode: detail.oldMaterialCode,
      inboundOrderNo: detail.inboundOrderNo,
    );
  }

  bool _shouldCheckBatchByItems(List<AswhUpTaskDetailItem> items) {
    if (items.isEmpty) {
      return true;
    }
    final proType = items.first.proType ?? '';
    const batchTypes = {'10', '12', '15', '16', '17', '18'};
    return batchTypes.contains(proType);
  }

  bool _shouldCheckSupplierByItems(List<AswhUpTaskDetailItem> items) {
    if (items.isEmpty) {
      return false;
    }
    final proType = items.first.proType ?? '';
    const supplierTypes = {'9', '10'};
    return supplierTypes.contains(proType);
  }

  bool _shouldRestrictMaterialMixing(List<AswhUpTaskDetailItem> items) {
    return true;
  }

  AswhUpTaskDetailItem _selectCandidate(
    List<AswhUpTaskDetailItem> candidates,
    List<AswhUpTaskDetailItem> visible,
  ) {
    if (candidates.isEmpty) {
      return const AswhUpTaskDetailItem(
        inTaskItemId: 0,
        inTaskId: 0,
        materialCode: '',
      );
    }
    final visibleIds = visible.map((item) => item.inTaskItemId).toSet();
    return candidates.firstWhere(
      (candidate) => visibleIds.contains(candidate.inTaskItemId),
      orElse: () => candidates.first,
    );
  }

  Map<String, dynamic> _parseMatControlInfo(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final normalized = <String, dynamic>{};
      raw.forEach((key, value) {
        normalized[key.toString().toLowerCase()] = value;
      });
      final msg = raw['msg'];
      if (msg is String) {
        final parts = msg.split('!');
        if (parts.isNotEmpty) {
          normalized.putIfAbsent('matflag', () => parts[0]);
        }
        if (parts.length > 1) {
          normalized.putIfAbsent('mtlweight', () => parts[1]);
        }
        if (parts.length > 2) {
          normalized.putIfAbsent('mtlcapacity', () => parts[2]);
        }
      }
      return normalized;
    }
    if (raw is String) {
      final parts = raw.split('!');
      return {
        'matflag': parts.isNotEmpty ? parts[0] : null,
        'mtlweight': parts.length > 1 ? parts[1] : null,
        'mtlcapacity': parts.length > 2 ? parts[2] : null,
      };
    }
    return <String, dynamic>{};
  }

  bool _equalsIgnoreCase(String a, String b) =>
      a.toUpperCase() == b.toUpperCase();

  String _readString(Map<String, dynamic> source, String key) {
    final lowerKey = key.toLowerCase();
    final entry = source.entries.firstWhere(
      (element) => element.key.toString().toLowerCase() == lowerKey,
      orElse: () => const MapEntry<String, dynamic>('', ''),
    );
    final value = entry.value;
    if (value == null) {
      return '';
    }
    return value.toString().trim();
  }

  String _resolveExpectedOwner(
    AswhUpBarcodeContent barcode,
    AswhUpTaskDetailItem item,
  ) {
    final barcodeOwner =
        (barcode.supplierCode ?? barcode.supplierName ?? '').trim();
    if (barcodeOwner.isNotEmpty) {
      return barcodeOwner;
    }
    return (item.supplierName ?? '').trim();
  }

  double? _extractMaterialCapacity(Map<String, dynamic> info) {
    return _parseDouble(info['mtlcapacity']) ??
        _parseDouble(info['capacity']) ??
        _parseDouble(info['traycapacity']);
  }

  double? _extractMaterialWeight(Map<String, dynamic> info) {
    return _parseDouble(info['mtlweight']) ??
        _parseDouble(info['weight']) ??
        _parseDouble(info['trayweight']);
  }

  String _buildTrayMaterialKey(
    String materialCode,
    String? batchNo,
    bool restrictMaterialMixing,
    bool shouldCheckBatch,
  ) {
    if (!restrictMaterialMixing) {
      return '';
    }
    final buffer = StringBuffer(materialCode.trim());
    if (shouldCheckBatch) {
      buffer.write('#');
      buffer.write((batchNo ?? '').trim());
    }
    return buffer.toString();
  }

  String? _resolveTrayMaterialKeyFromStocks(
    List<AswhUpCollectionStock> stocks,
    bool restrictMaterialMixing,
    bool shouldCheckBatch,
  ) {
    if (!restrictMaterialMixing || stocks.isEmpty) {
      return null;
    }
    final first = stocks.first;
    return _buildTrayMaterialKey(
      first.materialCode,
      shouldCheckBatch ? first.batchNo : null,
      restrictMaterialMixing,
      shouldCheckBatch,
    );
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

  bool _isSerialControlled(String flag) {
    final normalized = flag.trim().toUpperCase();
    return normalized == 'Y' || normalized == '0' || normalized == 'SN';
  }
}
