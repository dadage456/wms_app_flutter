import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/page_status.dart';
import '../../../../utils/error_handler.dart';
import '../../services/goods_up_task_service.dart';
import '../../task_list/models/goods_up_task.dart';
import '../models/inbound_collection_models.dart';
import '../models/inbound_collection_request.dart';
import 'inbound_collection_event.dart';
import 'inbound_collection_state.dart';

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

      final items = await _service.getInboundCollectItems(
        query: _buildQuery(),
      );

      emit(
        state.copyWith(
          detailList: items.map(_cloneDetail).toList(),
          collectionList: state.storeSite.isEmpty
              ? const []
              : items
                  .where((item) =>
                      (item.storeSiteNo ?? '').trim() == state.storeSite.trim())
                  .map(_cloneDetail)
                  .toList(),
          storeRoom: _task.storeRoomNo ?? '',
          status: CollectionStatus.success(),
          placeholder: state.scanStep == InboundScanStep.site
              ? '请扫描库位'
              : state.placeholder,
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
          .map((item) => InboundCollectTaskItem.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .map(_cloneDetail)
          .toList();

      final stocks = List<dynamic>.from(cachedStocks)
          .map((item) => InboundCollectionStock.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList();

      final dicMtlQty = cachedDicMtlQtyRaw.map(
        (key, value) => MapEntry(
          key,
          List<dynamic>.from(value as List),
        ),
      );

      emit(
        state.copyWith(
          detailList: detailList,
          collectionList: state.storeSite.isEmpty
              ? detailList
              : detailList
                  .where((item) =>
                      (item.storeSiteNo ?? '').trim() == state.storeSite.trim())
                  .toList(),
          stocks: stocks,
          dicSeq: cachedDicSeq,
          dicMtlQty: dicMtlQty,
          dicInvMtlQty: cachedDicInvQty,
          status: CollectionStatus.success(),
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
    final box = _cacheBox;
    if (box == null) return;

    await box.put(
      'detailList',
      newState.detailList.map((e) => e.toJson()).toList(),
    );
    await box.put(
      'stocks',
      newState.stocks.map((e) => e.toJson()).toList(),
    );
    await box.put('dicSeq', newState.dicSeq);
    await box.put('dicInvMtlQty', newState.dicInvMtlQty);
    await box.put('dicMtlQty', newState.dicMtlQty);
    await box.put('updateFlag', '1');
  }

  Future<void> _onPerformScan(
    PerformInboundScanEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final payload = event.payload.trim();
    if (payload.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('扫描内容不能为空'),
        ),
      );
      return;
    }

    switch (state.scanStep) {
      case InboundScanStep.site:
        await _handleSiteScan(payload, emit);
        break;
      case InboundScanStep.material:
        await _handleMaterialScan(payload, emit);
        break;
      case InboundScanStep.quantity:
        await _handleQuantityInput(payload, emit);
        break;
    }
  }

  Future<void> _handleSiteScan(
    String site,
    Emitter<InboundCollectionState> emit,
  ) async {
    try {
      final storeRoom = _task.storeRoomNo ?? '';
      if (storeRoom.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('任务缺少库房信息，无法校验库位'),
          ),
        );
        return;
      }

      final result = await _service.getStoreSiteByRoom(
        storeRoomNo: storeRoom,
        storeSiteNo: site,
      );
      if (result.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('库位【$site】不存在或不在当前库房'),
          ),
        );
        return;
      }

      final collectionList = state.detailList
          .where((item) => (item.storeSiteNo ?? '').trim() == site.trim())
          .toList();

      emit(
        state.copyWith(
          storeSite: site,
          collectionList: collectionList,
          placeholder: '请扫描物料二维码',
          scanStep: InboundScanStep.material,
          status: CollectionStatus.success(),
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

  Future<void> _handleMaterialScan(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    try {
      final barcodeContent =
          await _service.getInboundBarcodeInfo(barcode.trim());

      final materialCode = barcodeContent.materialCode ?? '';
      if (materialCode.isEmpty) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('未解析到有效的物料编码'),
          ),
        );
        return;
      }

      final targetItem = state.detailList.firstWhereOrNull((item) {
        final sameMaterial = item.materialCode == materialCode;
        if (!sameMaterial) return false;

        if (state.storeSite.isNotEmpty) {
          final site = (item.storeSiteNo ?? '').trim();
          if (site != state.storeSite.trim()) {
            return false;
          }
        }

        final batch = (barcodeContent.batchNo ?? '').trim();
        if (batch.isNotEmpty) {
          return (item.batchNo ?? '').trim() == batch;
        }
        return true;
      });

      if (targetItem == null) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('未在任务明细中找到匹配的物料'),
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          currentBarcode: barcodeContent,
          currentItem: _cloneDetail(targetItem),
          storeSite: state.storeSite.isNotEmpty
              ? state.storeSite
              : (targetItem.storeSiteNo ?? ''),
          placeholder: '请输入采集数量',
          scanStep: InboundScanStep.quantity,
          status: CollectionStatus.success(),
          focus: true,
          repQty: targetItem.repertoryQty,
          collectQty: targetItem.collectedQty,
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
    final quantity = double.tryParse(payload);
    if (quantity == null || quantity <= 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请输入有效的数量'),
        ),
      );
      return;
    }

    final item = state.currentItem;
    final barcode = state.currentBarcode;
    if (item == null || barcode == null) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先扫描物料信息'),
        ),
      );
      return;
    }

    final available = item.planQty - item.collectedQty;
    if (quantity > available + 1e-6) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('采集数量超过剩余可采集数量'),
        ),
      );
      return;
    }

    final updatedDetails = state.detailList.map(_cloneDetail).toList();
    final targetIndex = updatedDetails.indexWhere(
      (detail) => detail.inTaskItemId == item.inTaskItemId,
    );
    if (targetIndex < 0) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('当前物料不在任务明细中'),
        ),
      );
      return;
    }

    final targetDetail = updatedDetails[targetIndex];
    targetDetail.collectedQty = targetDetail.collectedQty + quantity;

    final stock = InboundCollectionStock(
      stockId: _uuid.v4(),
      materialCode: barcode.materialCode ?? item.materialCode,
      materialName: barcode.materialName ?? item.materialName,
      batchNo: barcode.batchNo?.isNotEmpty == true
          ? barcode.batchNo
          : item.batchNo,
      serialNo: barcode.serialNo?.isNotEmpty == true
          ? barcode.serialNo
          : item.serialNo,
      taskQty: item.planQty,
      collectQty: quantity,
      inTaskItemId: item.inTaskItemId.toString(),
      inTaskId: item.inTaskId.toString(),
      storeRoom: item.storeRoomNo ?? state.storeRoom,
      storeSite: state.storeSite.isNotEmpty
          ? state.storeSite
          : (item.storeSiteNo ?? ''),
      erpStore: item.subInventoryCode,
      trayNo: null,
      productionDate:
          barcode.productionDate ?? item.productionDate ?? item.productionDate,
      expireDays: barcode.expireDays ?? item.expireDays,
    );

    final updatedStocks = [...state.stocks, stock];

    final updatedDicMtlQty = Map<String, List<dynamic>>.from(state.dicMtlQty);
    final key = item.inTaskItemId.toString();
    final updatedCollected = targetDetail.collectedQty;
    updatedDicMtlQty[key] = [
      item.planQty,
      updatedCollected,
      item.materialCode,
    ];

    final updatedDicSeq = Map<String, String>.from(state.dicSeq);
    final serial = stock.serialNo;
    if (serial != null && serial.isNotEmpty) {
      final seqKey = '${stock.materialCode}@$serial';
      updatedDicSeq[seqKey] = seqKey;
    }

    final updatedDicInv = Map<String, double>.from(state.dicInvMtlQty);
    final invKey = _buildInventoryKey(
      stock.storeSite ?? '',
      stock.materialCode,
      stock.batchNo,
    );
    final currentQty = updatedDicInv[invKey] ?? 0;
    updatedDicInv[invKey] = currentQty + quantity;

    final updatedCollectionList = state.storeSite.isEmpty
        ? updatedDetails
        : updatedDetails
            .where((detail) =>
                (detail.storeSiteNo ?? '').trim() == state.storeSite.trim())
            .toList();

    final newState = state.copyWith(
      detailList: updatedDetails,
      stocks: updatedStocks,
      dicMtlQty: updatedDicMtlQty,
      dicSeq: updatedDicSeq,
      dicInvMtlQty: updatedDicInv,
      collectionList: updatedCollectionList,
      placeholder: '请扫描库位',
      scanStep: InboundScanStep.site,
      currentBarcode: null,
      currentItem: null,
      currentTab: 1,
      collectQty: quantity,
      repQty: targetDetail.repertoryQty,
      status: CollectionStatus.success('采集成功'),
      focus: true,
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
      emit(
        state.copyWith(
          status: CollectionStatus.error('请先采集数据后再提交'),
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final upShelvesInfos = state.stocks.map((stock) {
        return {
          'taskNo': _task.inTaskNo,
          'matCode': stock.materialCode,
          'batchNo': stock.batchNo ?? '',
          'sn': stock.serialNo ?? '',
          'taskQty': stock.taskQty,
          'collectQty': stock.collectQty,
          'storeRoomNo': stock.storeRoom ?? '',
          'storeSiteNo': stock.storeSite ?? '',
          'taskid': stock.inTaskId,
          'inTaskItemid': stock.inTaskItemId,
          'data1': stock.productionDate,
          'data2': stock.expireDays,
        };
      }).toList();

      final itemListInfos = state.dicMtlQty.entries.map((entry) {
        final values = entry.value;
        final double planQty = values.isNotEmpty && values[0] is num
            ? (values[0] as num).toDouble()
            : 0;
        final double collectedQty = values.length > 1 && values[1] is num
            ? (values[1] as num).toDouble()
            : 0;
        final String materialCode = values.length > 2
            ? values[2]?.toString() ?? ''
            : '';
        return {
          'mtlQty': [planQty, collectedQty],
          'inTaskItemid': entry.key,
          'mtlCode': materialCode,
        };
      }).toList();

      final filter = state.dicSeq.values.join(',');

      await _service.commitUpShelves(
        request: GoodsUpCommitRequest(
          upShelvesInfos: upShelvesInfos,
          itemListInfos: itemListInfos,
          filter: filter,
        ),
      );

      await _clearCache();
      final freshItems = await _service.getInboundCollectItems(
        query: _buildQuery(),
      );

      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          detailList: freshItems.map(_cloneDetail).toList(),
          collectionList: state.storeSite.isEmpty
              ? const []
              : freshItems
                  .where((item) =>
                      (item.storeSiteNo ?? '').trim() == state.storeSite.trim())
                  .map(_cloneDetail)
                  .toList(),
          stocks: const [],
          dicMtlQty: const {},
          dicSeq: const {},
          dicInvMtlQty: const {},
          currentBarcode: null,
          currentItem: null,
          scanStep: InboundScanStep.site,
          placeholder: '请扫描库位',
          currentTab: 0,
          checkedIds: const [],
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

    await _removeStocks(toDelete, emit,
        successMessage: '已删除 ${toDelete.length} 条采集记录');
  }

  Future<void> _onUpdateFromResult(
    UpdateInboundFromResultEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (event.deletedStocks.isEmpty) {
      return;
    }
    await _removeStocks(event.deletedStocks, emit,
        successMessage: '采集记录已更新');
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
          final newCollected =
              (detail.collectedQty - stock.collectQty).clamp(0, detail.planQty);
          final updatedDetail = _cloneDetail(detail);
          updatedDetail.collectedQty = newCollected;
          updatedDetails[i] = updatedDetail;
        }
      }

      final key = stock.inTaskItemId;
      final existing = updatedDicMtlQty[key];
      if (existing != null) {
        final plan = existing.isNotEmpty && existing[0] is num
            ? (existing[0] as num).toDouble()
            : 0;
        final collected = existing.length > 1 && existing[1] is num
            ? (existing[1] as num).toDouble() - stock.collectQty
            : 0;
        updatedDicMtlQty[key] = [
          plan,
          collected < 0 ? 0 : collected,
          existing.length > 2 ? existing[2] : stock.materialCode,
        ];
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
            .where((detail) =>
                (detail.storeSiteNo ?? '').trim() == state.storeSite.trim())
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

  String _buildInventoryKey(
    String site,
    String materialCode,
    String? batchNo,
  ) {
    return '${site.trim()}|$materialCode|${batchNo ?? ''}';
  }

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
    );
  }
}
