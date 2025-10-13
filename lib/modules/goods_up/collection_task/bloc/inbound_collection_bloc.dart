import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_event.dart';
import 'package:wms_app/modules/goods_up/collection_task/bloc/inbound_collection_state.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_models.dart';
import 'package:wms_app/modules/goods_up/collection_task/models/inbound_collection_request.dart';
import 'package:wms_app/modules/goods_up/services/goods_up_task_service.dart';
import 'package:wms_app/modules/goods_up/task_list/models/goods_up_task.dart';
import 'package:wms_app/utils/error_handler.dart';

class InboundCollectionBloc
    extends Bloc<InboundCollectionEvent, InboundCollectionState> {
  InboundCollectionBloc({required GoodsUpTaskService service})
      : _service = service,
        super(const InboundCollectionState()) {
    on<InitializeInboundCollectionEvent>(_onInitialize);
    on<PerformInboundScanEvent>(_onPerformScan);
    on<ChangeInboundTabEvent>(_onChangeTab);
    on<CommitInboundCollectionEvent>(_onCommit);
    on<ResetInboundStatusEvent>(_onResetStatus);
    on<SetInboundFocusEvent>(_onSetFocus);
    on<DeleteInboundStocksEvent>(_onDeleteStocks);
    on<UpdateInboundResultEvent>(_onUpdateFromResult);
    on<UpdateInboundProductionDateEvent>(_onUpdateProductionDate);
    on<UpdateInboundExpireDaysEvent>(_onUpdateExpireDays);
  }

  final GoodsUpTaskService _service;
  final Uuid _uuid = const Uuid();
  Box? _cacheBox;
  GoodsUpTask? _task;

  Future<void> _onInitialize(
    InitializeInboundCollectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    _task = event.task;
    emit(
      state.copyWith(
        status: CollectionStatus.loading(),
        task: event.task,
        userId: event.userId,
        storeRoom: event.task.storeRoomNo ?? '',
        placeholder: '请扫描库位',
        scanStep: InboundScanStep.site,
        storeSite: '',
      ),
    );

    try {
      await _openCacheBox();
      await _clearCacheIfNeeded();
      await _loadTaskItems(event, emit);
      await _restoreCache(emit);
      emit(state.copyWith(status: CollectionStatus.success()));
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  Future<void> _openCacheBox() async {
    if (_task == null) return;
    final boxName = 'inbound_collection_cache_${_task!.inTaskId}';
    _cacheBox ??= await Hive.openBox(boxName);
  }

  Future<void> _clearCacheIfNeeded() async {
    if (_cacheBox == null) return;
    await _cacheBox!.put('updateFlag', '0');
    await _cacheBox!.put('detailList', const []);
    await _cacheBox!.put('stocks', const []);
    await _cacheBox!.put('dicSeq', <String, String>{});
    await _cacheBox!.put('dicMtlQty', <String, Map<String, dynamic>>{});
    await _cacheBox!.put('dicInvMtlQty', <String, double>{});
  }

  Future<void> _loadTaskItems(
    InitializeInboundCollectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final task = event.task;
    final query = GoodsUpCollectTaskItemQuery(
      inTaskNo: task.inTaskNo,
      inTaskId: task.inTaskId,
      storeRoomNo: task.storeRoomNo ?? '',
      forceSite: '',
      forceBatch: '',
      taskComment: task.taskComment ?? '',
      taskFinishFlag: '0',
      roomTag: '0',
      workStation: task.workStation,
      sortType: '',
      sortColumn: '',
      searchKey: '',
      userId: event.userId.toString(),
    );

    final items = await _service.getInboundCollectItems(query: query);
    final qtyMap = <String, InboundCollectionQty>{};
    for (final item in items) {
      final key = item.inTaskItemId.toString();
      qtyMap[key] = InboundCollectionQty(
        originalQty: item.collectedQty,
        currentQty: 0,
        materialCode: item.materialCode ?? '',
      );
    }

    final proType = items
        .map((item) => (item.proType ?? '').trim())
        .firstWhere((value) => value.isNotEmpty, orElse: () => '');
    final requireBatchValidation =
        ['10', '12', '15', '16', '17', '18'].contains(proType);
    final requireSupplierValidation = ['9', '10'].contains(proType);

    emit(
      state.copyWith(
        detailList: items,
        dicMtlQty: qtyMap,
        requireBatchValidation: requireBatchValidation,
        requireSupplierValidation: requireSupplierValidation,
      ),
    );
  }

  Future<void> _restoreCache(Emitter<InboundCollectionState> emit) async {
    if (_cacheBox == null) return;
    final updateFlag = _cacheBox!.get('updateFlag', defaultValue: '0');
    if (updateFlag != '1') {
      return;
    }

    final cachedDetail = _cacheBox!.get('detailList', defaultValue: const []);
    final cachedStocks = _cacheBox!.get('stocks', defaultValue: const []);
    final cachedDicSeq = Map<String, String>.from(
      _cacheBox!.get('dicSeq', defaultValue: <String, String>{}),
    );
    final rawDicMtlQty = Map<String, dynamic>.from(
      _cacheBox!.get('dicMtlQty', defaultValue: <String, dynamic>{}),
    );
    final cachedDicMtlQty = rawDicMtlQty.map(
      (key, value) => MapEntry(
        key,
        InboundCollectionQty.fromJson(
          Map<String, dynamic>.from(value as Map),
        ),
      ),
    );
    final cachedDicInvMtlQty = Map<String, double>.from(
      _cacheBox!.get('dicInvMtlQty', defaultValue: <String, double>{}),
    );

    final detailList = (cachedDetail as List)
        .map(
          (e) => InboundCollectTaskItem.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
    final stocks = (cachedStocks as List)
        .map(
          (e) => InboundCollectionStock.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();

    emit(
      state.copyWith(
        detailList: detailList.isEmpty ? state.detailList : detailList,
        stocks: stocks,
        dicSeq: cachedDicSeq,
        dicMtlQty: cachedDicMtlQty.isEmpty ? state.dicMtlQty : cachedDicMtlQty,
        dicInvMtlQty: cachedDicInvMtlQty,
      ),
    );
  }

  Future<void> _onPerformScan(
    PerformInboundScanEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final barcode = event.barcode.trim();
    if (barcode.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('采集内容为空,请重新采集')));
      return;
    }

    try {
      switch (state.scanStep) {
        case InboundScanStep.site:
          await _handleSite(barcode, emit);
          break;
        case InboundScanStep.material:
          await _handleMaterial(barcode, emit);
          break;
        case InboundScanStep.quantity:
          await _handleQuantity(barcode, emit);
          break;
        case InboundScanStep.dangerousSupplement:
          await _handleDangerousSupplement(barcode, emit);
          break;
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(error)),
          focus: true,
        ),
      );
    }
  }

  Future<void> _handleSite(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    final site = _extractSiteCode(barcode);
    final room = state.storeRoom;

    final siteList = await _service.getStoreSiteByRoom(
      storeRoomNo: room,
      storeSiteNo: site,
    );
    if (siteList.isEmpty) {
      throw Exception('库房【$room】下无库位号【$site】');
    }

    final first = siteList.first;
    final frozenFlag = first['isfrozen']?.toString();
    if (frozenFlag != null && frozenFlag != '0') {
      throw Exception('库位【$site】被锁定或者冻结');
    }

    final collection = state.detailList
        .where((item) => (item.storeSiteNo ?? '').trim() == site)
        .toList();

    emit(
      state.copyWith(
        status: CollectionStatus.success(),
        storeSite: site,
        scanStep: InboundScanStep.material,
        placeholder: '请扫描二维码',
        collectionList: collection,
        focus: true,
        requireDangerousSupplement: false,
        currentBarcode: null,
        repQty: 0,
        collectQty: 0,
        expectedSubInventory: null,
      ),
    );
  }

  Future<void> _handleMaterial(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (state.storeSite.trim().isEmpty) {
      throw Exception('请先扫描库位');
    }

    final content = await _service.getInboundBarcodeInfo(barcode);
    if (content.isEmpty) {
      throw Exception('物料条码识别出现问题');
    }

    final materialCode = content.materialKey;
    final matched = state.detailList
        .where((item) => (item.materialCode ?? '').trim() == materialCode)
        .toList();
    if (matched.isEmpty) {
      throw Exception('任务明细中物料【$materialCode】不存在');
    }

    final expectedSubInventory = matched
        .map((item) => (item.subInventoryCode ?? '').trim())
        .firstWhere((value) => value.isNotEmpty, orElse: () => '');

    final inventory = await _queryInventoryInfo(
      storeSite: state.storeSite,
      materialCode: materialCode,
    );

    _validateInventory(
      inventory,
      expectedSubInventory: expectedSubInventory,
    );

    final requireSupplement = _needsDangerousSupplement(content);
    final requiresQuantityInput = _requiresQuantityInput(content);
    final autoQty = _determineAutoQuantity(content);

    emit(
      state.copyWith(
        status: CollectionStatus.success(),
        currentBarcode: content,
        scanStep: requireSupplement
            ? InboundScanStep.dangerousSupplement
            : InboundScanStep.quantity,
        placeholder: requireSupplement
            ? '请扫描供应商二维码，采集生产日期、有效期'
            : (requiresQuantityInput ? '请输入数量' : '请输入数量'),
        collectQty:
            requireSupplement || requiresQuantityInput ? 0 : autoQty,
        requireDangerousSupplement: requireSupplement,
        repQty: inventory.sumQty,
        focus: !requireSupplement && requiresQuantityInput,
        expectedSubInventory:
            expectedSubInventory.isEmpty ? null : expectedSubInventory,
      ),
    );

    if (!requireSupplement && !requiresQuantityInput) {
      await _applyQuantity(autoQty, emit);
    }
  }

  Future<void> _handleDangerousSupplement(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    final supplement = await _service.getInboundBarcodeInfo(barcode);
    if (supplement.isEmpty) {
      throw Exception('供应商二维码识别失败');
    }

    final current = state.currentBarcode;
    if (current == null || current.materialKey != supplement.materialKey) {
      throw Exception('供应商二维码与物料不匹配');
    }

    final merged = current.copyWith(
      productionDate: supplement.productionDate ?? current.productionDate,
      expireDays: supplement.expireDays ?? current.expireDays,
      quantity: current.quantity ?? supplement.quantity,
    );

    final requireSupplement = _needsDangerousSupplement(merged);
    final requiresQuantityInput = _requiresQuantityInput(merged);
    final autoQty = _determineAutoQuantity(merged);

    emit(
      state.copyWith(
        status: CollectionStatus.success(),
        currentBarcode: merged,
        scanStep: requireSupplement
            ? InboundScanStep.dangerousSupplement
            : InboundScanStep.quantity,
        placeholder: requireSupplement
            ? '请扫描供应商二维码，采集生产日期、有效期'
            : '请输入数量',
        requireDangerousSupplement: requireSupplement,
        focus: !requireSupplement && requiresQuantityInput,
        collectQty:
            requireSupplement || requiresQuantityInput ? state.collectQty : autoQty,
      ),
    );

    if (!requireSupplement && !requiresQuantityInput) {
      await _applyQuantity(autoQty, emit);
    }
  }

  bool _needsDangerousSupplement(InboundBarcodeContent content) {
    if ((content.dgFlag ?? '').toUpperCase() != 'Y') {
      return false;
    }
    final productionDate = content.productionDate?.trim() ?? '';
    final expireDays = content.expireDays ?? 0;
    return productionDate.isEmpty || expireDays <= 0;
  }

  Future<void> _onUpdateProductionDate(
    UpdateInboundProductionDateEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final barcode = state.currentBarcode;
    if (barcode == null) {
      return;
    }

    final trimmed = event.productionDate.trim();
    final updated = barcode.copyWith(
      productionDate: trimmed.isEmpty ? null : trimmed,
      resetProductionDate: trimmed.isEmpty,
    );
    final requireSupplement = _needsDangerousSupplement(updated);
    final requiresQuantityInput = _requiresQuantityInput(updated);
    final autoQty = _determineAutoQuantity(updated);
    final wasDangerousStep = state.scanStep == InboundScanStep.dangerousSupplement;

    emit(
      state.copyWith(
        currentBarcode: updated,
        requireDangerousSupplement: requireSupplement,
        scanStep: requireSupplement
            ? InboundScanStep.dangerousSupplement
            : InboundScanStep.quantity,
        placeholder: requireSupplement
            ? '请扫描供应商二维码，采集生产日期、有效期'
            : '请输入数量',
        focus: !requireSupplement && requiresQuantityInput,
        collectQty:
            requireSupplement || requiresQuantityInput ? state.collectQty : autoQty,
      ),
    );

    if (wasDangerousStep && !requireSupplement && !requiresQuantityInput) {
      await _applyQuantity(autoQty, emit);
    }
  }

  Future<void> _onUpdateExpireDays(
    UpdateInboundExpireDaysEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    final barcode = state.currentBarcode;
    if (barcode == null) {
      return;
    }

    final trimmed = event.expireDays.trim();
    final parsed = trimmed.isEmpty ? null : int.tryParse(trimmed);
    final updated = barcode.copyWith(
      expireDays: parsed ?? 0,
      resetExpireDays: trimmed.isEmpty,
    );
    final requireSupplement = _needsDangerousSupplement(updated);
    final requiresQuantityInput = _requiresQuantityInput(updated);
    final autoQty = _determineAutoQuantity(updated);
    final wasDangerousStep = state.scanStep == InboundScanStep.dangerousSupplement;

    emit(
      state.copyWith(
        currentBarcode: updated,
        requireDangerousSupplement: requireSupplement,
        scanStep: requireSupplement
            ? InboundScanStep.dangerousSupplement
            : InboundScanStep.quantity,
        placeholder: requireSupplement
            ? '请扫描供应商二维码，采集生产日期、有效期'
            : '请输入数量',
        focus: !requireSupplement && requiresQuantityInput,
        collectQty:
            requireSupplement || requiresQuantityInput ? state.collectQty : autoQty,
      ),
    );

    if (wasDangerousStep && !requireSupplement && !requiresQuantityInput) {
      await _applyQuantity(autoQty, emit);
    }
  }

  Future<void> _handleQuantity(
    String barcode,
    Emitter<InboundCollectionState> emit,
  ) async {
    final qty = double.tryParse(barcode);
    if (qty == null || qty <= 0) {
      throw Exception('采集数量必须大于0');
    }

    await _applyQuantity(qty, emit);
  }

  Future<void> _applyQuantity(
    double qty,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (qty <= 0) {
      throw Exception('采集数量必须大于0');
    }

    final barcodeContent = state.currentBarcode;
    if (barcodeContent == null || barcodeContent.isEmpty) {
      throw Exception('请先扫描物料二维码');
    }
    if (state.storeSite.trim().isEmpty) {
      throw Exception('请先扫描库位');
    }

    final materialCode = barcodeContent.materialKey;
    final batchNo = (barcodeContent.batchNo ?? '').trim();
    final serial = (barcodeContent.serialNumber ?? '').trim();
    final seqCtrl = (barcodeContent.seqCtrl ?? '').trim();
    final requireBatchValidation = state.requireBatchValidation;

    final matchedItems = state.detailList.where((item) {
      if ((item.materialCode ?? '').trim() != materialCode) {
        return false;
      }
      if (seqCtrl == '0') {
        final itemSn = (item.serialNumber ?? '').trim();
        return itemSn.isEmpty || itemSn == serial;
      }
      if (seqCtrl == '1' || seqCtrl == '2') {
        if (!requireBatchValidation) {
          return true;
        }
        final itemBatch = (item.batchNo ?? '').trim();
        if (itemBatch.isEmpty) {
          return true;
        }
        return itemBatch == batchNo;
      }
      return true;
    }).toList();

    if (matchedItems.isEmpty) {
      throw Exception('采集物料批号序列号信息匹配任务明细失败');
    }

    double totalPlan = 0;
    double totalCollected = 0;
    for (final item in matchedItems) {
      totalPlan += item.planQty;
      totalCollected += item.collectedQty;
    }

    if (totalCollected + qty > totalPlan) {
      final remainQty = (totalPlan - totalCollected).toStringAsFixed(2);
      throw Exception('本次采集数量【$qty】大于剩余可采集数量【$remainQty】');
    }

    final updatedItems = List<InboundCollectTaskItem>.from(state.detailList);
    final dicMtlQty = Map<String, InboundCollectionQty>.from(state.dicMtlQty);
    final stocks = List<InboundCollectionStock>.from(state.stocks);
    final dicSeq = Map<String, String>.from(state.dicSeq);

    double remain = qty;
    var serialKeyRecorded = false;
    for (var i = 0; i < updatedItems.length && remain > 0; i++) {
      final item = updatedItems[i];
      if ((item.materialCode ?? '').trim() != materialCode) {
        continue;
      }
      if (seqCtrl == '0') {
        final itemSn = (item.serialNumber ?? '').trim();
        if (itemSn.isNotEmpty && itemSn != serial) {
          continue;
        }
        if (serial.isNotEmpty && !serialKeyRecorded) {
          final key = '$materialCode@$serial';
          if (dicSeq.containsKey(key)) {
            throw Exception('物料$materialCode 序列号【$serial】不允许重复采集，请确认');
          }
          dicSeq[key] = key;
          serialKeyRecorded = true;
        }
      }
      if ((seqCtrl == '1' || seqCtrl == '2') && requireBatchValidation) {
        final itemBatch = (item.batchNo ?? '').trim();
        if (itemBatch.isNotEmpty && batchNo.isNotEmpty && itemBatch != batchNo) {
          continue;
        }
      }

      final available = item.planQty - item.collectedQty;
      if (available <= 0) {
        continue;
      }

      final take = remain <= available ? remain : available;
      remain -= take;

      updatedItems[i] = item.copyWith(collectedQty: item.collectedQty + take);

      final key = item.inTaskItemId.toString();
      final currentEntry = dicMtlQty[key] ??
          InboundCollectionQty(
            originalQty: item.collectedQty,
            currentQty: 0,
            materialCode: item.materialCode ?? '',
          );
      dicMtlQty[key] = currentEntry.copyWith(
        currentQty: currentEntry.currentQty + take,
        materialCode: currentEntry.materialCode.isNotEmpty
            ? currentEntry.materialCode
            : (item.materialCode ?? ''),
      );

      final stock = InboundCollectionStock(
        stockId: _uuid.v4(),
        materialCode: materialCode,
        batchNo: batchNo,
        serialNumber: serial,
        planQty: item.planQty,
        collectQty: take,
        inTaskItemId: item.inTaskItemId.toString(),
        taskId: item.inTaskId.toString(),
        storeRoom: state.storeRoom,
        storeSite: state.storeSite,
        productionDate: (barcodeContent.productionDate ?? '').trim().isEmpty
            ? null
            : barcodeContent.productionDate,
        expireDays: barcodeContent.expireDays != null &&
                barcodeContent.expireDays! > 0
            ? barcodeContent.expireDays
            : null,
        taskNo: _task?.inTaskNo,
      );
      stocks.add(stock);
    }

    if (remain > 0) {
      throw Exception('采集物料批号序列号信息匹配任务明细失败');
    }

    final collectionList = updatedItems
        .where((item) => (item.storeSiteNo ?? '').trim() == state.storeSite)
        .toList();

    await _localSave(
      detailList: updatedItems,
      stocks: stocks,
      dicSeq: dicSeq,
      dicMtlQty: dicMtlQty,
      dicInvMtlQty: state.dicInvMtlQty,
    );

    emit(
      state.copyWith(
        detailList: updatedItems,
        stocks: stocks,
        dicSeq: dicSeq,
        dicMtlQty: dicMtlQty,
        collectionList: collectionList,
        status: CollectionStatus.success('采集成功'),
        scanStep: InboundScanStep.site,
        placeholder: '请扫描库位',
        currentTab: stocks.isEmpty ? 0 : 1,
        focus: true,
        requireDangerousSupplement: false,
        currentBarcode: null,
        collectQty: qty,
      ),
    );
  }

  bool _requiresQuantityInput(InboundBarcodeContent content) {
    final hasSerial = (content.serialNumber ?? '').trim().isNotEmpty;
    final qty = content.quantity ?? 0;
    return !hasSerial && qty <= 0;
  }

  double _determineAutoQuantity(InboundBarcodeContent content) {
    final qty = content.quantity ?? 0;
    if (qty > 0) {
      return qty;
    }
    final hasSerial = (content.serialNumber ?? '').trim().isNotEmpty;
    if (hasSerial) {
      return 1;
    }
    return qty;
  }


  String _extractSiteCode(String barcode) {
    final trimmed = barcode.trim();
    if (trimmed.isEmpty) {
      throw Exception('库位信息不能为空');
    }

    final regex = RegExp(r'\$KW\$(.+)');
    final match = regex.firstMatch(trimmed);
    if (match != null) {
      final site = match.group(1)!.trim();
      if (site.isEmpty) {
        throw Exception('库位信息不能为空');
      }
      return site;
    }

    final parts = trimmed.split('\$');
    if (parts.length >= 3) {
      final site = parts[2].trim();
      if (site.isEmpty) {
        throw Exception('库位信息不能为空');
      }
      return site;
    }

    return trimmed;
  }

  void _validateInventory(
    _InventoryInfo info, {
    String? expectedSubInventory,
  }) {
    final expected = (expectedSubInventory ?? '').trim();
    if (expected.isEmpty) {
      return;
    }
    if (_shouldSkipSubInventoryCheck()) {
      return;
    }
    final actual = (info.erpStoreroom ?? '').trim();
    if (actual.isEmpty) {
      return;
    }
    if (actual.toUpperCase() != expected.toUpperCase()) {
      throw Exception('此物料在当前货位存在其他物权属性的库存，请选择其他上架库位');
    }
  }

  bool _shouldSkipSubInventoryCheck() {
    if (!state.requireSupplierValidation) {
      return false;
    }
    return state.storeRoom.trim().toUpperCase() == 'XN-BL';
  }

  Future<_InventoryInfo> _queryInventoryInfo({
    required String storeSite,
    required String materialCode,
  }) async {
    if (storeSite.isEmpty || materialCode.isEmpty) {
      return const _InventoryInfo(sumQty: 0);
    }
    final rows = await _service.getMtlRepertoryByStoreSite(
      storeSite: storeSite,
      materialCode: materialCode,
    );
    if (rows.isEmpty) {
      return const _InventoryInfo(sumQty: 0);
    }

    double sum = 0;
    String? erpStoreroom;
    String? owner;
    for (var index = 0; index < rows.length; index++) {
      final row = rows[index];
      final qty = row['repqty'];
      if (qty is num) {
        sum += qty.toDouble();
      } else if (qty is String) {
        sum += double.tryParse(qty) ?? 0;
      }
      if (index == 0) {
        erpStoreroom = row['erpStoreroom']?.toString();
        owner = row['parno']?.toString();
      }
    }

    return _InventoryInfo(
      sumQty: sum,
      erpStoreroom: erpStoreroom,
      owner: owner,
    );
  }

  Future<void> _localSave({
    required List<InboundCollectTaskItem> detailList,
    required List<InboundCollectionStock> stocks,
    required Map<String, String> dicSeq,
    required Map<String, InboundCollectionQty> dicMtlQty,
    required Map<String, double> dicInvMtlQty,
  }) async {
    if (_cacheBox == null) return;

    await _cacheBox!.put('updateFlag', '1');
    await _cacheBox!.put(
      'detailList',
      detailList.map((e) => e.toJson()).toList(),
    );
    await _cacheBox!.put(
      'stocks',
      stocks.map((e) => e.toJson()).toList(),
    );
    await _cacheBox!.put('dicSeq', dicSeq);
    await _cacheBox!.put(
      'dicMtlQty',
      dicMtlQty.map((key, value) => MapEntry(key, value.toJson())),
    );
    await _cacheBox!.put('dicInvMtlQty', dicInvMtlQty);
  }

  Future<void> _onChangeTab(
    ChangeInboundTabEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    emit(state.copyWith(currentTab: event.index));
  }

  Future<void> _onCommit(
    CommitInboundCollectionEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (state.stocks.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('本次无采集明细，请确认！')));
      return;
    }

    emit(state.copyWith(status: CollectionStatus.loading()));

    try {
      final upInfos = state.stocks.map((stock) {
        return {
          'taskNo': stock.taskNo,
          'matCode': stock.materialCode,
          'batchNo': stock.batchNo,
          'sn': stock.serialNumber,
          'taskQty': stock.planQty,
          'collectQty': stock.collectQty,
          'storeRoomNo': stock.storeRoom,
          'storeSiteNo': stock.storeSite,
          'taskid': stock.taskId,
          'inTaskItemid': stock.inTaskItemId,
          'data1': stock.productionDate,
          'data2': stock.expireDays,
        };
      }).toList();

      final itemInfos = state.dicMtlQty.entries.map((entry) {
        final value = entry.value;
        return {
          'mtlQty': [value.originalQty, value.currentQty],
          'inTaskItemid': entry.key,
          'mtlCode': value.materialCode,
        };
      }).toList();

      final filter = state.dicSeq.values.map((e) => '\\"$e\\"').join(',');

      final response = await _service.commitUpShelves(
        upShelvesInfos: upInfos,
        itemListInfos: itemInfos,
        filter: filter,
      );

      final code = response['code'] as int? ?? 200;
      if (code != 200) {
        throw Exception(response['msg']?.toString() ?? '提交失败');
      }

      await _clearCacheIfNeeded();
      emit(
        state.copyWith(
          status: CollectionStatus.success('提交成功'),
          stocks: const [],
          dicSeq: const {},
          dicMtlQty: const {},
          collectionList: const [],
          currentTab: 0,
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
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  void _onSetFocus(
    SetInboundFocusEvent event,
    Emitter<InboundCollectionState> emit,
  ) {
    emit(state.copyWith(focus: event.focus));
  }

  Future<void> _onDeleteStocks(
    DeleteInboundStocksEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (event.stockIds.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请至少选择一条记录')));
      return;
    }

    final targets = state.stocks
        .where((stock) => event.stockIds.contains(stock.stockId))
        .toList();
    if (targets.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('未找到可删除的采集记录')));
      return;
    }

    await _applyStockDeletion(targets, emit, message: '删除成功');
  }

  Future<void> _onUpdateFromResult(
    UpdateInboundResultEvent event,
    Emitter<InboundCollectionState> emit,
  ) async {
    if (event.deletedStocks.isEmpty) {
      return;
    }

    await _applyStockDeletion(event.deletedStocks, emit);
  }

  Future<void> _applyStockDeletion(
    List<InboundCollectionStock> targets,
    Emitter<InboundCollectionState> emit, {
    String? message,
  }) async {
    if (targets.isEmpty) {
      return;
    }

    final updatedStocks = List<InboundCollectionStock>.from(state.stocks);
    final updatedDetail = List<InboundCollectTaskItem>.from(state.detailList);
    final dicSeq = Map<String, String>.from(state.dicSeq);
    final dicMtlQty = Map<String, InboundCollectionQty>.from(state.dicMtlQty);

    for (final stock in targets) {
      final idx = updatedStocks.indexWhere((s) => s.stockId == stock.stockId);
      if (idx < 0) {
        continue;
      }

      final removed = updatedStocks.removeAt(idx);

      final detailIdx = updatedDetail.indexWhere(
        (item) => item.inTaskItemId.toString() == removed.inTaskItemId,
      );
      if (detailIdx >= 0) {
        final detail = updatedDetail[detailIdx];
        final newCollected = detail.collectedQty - removed.collectQty;
        updatedDetail[detailIdx] = detail.copyWith(
          collectedQty: newCollected < 0 ? 0 : newCollected,
        );
      }

      final serial = (removed.serialNumber ?? '').trim();
      if (serial.isNotEmpty) {
        dicSeq.remove('${removed.materialCode}@$serial');
      }

      final qtyEntry = dicMtlQty[removed.inTaskItemId];
      if (qtyEntry != null) {
        final newCurrent = qtyEntry.currentQty - removed.collectQty;
        dicMtlQty[removed.inTaskItemId] = qtyEntry.copyWith(
          currentQty: newCurrent < 0 ? 0 : newCurrent,
        );
      }
    }

    final collectionList = updatedDetail
        .where((item) => (item.storeSiteNo ?? '').trim() == state.storeSite)
        .toList();

    await _localSave(
      detailList: updatedDetail,
      stocks: updatedStocks,
      dicSeq: dicSeq,
      dicMtlQty: dicMtlQty,
      dicInvMtlQty: state.dicInvMtlQty,
    );

    emit(
      state.copyWith(
        stocks: updatedStocks,
        detailList: updatedDetail,
        dicSeq: dicSeq,
        dicMtlQty: dicMtlQty,
        collectionList: collectionList,
        status: message == null
            ? CollectionStatus.success()
            : CollectionStatus.success(message),
        currentTab: updatedStocks.isEmpty ? 0 : state.currentTab,
      ),
    );
  }
}


class _InventoryInfo {
  const _InventoryInfo({
    required this.sumQty,
    this.erpStoreroom,
    this.owner,
  });

  final double sumQty;
  final String? erpStoreroom;
  final String? owner;
}
