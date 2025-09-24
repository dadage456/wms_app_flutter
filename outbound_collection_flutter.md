// lib/modules/outbound/collection_task/models/collection_models.dart
import 'package:hive/hive.dart';

part 'collection_models.g.dart';

@HiveType(typeId: 0)
class OutTaskItem extends HiveObject {
  @HiveField(0)
  String outtaskitemid;
  
  @HiveField(1)
  String matcode;
  
  @HiveField(2)
  String matname;
  
  @HiveField(3)
  String storesiteno;
  
  @HiveField(4)
  double hintqty;
  
  @HiveField(5)
  double collectedqty;
  
  @HiveField(6)
  double repqty;
  
  @HiveField(7)
  String hintbatchno;
  
  @HiveField(8)
  String sn;
  
  @HiveField(9)
  String storeroomno;
  
  @HiveField(10)
  String subinventoryCode;
  
  @HiveField(11)
  String orderno;
  
  @HiveField(12)
  String matinnercode;

  OutTaskItem({
    required this.outtaskitemid,
    required this.matcode,
    required this.matname,
    required this.storesiteno,
    required this.hintqty,
    required this.collectedqty,
    required this.repqty,
    required this.hintbatchno,
    required this.sn,
    required this.storeroomno,
    required this.subinventoryCode,
    required this.orderno,
    required this.matinnercode,
  });

  factory OutTaskItem.fromJson(Map<String, dynamic> json) {
    return OutTaskItem(
      outtaskitemid: json['outtaskitemid'] ?? '',
      matcode: json['matcode'] ?? '',
      matname: json['matname'] ?? '',
      storesiteno: json['storesiteno'] ?? '',
      hintqty: double.tryParse(json['hintqty']?.toString() ?? '0') ?? 0,
      collectedqty: double.tryParse(json['collectedqty']?.toString() ?? '0') ?? 0,
      repqty: double.tryParse(json['repqty']?.toString() ?? '0') ?? 0,
      hintbatchno: json['hintbatchno'] ?? '',
      sn: json['sn'] ?? '',
      storeroomno: json['storeroomno'] ?? '',
      subinventoryCode: json['subinventoryCode'] ?? '',
      orderno: json['orderno'] ?? '',
      matinnercode: json['matinnercode'] ?? '',
    );
  }
}

@HiveType(typeId: 1)
class BarcodeContent extends HiveObject {
  @HiveField(0)
  String matcode;
  
  @HiveField(1)
  String matname;
  
  @HiveField(2)
  String batchno;
  
  @HiveField(3)
  String sn;
  
  @HiveField(4)
  String seqctrl;
  
  @HiveField(5)
  String id_old;
  
  @HiveField(6)
  double qty;

  BarcodeContent({
    required this.matcode,
    required this.matname,
    required this.batchno,
    required this.sn,
    required this.seqctrl,
    required this.id_old,
    required this.qty,
  });

  factory BarcodeContent.fromJson(Map<String, dynamic> json) {
    return BarcodeContent(
      matcode: json['matcode'] ?? '',
      matname: json['matname'] ?? '',
      batchno: json['batchno'] ?? '',
      sn: json['sn'] ?? '',
      seqctrl: json['seqctrl'] ?? '',
      id_old: json['id_old'] ?? '',
      qty: double.tryParse(json['qty']?.toString() ?? '0') ?? 0,
    );
  }
}

@HiveType(typeId: 2)
class CollectionStock extends HiveObject {
  @HiveField(0)
  String stockid;
  
  @HiveField(1)
  String matcode;
  
  @HiveField(2)
  String batchno;
  
  @HiveField(3)
  String sn;
  
  @HiveField(4)
  double taskQty;
  
  @HiveField(5)
  double collectQty;
  
  @HiveField(6)
  String outtaskitemid;
  
  @HiveField(7)
  String taskid;
  
  @HiveField(8)
  String storeRoom;
  
  @HiveField(9)
  String storeSite;
  
  @HiveField(10)
  String erpStore;
  
  @HiveField(11)
  String trayNo;

  CollectionStock({
    required this.stockid,
    required this.matcode,
    required this.batchno,
    required this.sn,
    required this.taskQty,
    required this.collectQty,
    required this.outtaskitemid,
    required this.taskid,
    required this.storeRoom,
    required this.storeSite,
    required this.erpStore,
    required this.trayNo,
  });
}

enum ScanStep {
  qrcode,
  site,
  quantity
}

enum MtlCheckMode {
  mtl,
  mtlBatch,
  mtlSite,
  mtlBatchSite
}

class CollectionState {
  final List<OutTaskItem> detailList;
  final List<OutTaskItem> collectionList;
  final List<CollectionStock> stocks;
  final BarcodeContent? currentBarcode;
  final String storeSite;
  final double repQty;
  final double collectQty;
  final String placeholder;
  final bool isLoading;
  final String? error;
  final int currentTab;
  final List<String> checkedIds;
  final Map<String, List<double>> dicMtlQty;
  final Map<String, String> dicSeq;
  final Map<String, double> dicInvMtlQty;
  final String matCode;
  final String batchNo;
  final String sn;
  final String matControlFlag;
  final String erpRoom;
  final String erpStoreInv;
  final MtlCheckMode mtlCheckMode;
  final String roomMatControl;
  final String matSendControl;
  final bool focus;

  const CollectionState({
    this.detailList = const [],
    this.collectionList = const [],
    this.stocks = const [],
    this.currentBarcode,
    this.storeSite = '',
    this.repQty = 0,
    this.collectQty = 0,
    this.placeholder = '请扫描库位',
    this.isLoading = false,
    this.error,
    this.currentTab = 0,
    this.checkedIds = const [],
    this.dicMtlQty = const {},
    this.dicSeq = const {},
    this.dicInvMtlQty = const {},
    this.matCode = '',
    this.batchNo = '',
    this.sn = '',
    this.matControlFlag = '',
    this.erpRoom = '',
    this.erpStoreInv = '',
    this.mtlCheckMode = MtlCheckMode.mtl,
    this.roomMatControl = '0',
    this.matSendControl = '0',
    this.focus = false,
  });

