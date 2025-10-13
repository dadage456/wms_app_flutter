import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/models/page_status.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_event.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/utils/custom_extension.dart';
import 'package:wms_app/utils/error_handler.dart';

/// Base bloc that encapsulates the common collection workflow shared by
/// outbound and inbound modules.
abstract class BaseCollectionBloc<TTask>
    extends Bloc<CollectionEvent, CollectionState> {
  BaseCollectionBloc() : super(CollectionState()) {
    on<PerformBarcodeEvent>(_onPerformBarcode);
    on<ChangeTabEvent>(_onChangeTab);
    on<ChangedSelectionEvent>(_onChangedSelection);
    on<DeleteCollectedStocksEvent>(_onDeleteCollectedStocks);
    on<UpdateFromResultEvent>(_onUpdateFromResult);
    on<ResetStatusEvent>(_onResetStatus);
    on<SetFocusEvent>(_onSetFocus);
  }

  late Box _cacheBox;
  late int userId;
  late String taskId;
  late String taskNo;
  late String storeRoomNo;

  String siteFlag = 'Y';
  String batchFlag = 'Y';

  /// Hook for subclasses to set the task context.
  @protected
  void configureTask({
    required int userId,
    required String taskId,
    required String taskNo,
    required String storeRoomNo,
  }) {
    this.userId = userId;
    this.taskId = taskId;
    this.taskNo = taskNo;
    this.storeRoomNo = storeRoomNo;
    siteFlag = 'Y';
    batchFlag = 'Y';
  }

  /// Opens hive cache according to the provided key.
  @protected
  Future<void> openCache(String cacheKey) async {
    _cacheBox = await Hive.openBox(cacheKey);
  }

  /// Clears cached collection data.
  @protected
  Future<void> clearCache() async {
    await _cacheBox.put('stocks', <Map>[]);
    await _cacheBox.put('updateFlag', '0');
    await _cacheBox.put('detailList', <Map>[]);
    await _cacheBox.put('dicMtlQty', <String, List<double>>{});
    await _cacheBox.put('dicInvMtlQty', <String, double>{});
    await _cacheBox.clear();
  }

  Future<void> restoreFromCache(Emitter<CollectionState> emit) async {
    try {
      final updateFlag = _cacheBox.get('updateFlag', defaultValue: '0');
      if (updateFlag != '1') {
        return;
      }

      final cachedStocks = _cacheBox.get('stocks', defaultValue: <Map>[]);
      final cachedDicSeq = Map<String, String>.from(
        _cacheBox.get('dicSeq', defaultValue: <String, String>{}),
      );
      final cachedDicMtlQty = Map<String, List<double>>.from(
        _cacheBox.get('dicMtlQty', defaultValue: <String, List<double>>{}),
      );
      final cachedDicInvMtlQty = Map<String, double>.from(
        _cacheBox.get('dicInvMtlQty', defaultValue: <String, double>{}),
      );

      final stocks = cachedStocks
          .map<CollectionStock>(
            (item) => CollectionStock.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      emit(
        state.copyWith(
          stocks: stocks,
          dicSeq: cachedDicSeq,
          dicMtlQty: cachedDicMtlQty,
          dicInvMtlQty: cachedDicInvMtlQty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('恢复缓存数据失败：${e.toString()}'),
        ),
      );
    }
  }

  Future<void> _onSetFocus(
    SetFocusEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(focus: event.focus));
  }

  void _onResetStatus(ResetStatusEvent event, Emitter<CollectionState> emit) {
    emit(state.copyWith(status: CollectionStatus.normal()));
  }

  Future<void> _onChangeTab(
    ChangeTabEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(currentTab: event.index));
  }

  Future<void> _onChangedSelection(
    ChangedSelectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    debugPrint('------------- Selected indexes: ${event.ids}');
    emit(state.copyWith(checkedIds: event.ids));
  }

  Future<void> _onPerformBarcode(
    PerformBarcodeEvent event,
    Emitter<CollectionState> emit,
  ) async {
    final barcode = event.barcode;
    if (barcode.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('采集内容为空,请重新采集')));
      return;
    }

    try {
      if (barcode.contains('MC')) {
        await handleQRCode(barcode, emit);
      } else if (barcode.contains('\\$KW\\$')) {
        await handleSite(barcode, emit);
      } else if (_isNumeric(barcode)) {
        await handleQuantity(double.parse(barcode), emit);
      } else {
        emit(state.copyWith(status: CollectionStatus.error('采集内容不合法！')));
        return;
      }

      var placeholder = await getPlaceMessage();
      if (placeholder.isEmpty) {
        await dealQuantity(state.collectQty, state.matControlFlag, emit);
      }

      placeholder = placeholder.isEmpty
          ? (state.storeSite.isEmpty ? '请扫描库位' : '请扫描二维码')
          : placeholder;

      final focus = placeholder == '请输入数量';

      emit(state.copyWith(placeholder: placeholder, focus: focus));
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(ErrorHandler.handleError(e)),
        ),
      );
    }
  }

  Future<void> handleQRCode(
    String barcode,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(status: CollectionStatus.loading()));

    final barcodeContent = await fetchBarcode(barcode);
    final newmarttask = barcodeContent.id_old ?? '';
    final matControl = barcodeContent.seqctrl ?? '';

    String matSendControl = '0';
    final mtlInfo = await fetchMatControl(barcodeContent.matcode!);
    if (mtlInfo.length > 4 && mtlInfo[4].isNotEmpty) {
      matSendControl = mtlInfo[4];
    }

    final erpRoom = await validateMaterialControl(
      barcodeContent,
      newmarttask,
      matControl,
      matSendControl,
    );

    var newstate = state.copyWith(
      currentBarcode: barcodeContent,
      matControlFlag: matControl,
      matSendControl: matSendControl,
      collectQty: matControl == '0' ? 1 : state.collectQty,
      erpRoom: erpRoom ?? '',
      status: CollectionStatus.success(),
    );

    newstate = await checkInventory(
      newstate,
      newstate.collectQty,
      newstate.storeSite,
      emit,
    );
    final collectionList = updateCollectionList(newstate.storeSite);

    final newTab = collectionList.isEmpty ? 0 : 1;

    emit(newstate.copyWith(collectionList: collectionList, currentTab: newTab));
  }

  Future<String?> validateMaterialControl(
    BarcodeContent barcodeContent,
    String newmarttask,
    String matControl,
    String matSendControl,
  ) async {
    String erpRoom = '';
    if (matControl == '0') {
      if ((barcodeContent.sn ?? '').isEmpty) {
        throw Exception('物料【${barcodeContent.matcode!}】序列号不能为空');
      }

      final seqKey = '${barcodeContent.matcode!}@${barcodeContent.sn}';
      if (state.dicSeq.containsKey(seqKey)) {
        throw Exception(
          '物料【${barcodeContent.matcode!}】序列号【${barcodeContent.sn}】不允许重复采集，请确认',
        );
      }
    } else if (matControl == '1' || matControl == '2') {
      String? batchNo = newmarttask == '0'
          ? barcodeContent.sn
          : barcodeContent.batchno;

      if ((matSendControl == '0' && state.roomMatControl == '0') ||
          state.roomMatControl == '1') {
        final erpRoom1 = await checkMaterial(
          barcodeContent.matcode!,
          batchNo!,
          state.storeSite,
        );
        if (erpRoom1.isNotEmpty) {
          erpRoom = erpRoom1;
        }
      }
      final erpRoom2 = await checkMaterialSite(
        barcodeContent.matcode!,
        batchNo!,
        state.storeSite,
      );
      if (erpRoom2.isNotEmpty) {
        erpRoom = erpRoom2;
      }
      return erpRoom;
    } else {
      throw Exception('物料${barcodeContent.matcode!}编码控制维护值维护不合法');
    }
    return null;
  }

  Future<String> checkMaterial(
    String matcode,
    String batchno,
    String storeSite,
  ) async {
    bool batchFound = false;
    String erpRoom = '';

    for (final item in state.detailList) {
      if (item.matcode == matcode &&
          item.storesiteno == storeSite &&
          item.hintbatchno == batchno) {
        erpRoom = item.subinventoryCode ?? '';
        batchFound = true;
        break;
      }
    }

    if (!batchFound) {
      for (final item in state.detailList) {
        if (item.matcode == matcode && item.storesiteno == storeSite) {
          erpRoom = item.subinventoryCode ?? '';
          batchFound = true;
          break;
        }
      }
    }

    if (!batchFound) {
      throw Exception('任务明细中物料【$matcode】不存在');
    }
    return erpRoom;
  }

  Future<String> checkMaterialSite(
    String matcode,
    String batchno,
    String storeSite,
  ) async {
    if (isSnTask) return '';

    bool matFind = false;
    String erpRoom = '';

    for (final item in state.detailList) {
      bool matches = false;

      switch (state.mtlCheckMode) {
        case MtlCheckMode.mtlSiteBatch:
          matches =
              item.matcode == matcode &&
              item.hintbatchno == batchno &&
              item.storesiteno == storeSite;
          break;
        case MtlCheckMode.mtlSite:
          matches = item.matcode == matcode && item.storesiteno == storeSite;
          break;
        case MtlCheckMode.mtlBatch:
          matches = item.matcode == matcode && item.hintbatchno == batchno;
          break;
        case MtlCheckMode.mtl:
          matches = item.matcode == matcode;
          break;
      }

      if (matches) {
        erpRoom = item.subinventoryCode ?? '';
        matFind = true;
        break;
      }
    }

    if (!matFind) {
      if (batchFlag == 'Y') {
        throw Exception('采集物料【$matcode】批次【$batchno】库位【$storeSite】不在任务明细中，请核实');
      } else {
        throw Exception('采集物料【$matcode】库位【$storeSite】不在任务明细中，请核实');
      }
    }

    return erpRoom;
  }

  Future<void> handleSite(
    String barcode,
    Emitter<CollectionState> emit,
  ) async {
    final parts = barcode.split('\\$');
    if (parts.length < 3) {
      throw Exception('库位格式不正确');
    }

    final siteCode = parts[2];

    emit(state.copyWith(status: CollectionStatus.loading()));

    final response = await fetchStoreSite(storeRoomNo, siteCode);
    if (response['code'] != 200) {
      throw Exception(response['msg'] ?? '库位验证失败');
    }

    final siteList = response['data'] as List;
    if (siteList.isEmpty) {
      throw Exception('库房【$storeRoomNo}}】下无库位号【$siteCode】');
    }

    if (siteList[0]['isfrozen'] != '0') {
      throw Exception('库位【$siteCode】被锁定或者冻结');
    }

    if (state.currentBarcode != null && state.currentBarcode!.isNotEmpty) {
      if ((state.matSendControl == '0' && state.roomMatControl == '0') ||
          state.roomMatControl == '1') {
        await checkMaterialSite(
          state.currentBarcode!.matcode ?? '',
          state.currentBarcode!.batchno ?? '',
          siteCode,
        );
      }
    }

    var newstate = state.copyWith(storeSite: siteCode);

    newstate = await checkInventory(
      newstate,
      newstate.collectQty,
      newstate.storeSite,
      emit,
    );

    final collectionList = updateCollectionList(newstate.storeSite);

    final newTab = collectionList.isEmpty ? 0 : 1;

    emit(
      newstate.copyWith(
        collectionList: collectionList,
        currentTab: newTab,
        status: CollectionStatus.success(),
      ),
    );
  }

  Future<void> handleQuantity(
    double quantity,
    Emitter<CollectionState> emit,
  ) async {
    if (isSnTask) {
      throw Exception('已采集序列号无需采集数量，请扫描二维码');
    }

    emit(state.copyWith(collectQty: quantity));
  }

  bool get isSnTask => state.matControlFlag == '0';

  Future<CollectionState> checkInventory(
    CollectionState state,
    double collectQty,
    String storeSite,
    Emitter<CollectionState> emit,
  ) async {
    if (state.currentBarcode?.matcode == null || storeSite.isEmpty) {
      return state;
    }

    final result = await fetchInventory(
      storeSite: storeSite,
      barcode: state.currentBarcode!,
      matControlFlag: state.matControlFlag,
      erpRoom: state.erpRoom,
    );

    final repQty = (result['repQty'] ?? 0).toDouble();
    final erpStoreInv = result['erpStoreInv']?.toString() ?? state.erpStoreInv;

    return state.copyWith(repQty: repQty, erpStoreInv: erpStoreInv);
  }

  Future<String> getPlaceMessage() async {
    if (state.storeSite.isEmpty) {
      return '请扫描库位';
    }
    if (state.currentBarcode?.isEmpty ?? true) {
      return '请扫描二维码';
    }
    if (!isSnTask && state.collectQty == 0) {
      return '请输入数量';
    }
    return '';
  }

  List<OutTaskItem> updateCollectionList(String storeSite) {
    if (storeSite.isEmpty) return [];

    final collectionList = state.detailList
        .where((item) => item.storesiteno == storeSite)
        .toList();

    return collectionList;
  }

  bool _shouldInclude(OutTaskItem item) {
    bool include = true;
    switch (state.mtlCheckMode) {
      case MtlCheckMode.mtlBatch:
        include = item.hintbatchno == state.currentBarcode?.batchno;
        break;
      case MtlCheckMode.mtlSiteBatch:
        include =
            item.hintbatchno == state.currentBarcode?.batchno &&
            item.storesiteno == state.storeSite;
        break;
      case MtlCheckMode.mtlSite:
        include = item.storesiteno == state.storeSite;
        break;
      case MtlCheckMode.mtl:
        include = true;
        break;
    }
    return include;
  }

  Future<void> dealQuantity(
    double count,
    String matFlag,
    Emitter<CollectionState> emit,
  ) async {
    if (matFlag.isEmpty) {
      throw Exception('获取物料编码属性失败');
    }

    final matFlagInt = int.tryParse(matFlag) ?? 0;
    String sn = '';
    if (matFlagInt == 0) {
      sn = state.currentBarcode?.sn ?? '';
    }

    if (count <= 0) {
      throw Exception('采集数量必须大于0');
    }

    final strKey =
        '${state.storeSite}${state.currentBarcode?.matcode!}${matFlagInt == 0 ? state.currentBarcode?.sn : state.currentBarcode?.batchno}';
    final decRepqty = state.dicInvMtlQty[strKey] ?? 0;
    if (state.repQty - decRepqty < count) {
      throw Exception(
        '库位【${state.storeSite}】物料【${state.currentBarcode?.matcode}】的库存【${state.repQty - decRepqty}】小于本次移出库存【$count】，请确认',
      );
    }

    final newDicSeq = Map<String, String>.from(state.dicSeq);

    final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);
    final currentInvQty = newDicInvMtlQty[strKey] ?? 0;
    newDicInvMtlQty[strKey] = currentInvQty + count;

    final updatedDetailList = List<OutTaskItem>.from(state.detailList);
    final dicMtlOperation = <String, List<double>>{};
    final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);

    double totalTaskQty = 0;
    double totalTmpQty = 0;
    double totalInventory = state.repQty;

    final indexes = updatedDetailList
        .asMap()
        .entries
        .where(
          (e) =>
              e.value.matcode == state.currentBarcode?.matcode &&
              _shouldInclude(e.value),
        )
        .map((e) => e.key)
        .toList();

    if (matFlagInt != 0 && indexes.isEmpty) {
      throw Exception('采集物料批号序列号信息匹配任务明细失败');
    }

    for (var index in indexes) {
      final item = updatedDetailList[index];
      totalTaskQty += item.hintqty;
      totalTmpQty += item.collectedqty;
    }

    totalInventory -= totalTmpQty + count;

    if (totalTmpQty + count > totalTaskQty) {
      throw Exception('本次采集数量【$count】大于剩余可采集数量【${totalTaskQty - totalTmpQty}】');
    }

    if (matFlagInt == 0) {
      var idx = indexes
          .where((index) => updatedDetailList[index].sn == sn)
          .firstOrNull;
      if (idx != null) {
        var item = updatedDetailList[idx];
        item = item.copyWith(collectedqty: 1);
        updatedDetailList[idx] = item;

        dicMtlOperation[item.outtaskitemid.toString()] = [1, 1];

        newDicMtlQty[item.outtaskitemid.toString()] = [0, 1];

        newDicSeq['${state.currentBarcode?.matcode}@$sn'] =
            '${state.currentBarcode?.matcode}@$sn';

        await addCollectData(
          state.currentBarcode?.matcode ?? '',
          state.currentBarcode?.batchno ?? '',
          sn,
          count,
          storeRoomNo,
          state.storeSite,
          dicMtlOperation,
          state.erpStoreInv,
          '',
          emit,
        );
      }
    } else {
      double currentCount = count;
      for (var index in indexes) {
        var item = updatedDetailList[index];
        final taskCount = item.hintqty;
        final collectedCount = item.collectedqty;

        item = item.copyWith(repqty: totalInventory);
        updatedDetailList[index] = item;

        if (taskCount == collectedCount || currentCount == 0) continue;

        final tempCount = (taskCount - collectedCount) > currentCount
            ? currentCount
            : (taskCount - collectedCount);

        currentCount -= tempCount;

        item = item.copyWith(collectedqty: collectedCount + tempCount);
        updatedDetailList[index] = item;

        if (!newDicMtlQty.containsKey(item.outtaskitemid.toString())) {
          newDicMtlQty[item.outtaskitemid.toString()] = [collectedCount, 0];
        }

        dicMtlOperation[item.outtaskitemid.toString()] = [taskCount, tempCount];

        final begin = newDicMtlQty[item.outtaskitemid.toString()]![0];
        newDicMtlQty[item.outtaskitemid.toString()] = [
          begin,
          collectedCount + tempCount,
        ];
      }

      await addCollectData(
        state.currentBarcode?.matcode ?? '',
        state.currentBarcode?.batchno ?? '',
        sn,
        count,
        storeRoomNo,
        state.storeSite,
        dicMtlOperation,
        state.erpStoreInv,
        '',
        emit,
      );
    }

    final collectionList = updatedDetailList
        .where((item) => item.storesiteno == state.storeSite)
        .toList();

    emit(
      initializeCollect().copyWith(
        detailList: updatedDetailList,
        collectionList: collectionList,
        dicSeq: newDicSeq,
        dicMtlQty: newDicMtlQty,
        dicInvMtlQty: newDicInvMtlQty,
        status: CollectionStatus.success('采集成功'),
      ),
    );

    await localSave();
  }

  Future<void> addCollectData(
    String matCode,
    String batchNo,
    String sn,
    double collectQty,
    String storeRoom,
    String storeSite,
    Map<String, List<double>> dicMtlOperation,
    String erpRoom,
    String trayNo,
    Emitter<CollectionState> emit,
  ) async {
    final newStocks = List<CollectionStock>.from(state.stocks);

    for (final entry in dicMtlOperation.entries) {
      final stock = mapStock(
        stockId: const Uuid().v4(),
        matCode: matCode,
        batchNo: batchNo,
        sn: sn,
        taskQty: entry.value[0],
        collectQty: entry.value[1],
        outTaskItemId: entry.key,
        taskId: taskId,
        storeRoom: storeRoom,
        storeSite: storeSite,
        erpStore: erpRoom,
        trayNo: trayNo,
      );
      newStocks.add(stock);
    }

    emit(state.copyWith(stocks: newStocks));
  }

  Future<void> localSave() async {
    await _cacheBox.put(
      'detailList',
      state.detailList.map((e) => e.toJson()).toList(),
    );

    await _cacheBox.put('stocks', state.stocks.map((e) => e.toJson()).toList());
    await _cacheBox.put('dicSeq', state.dicSeq);
    await _cacheBox.put('dicMtlQty', state.dicMtlQty);
    await _cacheBox.put('dicInvMtlQty', state.dicInvMtlQty);
    await _cacheBox.put('updateFlag', '1');
  }

  CollectionState initializeCollect() {
    return state.copyWith(
      status: CollectionStatus.normal(),
      collectQty: 0,
      repQty: 0,
      currentBarcode: BarcodeContent.fromJson({}),
      focus: false,
      matControlFlag: '',
      erpRoom: '',
      erpStoreInv: '',
      placeholder: '请扫描库位',
    );
  }

  bool _isNumeric(String str) {
    return RegExp(r'^[0-9]+(\\.[0-9]+)?').hasMatch(str);
  }

  Future<void> _onDeleteCollectedStocks(
    DeleteCollectedStocksEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (event.stockIds.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请至少选择一行记录')));
        return;
      }

      final updatedStocks = List<CollectionStock>.from(state.stocks);
      final updatedDetailList = List<OutTaskItem>.from(state.detailList);
      final newDicSeq = Map<String, String>.from(state.dicSeq);
      final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
      final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);

      for (final stockId in event.stockIds) {
        final idx = updatedStocks.indexWhere((s) => s.stockid == stockId);
        if (idx < 0) continue;

        final s = updatedStocks[idx];

        final dIdx = updatedDetailList.indexWhere(
          (d) => d.outtaskitemid.toString() == s.outtaskitemid,
        );
        if (dIdx >= 0) {
          final d = updatedDetailList[dIdx];
          final newCollected = (d.collectedqty - s.collectQty);
          updatedDetailList[dIdx] = d.copyWith(
            collectedqty: newCollected < 0 ? 0 : newCollected,
          );
        }

        if (s.sn.isNotEmpty) {
          final seqKey = '${s.matcode}@${s.sn}';
          if (newDicSeq.containsKey(seqKey)) {
            newDicSeq.remove(seqKey);
          }
        }

        final mtlKey = s.outtaskitemid;
        if (newDicMtlQty.containsKey(mtlKey)) {
          final ls2 = List<double>.from(newDicMtlQty[mtlKey]!);
          final newSecond = (ls2.length > 1 ? ls2[1] : 0) - s.collectQty;
          if (ls2.length > 1) {
            ls2[1] = newSecond < 0 ? 0 : newSecond;
          } else {
            ls2.add(newSecond < 0 ? 0 : newSecond);
          }
          newDicMtlQty[mtlKey] = ls2;
        }

        String invKey = '';
        if (s.sn.isNotEmpty) {
          invKey = '${s.storeSite}${s.matcode}${s.sn}';
        } else {
          invKey = '${s.storeSite}${s.matcode}${s.batchno}';
        }
        if (newDicInvMtlQty.containsKey(invKey)) {
          final val = (newDicInvMtlQty[invKey] ?? 0) - s.collectQty;
          newDicInvMtlQty[invKey] = val < 0 ? 0 : val;
        }

        updatedStocks.removeAt(idx);
      }
      final updateCollectionList = updatedDetailList
          .where((item) => item.storesiteno == state.storeSite)
          .toList();

      emit(
        state.copyWith(
          stocks: updatedStocks,
          detailList: updatedDetailList,
          collectionList: updateCollectionList,
          dicSeq: newDicSeq,
          dicMtlQty: newDicMtlQty,
          dicInvMtlQty: newDicInvMtlQty,
        ),
      );
      await localSave();
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '删除采集记录失败：${ErrorHandler.handleError(e)}',
          ),
        ),
      );
    }
  }

  Future<void> _onUpdateFromResult(
    UpdateFromResultEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (event.deletedStocks.isEmpty) return;

      final deleted = event.deletedStocks;
      if (deleted.isEmpty) return;

      final updatedStocks = List<CollectionStock>.from(state.stocks);
      final updatedDetailList = List<OutTaskItem>.from(state.detailList);
      final newDicSeq = Map<String, String>.from(state.dicSeq);
      final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
      final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);

      for (final s in deleted) {
        final idx = updatedStocks.indexWhere((x) => x.stockid == s.stockid);
        if (idx < 0) continue;

        final dIdx = updatedDetailList.indexWhere(
          (d) => d.outtaskitemid.toString() == s.outtaskitemid,
        );
        if (dIdx >= 0) {
          final d = updatedDetailList[dIdx];
          final newCollected = d.collectedqty - s.collectQty;
          updatedDetailList[dIdx] = d.copyWith(
            collectedqty: newCollected < 0 ? 0 : newCollected,
          );
        }

        if (s.sn.isNotEmpty) {
          final seqKey = '${s.matcode}@${s.sn}';
          newDicSeq.remove(seqKey);
        }

        final mtlKey = s.outtaskitemid;
        if (newDicMtlQty.containsKey(mtlKey)) {
          final values = List<double>.from(newDicMtlQty[mtlKey]!);
          if (values.length > 1) {
            final newValue = values[1] - s.collectQty;
            values[1] = newValue < 0 ? 0 : newValue;
          }
          newDicMtlQty[mtlKey] = values;
        }

        String invKey = '';
        if (s.sn.isNotEmpty) {
          invKey = '${s.storeSite}${s.matcode}${s.sn}';
        } else {
          invKey = '${s.storeSite}${s.matcode}${s.batchno}';
        }
        if (newDicInvMtlQty.containsKey(invKey)) {
          final value = (newDicInvMtlQty[invKey] ?? 0) - s.collectQty;
          newDicInvMtlQty[invKey] = value < 0 ? 0 : value;
        }

        updatedStocks.removeAt(idx);
      }

      final updateCollectionList = updatedDetailList
          .where((item) => item.storesiteno == state.storeSite)
          .toList();

      emit(
        state.copyWith(
          stocks: updatedStocks,
          detailList: updatedDetailList,
          collectionList: updateCollectionList,
          dicSeq: newDicSeq,
          dicMtlQty: newDicMtlQty,
          dicInvMtlQty: newDicInvMtlQty,
        ),
      );
      await localSave();
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionStatus.error(
            '从结果页更新采集数据失败：${ErrorHandler.handleError(e)}',
          ),
        ),
      );
    }
  }

  /// Fetches barcode content.
  Future<BarcodeContent> fetchBarcode(String code);

  /// Fetches material control information for the given material code.
  Future<List<String>> fetchMatControl(String matCode);

  /// Validates store site and returns response map.
  Future<Map<String, dynamic>> fetchStoreSite(String storeRoomNo, String siteNo);

  /// Fetches inventory information required by [checkInventory].
  Future<Map<String, dynamic>> fetchInventory({
    required String storeSite,
    required BarcodeContent barcode,
    required String matControlFlag,
    required String erpRoom,
  });

  /// Maps collected data to [CollectionStock].
  CollectionStock mapStock({
    required String stockId,
    required String matCode,
    required String batchNo,
    required String sn,
    required double taskQty,
    required double collectQty,
    required String outTaskItemId,
    required String taskId,
    required String storeRoom,
    required String storeSite,
    required String erpStore,
    required String trayNo,
  });
}
