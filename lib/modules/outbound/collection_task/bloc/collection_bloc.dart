import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/utils/error_handler.dart';
import '../models/collection_models.dart';
import '../services/collection_service.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_request.dart';
import 'collection_event.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionService _service;
  late Box _cacheBox;

  late OutboundTask _task;

  String _siteFlag = 'Y';
  String _batchFlag = 'Y';
  late int _userId;

  CollectionBloc(this._service) : super(CollectionState()) {
    on<InitializeTaskEvent>(_onInitializeTask);
    on<PerformBarcodeEvent>(_onPerformBarcode);
    on<ChangeTabEvent>(_onChangeTab);
    on<CommitCollectionEvent>(_onCommitCollection);
    on<ReportShortageEvent>(_onReportShortage);
    on<ClearErrorEvent>(_onClearError);
    on<SetFocusEvent>(_onSetFocus);
    on<ChangedSelectionEvent>(_onChangedSelection);
    on<DeleteCollectedStocksEvent>(_onDeleteCollectedStocks);
    on<UpdateFromResultEvent>(_onUpdateFromResult);
  }

  Future<void> _initHive() async {
    _cacheBox = await Hive.openBox('collection_cache_${_task.outTaskId}');
  }

  Future<void> _onInitializeTask(
    InitializeTaskEvent event,
    Emitter<CollectionState> emit,
  ) async {
    _userId = event.userId;
    _task = event.task;

    _siteFlag = 'Y';
    _batchFlag = 'Y';

    await _initHive();
    _clearCache();
    await loadTaskList(emit);
    await _restoreFromCache(emit);
  }

  Future<void> loadTaskList(Emitter<CollectionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final detailList = await _service.getOutTaskCollitemList(
        CollectionTaskItemQuery(
          outTaskNo: _task.outTaskNo,
          storeRoomNo: _task.storeRoomNo,
          forceSite: '',
          forceBatch: '',
          taskComment: _task.taskComment,
          taskFinishFlag: '0',
          roomTag: '0',
          workStation: _task.workStation,
          finishFlag: '0',
          sortType: '',
          sortColumn: '',
          searchKey: '',
          beatFlag: 'N',
          collecter: _userId,
        ),
      );

      if (detailList.isEmpty) {
        emit(state.copyWith(isLoading: false, error: '当前任务列表没有待处理任务!'));
        return;
      }

      // 获取物料控制信息
      String roomMatControl = '0';
      final controlResponse = await _service.getRoomMatControl(
        _task.outTaskId.toString(),
      );
      final roomMtlInfo = controlResponse.split('!');
      if (roomMtlInfo.length > 4 && roomMtlInfo[4].isNotEmpty) {
        roomMatControl = roomMtlInfo[4];
      }

      // 确定检查模式
      MtlCheckMode mtlCheckMode;
      if (_siteFlag == 'Y' && _batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlSiteBatch;
      } else if (_siteFlag == 'Y' && _batchFlag != 'Y') {
        mtlCheckMode = MtlCheckMode.mtlSite;
      } else if (_siteFlag != 'Y' && _batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlBatch;
      } else {
        mtlCheckMode = MtlCheckMode.mtl;
      }

      emit(
        state.copyWith(
          detailList: detailList,
          isLoading: false,
          roomMatControl: roomMatControl,
          mtlCheckMode: mtlCheckMode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: ErrorHandler.handleError(e)),
      );
    }
  }

  Future<void> _restoreFromCache(Emitter<CollectionState> emit) async {
    try {
      final updateFlag = _cacheBox.get('updateFlag', defaultValue: '0');
      if (updateFlag == '1') {
        // 从缓存恢复数据
        final cachedDetailList = _cacheBox.get(
          'detailList',
          defaultValue: <Map>[],
        );
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

        final detailList = cachedDetailList
            .map<OutTaskItem>(
              (item) => OutTaskItem.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
        final stocks = cachedStocks
            .map<CollectionStock>(
              (item) =>
                  CollectionStock.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();

        emit(
          state.copyWith(
            // detailList: detailList,
            stocks: stocks,
            dicSeq: cachedDicSeq,
            dicMtlQty: cachedDicMtlQty,
            dicInvMtlQty: cachedDicInvMtlQty,
          ),
        );

        // await _cacheBox.put('updateFlag', '0');
      }
    } catch (e) {
      emit(state.copyWith(error: '恢复缓存数据失败：${e.toString()}'));
    }
  }

  List<OutTaskItem> updateCollectionList(
    String storeSite,
    Emitter<CollectionState> emit,
  ) {
    if (storeSite.isEmpty) return [];

    final collectionList = state.detailList
        .where((item) => item.storesiteno == storeSite)
        .toList();

    return collectionList;
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
      emit(state.copyWith(error: '采集内容为空,请重新采集'));
      return;
    }

    try {
      // 判断扫码内容类型
      ScanStep currentStep;
      if (barcode.contains('MC')) {
        currentStep = ScanStep.qrcode;
        await _handleQRCode(barcode, emit);
      } else if (barcode.contains('\$KW\$')) {
        currentStep = ScanStep.site;
        await _handleSite(barcode, emit);
      } else if (_isNumeric(barcode)) {
        currentStep = ScanStep.quantity;
        await _handleQuantity(double.parse(barcode), emit);
      } else {
        emit(state.copyWith(error: '采集内容不合法！'));
        return;
      }

      var placeholder = await _getPlaceMessage();
      if (placeholder.isEmpty) {
        // 所有扫码步骤完成，处理数量
        await _dealQuantity(state.collectQty, state.matControlFlag, emit);
      }

      placeholder = placeholder.isEmpty
          ? (state.storeSite.isEmpty ? '请扫描库位' : '请扫描二维码')
          : placeholder;

      final focus = placeholder == '请输入数量';

      emit(state.copyWith(placeholder: placeholder, focus: focus));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _handleQRCode(
    String barcode,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // 解析二维码
    final barcodeContent = await _service.getMaterialInfoByQR(barcode);
    final newmarttask = barcodeContent.id_old ?? '';
    final matControl = barcodeContent.seqctrl ?? '';

    // 获取物料控制信息
    String matSendControl = '0';
    final mtlInfo = await _service.getMatControl(barcodeContent.matcode!);
    if (mtlInfo.length > 4 && mtlInfo[4].isNotEmpty) {
      matSendControl = mtlInfo[4];
    }

    // 验证序列号和批次
    final erpRoom = await _validateMaterialControl(
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
      erpRoom: erpRoom,
      isLoading: false,
    );

    // 检查库存
    newstate = await _checkInventory(
      newstate,
      newstate.collectQty,
      newstate.storeSite,
      emit,
    );
    final collectionList = updateCollectionList(newstate.storeSite, emit);

    final newTab = collectionList.isEmpty ? 0 : 1;

    emit(newstate.copyWith(collectionList: collectionList, currentTab: newTab));
  }

  Future<String?> _validateMaterialControl(
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
      // 新格式与老格式的批次号
      String? batchNo = newmarttask == '0'
          ? barcodeContent.sn
          : barcodeContent.batchno;

      if ((matSendControl == '0' && state.roomMatControl == '0') ||
          state.roomMatControl == '1') {
        final erpRoom1 = await _checkMaterial(
          barcodeContent.matcode!,
          batchNo!,
          state.storeSite,
        );
        if (erpRoom1.isNotEmpty) {
          erpRoom = erpRoom1;
        }
      }
      final erpRoom2 = await _checkMaterialSite(
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

  Future<String> _checkMaterial(
    String matcode,
    String batchno,
    String storeSite,
  ) async {
    bool batchFound = false;
    String erpRoom = '';

    // 在任务明细中查找物料
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

  Future<String> _checkMaterialSite(
    String matcode,
    String batchno,
    String storeSite,
  ) async {
    if (state.matControlFlag == '0') return '';

    bool matFind = false;
    String erpRoom = '';

    // 根据控制模式检查物料
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
      if (_batchFlag == 'Y') {
        throw Exception('采集物料【$matcode】批次【$batchno】库位【$storeSite】不在任务明细中，请核实');
      } else {
        throw Exception('采集物料【$matcode】库位【$storeSite】不在任务明细中，请核实');
      }
    }

    return erpRoom;
  }

  Future<void> _handleSite(
    String barcode,
    Emitter<CollectionState> emit,
  ) async {
    final parts = barcode.split('\$');
    if (parts.length < 3) {
      throw Exception('库位格式不正确');
    }

    final siteCode = parts[2];

    emit(state.copyWith(isLoading: true));

    // 验证库位
    final response = await _service.getStoreSite(_task.storeRoomNo, siteCode);
    if (response['code'] != 200) {
      throw Exception(response['msg'] ?? '库位验证失败');
    }

    final siteList = response['data'] as List;
    if (siteList.isEmpty) {
      throw Exception('库房【${_task.storeRoomNo}}】下无库位号【$siteCode】');
    }

    if (siteList[0]['isfrozen'] != '0') {
      throw Exception('库位【$siteCode】被锁定或者冻结');
    }

    // 检查物料和库位匹配
    if (state.currentBarcode != null && state.currentBarcode!.isNotEmpty) {
      if ((state.matSendControl == '0' && state.roomMatControl == '0') ||
          state.roomMatControl == '1') {
        await _checkMaterialSite(
          state.currentBarcode!.matcode ?? '',
          state.currentBarcode!.batchno ?? '',
          siteCode,
        );
      }
    }

    var newstate = state.copyWith(storeSite: siteCode);

    // 检查库存
    newstate = await _checkInventory(
      newstate,
      newstate.collectQty,
      newstate.storeSite,
      emit,
    );

    final collectionList = updateCollectionList(newstate.storeSite, emit);

    final newTab = collectionList.isEmpty ? 0 : 1;

    emit(
      newstate.copyWith(
        collectionList: collectionList,
        currentTab: newTab,
        isLoading: false,
      ),
    );
  }

  Future<void> _handleQuantity(
    double quantity,
    Emitter<CollectionState> emit,
  ) async {
    if ((state.currentBarcode?.sn ?? '').isNotEmpty) {
      throw Exception('已采集序列号无需采集数量，请扫描二维码');
    }

    emit(state.copyWith(collectQty: quantity));
  }

  Future<CollectionState> _checkInventory(
    CollectionState state,
    double collectQty,
    String storeSite,
    Emitter<CollectionState> emit,
  ) async {
    if (state.currentBarcode?.matcode == null || storeSite.isEmpty) {
      return state;
    }

    final batchno = state.currentBarcode!.batchno ?? '';

    CollectionState newstate = state;

    List<dynamic> repertoryList = [];
    double repQty = 0;

    if (state.matControlFlag == '1' || state.matControlFlag == '2') {
      // 批次管理的库存查询
      final response = await _service.getRepertoryByStoreSiteNo(
        storeSite,
        state.currentBarcode!.matcode ?? '',
      );

      if (response['code'] == 200) {
        repertoryList = response['data'];

        // 计算总库存
        double repqtySum = 0;
        for (final item in repertoryList) {
          repqtySum += double.parse(item['repqty']?.toString() ?? '0');
        }
        repQty = repqtySum;

        // 检查符合条件的库存
        final List<dynamic> drcheck = [];
        if (state.erpRoom.isNotEmpty) {
          for (final item in repertoryList) {
            if (item['erpStoreroom'] == state.erpRoom &&
                item['batchno'] == batchno) {
              drcheck.add(item);
              repQty = double.parse(item['repqty']?.toString() ?? '0');
            }
          }
        } else {
          for (final item in repertoryList) {
            if (item['batchno'] == batchno) {
              drcheck.add(item);
              repQty += double.parse(item['repqty']?.toString() ?? '0');
            }
          }
        }

        if (drcheck.isEmpty || repertoryList.isEmpty) {
          throw Exception(
            '物料【${state.currentBarcode!.matcode}】批次【$batchno】在库位【$storeSite】不存在，请确认',
          );
        }

        // 检查子库一致性
        if (state.erpRoom.isNotEmpty && repertoryList.isNotEmpty) {
          final erpStoreInv = repertoryList[0]['erpStoreroom'];
          if (erpStoreInv != state.erpRoom) {
            throw Exception(
              '当前物料明细指定子库【${state.erpRoom}】与当前库位的物料批次子库【$erpStoreInv】存在不一致，请确认',
            );
          }
          newstate = newstate.copyWith(erpStoreInv: erpStoreInv);
        }
      }
    } else {
      // 序列号管理的库存查询
      double repqtySum31 = 0;
      double repqtySum41 = 0;

      final responseSn = await _service.getRepertoryByStoreSiteNoSn(
        storeSite,
        state.currentBarcode!.matcode ?? '',
        null,
        null,
        null,
      );

      if (responseSn['code'] == 200) {
        repertoryList = responseSn['data'];
        if (repertoryList.isNotEmpty) {
          repQty = double.parse(repertoryList[0]['repqty']?.toString() ?? '0');
        }

        if (repQty <= 0) {
          throw Exception(
            '物料【${state.currentBarcode!.matcode}】批次【$batchno】序列【${state.currentBarcode!.sn}】 在库位【$storeSite】不存在，请确认',
          );
        }

        // 根据ERP子库查询
        if (state.erpRoom.isNotEmpty) {
          final responseErp = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            state.currentBarcode!.matcode ?? '',
            state.erpRoom,
            state.currentBarcode!.batchno ?? '',
            state.currentBarcode!.sn ?? '',
          );
          if (responseErp['code'] == 200) {
            final erpList = responseErp['data'] as List;
            if (erpList.isNotEmpty) {
              repqtySum31 = double.parse(
                erpList[0]['repqty']?.toString() ?? '0',
              );
            }
          }
          repQty = repqtySum31;
        } else {
          final responseBatch = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            state.currentBarcode?.matcode ?? '',
            null,
            state.currentBarcode?.batchno ?? '',
            state.currentBarcode?.sn ?? '',
          );
          if (responseBatch['code'] == 200) {
            final batchList = responseBatch['data'] as List;
            if (batchList.isNotEmpty) {
              repqtySum41 = double.parse(
                batchList[0]['repqty']?.toString() ?? '0',
              );
            }
          }
          repQty = repqtySum41;
        }

        if (repQty <= 0) {
          throw Exception(
            '物料【${state.currentBarcode!.matcode}】批次【$batchno】序列【${state.currentBarcode!.sn}】在库位【$storeSite】不存在，请确认',
          );
        }

        // 获取ERP子库信息
        final erpResponse = await _service.getRepertoryByStoreSiteNoErp(
          storeSite,
          state.currentBarcode!.matcode ?? '',
        );
        if (erpResponse['code'] == 200) {
          final erpList = erpResponse['data'] as List;
          if (erpList.isNotEmpty) {
            final erpStoreInv = erpList[0]['erpStoreroom'];
            if (state.erpRoom.isNotEmpty && erpStoreInv != state.erpRoom) {
              throw Exception(
                '当前物料明细指定子库【${state.erpRoom}】与当前库位的物料批次子库【$erpStoreInv】存在不一致，请确认',
              );
            }
            newstate = newstate.copyWith(erpStoreInv: erpStoreInv);
          }
        }
      }
    }

    return newstate.copyWith(repQty: repQty);
  }

  Future<String> _getPlaceMessage() async {
    if (state.storeSite.isEmpty) {
      return '请扫描库位';
    }
    if (state.currentBarcode?.isEmpty ?? true) {
      return '请扫描二维码';
    }
    if (state.currentBarcode?.sn == null && state.collectQty == 0) {
      return '请输入数量';
    }
    return '';
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

  Future<void> _dealQuantity(
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

    // 检查库存是否足够
    final strKey =
        '${state.storeSite}${state.currentBarcode?.matcode!}${matFlagInt == 0 ? state.currentBarcode?.sn : state.currentBarcode?.batchno}';
    final decRepqty = state.dicInvMtlQty[strKey] ?? 0;
    if (state.repQty - decRepqty < count) {
      throw Exception(
        '库位【${state.storeSite}】物料【${state.currentBarcode?.matcode}】的库存【${state.repQty - decRepqty}】小于本次移出库存【$count】，请确认',
      );
    }

    // 更新序列号记录
    final newDicSeq = Map<String, String>.from(state.dicSeq);

    // 更新库存消耗记录
    final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);
    final currentInvQty = newDicInvMtlQty[strKey] ?? 0;
    newDicInvMtlQty[strKey] = currentInvQty + count;

    final updatedDetailList = List<OutTaskItem>.from(state.detailList);
    final dicMtlOperation = <String, List<double>>{};
    final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);

    // 统计当前物料总计划数和总扫描数 - 第一次遍历
    double totalTaskQty = 0;
    double totalTmpQty = 0;
    double totalInventory = state.repQty;

    // 当前操作物料的所有任务项的index
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
      // 验证是否成功分配
      throw Exception('采集物料批号序列号信息匹配任务明细失败');
    }

    for (var index in indexes) {
      final item = updatedDetailList[index];
      totalTaskQty += item.hintqty;
      totalTmpQty += item.collectedqty;
    }

    totalInventory -= totalTmpQty + count; // 剩余总库存

    // 校验数量是否足够
    if (totalTmpQty + count > totalTaskQty) {
      throw Exception('本次采集数量【$count】大于剩余可采集数量【${totalTaskQty - totalTmpQty}】');
    }

    if (matFlagInt == 0) {
      // 处理序列号
      var idx = indexes
          .where((index) => updatedDetailList[index].sn == sn)
          .firstOrNull;
      if (idx != null) {
        var item = updatedDetailList[idx];
        item = item.copyWith(collectedqty: 1);
        updatedDetailList[idx] = item;

        // 记录分配操作（任务的总采集数，本次采集的数量）
        dicMtlOperation[item.outtaskitemid.toString()] = [1, 1];

        // 更新dicMtlQty (已采集的数量，累计采集的数量)
        newDicMtlQty[item.outtaskitemid.toString()] = [0, 1];

        if (sn.isNotEmpty) {
          newDicSeq['${state.currentBarcode?.matcode}@$sn'] =
              '${state.currentBarcode?.matcode}@$sn';
        }

        // 添加采集记录
        await _addCollectData(
          state.currentBarcode?.matcode ?? '',
          state.currentBarcode?.batchno ?? '',
          sn,
          count,
          _task.storeRoomNo,
          state.storeSite,
          dicMtlOperation,
          state.erpStoreInv,
          '',
          emit,
        );
      }
    } else {
      // 分配数量到具体任务项
      double currentCount = count;
      for (var index in indexes) {
        var item = updatedDetailList[index];
        final taskCount = item.hintqty;
        final collectedCount = item.collectedqty;

        item = item.copyWith(repqty: totalInventory);
        updatedDetailList[index] = item;

        // 已经完成的跳过
        if (taskCount == collectedCount || currentCount == 0) continue;

        // 采集数量
        final tempCount = (taskCount - collectedCount) > currentCount
            ? currentCount
            : (taskCount - collectedCount);

        // 剩余采集数量
        currentCount -= tempCount;

        item = item.copyWith(collectedqty: collectedCount + tempCount);
        updatedDetailList[index] = item;

        // 初始化 dicMtlQty
        if (!newDicMtlQty.containsKey(item.outtaskitemid.toString())) {
          newDicMtlQty[item.outtaskitemid.toString()] = [collectedCount, 0];
        }

        // 记录分配操作（任务的总采集数，本次采集的数量）
        dicMtlOperation[item.outtaskitemid.toString()] = [taskCount, tempCount];

        // 更新dicMtlQty (已采集的数量，累计采集的数量)
        final begin = newDicMtlQty[item.outtaskitemid.toString()]![0];
        newDicMtlQty[item.outtaskitemid.toString()] = [
          begin,
          collectedCount + tempCount,
        ];
      }

      // 添加采集记录
      await _addCollectData(
        state.currentBarcode?.matcode ?? '',
        state.currentBarcode?.batchno ?? '',
        sn,
        count,
        _task.storeRoomNo,
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
      _initializeCollect().copyWith(
        detailList: updatedDetailList,
        collectionList: collectionList,
        dicSeq: newDicSeq,
        dicMtlQty: newDicMtlQty,
        dicInvMtlQty: newDicInvMtlQty,
      ),
    );

    await _localSave();
  }

  Future<void> _addCollectData(
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
      final stock = CollectionStock(
        stockid: const Uuid().v4(),
        matcode: matCode,
        batchno: batchNo,
        sn: sn,
        taskQty: entry.value[0],
        collectQty: entry.value[1],
        outtaskitemid: entry.key,
        taskid: _task.outTaskId.toString(),
        storeRoom: storeRoom,
        storeSite: storeSite,
        erpStore: erpRoom,
        trayNo: trayNo,
      );
      newStocks.add(stock);
    }

    emit(state.copyWith(stocks: newStocks));
  }

  Future<void> _localSave() async {
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

  CollectionState _initializeCollect() {
    return state.copyWith(
      error: null,
      isLoading: false,
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
    return RegExp(r'^[0-9]+(\.[0-9]+)?').hasMatch(str);
  }

  Future<void> _onCommitCollection(
    CommitCollectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (state.stocks.isEmpty) {
        emit(state.copyWith(error: '本次无采集明细，请确认！'));
        return;
      }

      // 按照原文档逻辑检查未完成任务，生成详细的提示信息
      String msg = '';
      String tmpStore = '';
      String tmpMat = '';
      double taskQty1 = 0;
      double tmpQty1 = 0;

      for (final item in state.detailList) {
        tmpMat = item.matcode ?? '';
        tmpStore = item.storesiteno ?? '';
        taskQty1 = item.hintqty;
        tmpQty1 = item.collectedqty;

        if (taskQty1 != tmpQty1) {
          msg = '库位【$tmpStore】物料【$tmpMat】还剩【${taskQty1 - tmpQty1}】未做';
          break;
        }
      }

      if (msg.isNotEmpty) {
        msg += '，请确认是否提交？';
      } else {
        msg = '请确认是否提交？';
      }

      // 这里应该显示确认对话框，为简化直接处理
      await _performCommit(emit);
    } catch (e) {
      emit(state.copyWith(error: '平库出库采集异常：${e.toString()}'));
    }
  }

  Future<void> _performCommit(Emitter<CollectionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // 再次校验采集数据
      final collectStocks = state.stocks;
      if (collectStocks.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      // 生成下架信息列表
      final downShelvesInfosList = collectStocks
          .map(
            (stock) => {
              'taskNo': _task.outTaskNo,
              'matCode': stock.matcode,
              'batchNo': stock.batchno,
              'sn': stock.sn,
              'taskQty': stock.taskQty,
              'collectQty': stock.collectQty,
              'storeRoomNo': stock.storeRoom,
              'storeSiteNo': stock.storeSite,
              'taskid': stock.taskid,
              'outTaskItemid': stock.outtaskitemid,
              'erpStore': stock.erpStore,
            },
          )
          .toList();

      // 生成任务项列表
      final lsItems = <Map<String, dynamic>>[];
      for (final entry in state.dicMtlQty.entries) {
        final itemListInfo = <String, dynamic>{};
        final mtlQty = entry.value
            .map((e) => isInteger(e) ? e.toInt().toString() : e.toString())
            .toList();
        itemListInfo['mtlQty'] = mtlQty;
        itemListInfo['outTaskItemid'] = entry.key;

        // 查找物料编码
        final taskItem = state.detailList.firstWhere(
          (item) => item.outtaskitemid.toString() == entry.key,
          orElse: () => OutTaskItem(
            outtaskitemid: 0,
            matcode: '',
            matname: '',
            storesiteno: '',
            hintqty: 0,
            collectedqty: 0,
            repqty: 0,
            hintbatchno: '',
            sn: '',
            storeroomno: '',
            subinventoryCode: '',
            orderno: '',
            matinnercode: '',
          ),
        );
        itemListInfo['mtlCode'] = taskItem.matcode;

        lsItems.add(itemListInfo);
      }

      if (lsItems.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      log('下架信息：$downShelvesInfosList');
      log('任务项信息：$lsItems');

      final response = await _service.commitDownShelves(
        downShelvesInfosList,
        lsItems,
      );

      if (response['code'] == 200) {
        // 清理缓存
        await _clearCache();
        emit(
          state.copyWith(
            isLoading: false,
            stocks: [],
            dicSeq: {},
            dicMtlQty: {},
            dicInvMtlQty: {},
          ),
        );

        // 显示成功提示
        // 在实际应用中应该显示成功对话框并导航回上一页
        // Navigator.of(context).pop();
      } else {
        emit(
          state.copyWith(isLoading: false, error: response['msg'] ?? '提交失败'),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: '平库出库采集异常：${e.toString()}'));
    }
  }

  bool isInteger(double x) => x.isFinite && x % 1 == 0;

  Future<void> _onReportShortage(
    ReportShortageEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (state.stocks.isNotEmpty) {
        emit(state.copyWith(error: '采集数据未提交,不允许报缺！'));
        return;
      }

      if (state.checkedIds.isEmpty) {
        emit(state.copyWith(error: '请至少选择一行记录！'));
        return;
      }
      final id = state.checkedIds.first;
      final response = await _service.commitFinishOutTaskItem(id);

      if (response['code'] == 200) {
        // 重新加载任务列表
        await loadTaskList(emit);
      } else {
        emit(state.copyWith(error: response['msg'] ?? '报缺失败'));
      }
    } catch (e) {
      emit(state.copyWith(error: '报缺异常：${e.toString()}'));
    }
  }

  Future<void> _clearCache() async {
    await _cacheBox.put('stocks', <Map>[]);
    await _cacheBox.put('updateFlag', '0');
    await _cacheBox.put('detailList', <Map>[]);
    await _cacheBox.put('dicMtlQty', <String, List<double>>{});
    await _cacheBox.put('dicInvMtlQty', <String, double>{});
    _cacheBox.clear();
  }

  Future<void> _onClearError(
    ClearErrorEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(error: null));
  }

  Future<void> _onUpdateFromResult(
    UpdateFromResultEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (event.deletedStocks.isEmpty) return;

      // 类型安全：集合内应为 CollectionStock
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

        // 1) 明细 collectedqty 扣减
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

        // 2) dicSeq 删除 matcode@sn
        if (s.sn.isNotEmpty) {
          final seqKey = '${s.matcode}@${s.sn}';
          newDicSeq.remove(seqKey);
        }

        // 3) dicMtlQty 扣减第二位（累计采集量）
        final mtlKey = s.outtaskitemid;
        final ls2 = List<double>.from(newDicMtlQty[mtlKey] ?? <double>[0, 0]);
        final newSecond = (ls2.length > 1 ? ls2[1] : 0) - s.collectQty;
        if (ls2.length > 1) {
          ls2[1] = newSecond < 0 ? 0 : newSecond;
        } else {
          ls2.add(newSecond < 0 ? 0 : newSecond);
        }
        newDicMtlQty[mtlKey] = ls2;

        // 4) dicInvMtlQty 扣减库存消耗
        final invKey = s.sn.isNotEmpty
            ? '${s.storeSite}${s.matcode}${s.sn}'
            : '${s.storeSite}${s.matcode}${s.batchno}';
        final invVal = (newDicInvMtlQty[invKey] ?? 0) - s.collectQty;
        newDicInvMtlQty[invKey] = invVal < 0 ? 0 : invVal;

        // 5) 从 stocks 移除
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
      await _localSave();
    } catch (e) {
      emit(state.copyWith(error: '从结果页更新采集数据失败：${e.toString()}'));
    }
  }

  Future<void> _onDeleteCollectedStocks(
    DeleteCollectedStocksEvent event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      if (event.stockIds.isEmpty) {
        emit(state.copyWith(error: '请至少选择一行记录'));
        return;
      }

      // 可变副本
      final updatedStocks = List<CollectionStock>.from(state.stocks);
      final updatedDetailList = List<OutTaskItem>.from(state.detailList);
      final newDicSeq = Map<String, String>.from(state.dicSeq);
      final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
      final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);

      // 逐条删除并扣减关联数据
      for (final stockId in event.stockIds) {
        final idx = updatedStocks.indexWhere((s) => s.stockid == stockId);
        if (idx < 0) continue;

        final s = updatedStocks[idx];

        // 1) 明细 collectedqty 扣减
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

        // 2) dicSeq 删除 matcode@sn
        if (s.sn.isNotEmpty) {
          final seqKey = '${s.matcode}@${s.sn}';
          if (newDicSeq.containsKey(seqKey)) {
            newDicSeq.remove(seqKey);
          }
        }

        // 3) dicMtlQty 扣减第二位（累计采集量）
        final mtlKey = s.outtaskitemid;
        if (newDicMtlQty.containsKey(mtlKey)) {
          final ls2 = List<double>.from(newDicMtlQty[mtlKey]!);
          // ls2 结构： [原tmpQty, 累计采集 qty]
          final newSecond = (ls2.length > 1 ? ls2[1] : 0) - s.collectQty;
          if (ls2.length > 1) {
            ls2[1] = newSecond < 0 ? 0 : newSecond;
          } else {
            ls2.add(newSecond < 0 ? 0 : newSecond);
          }
          newDicMtlQty[mtlKey] = ls2;
        }

        // 4) dicInvMtlQty 扣减库存消耗
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

        // 5) 从 stocks 移除
        updatedStocks.removeAt(idx);
      }
      final updateCollectionList = updatedDetailList
          .where((item) => item.storesiteno == state.storeSite)
          .toList();

      // 写入并持久化
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
      await _localSave();
    } catch (e) {
      emit(state.copyWith(error: '删除采集记录失败：${e.toString()}'));
    }
  }

  Future<void> _onSetFocus(
    SetFocusEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(focus: event.focus));
  }
}