  CollectionState copyWith({
    List<OutTaskItem>? detailList,
    List<OutTaskItem>? collectionList,
    List<CollectionStock>? stocks,
    BarcodeContent? currentBarcode,
    String? storeSite,
    double? repQty,
    double? collectQty,
    String? placeholder,
    bool? isLoading,
    String? error,
    int? currentTab,
    List<String>? checkedIds,
    Map<String, List<double>>? dicMtlQty,
    Map<String, String>? dicSeq,
    Map<String, double>? dicInvMtlQty,
    String? matCode,
    String? batchNo,
    String? sn,
    String? matControlFlag,
    String? erpRoom,
    String? erpStoreInv,
    MtlCheckMode? mtlCheckMode,
    String? roomMatControl,
    String? matSendControl,
    bool? focus,
  }) {
    return CollectionState(
      detailList: detailList ?? this.detailList,
      collectionList: collectionList ?? this.collectionList,
      stocks: stocks ?? this.stocks,
      currentBarcode: currentBarcode ?? this.currentBarcode,
      storeSite: storeSite ?? this.storeSite,
      repQty: repQty ?? this.repQty,
      collectQty: collectQty ?? this.collectQty,
      placeholder: placeholder ?? this.placeholder,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentTab: currentTab ?? this.currentTab,
      checkedIds: checkedIds ?? this.checkedIds,
      dicMtlQty: dicMtlQty ?? this.dicMtlQty,
      dicSeq: dicSeq ?? this.dicSeq,
      dicInvMtlQty: dicInvMtlQty ?? this.dicInvMtlQty,
      matCode: matCode ?? this.matCode,
      batchNo: batchNo ?? this.batchNo,
      sn: sn ?? this.sn,
      matControlFlag: matControlFlag ?? this.matControlFlag,
      erpRoom: erpRoom ?? this.erpRoom,
      erpStoreInv: erpStoreInv ?? this.erpStoreInv,
      mtlCheckMode: mtlCheckMode ?? this.mtlCheckMode,
      roomMatControl: roomMatControl ?? this.roomMatControl,
      matSendControl: matSendControl ?? this.matSendControl,
      focus: focus ?? this.focus,
    );
  }
}

// lib/modules/outbound/collection_task/bloc/collection_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/collection_models.dart';
import '../services/collection_service.dart';

class CollectionBloc extends Cubit<CollectionState> {
  final CollectionService _service;
  late Box _cacheBox;
  
  String _taskNo = '';
  String _taskId = '';
  String _storeRoom = '';
  String _taskComment = '';
  String _workStation = '';
  String _siteFlag = 'Y';
  String _batchFlag = 'Y';

  CollectionBloc(this._service) : super(const CollectionState()) {
    _initHive();
  }

  Future<void> _initHive() async {
    _cacheBox = await Hive.openBox('collection_cache');
  }

  void initialize(Map<String, dynamic> taskData) {
    _taskNo = taskData['outtaskno'] ?? '';
    _taskId = taskData['outtaskid'] ?? '';
    _storeRoom = taskData['storeroomno'] ?? '';
    _taskComment = taskData['taskcomment'] ?? '';
    _workStation = taskData['workstation'] ?? '';
    _siteFlag = 'Y';
    _batchFlag = 'Y';
    
    loadTaskList();
    _restoreFromCache();
  }

