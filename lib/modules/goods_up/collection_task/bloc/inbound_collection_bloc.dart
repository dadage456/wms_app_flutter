import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/utils/custom_extension.dart';

import '../../../../models/page_status.dart';
import '../../../../utils/error_handler.dart';
import '../../services/goods_up_task_service.dart';
import '../../task_list/models/goods_up_task.dart';
import '../models/inbound_collection_models.dart';
import '../models/inbound_collection_request.dart';
import 'inbound_collection_event.dart';
import 'inbound_collection_state.dart';

enum _SeqControlType { serial, batch, none }

class InboundCollectionBloc
    extends Bloc<InboundCollectionEvent, InboundCollectionState> {
  InboundCollectionBloc({required GoodsUpTaskService service})
    : _service = service,
      super(const InboundCollectionState()) {
    on<InitializeInboundCollectionEvent>(_onInitialize);
    on<PerformInboundScanEvent>(_onPerformScan);
    on<ChangeInboundTabEvent>(_onChangeTab);
    on<UpdateInboundSelectionEvent>(_onUpdateSelection);
    on<CommitInboundCollectionEvent>(_onCommitCollection);
    on<ResetInboundStatusEvent>(_onResetStatus);
    on<RequestInboundFocusEvent>(_onRequestFocus);
    on<DeleteInboundStocksEvent>(_onDeleteStocks);
    on<UpdateInboundFromResultEvent>(_onUpdateFromResult);
    on<ClearInboundCacheEvent>(_onClearCacheFlag);
  }

  final GoodsUpTaskService _service;
  final Uuid _uuid = const Uuid();

  late GoodsUpTask _task;
  late int _userId;
  Box<dynamic>? _cacheBox;

  Future<void> _onInitialize(
    InitializeInboundCollectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    _task = event.task;
    _userId = event.userId;

    await _openCacheBox();
    await _loadDetailList(emit, restoreCache: true);
  }

  Future<void> _openCacheBox() async {
    _cacheBox = await Hive.openBox('collection_cache_${_task.inTaskId}');
  }

  GoodsUpCollectTaskItemQuery _buildQuery() {
    return GoodsUpCollectTaskItemQuery(
      inTaskNo: _task.inTaskNo,
      inTaskId: _task.inTaskId.toString(),
      storeRoomNo: _task.storeRoomNo ?? '',
      taskComment: _task.taskComment ?? '',
      workStation: _task.workStation ?? '',
      collecter: _userId,
      userId: _userId,
    );
  }

  Future<void> _loadDetailList(
    Emitter<InboundCollectionState> emit, {
    bool restoreCache = false,
  }) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final items = await _service.getInboundCollectItems(query: _buildQuery());
      final clonedItems = items.map(_cloneDetail).toList();
      final proType = clonedItems.isEmpty ? null : clonedItems.first.proType;
      final shouldCheckBatch = _requiresBatchValidation(proType);
      final allowErpStoreBypass = _allowsErpStoreBypass(proType);
      final filteredCollection = state.storeSite.isEmpty
          ? const <InboundCollectTaskItem>[]
          : clonedItems
                .where(
                  (item) =>
                      (item.storeSiteNo ?? '').trim() == state.storeSite.trim(),
                )
                .toList();

      emit(
        state.copyWith(
          detailList: clonedItems,
          collectionList: filteredCollection,
          storeRoom: _task.storeRoomNo ?? '',
          status: CollectionStatus.success(),
          placeholder: _getPlaceMessage(),
          shouldCheckBatch: shouldCheckBatch,
          allowErpStoreBypass: allowErpStoreBypass,
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

  Future<void> _restoreFromCache(Emitter<InboundCollectionState> emit) async {
    try {
      final box = _cacheBox;
      if (box == null) return;

      final updateFlag = box.get('updateFlag', defaultValue: '0');
      if (updateFlag != '1') {
        return;
      }

      final cachedDetails = box.get('detailList', defaultValue: <dynamic>[]);
      final cachedStocks = box.get('stocks', defaultValue: <dynamic>[]);
      final cachedDicSeq = Map<String, String>.from(
        box.get('dicSeq', defaultValue: <String, String>{}),
      );
      final cachedDicMtlQtyRaw = Map<String, dynamic>.from(
        box.get('dicMtlQty', defaultValue: <String, dynamic>{}),
      );
      final cachedDicInvQty = Map<String, double>.from(
        box.get('dicInvMtlQty', defaultValue: <String, double>{}),
      );

      final detailList = List<dynamic>.from(cachedDetails)
          .map(
            (item) => InboundCollectTaskItem.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .map(_cloneDetail)
          .toList();

      final proType = detailList.isEmpty ? null : detailList.first.proType;
      final shouldCheckBatch = _requiresBatchValidation(proType);
      final allowErpStoreBypass = _allowsErpStoreBypass(proType);

      final stocks = List<dynamic>.from(cachedStocks)
          .map(
            (item) => InboundCollectionStock.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();

      final dicMtlQty = cachedDicMtlQtyRaw.map(
        (key, value) => MapEntry(key, List<dynamic>.from(value as List)),
      );

      emit(
        state.copyWith(
          detailList: detailList,
          collectionList: state.storeSite.isEmpty
              ? detailList
              : detailList
                    .where(
                      (item) =>
                          (item.storeSiteNo ?? '').trim() ==
                          state.storeSite.trim(),
                    )
                    .toList(),
          stocks: stocks,
          dicSeq: cachedDicSeq,
          dicMtlQty: dicMtlQty,
          dicInvMtlQty: cachedDicInvQty,
          candidateItemIds: const [],
          status: CollectionStatus.success(),
          shouldCheckBatch: shouldCheckBatch,
          allowErpStoreBypass: allowErpStoreBypass,
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

  Future<void> _persistCache(InboundCollectionState newState) async {
    return;
    final box = _cacheBox;
    if (box == null) return;

    await box.put(
      'detailList',
      newState.detailList.map((e) => e.toJson()).toList(),
    );
    await box.put('stocks', newState.stocks.map((e) => e.toJson()).toList());
    await box.put('dicSeq', newState.dicSeq);
    await box.put('dicInvMtlQty', newState.dicInvMtlQty);
    await box.put('dicMtlQty', newState.dicMtlQty);
    await box.put('updateFlag', '1');
  }

  bool _isNumeric(String str) {
    return RegExp(r'^[0-9]+(\.[0-9]+)?').hasMatch(str);
  }

  Future<void> _onPerformScan(
    PerformInboundScanEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final payload = event.payload.trim();
    if (payload.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('扫描内容不能为空')));
      return;
    }

    if (payload.contains('MC')) {
      await _handleMaterialScan(payload, emit);
    } else if (payload.contains('\$KW\$')) {
      await _handleSiteScan(payload, emit);
    } else if (_isNumeric(payload)) {
      await _handleQuantityInput(payload, emit);
    } else {
      emit(state.copyWith(status: CollectionStatus.error('采集内容不合法！')));
      return;
    }

    final placeholder = _getPlaceMessage();

    final focus = placeholder == '请输入数量';

    emit(state.copyWith(placeholder: placeholder, focus: focus));
  }

  Future<void> _handleSiteScan(
    String site,
    Emitter<InboundCollectionState> emit,
  ) async {
    try {
      final storeRoom = _task.storeRoomNo ?? '';
      if (storeRoom.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('任务缺少库房信息，无法校验库位')));
        return;
      }

      final resolvedSite = _extractSiteCode(site);
      if (resolvedSite.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('解析库位条码失败，请重新扫描')));
        return;
      }

      final result = await _service.getStoreSiteByRoom(
        storeRoomNo: storeRoom,
        storeSiteNo: resolvedSite,
      );
      if (result.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('库位【$resolvedSite】不存在或不在当前库房'),
          ),
        );
        return;
      }

      final siteInfo = result.first;
      final frozenFlag = siteInfo['isfrozen'] ?? siteInfo['isFrozen'];
      final isFrozen = frozenFlag != null && frozenFlag.toString() != '0';
      if (isFrozen) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('库位【$resolvedSite】被锁定或冻结，无法采集'),
          ),
        );
        return;
      }

      final collectionList = state.detailList
          .where(
            (item) => (item.storeSiteNo ?? '').trim() == resolvedSite.trim(),
          )
          .toList();

      emit(
        state.copyWith(
          storeSite: resolvedSite,
          collectionList: collectionList,
          scanStep: InboundScanStep.material,
          focus: false,
          currentBarcode: null,
          currentItem: null,
          candidateItemIds: const [],
          currentTab: 1,
          repQty: 0,
          collectQty: 0,
          isDangerous: false,
          requireDangerousSupplement: false,
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

  Future<void> _handleMaterialScan(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    try {
      final barcodeContent = await _service.getInboundBarcodeInfo(
        barcode.trim(),
      );

      final materialCode = (barcodeContent.materialCode ?? '').trim();
      if (materialCode.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('未解析到有效的物料编码')));
        return;
      }

      final isOldFormat = (barcodeContent.idOld ?? '').trim() == '0';
      final controlType = _parseSeqCtrl(barcodeContent.seqCtrl);
      if (controlType == null) {
        emit(
          state.copyWith(status: CollectionStatus.error('条码缺少管控方式，无法匹配任务明细')),
        );
        return;
      }

      final trimmedStoreSite = state.storeSite.trim();
      var trimmedBatch = (barcodeContent.batchNo ?? '').trim();
      final trimmedSerial = (barcodeContent.serialNo ?? '').trim();

      if (controlType == _SeqControlType.serial && trimmedSerial.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('序列号不能为空')));
        return;
      }

      if (controlType == _SeqControlType.serial) {
        final seqKey = '$materialCode@$trimmedSerial';
        if (state.dicSeq.containsKey(seqKey)) {
          emit(state.copyWith(status: CollectionStatus.error('序列号已采集，请勿重复扫描')));
          return;
        }
      }

      if (trimmedBatch.isEmpty &&
          controlType != _SeqControlType.serial &&
          state.shouldCheckBatch) {
        trimmedBatch = trimmedSerial;
      }

      final requiresBatch =
          state.shouldCheckBatch ||
          controlType == _SeqControlType.batch ||
          controlType == _SeqControlType.serial;
      if (requiresBatch && trimmedBatch.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('批次号不能为空')));
        return;
      }

      final matchingDetails = _findMatchingDetails(
        state.detailList,
        materialCode: materialCode,
        storeSite: trimmedStoreSite,
        batchNo: trimmedBatch,
        serialNo: trimmedSerial,
        controlType: controlType,
      );

      if (matchingDetails.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('未在任务明细中找到匹配的物料')));
        return;
      }

      final availableDetails = matchingDetails
          .where((detail) => detail.planQty - detail.collectedQty > 0)
          .toList();

      if (availableDetails.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('当前物料已采集完成')));
        return;
      }

      final targetItem = availableDetails.first;

      final resolvedSite = state.storeSite.isNotEmpty
          ? state.storeSite.trim()
          : (targetItem.storeSiteNo ?? '').trim();

      final storeRoom = state.storeRoom.isNotEmpty
          ? state.storeRoom
          : (targetItem.storeRoomNo ?? '');
      final shouldBypassErpCheck =
          state.allowErpStoreBypass &&
          storeRoom.trim().toUpperCase() == 'XN-BL';

      double repQty = targetItem.repertoryQty;
      if (resolvedSite.isNotEmpty) {
        try {
          repQty = await _queryInventoryQuantity(
            storeSite: resolvedSite,
            item: targetItem,
            barcode: barcodeContent.copyWith(batchNo: trimmedBatch),
            bypassErpValidation: shouldBypassErpCheck,
          );
        } catch (error) {
          emit(
            state.copyWith(
              status: CollectionStatus.error(ErrorHandler.handleError(error)),
            ),
          );
          return;
        }
      }

      final candidateIds = availableDetails
          .map((detail) => detail.inTaskItemId)
          .toList();
      final normalizedBarcode = barcodeContent.copyWith(
        batchNo: trimmedBatch,
        serialNo: trimmedSerial,
        seqCtrl: _seqCtrlCode(controlType),
      );

      final isDangerous = (normalizedBarcode.dgFlag ?? '').toUpperCase() == 'Y';
      final missingMessage = isDangerous
          ? _buildDangerousMissingMessage(normalizedBarcode)
          : null;
      final requiresSupplement = missingMessage != null;

      if (!requiresSupplement && controlType == _SeqControlType.serial) {
        await _processCollection(
          quantity: 1,
          barcode: normalizedBarcode.copyWith(quantity: 1),
          candidateItemIds: candidateIds,
          referenceItem: targetItem,
          emit: emit,
        );
        return;
      }

      final clonedItem = _cloneDetail(targetItem);
      final nextStep = requiresSupplement
          ? InboundScanStep.dangerousSupplement
          : InboundScanStep.quantity;

      emit(
        state.copyWith(
          currentBarcode: normalizedBarcode,
          currentItem: clonedItem,
          storeSite: resolvedSite,
          storeRoom: storeRoom,
          scanStep: nextStep,
          status: requiresSupplement
              ? CollectionStatus.error(missingMessage)
              : CollectionStatus.success(),
          repQty: repQty,
          isDangerous: isDangerous,
          requireDangerousSupplement: requiresSupplement,
          candidateItemIds: candidateIds,
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
    Emitter<InboundCollectionState> emit,
  ) async {
    if (state.requireDangerousSupplement) {
      emit(
        state.copyWith(status: CollectionStatus.error('该物料为危化品，请先采集生产日期、效期信息')),
      );
      return;
    }

    final quantity = double.tryParse(payload);
    if (quantity == null || quantity <= 0) {
      emit(state.copyWith(status: CollectionStatus.error('请输入有效的数量')));
      return;
    }

    final item = state.currentItem;
    final barcode = state.currentBarcode;
    if (item == null || barcode == null) {
      emit(state.copyWith(status: CollectionStatus.error('请先扫描物料信息')));
      return;
    }

    final candidateIds = state.candidateItemIds.isNotEmpty
        ? state.candidateItemIds
        : [item.inTaskItemId];

    await _processCollection(
      quantity: quantity,
      barcode: barcode,
      candidateItemIds: candidateIds,
      referenceItem: item,
      emit: emit,
    );
  }

  Future<void> _processCollection({
    required double quantity,
    required InboundBarcodeContent barcode,
    required List<int> candidateItemIds,
    required InboundCollectTaskItem referenceItem,
    required Emitter<InboundCollectionState> emit,
  }) async {
    if (quantity <= 0) {
      emit(state.copyWith(status: CollectionStatus.error('请输入有效的数量')));
      return;
    }

    final materialCode = (barcode.materialCode ?? referenceItem.materialCode)
        .trim();
    final resolvedSite = state.storeSite.isNotEmpty
        ? state.storeSite.trim()
        : (referenceItem.storeSiteNo ?? '').trim();
    var batchNo = (barcode.batchNo ?? '').trim();
    final serialNo = (barcode.serialNo ?? '').trim();

    final controlType = _parseSeqCtrl(barcode.seqCtrl);

    if (controlType == null) {
      emit(state.copyWith(status: CollectionStatus.error('无法识别物料的管控方式')));
      return;
    }

    if (batchNo.isEmpty &&
        controlType != _SeqControlType.serial &&
        state.shouldCheckBatch) {
      batchNo = serialNo;
    }

    final candidateIdSet = candidateItemIds.isEmpty
        ? null
        : candidateItemIds.toSet();

    final updatedDetails = state.detailList.map(_cloneDetail).toList();
    final candidates = _findMatchingDetails(
      updatedDetails,
      materialCode: materialCode,
      storeSite: resolvedSite,
      batchNo: batchNo,
      serialNo: serialNo,
      controlType: controlType,
      limitIds: candidateIdSet,
    );

    if (candidates.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('当前物料不在任务明细中')));
      return;
    }

    var totalAvailable = 0.0;
    for (final detail in candidates) {
      final remain = detail.planQty - detail.collectedQty;
      if (remain > 1e-6) {
        totalAvailable += remain;
      }
    }

    if (totalAvailable <= 0) {
      emit(state.copyWith(status: CollectionStatus.error('当前物料已采集完成')));
      return;
    }

    if (quantity > totalAvailable + 1e-6) {
      emit(state.copyWith(status: CollectionStatus.error('采集数量超过剩余可采集数量')));
      return;
    }

    final updatedDicMtlQty = Map<String, List<dynamic>>.from(state.dicMtlQty);
    final updatedDicSeq = Map<String, String>.from(state.dicSeq);
    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);

    var remaining = quantity;
    final newStocks = <InboundCollectionStock>[];
    for (final detail in candidates) {
      final available = detail.planQty - detail.collectedQty;
      if (available <= 1e-6) {
        continue;
      }

      final toCollect = remaining < available ? remaining : available;
      if (toCollect <= 1e-6) {
        continue;
      }

      detail.collectedQty = detail.collectedQty + toCollect;

      final stock = InboundCollectionStock(
        stockId: _uuid.v4(),
        materialCode: barcode.materialCode ?? detail.materialCode,
        materialName: barcode.materialName ?? detail.materialName,
        batchNo: batchNo.isNotEmpty ? batchNo : detail.batchNo,
        serialNo: serialNo.isNotEmpty ? serialNo : detail.serialNo,
        taskQty: detail.planQty,
        collectQty: toCollect,
        inTaskItemId: detail.inTaskItemId.toString(),
        inTaskId: detail.inTaskId.toString(),
        storeRoom: detail.storeRoomNo ?? state.storeRoom,
        storeSite: state.storeSite.isNotEmpty
            ? state.storeSite
            : (detail.storeSiteNo ?? ''),
        erpStore: detail.subInventoryCode,
        trayNo: null,
        productionDate: barcode.productionDate ?? detail.productionDate,
        expireDays: barcode.expireDays ?? detail.expireDays,
      );

      newStocks.add(stock);

      // 循环分配到每个候选明细：统一 old/new 写法（关键修复点）
      // 1) 初始化该明细的 old/new 语义
      final beforeScanCollected =
          detail.collectedQty - toCollect; // 该明细在本次分配前的已采集值
      _ensureOldNewTriplet(
        dicMtlQty: updatedDicMtlQty,
        inTaskItemId: detail.inTaskItemId.toString(),
        materialCode: detail.materialCode,
        currentCollectedBeforeScan: beforeScanCollected,
      );
      // 2) 对该明细的 new 累加 incQty，并可选封顶为明细的计划数 planQty
      _incNewCollected(
        dicMtlQty: updatedDicMtlQty,
        inTaskItemId: detail.inTaskItemId.toString(),
        incQty: toCollect,
        planCap: detail.planQty, // 封顶（等价于"能装满就装满"）
      );

      final invKey = _buildInventoryKey(
        stock.storeSite ?? '',
        stock.materialCode,
        stock.batchNo,
      );
      final currentQty = updatedDicInv[invKey] ?? 0;
      updatedDicInv[invKey] = currentQty + toCollect;

      remaining -= toCollect;
      if (remaining <= 1e-6) {
        break;
      }
    }

    if (remaining > 1e-6) {
      emit(state.copyWith(status: CollectionStatus.error('采集数量超过剩余可采集数量')));
      return;
    }

    if (serialNo.isNotEmpty) {
      final seqKey = '$materialCode@$serialNo';
      updatedDicSeq[seqKey] = seqKey;
    }

    final updatedStocks = [...state.stocks, ...newStocks];

    final updatedCollectionList = state.storeSite.isEmpty
        ? updatedDetails
        : updatedDetails
              .where(
                (detail) =>
                    (detail.storeSiteNo ?? '').trim() == state.storeSite.trim(),
              )
              .toList();

    final newState = state.copyWith(
      detailList: updatedDetails,
      stocks: updatedStocks,
      dicMtlQty: updatedDicMtlQty,
      dicSeq: updatedDicSeq,
      dicInvMtlQty: updatedDicInv,
      collectionList: updatedCollectionList,
      currentBarcode: InboundBarcodeContent.fromJson({}),
      currentItem: InboundCollectTaskItem.fromJson({}),
      candidateItemIds: const [],
      collectQty: 0,
      status: CollectionStatus.success('采集成功'),
      focus: false,
      isDangerous: false,
      requireDangerousSupplement: false,
    );

    emit(newState);
    await _persistCache(newState);
  }

  void _onChangeTab(
    ChangeInboundTabEvent event,
    Emitter<InboundCollectionState> emit,
  ) {
    emit(state.copyWith(currentTab: event.index));
  }

  void _onUpdateSelection(
    UpdateInboundSelectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) {
    emit(state.copyWith(checkedIds: event.selectedIds));
  }

  Future<void> _onCommitCollection(
    CommitInboundCollectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (state.stocks.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请先采集数据后再提交')));
      return;
    }

    if (!event.force) {
      final incompleteMessage = _buildIncompleteMessage();
      if (incompleteMessage != null) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('$incompleteMessage，请确认是否继续提交'),
          ),
        );
        return;
      }
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final upShelvesInfos = state.stocks.map((stock) {
        return {
          'taskNo': _task.inTaskNo,
          'matCode': stock.materialCode,
          'batchNo': stock.batchNo ?? '',
          'sn': stock.serialNo,
          'taskQty': stock.taskQty,
          'collectQty': stock.collectQty,
          'storeRoomNo': stock.storeRoom ?? '',
          'storeSiteNo': stock.storeSite ?? '',
          'taskid': int.parse(stock.inTaskId),
          'inTaskItemid': stock.inTaskItemId,
          'data1': stock.productionDate,
          'data2': stock.expireDays?.toString(),
        };
      }).toList();

      // 组装提交的 itemListInfos（修复为 [old, new]）
      final List<Map<String, dynamic>> itemListInfos = [];
      state.dicMtlQty.forEach((inTaskItemId, vals) {
        if (vals.length >= 3) {
          final oldCollected = (vals[0] as num).toDouble();
          final newCollected = (vals[1] as num).toDouble();
          final mtlCode = vals[2] as String;
          itemListInfos.add({
            'mtlQty': [
              oldCollected.toFormatString(),
              newCollected.toFormatString(),
            ], // ✅ 正确语义
            'inTaskItemid': inTaskItemId,
            'mtlCode': mtlCode,
          });
        }
      });

      final filterValues = state.dicSeq.values
          .map((value) => '"' + value.trim() + '"')
          .toList();
      final filter = filterValues.isEmpty ? '' : filterValues.join(',');

      // 可选：打印调试日志（上线可关）
      // debugPrint('[COMMIT] dicMtlQty(old,new,code): ${state.dicMtlQty}');
      // debugPrint('[COMMIT] filter(SN): $filter');

      await _service.commitUpShelves(upShelvesInfos, itemListInfos, filter);

      await _clearCache();
      final freshItems = await _service.getInboundCollectItems(
        query: _buildQuery(),
      );
      final clonedFreshItems = freshItems.map(_cloneDetail).toList();
      final proType = clonedFreshItems.isEmpty
          ? null
          : clonedFreshItems.first.proType;
      final shouldCheckBatch = _requiresBatchValidation(proType);
      final allowErpStoreBypass = _allowsErpStoreBypass(proType);
      final refreshedCollection = state.storeSite.isEmpty
          ? const <InboundCollectTaskItem>[]
          : clonedFreshItems
                .where(
                  (item) =>
                      (item.storeSiteNo ?? '').trim() == state.storeSite.trim(),
                )
                .toList();

      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          detailList: clonedFreshItems,
          collectionList: refreshedCollection,
          stocks: const [],
          dicMtlQty: const {},
          dicSeq: const {},
          dicInvMtlQty: const {},
          currentBarcode: InboundBarcodeContent.fromJson({}),
          currentItem: InboundCollectTaskItem.fromJson({}),
          candidateItemIds: const [],
          checkedIds: const [],
          focus: false,
          shouldCheckBatch: shouldCheckBatch,
          allowErpStoreBypass: allowErpStoreBypass,
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
    ResetInboundStatusEvent event,
    Emitter<InboundCollectionState> emit,
  ) {
    if (!state.status.isNormal) {
      emit(state.copyWith(status: CollectionStatus.normal()));
    }
  }

  void _onRequestFocus(
    RequestInboundFocusEvent event,
    Emitter<InboundCollectionState> emit,
  ) {
    emit(state.copyWith(focus: event.focused));
  }

  Future<void> _onDeleteStocks(
    DeleteInboundStocksEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (event.stockIds.isEmpty) {
      return;
    }

    final toDelete = state.stocks
        .where((stock) => event.stockIds.contains(stock.stockId))
        .toList();
    if (toDelete.isEmpty) {
      return;
    }

    await _removeStocks(
      toDelete,
      emit,
      successMessage: '已删除 ${toDelete.length} 条采集记录',
    );
  }

  Future<void> _onUpdateFromResult(
    UpdateInboundFromResultEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (event.deletedStocks.isEmpty) {
      return;
    }
    await _removeStocks(event.deletedStocks, emit, successMessage: '采集记录已更新');
  }

  Future<void> _removeStocks(
    List<InboundCollectionStock> stocks,
    Emitter<InboundCollectionState> emit, {
    String successMessage = '已删除采集记录',
  }) async {
    final remainingStocks = state.stocks
        .where((stock) => !stocks.any((item) => item.stockId == stock.stockId))
        .toList();

    final updatedDetails = state.detailList.map(_cloneDetail).toList();
    final updatedDicMtlQty = Map<String, List<dynamic>>.from(state.dicMtlQty);
    final updatedDicSeq = Map<String, String>.from(state.dicSeq);
    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);

    for (final stock in stocks) {
      for (var i = 0; i < updatedDetails.length; i++) {
        final detail = updatedDetails[i];
        if (detail.inTaskItemId.toString() == stock.inTaskItemId) {
          final double newCollected = (detail.collectedQty - stock.collectQty)
              .clamp(0, detail.planQty);
          final updatedDetail = _cloneDetail(detail);
          updatedDetail.collectedQty = newCollected;
          updatedDetails[i] = updatedDetail;
        }
      }

      // 新逻辑：dicMtlQty 统一 old/new 语义，[old, new, code]
      final key = stock.inTaskItemId;
      final vals = updatedDicMtlQty[key];
      if (vals != null && vals.length >= 3) {
        // 回滚 new := max(new - dec, old)
        _rollbackNewCollected(
          dicMtlQty: updatedDicMtlQty,
          inTaskItemId: key,
          decQty: stock.collectQty,
        );
      }

      if (stock.serialNo != null && stock.serialNo!.isNotEmpty) {
        updatedDicSeq.remove('${stock.materialCode}@${stock.serialNo}');
      }

      final invKey = _buildInventoryKey(
        stock.storeSite ?? '',
        stock.materialCode,
        stock.batchNo,
      );
      final remain = (updatedDicInv[invKey] ?? 0) - stock.collectQty;
      if (remain <= 0) {
        updatedDicInv.remove(invKey);
      } else {
        updatedDicInv[invKey] = remain;
      }
    }

    final updatedCollectionList = state.storeSite.isEmpty
        ? updatedDetails
        : updatedDetails
              .where(
                (detail) =>
                    (detail.storeSiteNo ?? '').trim() == state.storeSite.trim(),
              )
              .toList();

    final newState = state.copyWith(
      stocks: remainingStocks,
      detailList: updatedDetails,
      dicMtlQty: updatedDicMtlQty,
      dicSeq: updatedDicSeq,
      dicInvMtlQty: updatedDicInv,
      collectionList: updatedCollectionList,
      status: CollectionStatus.success(successMessage),
      collectQty: 0,
      candidateItemIds: const [],
    );

    emit(newState);
    await _persistCache(newState);
  }

  Future<void> _clearCache() async {
    final box = _cacheBox;
    if (box == null) return;
    await box.clear();
    await box.put('updateFlag', '0');
  }

  Future<void> _onClearCacheFlag(
    ClearInboundCacheEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    await _clearCache();
  }

  String? _buildDangerousMissingMessage(InboundBarcodeContent barcode) {
    final missing = <String>[];
    if ((barcode.productionDate ?? '').trim().isEmpty) {
      missing.add('生产日期');
    }
    final expire = barcode.expireDays;
    if (expire == null) {
      missing.add('效期');
    }
    if (missing.isEmpty) {
      return null;
    }
    return '该物料为危化品，请采集${missing.join('、')}信息';
  }

  String _extractSiteCode(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    const marker = r'$KW$';
    final markerIndex = trimmed.indexOf(marker);
    if (markerIndex >= 0) {
      final extracted = trimmed.substring(markerIndex + marker.length).trim();
      if (extracted.isNotEmpty) {
        return extracted;
      }
    }

    final segments = trimmed.split(r'$');
    if (segments.length >= 3) {
      final candidate = segments[2].trim();
      if (candidate.isNotEmpty) {
        return candidate;
      }
    }

    return trimmed;
  }

  bool _requiresBatchValidation(String? proType) {
    final value = proType?.trim();
    if (value == null || value.isEmpty) {
      return false;
    }

    const batchControlled = {'10', '12', '15', '16', '17', '18'};
    return batchControlled.contains(value);
  }

  _SeqControlType? _parseSeqCtrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    switch (trimmed) {
      case '0':
        return _SeqControlType.serial;
      case '1':
        return _SeqControlType.batch;
      case '2':
        return _SeqControlType.none;
    }
    return null;
  }

  String _seqCtrlCode(_SeqControlType type) {
    switch (type) {
      case _SeqControlType.serial:
        return '0';
      case _SeqControlType.batch:
        return '1';
      case _SeqControlType.none:
        return '2';
    }
  }

  List<InboundCollectTaskItem> _findMatchingDetails(
    List<InboundCollectTaskItem> details, {
    required String materialCode,
    required String storeSite,
    required String batchNo,
    required String serialNo,
    required _SeqControlType controlType,
    Set<int>? limitIds,
  }) {
    final trimmedSite = storeSite.trim();
    final requiresBatch =
        state.shouldCheckBatch ||
        controlType == _SeqControlType.batch ||
        controlType == _SeqControlType.serial;
    final requiresSerial =
        controlType == _SeqControlType.serial && serialNo.isNotEmpty;

    return details.where((item) {
      if (item.materialCode != materialCode) {
        return false;
      }
      if (limitIds != null && !limitIds.contains(item.inTaskItemId)) {
        return false;
      }
      if (trimmedSite.isNotEmpty) {
        final site = (item.storeSiteNo ?? '').trim();
        if (site != trimmedSite) {
          return false;
        }
      }

      if (requiresBatch) {
        if (batchNo.isEmpty) {
          return false;
        }
        final itemBatch = (item.batchNo ?? '').trim();
        if (itemBatch != batchNo) {
          return false;
        }
      }

      if (requiresSerial) {
        final itemSerial = (item.serialNo ?? '').trim();
        if (itemSerial.isEmpty || itemSerial != serialNo) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  String _formatQuantity(double value) {
    final rounded = value.roundToDouble();
    if ((rounded - value).abs() < 1e-6) {
      return rounded.toStringAsFixed(0);
    }
    var textValue = value.toStringAsFixed(3);
    while (textValue.contains('.') && textValue.endsWith('0')) {
      textValue = textValue.substring(0, textValue.length - 1);
    }
    if (textValue.endsWith('.')) {
      textValue = textValue.substring(0, textValue.length - 1);
    }
    return textValue;
  }

  String? _buildIncompleteMessage() {
    for (final detail in state.detailList) {
      final remain = detail.planQty - detail.collectedQty;
      if (remain > 1e-6) {
        final site = (detail.storeSiteNo ?? '').trim();
        final displaySite = site.isEmpty ? '-' : site;
        final formatted = _formatQuantity(remain);
        return '库位【$displaySite】物料【${detail.materialCode}】还剩【$formatted】未做';
      }
    }
    return null;
  }

  bool _allowsErpStoreBypass(String? proType) {
    final value = proType?.trim();
    if (value == null || value.isEmpty) {
      return false;
    }

    return value == '9' || value == '10';
  }

  Future<double> _queryInventoryQuantity({
    required String storeSite,
    required InboundCollectTaskItem item,
    required InboundBarcodeContent barcode,
    bool bypassErpValidation = false,
  }) async {
    final repertoryList = await _service.getMtlRepertoryByStoreSite(
      storeSite: storeSite,
      materialCode: item.materialCode,
    );

    if (repertoryList.isEmpty) {
      return 0;
    }

    final normalized = repertoryList
        .map((row) => Map<String, dynamic>.from(row))
        .toList();

    final matchKey =
        (barcode.batchNo ?? barcode.serialNo ?? item.batchNo ?? item.serialNo)
            ?.trim();
    final filtered = _filterInventoryByKey(normalized, matchKey);

    final baseList = filtered.isNotEmpty ? filtered : normalized;
    final erpStore = _readString(
      baseList.first['erpStoreroom'] ??
          baseList.first['erpstoreroom'] ??
          baseList.first['erpStore'],
    )?.trim();

    final expected = (item.subInventoryCode ?? '').trim();
    if (!bypassErpValidation &&
        expected.isNotEmpty &&
        erpStore != null &&
        erpStore.isNotEmpty) {
      if (erpStore != expected) {
        throw Exception('当前物料明细指定子库【$expected】与库位物料批次子库【$erpStore】存在不一致，请确认');
      }
    }

    var repQty = 0.0;
    for (final row in (filtered.isNotEmpty ? filtered : normalized)) {
      repQty += _toDouble(
        row['repqty'] ?? row['repQty'] ?? row['quantity'] ?? row['qty'],
      );
    }
    return repQty;
  }

  List<Map<String, dynamic>> _filterInventoryByKey(
    List<Map<String, dynamic>> source,
    String? matchKey,
  ) {
    final trimmed = matchKey?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return source;
    }

    final filtered = source.where((row) {
      final candidates = [
        row['batchno'],
        row['batchNo'],
        row['batch'],
        row['sn'],
        row['SN'],
      ];
      return candidates.any(
        (value) => value != null && value.toString().trim() == trimmed,
      );
    }).toList();

    return filtered.isEmpty ? source : filtered;
  }

  String? _readString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0;
    }
    return 0;
  }

  String _buildInventoryKey(String site, String materialCode, String? batchNo) {
    return '${site.trim()}|$materialCode|${batchNo ?? ''}';
  }

  String _getPlaceMessage() {
    if (state.storeSite.isEmpty) {
      return '请扫描库位';
    }
    if (state.currentBarcode?.isEmpty ?? true) {
      return '请扫描二维码';
    }

    final seqCtrl = _parseSeqCtrl(state.currentBarcode?.seqCtrl);

    if ((seqCtrl != _SeqControlType.serial) && state.collectQty == 0) {
      return '请输入数量';
    }
    return '';
  }

  // ======================= BEGIN: DICMtlQty helpers (统一 old/new 语义) =======================
  // 语义：dicMtlQty[inTaskItemId] = [oldCollectedBeforeThisScan, newCollectedAfterThisScan, materialCode]
  List<dynamic> _ensureOldNewTriplet({
    required Map<String, List<dynamic>> dicMtlQty,
    required String inTaskItemId,
    required String materialCode,
    required double currentCollectedBeforeScan,
  }) {
    final exists = dicMtlQty[inTaskItemId];
    if (exists == null || exists.length < 3) {
      // 初始化为 [old=new=扫描前已采集数, 物料编码]
      dicMtlQty[inTaskItemId] = <dynamic>[
        currentCollectedBeforeScan, // old
        currentCollectedBeforeScan, // new
        materialCode, // code
      ];
    } else {
      // 若已存在，但缺项或被误写，强制修正长度与位置
      dicMtlQty[inTaskItemId] = <dynamic>[
        (exists.length >= 1
            ? (exists[0] as num?)?.toDouble() ?? currentCollectedBeforeScan
            : currentCollectedBeforeScan),
        (exists.length >= 2
            ? (exists[1] as num?)?.toDouble() ?? currentCollectedBeforeScan
            : currentCollectedBeforeScan),
        (exists.length >= 3
            ? (exists[2] as String?) ?? materialCode
            : materialCode),
      ];
    }
    return dicMtlQty[inTaskItemId]!;
  }

  void _incNewCollected({
    required Map<String, List<dynamic>> dicMtlQty,
    required String inTaskItemId,
    required double incQty,
    double? planCap, // 可选上限（计划数）——封顶
  }) {
    final v = dicMtlQty[inTaskItemId]!;
    final oldVal = (v[0] as num).toDouble();
    var newVal = (v[1] as num).toDouble() + incQty;
    if (planCap != null) {
      if (newVal > planCap) newVal = planCap;
    }
    // new 不得小于 old
    if (newVal < oldVal) newVal = oldVal;
    dicMtlQty[inTaskItemId] = <dynamic>[oldVal, newVal, v[2]];
  }

  void _rollbackNewCollected({
    required Map<String, List<dynamic>> dicMtlQty,
    required String inTaskItemId,
    required double decQty,
  }) {
    final v = dicMtlQty[inTaskItemId]!;
    final oldVal = (v[0] as num).toDouble();
    var newVal = (v[1] as num).toDouble() - decQty;
    if (newVal < oldVal) newVal = oldVal; // 关键：回滚不得低于 old
    dicMtlQty[inTaskItemId] = <dynamic>[oldVal, newVal, v[2]];
  }
  // =======================  END:  DICMtlQty helpers  =========================================

  InboundCollectTaskItem _cloneDetail(InboundCollectTaskItem source) {
    return InboundCollectTaskItem(
      inTaskItemId: source.inTaskItemId,
      inTaskId: source.inTaskId,
      materialCode: source.materialCode,
      materialName: source.materialName,
      storeSiteNo: source.storeSiteNo,
      storeRoomNo: source.storeRoomNo,
      subInventoryCode: source.subInventoryCode,
      batchNo: source.batchNo,
      serialNo: source.serialNo,
      unit: source.unit,
      planQty: source.planQty,
      collectedQty: source.collectedQty,
      repertoryQty: source.repertoryQty,
      expireDays: source.expireDays,
      productionDate: source.productionDate,
      proType: source.proType,
      orderno: source.orderno,
      matinnercode: source.matinnercode,
      intaskno: source.intaskno,
      taskcommend: source.taskcommend,
    );
  }
}
