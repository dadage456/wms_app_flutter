import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_bloc.dart';
import 'package:wms_app/modules/outbound/collection_task/bloc/collection_state.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_models.dart';
import 'package:wms_app/modules/outbound/collection_task/models/collection_request.dart';
import 'package:wms_app/modules/outbound/collection_task/services/collection_service.dart';

class FakeCollectionService extends CollectionService {
  FakeCollectionService() : super(Dio());

  List<OutTaskItem> detailList = const [];
  String roomMatControl = '0';
  BarcodeContent barcodeContent = BarcodeContent.fromJson({});
  String matControlMessage = '';
  Map<String, dynamic> storeSiteResponse = const {
    'code': 200,
    'data': [
      {'isfrozen': '0'},
    ],
  };
  Map<String, dynamic> repertoryResponse = const {'code': 200, 'data': []};
  Map<String, dynamic> repertorySnResponse = const {'code': 200, 'data': []};
  Map<String, dynamic> repertorySnErpResponse = const {'code': 200, 'data': []};
  Map<String, dynamic> repertorySnBatchResponse = const {'code': 200, 'data': []};
  Map<String, dynamic> repertoryErpResponse = const {'code': 200, 'data': []};

  @override
  Future<List<OutTaskItem>> getOutTaskCollitemList(
    CollectionTaskItemQuery params,
  ) async {
    return detailList;
  }

  @override
  Future<String> getRoomMatControl(String taskId) async {
    return roomMatControl;
  }

  @override
  Future<BarcodeContent> getMaterialInfoByQR(String barcode) async {
    return barcodeContent;
  }

  @override
  Future<String> getMatControl(String matcode) async {
    return matControlMessage;
  }

  @override
  Future<Map<String, dynamic>> getStoreSite(
    String storeRoomNo,
    String storeSiteNo,
  ) async {
    return storeSiteResponse;
  }

  @override
  Future<Map<String, dynamic>> getRepertoryByStoreSiteNo(
    String storesiteno,
    String matcode,
  ) async {
    return repertoryResponse;
  }

  @override
  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoSn(
    String storesiteno,
    String matcode,
    String? erpStoreroom,
    String? batchno,
    String? sn,
  ) async {
    if (erpStoreroom != null) {
      return repertorySnErpResponse;
    }
    if (batchno != null || sn != null) {
      return repertorySnBatchResponse;
    }
    return repertorySnResponse;
  }

  @override
  Future<Map<String, dynamic>> getRepertoryByStoreSiteNoErp(
    String storesiteno,
    String matcode,
  ) async {
    return repertoryErpResponse;
  }
}

class TestableCollectionBloc extends CollectionBloc {
  TestableCollectionBloc(CollectionService service) : super(service);

  void setStateForTest(CollectionState value) {
    emit(value);
  }
}

void main() {
  group('CollectionBloc base integration', () {
    late FakeCollectionService service;
    late TestableCollectionBloc bloc;

    setUp(() {
      service = FakeCollectionService();
      bloc = TestableCollectionBloc(service);
    });

    test('fetchInventory returns batch inventory summary', () async {
      service.repertoryResponse = {
        'code': 200,
        'data': [
          {'repqty': '2', 'erpStoreroom': 'ERP1', 'batchno': 'B1'},
          {'repqty': '3', 'erpStoreroom': 'ERP1', 'batchno': 'B1'},
        ],
      };

      final result = await bloc.fetchInventory(
        storeSite: 'A1',
        barcode: BarcodeContent(matcode: 'MAT1', batchno: 'B1'),
        matControlFlag: '1',
        erpRoom: 'ERP1',
      );

      expect(result['repQty'], 5);
      expect(result['erpStoreInv'], 'ERP1');
    });

    test('fetchInventory returns serial inventory summary', () async {
      service.repertorySnResponse = {
        'code': 200,
        'data': [
          {'repqty': '1'},
        ],
      };
      service.repertorySnErpResponse = {
        'code': 200,
        'data': [
          {'repqty': '1'},
        ],
      };
      service.repertoryErpResponse = {
        'code': 200,
        'data': [
          {'erpStoreroom': 'ERP2'},
        ],
      };

      final result = await bloc.fetchInventory(
        storeSite: 'A1',
        barcode: BarcodeContent(
          matcode: 'MAT2',
          batchno: 'B2',
          sn: 'SN1',
        ),
        matControlFlag: '0',
        erpRoom: 'ERP2',
      );

      expect(result['repQty'], 1);
      expect(result['erpStoreInv'], 'ERP2');
    });

    test('mapStock builds CollectionStock with provided fields', () {
      final stock = bloc.mapStock(
        stockId: 'ID1',
        matCode: 'MAT1',
        batchNo: 'B1',
        sn: 'SN1',
        taskQty: 1,
        collectQty: 1,
        outTaskItemId: 'ITEM1',
        taskId: 'TASK1',
        storeRoom: 'ROOM',
        storeSite: 'SITE',
        erpStore: 'ERP',
        trayNo: '',
      );

      expect(stock.stockid, 'ID1');
      expect(stock.matcode, 'MAT1');
      expect(stock.batchno, 'B1');
      expect(stock.sn, 'SN1');
      expect(stock.outtaskitemid, 'ITEM1');
      expect(stock.taskid, 'TASK1');
    });
  });
}