  Future<void> loadTaskList() async {
    try {
      emit(state.copyWith(isLoading: true));
      
      final response = await _service.getOutTaskCollitemList({
        'outtaskno': _taskNo,
        'storeroomno': _storeRoom,
        'forcesite': '',
        'forcebatch': '',
        'taskcomment': _taskComment,
        'taskFinishFlag': '0',
        'roomtag': '0',
        'workstation': _workStation,
        'finshFlg': '0',
        'sortType': '',
        'sortColumn': '',
        'searchKey': '',
        'beatflag': 'N',
      });

      if (response['msg'] != null && response['code'] != '200') {
        emit(state.copyWith(
          isLoading: false,
          error: response['msg']
        ));
        return;
      }

      final List<OutTaskItem> detailList = (response['data'] as List)
          .map((item) => OutTaskItem.fromJson(item))
          .toList();

      // 获取物料控制信息
      final controlResponse = await _service.getRoomMatControl(_taskId);
      String roomMatControl = '0';
      if (controlResponse['code'] == '200') {
        final roomMtlInfo = controlResponse['msg'].split('!');
        if (roomMtlInfo.length > 4 && roomMtlInfo[4].isNotEmpty) {
          roomMatControl = roomMtlInfo[4];
        }
      }

      // 确定检查模式
      MtlCheckMode mtlCheckMode;
      if (_siteFlag == 'Y' && _batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlBatchSite;
      } else if (_siteFlag == 'Y' && _batchFlag != 'Y') {
        mtlCheckMode = MtlCheckMode.mtlSite;
      } else if (_siteFlag != 'Y' && _batchFlag == 'Y') {
        mtlCheckMode = MtlCheckMode.mtlBatch;
      } else {
        mtlCheckMode = MtlCheckMode.mtl;
      }

      emit(state.copyWith(
        detailList: detailList,
        isLoading: false,
        roomMatControl: roomMatControl,
        mtlCheckMode: mtlCheckMode,
      ));

      // 缓存数据
      await _cacheBox.put('detailList', detailList.map((e) => e.toMap()).toList());
      await _cacheBox.put('updateFlag', '0');

      if (detailList.isEmpty) {
        emit(state.copyWith(error: '当前任务列表没有待处理任务！'));
      }

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: '加载任务失败：${e.toString()}'
      ));
    }
  }

  Future<void> _restoreFromCache() async {
    try {
      final updateFlag = _cacheBox.get('updateFlag', defaultValue: '0');
      if (updateFlag == '1') {
        // 从缓存恢复数据
        final cachedDetailList = _cacheBox.get('detailList', defaultValue: <Map>[]);
        final cachedStocks = _cacheBox.get('stocks', defaultValue: <Map>[]);
        final cachedDicSeq = Map<String, String>.from(
          _cacheBox.get('dicSeq', defaultValue: <String, String>{}));
        final cachedDicMtlQty = Map<String, List<double>>.from(
          _cacheBox.get('dicMtlQty', defaultValue: <String, List<double>>{}));
        final cachedDicInvMtlQty = Map<String, double>.from(
          _cacheBox.get('dicInvMtlQty', defaultValue: <String, double>{}));

        final detailList = cachedDetailList
            .map<OutTaskItem>((item) => OutTaskItem.fromJson(Map<String, dynamic>.from(item)))
            .toList();
        final stocks = cachedStocks
            .map<CollectionStock>((item) => CollectionStock.fromJson(Map<String, dynamic>.from(item)))
            .toList();

        emit(state.copyWith(
          detailList: detailList,
          stocks: stocks,
          dicSeq: cachedDicSeq,
          dicMtlQty: cachedDicMtlQty,
          dicInvMtlQty: cachedDicInvMtlQty,
        ));

        updateCollectionList(state.storeSite);
        await _cacheBox.put('updateFlag', '0');
      }
    } catch (e) {
      emit(state.copyWith(error: '恢复缓存数据失败：${e.toString()}'));
    }
  }

  void updateCollectionList(String storeSite) {
    if (storeSite.isEmpty) return;
    
    final collectionList = state.detailList
        .where((item) => item.storesiteno == storeSite)
        .toList();
    
    final newTab = collectionList.isEmpty ? 0 : 1;
    
    emit(state.copyWith(
      collectionList: collectionList,
      currentTab: newTab,
    ));
  }

  void changeTab(int index) {
    emit(state.copyWith(currentTab: index));
  }

  void toggleItemSelection(String itemId, bool selected) {
    final checkedIds = List<String>.from(state.checkedIds);
    if (selected) {
      if (!checkedIds.contains(itemId)) {
        checkedIds.add(itemId);
      }
    } else {
      checkedIds.remove(itemId);
    }
    emit(state.copyWith(checkedIds: checkedIds));
  }

  void toggleAllSelection(bool selected) {
    final List<String> checkedIds;
    if (selected) {
      checkedIds = state.detailList.map((item) => item.outtaskitemid).toList();
    } else {
      checkedIds = [];
    }
    emit(state.copyWith(checkedIds: checkedIds));
  }

  Future<void> performBarcode(String barcode) async {
    if (barcode.isEmpty) {
      emit(state.copyWith(error: '采集内容为空,请重新采集'));
      return;
    }

    try {
      ScanStep currentStep;
      
      // 判断扫码内容类型
      if (barcode.contains('MC')) {
        currentStep = ScanStep.qrcode;
      } else if (barcode.contains('\$KW\$')) {
        currentStep = ScanStep.site;
      } else if (_isNumeric(barcode)) {
        currentStep = ScanStep.quantity;
      } else {
        emit(state.copyWith(error: '采集内容不合法！'));
        return;
      }

      switch (currentStep) {
        case ScanStep.qrcode:
          await _handleQRCode(barcode);
          break;
        case ScanStep.site:
          await _handleSite(barcode);
          break;
        case ScanStep.quantity:
          await _handleQuantity(double.parse(barcode));
          break;
      }

      final placeholder = await _getPlaceMessage();
      if (placeholder.isEmpty) {
        // 所有扫码步骤完成，处理数量
        await _dealQuantity(state.collectQty, state.matControlFlag);
      }

      emit(state.copyWith(placeholder: placeholder));

    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      _initializeCollect();
    }
  }

  Future<void> _handleQRCode(String barcode) async {
    // 解析二维码
    final response = await _service.getMaterialInfoByQR(barcode);
    if (response['code'] != '200' || response['data'] == null) {
      throw Exception('物料条码识别出现问题！');
    }

    final barcodeContent = BarcodeContent.fromJson(response['data']);
    final newmarttask = barcodeContent.id_old;
    final matControl = barcodeContent.seqctrl;

    // 获取物料控制信息
    final matControlResponse = await _service.getMatControl(barcodeContent.matcode);
    String matSendControl = '0';
    if (matControlResponse['code'] == '200') {
      final mtlInfo = matControlResponse['msg'].split('!');
      if (mtlInfo.length > 4 && mtlInfo[4].isNotEmpty) {
        matSendControl = mtlInfo[4];
      }
    }

    // 验证序列号和批次
    await _validateMaterialControl(barcodeContent, newmarttask, matControl, matSendControl);

    emit(state.copyWith(
      currentBarcode: barcodeContent,
      matCode: barcodeContent.matcode,
      batchNo: barcodeContent.batchno,
      sn: barcodeContent.sn,
      matControlFlag: matControl,
      matSendControl: matSendControl,
      collectQty: matControl == '0' ? 1 : 0,
    ));

    // 检查库存
    await _checkInventory(0, state.storeSite);
    updateCollectionList(state.storeSite);
  }

  Future<void> _validateMaterialControl(
    BarcodeContent barcodeContent,
    String newmarttask,
    String matControl,
    String matSendControl,
  ) async {
    if (newmarttask == '0') {
      // 新格式条码验证
      if (matControl == '0') {
        if (barcodeContent.sn.isEmpty) {
          throw Exception('物料【${barcodeContent.matcode}】序列号不能为空');
        }

        final seqKey = '${barcodeContent.matcode}@${barcodeContent.sn}';
        if (state.dicSeq.containsKey(seqKey)) {
          throw Exception('物料【${barcodeContent.matcode}】序列号【${barcodeContent.sn}】不允许重复采集，请确认');
        }

        // 检查已采集的序列号
        final existsInStocks = state.stocks.any((stock) => stock.sn == barcodeContent.sn);
        if (existsInStocks) {
          throw Exception(
              '采集物料【${barcodeContent.matcode}】序列号【${barcodeContent.sn}】库位【${state.storeSite}】已经采集,不允许重复采集!');
        }
      }

      if (matControl == '1' || matControl == '2') {
        if ((matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1') {
          await _checkMaterial(barcodeContent.matcode, barcodeContent.batchno, state.storeSite);
        }
        await _checkMaterialSite(barcodeContent.matcode, barcodeContent.batchno, state.storeSite);
      } else if (matControl != '0' && matControl != '1' && matControl != '2') {
        throw Exception('物料${barcodeContent.matcode}编码控制维护值维护不合法');
      }
    } else {
      // 旧格式条码验证
      if (matControl == '0') {
        if (barcodeContent.sn.isEmpty) {
          throw Exception('物料【${barcodeContent.matcode}】的序列号为空，不允许采集，请确认');
        }

        final seqKey = '${barcodeContent.matcode}@${barcodeContent.sn}';
        if (state.dicSeq.containsKey(seqKey)) {
          throw Exception('物料【${barcodeContent.matcode}】序列号【${barcodeContent.sn}】不允许重复采集，请确认');
        }
      } else if (matControl == '1' || matControl == '2') {
        if (barcodeContent.batchno.isEmpty) {
          throw Exception('物料【${barcodeContent.matcode}】批次号不能为空');
        }

        if ((matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1') {
          await _checkMaterial(barcodeContent.matcode, barcodeContent.batchno, state.storeSite);
        }
        await _checkMaterialSite(barcodeContent.matcode, barcodeContent.batchno, state.storeSite);
      } else {
        throw Exception('物料${barcodeContent.matcode}编码控制维护值维护不合法');
      }
    }
  }

  Future<void> _checkMaterial(String matcode, String batchno, String storeSite) async {
    bool batchFound = false;
    String erpRoom = '';

    // 在任务明细中查找物料
    for (final item in state.detailList) {
      if (item.matcode == matcode && item.storesiteno == storeSite && item.hintbatchno == batchno) {
        erpRoom = item.subinventoryCode;
        batchFound = true;
        break;
      }
    }

    if (!batchFound) {
      for (final item in state.detailList) {
        if (item.matcode == matcode && item.storesiteno == storeSite) {
          erpRoom = item.subinventoryCode;
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

  Future<void> _checkMaterialSite(String matcode, String batchno, String storeSite) async {
    if (state.matControlFlag == '0') return;

    bool matFind = false;
    String erpRoom = '';

    // 根据控制模式检查物料
    for (final item in state.detailList) {
      bool matches = false;

      switch (state.mtlCheckMode) {
        case MtlCheckMode.mtlBatchSite:
          matches = item.matcode == matcode &&
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
        erpRoom = item.subinventoryCode;
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

  Future<void> _handleSite(String barcode) async {
    final parts = barcode.split('\$');
    if (parts.length < 3) {
      throw Exception('库位格式不正确');
    }

    final siteCode = parts[2];

    // 验证库位
    final response = await _service.getStoreSite(_storeRoom, siteCode);
    if (response['code'] != '200') {
      throw Exception(response['msg'] ?? '库位验证失败');
    }

    final siteList = response['data'] as List;
    if (siteList.isEmpty) {
      throw Exception('库房【$_storeRoom】下无库位号【$siteCode】');
    }

    if (siteList[0]['isfrozen'] != '0') {
      throw Exception('库位【$siteCode】被锁定或者冻结');
    }

    // 检查物料和库位匹配
    if ((state.matSendControl == '0' && state.roomMatControl == '0') || 
        state.roomMatControl == '1') {
      await _checkMaterialSite(state.matCode, state.batchNo, siteCode);
    }

    emit(state.copyWith(storeSite: siteCode));

    // 检查库存
    await _checkInventory(0, siteCode);
    updateCollectionList(siteCode);
  }

  Future<void> _handleQuantity(double quantity) async {
    if (state.sn.isNotEmpty) {
      throw Exception('已采集序列号无需采集数量，请扫描二维码');
    }

    emit(state.copyWith(collectQty: quantity));
  }

  Future<void> _checkInventory(double collectQty, String storeSite) async {
    if (state.matCode.isEmpty || storeSite.isEmpty) return;

    List<dynamic> repertoryList = [];
    double repQty = 0;

    if (state.matControlFlag == '1' || state.matControlFlag == '2') {
      // 批次管理的库存查询
      final response = await _service.getRepertoryByStoreSiteNo(
        storeSite, 
        state.matCode, 
        state.erpRoom, 
        state.batchNo, 
        state.sn
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
            if (item['erpStoreroom'] == state.erpRoom && item['batchno'] == state.batchNo) {
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

        if (drcheck.isEmpty) {
          throw Exception('物料【${state.matCode}】批次【${state.batchNo}】在库位【$storeSite】不存在，请确认');
        }

        if (repertoryList.isEmpty) {
          throw Exception('物料【${state.matCode}】批次【${state.batchNo}】 在库位【$storeSite】不存在，请确认');
        }

        // 检查子库一致性
        if (state.erpRoom.isNotEmpty && repertoryList.isNotEmpty) {
          final erpStoreInv = repertoryList[0]['erpStoreroom'];
          if (erpStoreInv != state.erpRoom) {
            throw Exception('当前物料明细指定子库【${state.erpRoom}】与当前库位的物料批次子库【$erpStoreInv】存在不一致，请确认');
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
        null
      );

      if (responseSn['code'] == '200') {
        repertoryList = responseSn['data'];
        if (repertoryList.isNotEmpty) {
          repQty = double.parse(repertoryList[0]['repqty']?.toString() ?? '0');
        }

        if (repQty <= 0) {
          throw Exception('物料【${state.matCode}】批次【${state.batchNo}】序列【${state.sn}】 在库位【$storeSite】不存在，请确认');
        }

        // 根据ERP子库查询
        if (state.erpRoom.isNotEmpty) {
          final responseErp = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            state.matCode,
            state.erpRoom,
            state.batchNo,
            state.sn
          );
          if (responseErp['code'] == '200') {
            final erpList = responseErp['data'] as List;
            if (erpList.isNotEmpty) {
              repqtySum31 = double.parse(erpList[0]['repqty']?.toString() ?? '0');
            }
          }
          repQty = repqtySum31;
        } else {
          final responseBatch = await _service.getRepertoryByStoreSiteNoSn(
            storeSite,
            state.matCode,
            null,
            state.batchNo,
            state.sn
          );
          if (responseBatch['code'] == '200') {
            final batchList = responseBatch['data'] as List;
            if (batchList.isNotEmpty) {
              repqtySum41 = double.parse(batchList[0]['repqty']?.toString() ?? '0');
            }
          }
          repQty = repqtySum41;
        }

        if (repqtySum31 <= 0 && repqtySum41 <= 0) {
          throw Exception('物料【${state.matCode}】批次【${state.batchNo}】序列【${state.sn}】在库位【$storeSite】不存在，请确认');
        }

        // 获取ERP子库信息
        final erpResponse = await _service.getRepertoryByStoreSiteNoErp(storeSite, state.matCode);
        if (erpResponse['code'] == '200') {
          final erpList = erpResponse['data'] as List;
          if (erpList.isNotEmpty) {
            final erpStoreInv = erpList[0]['erpStoreroom'];
            if (state.erpRoom.isNotEmpty && erpStoreInv != state.erpRoom) {
              throw Exception('当前物料明细指定子库【${state.erpRoom}】与当前库位的物料批次子库【$erpStoreInv】存在不一致，请确认');
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
    if (state.currentBarcode?.matcode?.isEmpty ?? true) {
      return '请扫描二维码';
    }
    if (state.currentBarcode?.sn == null && state.collectQty == 0) {
      return '请输入数量';
    }
    return '';
  }

  Future<void> _dealQuantity(double qty, String matFlag) async {
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
    final strKey = '${state.storeSite}${state.matCode}${matFlagInt == 0 ? state.sn : state.batchNo}';
    final decRepqty = state.dicInvMtlQty[strKey] ?? 0;
    if (state.repQty - decRepqty < qty) {
      throw Exception(
          '库位【${state.storeSite}】物料【${state.matCode}】的库存【${state.repQty - decRepqty}】小于本次移出库存【$qty】，请确认');
    }

    // 统计当前物料总计划数和总扫描数 - 第一次遍历
    double totalTaskQty = 0;
    double totalTmpQty = 0;

    for (final item in state.detailList) {
      if (item.matcode != state.matCode) continue;

      bool shouldInclude = true;
      if ((matFlagInt == 1 || matFlagInt == 2) &&
          ((state.matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1')) {
        switch (state.mtlCheckMode) {
          case MtlCheckMode.mtlBatch:
            shouldInclude = item.hintbatchno == state.batchNo;
            break;
          case MtlCheckMode.mtlBatchSite:
            shouldInclude = item.hintbatchno == state.batchNo && item.storesiteno == state.storeSite;
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
      if (!newDicMtlQty.containsKey(item.outtaskitemid)) {
        newDicMtlQty[item.outtaskitemid] = [tmpQty, 0];
      }

      final availableQty = taskQty - tmpQty;
      final allocatedQty = remainingQty >= availableQty ? availableQty : remainingQty;
      
      // 更新采集数量
      updatedDetailList[i] = OutTaskItem(
        outtaskitemid: item.outtaskitemid,
        matcode: item.matcode,
        matname: item.matname,
        storesiteno: item.storesiteno,
        hintqty: item.hintqty,
        collectedqty: tmpQty + allocatedQty,
        repqty: availableQty == allocatedQty ? currentRepQty - allocatedQty : currentRepQty - (taskQty - tmpQty),
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
      dicMtlOperation[item.outtaskitemid] = [taskQty, allocatedQty];
      remainingQty -= allocatedQty;
      existFlag = true;

      // 更新dicMtlQty
      newDicMtlQty[item.outtaskitemid] = [tmpQty, tmpQty + allocatedQty];
    }

    // 验证是否成功分配
    if ((state.matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1') {
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

    emit(state.copyWith(
      detailList: updatedDetailList,
      dicSeq: newDicSeq,
      dicMtlQty: newDicMtlQty,
      dicInvMtlQty: newDicInvMtlQty,
    ));

    updateCollectionList(state.storeSite);

    // 添加采集记录
    await _addCollectData(state.matCode, state.batchNo, sn, qty, _storeRoom, 
                         state.storeSite, dicMtlOperation, state.erpStoreInv, '');
    await _localSave();
    _initializeCollect();
  }

  bool _shouldProcessItemForAllocation(OutTaskItem item, int matFlag) {
    // 物料不匹配
    if (item.matcode != state.matCode) return false;
    
    // 对于序列号控制的物料，需要同时匹配物料和库位
    if (matFlag == 0) {
      return item.matcode == state.matCode && item.storesiteno == state.storeSite;
    }

    // 对于批次控制的物料
    if ((matFlag == 1 || matFlag == 2) &&
        ((state.matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1')) {
      
      // 必须匹配物料和库位
      if (item.matcode != state.matCode || item.storesiteno != state.storeSite) {
        return false;
      }

      // 根据检查模式进一步验证
      switch (state.mtlCheckMode) {
        case MtlCheckMode.mtlBatch:
          return item.hintbatchno == state.batchNo;
        case MtlCheckMode.mtlBatchSite:
          return item.hintbatchno == state.batchNo && item.storesiteno == state.storeSite;
        case MtlCheckMode.mtlSite:
          return item.storesiteno == state.storeSite;
        case MtlCheckMode.mtl:
          return true;
      }
    }

    return true;
  }hintbatchno,
        sn: item.sn,
        storeroomno: item.storeroomno,
        subinventoryCode: item.subinventoryCode,
        orderno: item.orderno,
        matinnercode: item.matinnercode,
      );

      // 记录分配操作
      dicMtlOperation[item.outtaskitemid] = [item.hintqty, allocatedQty];
      remainingQty -= allocatedQty;

      // 更新dicMtlQty
      final newDicMtlQty = Map<String, List<double>>.from(state.dicMtlQty);
      newDicMtlQty[item.outtaskitemid] = [item.collectedqty, item.collectedqty + allocatedQty];
    }

    // 验证是否成功分配
    bool existFlag = dicMtlOperation.isNotEmpty;
    if ((state.matSendControl == '0' && state.roomMatControl == '0') || state.roomMatControl == '1') {
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

    emit(state.copyWith(
      detailList: updatedDetailList,
      dicSeq: newDicSeq,
      dicInvMtlQty: newDicInvMtlQty,
    ));

    updateCollectionList(state.storeSite);

    // 添加采集记录
    await _addCollectData(state.matCode, state.batchNo, sn, qty, _storeRoom, 
                         state.storeSite, dicMtlOperation, state.erpStoreInv, '');
    await _localSave();
    _initializeCollect();
  }

  bool _shouldProcessItem(OutTaskItem item, int matFlag) {
    if (item.matcode != state.matCode) return false;
    
    if (matFlag != 0 && ((state.matSendControl == '0' && state.roomMatControl == '0') || 
                        state.roomMatControl == '1')) {
      if (item.matcode != state.matCode || item.storesiteno != state.storeSite) {
        return false;
      }
    }

    if (item.hintqty == item.collectedqty) return false;

    switch (matFlag) {
      case 0:
        return true;
      case 1:
      case 2:
        if ((state.matSendControl == '0' && state.roomMatControl == '0') || 
            state.roomMatControl == '1') {
          switch (state.mtlCheckMode) {
            case MtlCheckMode.mtlBatch:
              return item.hintbatchno == state.batchNo;
            case MtlCheckMode.mtlBatchSite:
              return item.hintbatchno == state.batchNo && item.storesiteno == state.storeSite;
            case MtlCheckMode.mtlSite:
              return item.storesiteno == state.storeSite;
            case MtlCheckMode.mtl:
              return true;
          }
        }
        return true;
      default:
        return false;
    }
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
        taskid: _taskId,
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
    await _cacheBox.put('detailList', state.detailList.map((e) => e.toMap()).toList());
    await _cacheBox.put('stocks', state.stocks.map((e) => e.toMap()).toList());
    await _cacheBox.put('dicSeq', state.dicSeq);
    await _cacheBox.put('dicMtlQty', state.dicMtlQty);
    await _cacheBox.put('dicInvMtlQty', state.dicInvMtlQty);
    await _cacheBox.put('updateFlag', '1');
  }

  void _initializeCollect() {
    emit(state.copyWith(
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
    ));
  }

  bool _isNumeric(String str) {
    return RegExp(r'^[0-9]+(\.[0-9]+)?).hasMatch(str);
  }

  Future<void> commitCollection() async {
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
        tmpMat = item.matcode;
        tmpStore = item.storesiteno;
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
      await _performCommit();

    } catch (e) {
      emit(state.copyWith(error: '平库出库采集异常：${e.toString()}'));
    }
  }

  Future<void> _performCommit() async {
    try {
      emit(state.copyWith(isLoading: true));

      // 再次校验采集数据
      final collectStocks = state.stocks;
      if (collectStocks.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      // 生成下架信息列表
      final downShelvesInfosList = collectStocks.map((stock) => {
        'taskNo': _taskNo,
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
      }).toList();

      // 生成任务项列表
      final lsItems = <Map<String, dynamic>>[];
      for (final entry in state.dicMtlQty.entries) {
        final itemListInfo = <String, dynamic>{};
        final mtlQty = entry.value;
        itemListInfo['mtlQty'] = mtlQty;
        itemListInfo['outTaskItemid'] = entry.key;
        
        // 查找物料编码
        final taskItem = state.detailList.firstWhere(
          (item) => item.outtaskitemid == entry.key,
          orElse: () => OutTaskItem(
            outtaskitemid: '', matcode: '', matname: '', storesiteno: '',
            hintqty: 0, collectedqty: 0, repqty: 0, hintbatchno: '',
            sn: '', storeroomno: '', subinventoryCode: '', orderno: '', matinnercode: ''
          ),
        );
        itemListInfo['mtlCode'] = taskItem.matcode;
        
        lsItems.add(itemListInfo);
      }

      if (lsItems.isEmpty) {
        throw Exception('本次无采集明细，请确认！');
      }

      final response = await _service.commitDownShelves(downShelvesInfosList, lsItems);

      if (response['code'] == '200') {
        // 清理缓存
        await _clearCache();
        emit(state.copyWith(
          isLoading: false,
          stocks: [],
          detailList: [],
          dicSeq: {},
          dicMtlQty: {},
          dicInvMtlQty: {},
        ));
        
        // 显示成功提示
        // 在实际应用中应该显示成功对话框并导航回上一页
        // Navigator.of(context).pop();
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: response['msg'] ?? '提交失败'
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: '平库出库采集异常：${e.toString()}'
      ));
    }
  }

  Future<void> reportShortage() async {
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
        (item) => item.outtaskitemid == state.checkedIds.first
      );

      final response = await _service.commitFinishOutTaskItem(selectedItem.outtaskitemid);
      
      if (response['code'] == '200') {
        // 重新加载任务列表
        await loadTaskList();
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

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void setFocus(bool focus) {
    emit(state.copyWith(focus: focus));
  }
}

// lib/modules/outbound/collection_task/services/collection_service.dart
import 'package:dio/dio.dart';

class CollectionService {
  final Dio _dio;
  
  CollectionService(this._dio);

  Future<Map<String, dynamic>> getOutTaskCollitemList(Map<String, dynamic> params) async {
    final response = await _dio.get('/system/terminal/outTaskitemList', queryParameters: params);
    return response.data;
  }

  Future<Map<String, dynamic>> getRoomMatControl(String taskId) async {
    final response = await _dio.get('/system/terminal/getRoomMatControl', queryParameters: {'taskId': taskId});
    return response.data;
  }

  Future<Map<String, dynamic>> getMaterialInfoByQR(String barcode) async {
    final response = await _dio.get('/system/terminal/getPmMaterialInfoByQR', queryParameters: {'barcode': barcode});
    return response.data;
  }

  Future<Map<String, dynamic>> getMatControl(String matcode) async {
    final response = await _dio.get('/system/terminal/getMatControl', queryParameters: {'matCode': matcode});
    return response.data;
  }

  Future<Map<String, dynamic>> getStoreSite(String storeRoomNo, String storeSiteNo) async {
    final response = await _dio.get('/system/terminal/getStoreSite', queryParameters: {
      'storeRoomNo': storeRoomNo,
      'storeSiteNo': storeSiteNo,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNo(
    String storesiteno, 
    String matcode, 
    String? erpStoreroom, 
    String? batchno, 
    String? sn
  ) async {
    final response = await _dio.get('/system/terminal/getRepertoryByStoresiteNo', queryParameters: {
      'storesiteno': storesiteno,
      'matcode': matcode,
      if (erpStoreroom != null) 'erpStoreroom': erpStoreroom,
      if (batchno != null) 'batchno': batchno,
      if (sn != null) 'sn': sn,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoSn(
    String storesiteno,
    String matcode,
    String? erpStoreroom,
    String? batchno,
    String? sn
  ) async {
    final response = await _dio.get('/system/terminal/getRepertoryByStoresiteNosn', queryParameters: {
      'storesiteno': storesiteno,
      'matcode': matcode,
      if (erpStoreroom != null) 'erpStoreroom': erpStoreroom,
      if (batchno != null) 'batchno': batchno,
      if (sn != null) 'sn': sn,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoErp(String storesiteno, String matcode) async {
    final response = await _dio.get('/system/terminal/getRepertoryByStoresiteNoErp', queryParameters: {
      'storesiteno': storesiteno,
      'matcode': matcode,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> commitDownShelves(
    List<Map<String, dynamic>> downShelvesInfos,
    List<Map<String, dynamic>> itemListInfos
  ) async {
    final response = await _dio.post('/system/terminal/commitDownShelves', data: {
      'downShelvesInfos': downShelvesInfos,
      'itemListInfos': itemListInfos,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> commitFinishOutTaskItem(String outtaskitemid) async {
    final response = await _dio.post('/system/terminal/commitFinishOutTaskItem', data: {
      'outtaskitemid': outtaskitemid,
    });
    return response.data;
  }
}

// lib/modules/outbound/collection_task/widgets/task_table_widget.dart
import 'package:flutter/material.dart';
import '../models/collection_models.dart';

class TaskTableWidget extends StatelessWidget {
  final List<OutTaskItem> items;
  final List<String> checkedIds;
  final Function(String, bool) onItemCheck;
  final Function(bool) onSelectAll;
  final bool showSelection;

  const TaskTableWidget({
    Key? key,
    required this.items,
    required this.checkedIds,
    required this.onItemCheck,
    required this.onSelectAll,
    this.showSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: showSelection,
        columns: const [
          DataColumn(label: Text('物料编码')),
          DataColumn(label: Text('库位')),
          DataColumn(label: Text('任务数量')),
          DataColumn(label: Text('采集数量')),
          DataColumn(label: Text('结余库存')),
          DataColumn(label: Text('批次')),
          DataColumn(label: Text('序列')),
          DataColumn(label: Text('库房')),
          DataColumn(label: Text('子库')),
          DataColumn(label: Text('物料名称')),
        ],
        rows: items.map((item) {
          final isSelected = checkedIds.contains(item.outtaskitemid);
          return DataRow(
            selected: isSelected,
            onSelectChanged: showSelection ? (selected) {
              onItemCheck(item.outtaskitemid, selected ?? false);
            } : null,
            cells: [
              DataCell(Text(item.matcode)),
              DataCell(Text(item.storesiteno)),
              DataCell(Text(item.hintqty.toString())),
              DataCell(Text(item.collectedqty.toString())),
              DataCell(Text(item.repqty.toString(), 
                style: const TextStyle(color: Colors.blue))),
              DataCell(Text(item.hintbatchno)),
              DataCell(Text(item.sn)),
              DataCell(Text(item.storeroomno)),
              DataCell(Text(item.subinventoryCode)),
              DataCell(Text(item.matname)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// lib/modules/outbound/collection_task/widgets/collection_input_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CollectionInputWidget extends StatefulWidget {
  final String placeholder;
  final bool focus;
  final Function(String) onSubmitted;

  const CollectionInputWidget({
    Key? key,
    required this.placeholder,
    required this.focus,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<CollectionInputWidget> createState() => _CollectionInputWidgetState();
}

class _CollectionInputWidgetState extends State<CollectionInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(CollectionInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focus && !oldWidget.focus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z@$\.\-_]')),
        ],
        decoration: InputDecoration(
          hintText: widget.placeholder,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
            },
          ),
        ),
        onSubmitted: (value) {
          widget.onSubmitted(value);
          _controller.clear();
        },
      ),
    );
  }
}

// lib/modules/outbound/collection_task/widgets/collection_info_widget.dart
import 'package:flutter/material.dart';
import '../models/collection_models.dart';

class CollectionInfoWidget extends StatelessWidget {
  final String storeSite;
  final double repQty;
  final BarcodeContent? barcodeContent;
  final double collectQty;

  const CollectionInfoWidget({
    Key? key,
    required this.storeSite,
    required this.repQty,
    this.barcodeContent,
    required this.collectQty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('库位:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(storeSite.isEmpty ? '-' : storeSite),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('库存:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(repQty.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('物料:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.matcode ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('采集数量:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(collectQty.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('名称:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.matname ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('批次:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(barcodeContent?.batchno ?? '-'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text('序列:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(barcodeContent?.sn ?? '-')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// lib/modules/outbound/collection_task/outbound_collection_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'bloc/collection_bloc.dart';
import 'models/collection_models.dart';
import 'widgets/collection_input_widget.dart';
import 'widgets/collection_info_widget.dart';
import 'widgets/task_table_widget.dart';

class OutboundCollectionPage extends StatefulWidget {
  final Map<String, dynamic> taskData;

  const OutboundCollectionPage({
    Key? key,
    required this.taskData,
  }) : super(key: key);

  @override
  State<OutboundCollectionPage> createState() => _OutboundCollectionPageState();
}

class _OutboundCollectionPageState extends State<OutboundCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<CollectionBloc>().initialize(widget.taskData);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('平库下架采集'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBackPress(context),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'exception',
                child: Text('异常采集'),
              ),
              const PopupMenuItem(
                value: 'shortage',
                child: Text('报缺'),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<CollectionBloc, CollectionState>(
        listener: (context, state) {
          if (state.error != null) {
            _showErrorDialog(context, state.error!);
            context.read<CollectionBloc>().clearError();
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // 输入框
              CollectionInputWidget(
                placeholder: state.placeholder,
                focus: state.focus,
                onSubmitted: (value) {
                  context.read<CollectionBloc>().performBarcode(value);
                },
              ),
              // 信息卡片
              CollectionInfoWidget(
                storeSite: state.storeSite,
                repQty: state.repQty,
                barcodeContent: state.currentBarcode,
                collectQty: state.collectQty,
              ),
              // 标签页
              TabBar(
                controller: _tabController,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: '任务列表'),
                  Tab(text: '正在采集'),
                ],
                onTap: (index) {
                  context.read<CollectionBloc>().changeTab(index);
                },
              ),
              // 表格内容
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // 任务列表
                    TaskTableWidget(
                      items: state.detailList,
                      checkedIds: state.checkedIds,
                      onItemCheck: (id, selected) {
                        context.read<CollectionBloc>().toggleItemSelection(id, selected);
                      },
                      onSelectAll: (selected) {
                        context.read<CollectionBloc>().toggleAllSelection(selected);
                      },
                    ),
                    // 正在采集
                    TaskTableWidget(
                      items: state.collectionList,
                      checkedIds: state.checkedIds,
                      onItemCheck: (id, selected) {
                        context.read<CollectionBloc>().toggleItemSelection(id, selected);
                      },
                      onSelectAll: (selected) {
                        context.read<CollectionBloc>().toggleAllSelection(selected);
                      },
                      showSelection: false,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '采集结果',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: '提交',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: '更多',
            ),
          ],
          onTap: (index) => _handleBottomNavTap(context, index),
        );
      },
    );
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // 采集结果 - 可以导航到采集结果页面
        break;
      case 1:
        _showCommitConfirmation(context);
        break;
      case 2:
        _showMoreOptions(context);
        break;
    }
  }

  void _showCommitConfirmation(BuildContext context) {
    final state = context.read<CollectionBloc>().state;
    
    if (state.stocks.isEmpty) {
      _showErrorDialog(context, '本次无采集明细，请确认！');
      return;
    }

    // 检查未完成任务
    String msg = '';
    for (final item in state.detailList) {
      if (item.hintqty != item.collectedqty) {
        msg = '库位【${item.storesiteno}】物料【${item.matcode}】还剩【${item.hintqty - item.collectedqty}】未做，请确认是否提交？';
        break;
      }
    }

    if (msg.isEmpty) {
      msg = '请确认是否提交？';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交确认'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<CollectionBloc>().commitCollection();
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.error_outline),
            title: const Text('异常采集'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'exception');
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('报缺'),
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuAction(context, 'shortage');
            },
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'exception':
        // 导航到异常采集页面
        Modular.to.pushNamed('/exception');
        break;
      case 'shortage':
        _handleShortageAction(context);
        break;
    }
  }

  void _handleShortageAction(BuildContext context) {
    final state = context.read<CollectionBloc>().state;
    
    if (state.stocks.isNotEmpty) {
      _showErrorDialog(context, '采集数据未提交,不允许报缺！');
      return;
    }

    if (state.checkedIds.isEmpty) {
      _showErrorDialog(context, '请至少选择一行记录！');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('物料报缺'),
        content: const Text('请确认是否该采集明细物料报缺？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<CollectionBloc>().reportShortage();
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void _handleBackPress(BuildContext context) {
    final state = context.read<CollectionBloc>().state;
    
    if (state.stocks.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: const Text('当前采集记录尚未提交 确定退出采集吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Modular.to.pop();
              },
              child: const Text('确认'),
            ),
          ],
        ),
      );
    } else {
      Modular.to.pop();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('平库出库采集异常'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }
}

// lib/modules/outbound/collection_task/outbound_collection_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/collection_bloc.dart';
import 'services/collection_service.dart';
import 'outbound_collection_page.dart';

class OutboundCollectionModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.singleton<CollectionService>((i) => CollectionService(i())),
    Bind.factory<CollectionBloc>((i) => CollectionBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      '/',
      child: (context, args) => BlocProvider(
        create: (context) => Modular.get<CollectionBloc>(),
        child: OutboundCollectionPage(
          taskData: args.data ?? {},
        ),
      ),
    ),
  ];
}

// lib/modules/outbound/collection_task/models/collection_models.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutTaskItemAdapter extends TypeAdapter<OutTaskItem> {
  @override
  final int typeId = 0;

  @override
  OutTaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutTaskItem(
      outtaskitemid: fields[0] as String,
      matcode: fields[1] as String,
      matname: fields[2] as String,
      storesiteno: fields[3] as String,
      hintqty: fields[4] as double,
      collectedqty: fields[5] as double,
      repqty: fields[6] as double,
      hintbatchno: fields[7] as String,
      sn: fields[8] as String,
      storeroomno: fields[9] as String,
      subinventoryCode: fields[10] as String,
      orderno: fields[11] as String,
      matinnercode: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OutTaskItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.outtaskitemid)
      ..writeByte(1)
      ..write(obj.matcode)
      ..writeByte(2)
      ..write(obj.matname)
      ..writeByte(3)
      ..write(obj.storesiteno)
      ..writeByte(4)
      ..write(obj.hintqty)
      ..writeByte(5)
      ..write(obj.collectedqty)
      ..writeByte(6)
      ..write(obj.repqty)
      ..writeByte(7)
      ..write(obj.hintbatchno)
      ..writeByte(8)
      ..write(obj.sn)
      ..writeByte(9)
      ..write(obj.storeroomno)
      ..writeByte(10)
      ..write(obj.subinventoryCode)
      ..writeByte(11)
      ..write(obj.orderno)
      ..writeByte(12)
      ..write(obj.matinnercode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutTaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BarcodeContentAdapter extends TypeAdapter<BarcodeContent> {
  @override
  final int typeId = 1;

  @override
  BarcodeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeContent(
      matcode: fields[0] as String,
      matname: fields[1] as String,
      batchno: fields[2] as String,
      sn: fields[3] as String,
      seqctrl: fields[4] as String,
      id_old: fields[5] as String,
      qty: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeContent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.matcode)
      ..writeByte(1)
      ..write(obj.matname)
      ..writeByte(2)
      ..write(obj.batchno)
      ..writeByte(3)
      ..write(obj.sn)
      ..writeByte(4)
      ..write(obj.seqctrl)
      ..writeByte(5)
      ..write(obj.id_old)
      ..writeByte(6)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CollectionStockAdapter extends TypeAdapter<CollectionStock> {
  @override
  final int typeId = 2;

  @override
  CollectionStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionStock(
      stockid: fields[0] as String,
      matcode: fields[1] as String,
      batchno: fields[2] as String,
      sn: fields[3] as String,
      taskQty: fields[4] as double,
      collectQty: fields[5] as double,
      outtaskitemid: fields[6] as String,
      taskid: fields[7] as String,
      storeRoom: fields[8] as String,
      storeSite: fields[9] as String,
      erpStore: fields[10] as String,
      trayNo: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionStock obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.stockid)
      ..writeByte(1)
      ..write(obj.matcode)
      ..writeByte(2)
      ..write(obj.batchno)
      ..writeByte(3)
      ..write(obj.sn)
      ..writeByte(4)
      ..write(obj.taskQty)
      ..writeByte(5)
      ..write(obj.collectQty)
      ..writeByte(6)
      ..write(obj.outtaskitemid)
      ..writeByte(7)
      ..write(obj.taskid)
      ..writeByte(8)
      ..write(obj.storeRoom)
      ..writeByte(9)
      ..write(obj.storeSite)
      ..writeByte(10)
      ..write(obj.erpStore)
      ..writeByte(11)
      ..write(obj.trayNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// 扩展方法
extension OutTaskItemExtension on OutTaskItem {
  Map<String, dynamic> toMap() {
    return {
      'outtaskitemid': outtaskitemid,
      'matcode': matcode,
      'matname': matname,
      'storesiteno': storesiteno,
      'hintqty': hintqty,
      'collectedqty': collectedqty,
      'repqty': repqty,
      'hintbatchno': hintbatchno,
      'sn': sn,
      'storeroomno': storeroomno,
      'subinventoryCode': subinventoryCode,
      'orderno': orderno,
      'matinnercode': matinnercode,
    };
  }
}

extension CollectionStockExtension on CollectionStock {
  Map<String, dynamic> toMap() {
    return {
      'stockid': stockid,
      'matcode': matcode,
      'batchno': batchno,
      'sn': sn,
      'taskQty': taskQty,
      'collectQty': collectQty,
      'outtaskitemid': outtaskitemid,
      'taskid': taskid,
      'storeRoom': storeRoom,
      'storeSite': storeSite,
      'erpStore': erpStore,
      'trayNo': trayNo,
    };
  }

  static CollectionStock fromJson(Map<String, dynamic> json) {
    return CollectionStock(
      stockid: json['stockid'] ?? '',
      matcode: json['matcode'] ?? '',
      batchno: json['batchno'] ?? '',
      sn: json['sn'] ?? '',
      taskQty: double.tryParse(json['taskQty']?.toString() ?? '0') ?? 0,
      collectQty: double.tryParse(json['collectQty']?.toString() ?? '0') ?? 0,
      outtaskitemid: json['outtaskitemid'] ?? '',
      taskid: json['taskid'] ?? '',
      storeRoom: json['storeRoom'] ?? '',
      storeSite: json['storeSite'] ?? '',
      erpStore: json['erpStore'] ?? '',
      trayNo: json['trayNo'] ?? '',
    );
  }
}

// pubspec.yaml dependencies 需要添加:
/*
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  flutter_modular: ^5.0.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  dio: ^5.3.2
  uuid: ^3.0.7

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
*/