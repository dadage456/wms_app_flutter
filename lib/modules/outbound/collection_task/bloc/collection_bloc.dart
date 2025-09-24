import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/task_details/models/outbound_task_item.dart';
import 'package:wms_app/modules/outbound/task_list/models/outbound_task.dart';
import 'package:wms_app/services/user_manager.dart';
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

  CollectionBloc(this._service) : super(const CollectionState()) {
    on<InitializeTaskEvent>(_onInitializeTask);
    on<PerformBarcodeEvent>(_onPerformBarcode);
    on<ChangeTabEvent>(_onChangeTab);
    on<ToggleItemSelectionEvent>(_onToggleItemSelection);
    on<ToggleAllSelectionEvent>(_onToggleAllSelection);
    on<CommitCollectionEvent>(_onCommitCollection);
    on<ReportShortageEvent>(_onReportShortage);
    on<ClearErrorEvent>(_onClearError);
    on<SetFocusEvent>(_onSetFocus);
    _initHive();
  }

  Future<void> _initHive() async {
    _cacheBox = await Hive.openBox('collection_cache');
  }

  Future<void> _onInitializeTask(
    InitializeTaskEvent event,
    Emitter<CollectionState> emit,
  ) async {
    
    _userId = event.userId;
    _task = event.task;

    
    _siteFlag = 'Y';
    _batchFlag = 'Y';

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

      debugPrint('----------------- $detailList');

      if(detailList.isEmpty) {
        emit(state.copyWith(isLoading: false, error: '当前任务列表没有待处理任务!'));
        return;
      }

      // 获取物料控制信息
      String roomMatControl = '0';
      final controlResponse = await _service.getRoomMatControl(_task.outTaskId.toString());
final roomMtlInfo = controlResponse.split('!');
        if (roomMtlInfo.length > 4 && roomMtlInfo[4].isNotEmpty) {
          roomMatControl = roomMtlInfo[4];
        }


      // 确定检查模式
      MtlCheckMode mtlCheckMode;
      if (_siteFlag == 'Y' && _batchFlag == 'Y') {
        mtlCheckMode =  MtlCheckMode.mtlSiteBatch;
      } else if (_siteFlag == 'Y' && _batchFlag != 'Y') {
        mtlCheckMode =  MtlCheckMode.mtlSite;
      } else if (_siteFlag != 'Y' && _batchFlag == 'Y') {
        mtlCheckMode =  MtlCheckMode.mtlBatch;
      } else {
        mtlCheckMode =  MtlCheckMode.mtl;
      }

      emit(
        state.copyWith(
          detailList: detailList,
          isLoading: false,
          roomMatControl: roomMatControl,
          mtlCheckMode: mtlCheckMode,
        ),
      );

      // 缓存数据
      await _cacheBox.put(
        'detailList',
        detailList.map((e) => e.toJson()).toList(),
      );
      await _cacheBox.put('updateFlag', '0');

    } catch (e) {
      emit(state.copyWith(isLoading: false, error: ErrorHandler.handleError(e)));
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
            detailList: detailList,
            stocks: stocks,
            dicSeq: cachedDicSeq,
            dicMtlQty: cachedDicMtlQty,
            dicInvMtlQty: cachedDicInvMtlQty,
          ),
        );

        updateCollectionList(state.storeSite, emit);
        await _cacheBox.put('updateFlag', '0');
      }
    } catch (e) {
      emit(state.copyWith(error: '恢复缓存数据失败：${e.toString()}'));
    }
  }

  void updateCollectionList(String storeSite, Emitter<CollectionState> emit) {
    if (storeSite.isEmpty) return;

    final collectionList = state.detailList
        .where((item) => item.storesiteno == storeSite)
        .toList();

    final newTab = collectionList.isEmpty ? 0 : 1;

    emit(state.copyWith(collectionList: collectionList, currentTab: newTab));
  }

  Future<void> _onChangeTab(
    ChangeTabEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(currentTab: event.index));
  }

  Future<void> _onToggleItemSelection(
    ToggleItemSelectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    final checkedIds = List<String>.from(state.checkedIds);
    if (event.selected) {
      if (!checkedIds.contains(event.itemId)) {
        checkedIds.add(event.itemId);
      }
    } else {
      checkedIds.remove(event.itemId);
    }
    emit(state.copyWith(checkedIds: checkedIds));
  }

  Future<void> _onToggleAllSelection(
    ToggleAllSelectionEvent event,
    Emitter<CollectionState> emit,
  ) async {
    final List<String> checkedIds;
    if (event.selected) {
      checkedIds = state.detailList.map((item) => item.outtaskitemid.toString()).toList();
    } else {
      checkedIds = [];
    }
    emit(state.copyWith(checkedIds: checkedIds));
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


      final placeholder = await _getPlaceMessage();
      if (placeholder.isEmpty) {
        // 所有扫码步骤完成，处理数量
        await _dealQuantity(state.collectQty, state.matControlFlag, emit);
      }

      emit(state.copyWith(placeholder: placeholder));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      _initializeCollect(emit);
    }
  }

  Future<void> _handleQRCode(
    String barcode,
    Emitter<CollectionState> emit,
  ) async {
    // 解析二维码
    final barcodeContent = await _service.getMaterialInfoByQR(barcode);
    final newmarttask = barcodeContent.id_old;
    final matControl = barcodeContent.seqctrl;

    // 获取物料控制信息
    String matSendControl = '0';
    final mtlInfo = await _service.getMatControl(
      barcodeContent.matcode,
    );
     if (mtlInfo.length > 4 && mtlInfo[4].isNotEmpty) {
        matSendControl = mtlInfo[4];
      }

    // 验证序列号和批次
    await _validateMaterialControl(
      barcodeContent,
      newmarttask,
      matControl,
      matSendControl,
      emit,
    );

    emit(
      state.copyWith(
        currentBarcode: barcodeContent,
        matCode: barcodeContent.matcode,
        batchNo: barcodeContent.batchno,
        sn: barcodeContent.sn,
        matControlFlag: matControl,
        matSendControl: matSendControl,
        collectQty: matControl == '0' ? 1 : state.collectQty,
      ),
    );

    // 检查库存
    await _checkInventory(state.collectQty, state.storeSite, emit);
    updateCollectionList(state.storeSite, emit);
  }

  Future<void> _validateMaterialControl(
    BarcodeContent barcodeContent,
    String newmarttask,
    String matControl,
    String matSendControl,
    Emitter<CollectionState> emit,
  ) async {

      if (matControl == '0') {
        if (barcodeContent.sn.isEmpty) {
          throw Exception('物料【${barcodeContent.matcode}】序列号不能为空');
        }

        final seqKey = '${barcodeContent.matcode}@${barcodeContent.sn}';
        if (state.dicSeq.containsKey(seqKey)) {
          throw Exception(
            '物料【${barcodeContent.matcode}】序列号【${barcodeContent.sn}】不允许重复采集，请确认',
          );
        }

        // 检查已采集的序列号
        final existsInStocks = state.stocks.any(
          (stock) => stock.sn == barcodeContent.sn,
        );
        if (existsInStocks) {
          throw Exception(
            '采集物料【${barcodeContent.matcode}】序列号【${barcodeContent.sn}】库位【${state.storeSite}】已经采集,不允许重复采集!',
          );
        }
      } else if (matControl == '1' || matControl == '2') {

        // 新格式与老格式的批次号
        String batchNo = newmarttask == '0' ? barcodeContent.sn : barcodeContent.batchno;

        if ((matSendControl == '0' && state.roomMatControl == '0') ||
            state.roomMatControl == '1') {
          await _checkMaterial(
            barcodeContent.matcode,
            batchNo,
            state.storeSite,emit,
          );
        }
        await _checkMaterialSite(
          barcodeContent.matcode,
          batchNo,
          state.storeSite,
          emit,
        );
      } else {
        throw Exception('物料${barcodeContent.matcode}编码控制维护值维护不合法');
      }
   
  }

  Future<void> _checkMaterial(
    String matcode,
    String batchno,
    String storeSite,
    Emitter<CollectionState> emit,
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

    emit(state.copyWith(erpRoom: erpRoom));
  }

  Future<void> _checkMaterialSite(
    String matcode,
    String batchno,
    String storeSite,
    Emitter<CollectionState> emit,
  ) async {
    if (state.matControlFlag == '0') return;

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

    emit(state.copyWith(erpRoom: erpRoom));
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

    // 验证库位
    final response = await _service.getStoreSite(_task.storeRoomNo, siteCode);
    if (response['code'] != '200') {
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
    if ((state.matSendControl == '0' && state.roomMatControl == '0') ||
        state.roomMatControl == '1') {
      await _checkMaterialSite(state.matCode, state.batchNo, siteCode, emit);
    }

    emit(state.copyWith(storeSite: siteCode));

    // 检查库存
    await _checkInventory(0, siteCode, emit);
    updateCollectionList(siteCode, emit);
  }

  Future<void> _handleQuantity(
    double quantity,
    Emitter<CollectionState> emit,
  ) async {
    if (state.sn.isNotEmpty) {
      throw Exception('已采集序列号无需采集数量，请扫描二维码');
    }

    emit(state.copyWith(collectQty: quantity));
  }

  Future<void> _checkInventory(
    double collectQty,
    String storeSite,
    Emitter<CollectionState> emit,
  ) async {
    if (state.matCode.isEmpty || storeSite.isEmpty) return;

    List<dynamic> repertoryList = [];
    double repQty = 0;

    if (state.matControlFlag == '1' || state.matControlFlag == '2') {
      // 批次管理的库存查询
      final response = await _service.getRepertoryByStoreSiteNo(
        storeSite,
        state.matCode
      );

      if (response['code'] == '200') {
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
                item['batchno'] == state.batchNo) {
              drcheck.add(item);
              repQty = double.parse(item['repqty']?.toString() ?? '0');
            }
          }
        } else {
          for (final item in repertoryList) {
            if (item['batchno'] == state.batchNo) {
              drcheck.add(item);
              repQty += double.parse(item['repqty']?.toString() ?? '0');
            }
          }
        }

        if (drcheck.isEmpty || repertoryList.isEmpty) {
          throw Exception(
            '物料【${state.matCode}】批次【${state.batchNo}】在库位【$storeSite】不存在，请确认',
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
          emit(state.copyWith(erpStoreInv: erpStoreInv));
        }
      }
    } else {
      // 序列号管理的库存查询
      double repqtySum31 = 0;
      double repqtySum41 = 0;

      final responseSn = await _service.getRepertoryByStoreSiteNoSn(
        storeSite,
        state.matCode,
        null,
        null,
        null,
      );

      if (responseSn['code'] == '200') {
        repertoryList = responseSn['data'];
        if (repertoryList.isNotEmpty) {
          repQty = double.parse(repertoryList[0]['repqty']?.toString() ?? '0');
        }

        if (repQty <= 0) {
          throw Exception(
            '物料【${state.matCode}】批次【${state.batchNo}】序列【${state.sn}】 在库位【$storeSite】不存在，请确认',
          );
        }

        // 根据ERP子库查询
        if (state.erpRoom.isNotEmpty) {
          final responseErp = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            state.matCode,
            state.erpRoom,
            state.batchNo,
            state.sn,
          );
          if (responseErp['code'] == '200') {
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
            state.matCode,
            null,
            state.batchNo,
            state.sn,
          );
          if (responseBatch['code'] == '200') {
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
            '物料【${state.matCode}】批次【${state.batchNo}】序列【${state.sn}】在库位【$storeSite】不存在，请确认',
          );
        }

        // 获取ERP子库信息
        final erpResponse = await _service.getRepertoryByStoreSiteNoErp(
          storeSite,
          state.matCode,
        );
        if (erpResponse['code'] == '200') {
          final erpList = erpResponse['data'] as List;
          if (erpList.isNotEmpty) {
            final erpStoreInv = erpList[0]['erpStoreroom'];
            if (state.erpRoom.isNotEmpty && erpStoreInv != state.erpRoom) {
              throw Exception(
                '当前物料明细指定子库【${state.erpRoom}】与当前库位的物料批次子库【$erpStoreInv】存在不一致，请确认',
              );
            }
            emit(state.copyWith(erpStoreInv: erpStoreInv));
          }
        }
      }
    }

    emit(state.copyWith(repQty: repQty));
  }

  Future<String> _getPlaceMessage() async {
    if (state.storeSite.isEmpty) {
      return '请扫描库位';
    }
    if (state.currentBarcode?.matcode.isEmpty ?? true) {
      return '请扫描二维码';
    }
    if (state.currentBarcode?.sn == null && state.collectQty == 0) {
      return '请输入数量';
    }
    return '';
  }

  Future<void> _dealQuantity(
    double qty,
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

    if (qty <= 0) {
      throw Exception('采集数量必须大于0');
    }

    // 检查库存是否足够
    final strKey =
        '${state.storeSite}${state.matCode}${matFlagInt == 0 ? state.sn : state.batchNo}';
    final decRepqty = state.dicInvMtlQty[strKey] ?? 0;
    if (state.repQty - decRepqty < qty) {
      throw Exception(
        '库位【${state.storeSite}】物料【${state.matCode}】的库存【${state.repQty - decRepqty}】小于本次移出库存【$qty】，请确认',
      );
    }

    // 统计当前物料总计划数和总扫描数 - 第一次遍历
    double totalTaskQty = 0;
    double totalTmpQty = 0;

    for (final item in state.detailList) {
      if (item.matcode != state.matCode) continue;

      bool shouldInclude = true;
      if ((matFlagInt == 1 || matFlagInt == 2) &&
          ((state.matSendControl == '0' && state.roomMatControl == '0') ||
              state.roomMatControl == '1')) {
        switch (state.mtlCheckMode) {
          case MtlCheckMode.mtlBatch:
            shouldInclude = item.hintbatchno == state.batchNo;
            break;
          case MtlCheckMode.mtlSiteBatch:
            shouldInclude =
                item.hintbatchno == state.batchNo &&
                item.storesiteno == state.storeSite;
            break;
          case MtlCheckMode.mtlSite:
            shouldInclude = item.storesiteno == state.storeSite;
            break;
          case MtlCheckMode.mtl:
            shouldInclude = true;
            break;
        }
      }

      if (shouldInclude) {
        totalTaskQty += item.hintqty;
        totalTmpQty += item.collectedqty;
      }
    }

    // 校验数量是否足够
    if (totalTmpQty + qty > totalTaskQty) {
      throw Exception('本次采集数量【$qty】大于剩余可采集数量【${totalTaskQty - totalTmpQty}】');
    }

    // 计算单个物料剩余库存 - 第二次遍历
    double tmpRepQty = 0;
    double currentRepQty = state.repQty;

    for (final item in state.detailList) {
      if (item.matcode == state.matCode &&
          item.storesiteno == state.storeSite &&
          item.repqty > 0) {
        tmpRepQty = item.repqty;
        break;
      }
    }

    if (currentRepQty > 0 && tmpRepQty > 0 && currentRepQty > tmpRepQty) {
      currentRepQty = tmpRepQty;
    }

    // 分配数量到具体任务项 - 第三次遍历（主要分配逻辑）
    double remainingQty = qty;
    final dicMtlOperation = <String, List<double>>{};
    final updatedDetailList = List<OutTaskItem>.from(state.detailList);
    final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
    bool existFlag = false;

    for (int i = 0; i < updatedDetailList.length && remainingQty > 0; i++) {
      final item = updatedDetailList[i];

      // 检查是否应该处理这个项目
      if (!_shouldProcessItemForAllocation(item, matFlagInt)) continue;

      final taskQty = item.hintqty;
      final tmpQty = item.collectedqty;

      if (taskQty == tmpQty) continue; // 已经完成的跳过

      // 初始化 dicMtlQty
      if (!newDicMtlQty.containsKey(item.outtaskitemid.toString())) {
        newDicMtlQty[item.outtaskitemid.toString()] = [tmpQty, 0];
      }

      final availableQty = taskQty - tmpQty;
      final allocatedQty = remainingQty >= availableQty
          ? availableQty
          : remainingQty;

      // 更新采集数量
      updatedDetailList[i] = OutTaskItem(
        outtaskitemid: item.outtaskitemid,
        matcode: item.matcode,
        matname: item.matname,
        storesiteno: item.storesiteno,
        hintqty: item.hintqty,
        collectedqty: tmpQty + allocatedQty,
        repqty: availableQty == allocatedQty
            ? currentRepQty - allocatedQty
            : currentRepQty - (taskQty - tmpQty),
        hintbatchno: item.hintbatchno,
        sn: item.sn,
        storeroomno: item.storeroomno,
        subinventoryCode: item.subinventoryCode,
        orderno: item.orderno,
        matinnercode: item.matinnercode,
      );

      // 更新库存
      currentRepQty = updatedDetailList[i].repqty;

      // 记录分配操作
      dicMtlOperation[item.outtaskitemid.toString()] = [taskQty, allocatedQty];
      remainingQty -= allocatedQty;
      existFlag = true;

      // 更新dicMtlQty
      newDicMtlQty[item.outtaskitemid.toString()] = [tmpQty, tmpQty + allocatedQty];
    }

    // 验证是否成功分配
    if ((state.matSendControl == '0' && state.roomMatControl == '0') ||
        state.roomMatControl == '1') {
      if (!existFlag) {
        throw Exception('采集物料批号序列号信息匹配任务明细失败');
      }
    }

    // 更新序列号记录
    final newDicSeq = Map<String, String>.from(state.dicSeq);
    if (sn.isNotEmpty) {
      newDicSeq['${state.matCode}@$sn'] = '${state.matCode}@$sn';
    }

    // 更新库存消耗记录
    final newDicInvMtlQty = Map<String, double>.from(state.dicInvMtlQty);
    final currentInvQty = newDicInvMtlQty[strKey] ?? 0;
    newDicInvMtlQty[strKey] = currentInvQty + qty;

    emit(
      state.copyWith(
        detailList: updatedDetailList,
        dicSeq: newDicSeq,
        dicMtlQty: newDicMtlQty,
        dicInvMtlQty: newDicInvMtlQty,
      ),
    );

    updateCollectionList(state.storeSite, emit);

    // 添加采集记录
    await _addCollectData(
      state.matCode,
      state.batchNo,
      sn,
      qty,
      _task.storeRoomNo,
      state.storeSite,
      dicMtlOperation,
      state.erpStoreInv,
      '',
      emit,
    );
    await _localSave();
    _initializeCollect(emit);
  }

  bool _shouldProcessItemForAllocation(OutTaskItem item, int matFlag) {
    // 物料不匹配
    if (item.matcode != state.matCode) return false;

    // 对于序列号控制的物料，需要同时匹配物料和库位
    if (matFlag == 0) {
      return item.matcode == state.matCode &&
          item.storesiteno == state.storeSite;
    }

    // 对于批次控制的物料
    if ((matFlag == 1 || matFlag == 2) &&
        ((state.matSendControl == '0' && state.roomMatControl == '0') ||
            state.roomMatControl == '1')) {
      // 必须匹配物料和库位
      if (item.matcode != state.matCode ||
          item.storesiteno != state.storeSite) {
        return false;
      }

      // 根据检查模式进一步验证
      switch (state.mtlCheckMode) {
        case MtlCheckMode.mtlBatch:
          return item.hintbatchno == state.batchNo;
        case MtlCheckMode.mtlSiteBatch:
          return item.hintbatchno == state.batchNo &&
              item.storesiteno == state.storeSite;
        case MtlCheckMode.mtlSite:
          return item.storesiteno == state.storeSite;
        case MtlCheckMode.mtl:
          return true;
      }
    }

    return true;
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

  void _initializeCollect(Emitter<CollectionState> emit) {
    emit(
      state.copyWith(
        collectQty: 0,
        currentBarcode: null,
        focus: false,
        matCode: '',
        batchNo: '',
        sn: '',
        matControlFlag: '',
        erpRoom: '',
        erpStoreInv: '',
        placeholder: '请扫描库位',
      ),
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
        final mtlQty = entry.value;
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

      final response = await _service.commitDownShelves(
        downShelvesInfosList,
        lsItems,
      );

      if (response['code'] == '200') {
        // 清理缓存
        await _clearCache();
        emit(
          state.copyWith(
            isLoading: false,
            stocks: [],
            detailList: [],
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

      // 这里应该显示确认对话框
      final selectedItem = state.detailList.firstWhere(
        (item) => item.outtaskitemid == state.checkedIds.first,
      );

      final response = await _service.commitFinishOutTaskItem(
        selectedItem.outtaskitemid.toString(),
      );

      if (response['code'] == '200') {
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
  }

  Future<void> _onClearError(
    ClearErrorEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(error: null));
  }

  Future<void> _onSetFocus(
    SetFocusEvent event,
    Emitter<CollectionState> emit,
  ) async {
    emit(state.copyWith(focus: event.focus));
  }
}
