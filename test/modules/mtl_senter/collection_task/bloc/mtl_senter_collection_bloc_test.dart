import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/bloc/mtl_senter_collection_bloc.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/bloc/mtl_senter_collection_event.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/bloc/mtl_senter_collection_state.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/models/mtl_senter_models.dart';
import 'package:wms_app/modules/mtl_senter/collection_task/services/mtl_senter_service.dart';

class StubMtlSenterService extends MtlSenterService {
  StubMtlSenterService({
    required this.material,
    this.qtyInfo,
    this.inventoryQty = 0,
    this.commitShouldFail = false,
  }) : super(Dio());

  final MtlSenterMaterial material;
  final MtlSenterMaterial? qtyInfo;
  final double inventoryQty;
  final bool commitShouldFail;

  String? lastQrContent;
  String? lastInventoryLocation;
  String? lastInventoryMaterial;
  MtlSenterSubmitRequest? lastSubmitRequest;

  @override
  Future<MtlSenterMaterial> fetchMaterialByQr(String qrContent) async {
    lastQrContent = qrContent;
    return material;
  }

  @override
  Future<double?> fetchInventoryByLocation({
    required String storeSite,
    required String materialCode,
  }) async {
    lastInventoryLocation = storeSite;
    lastInventoryMaterial = materialCode;
    return inventoryQty;
  }

  @override
  Future<MtlSenterMaterial?> fetchMtlQty({
    required String materialCode,
    String? siteNo,
  }) async {
    return qtyInfo;
  }

  @override
  Future<void> commitSender({
    required MtlSenterSubmitRequest request,
  }) async {
    lastSubmitRequest = request;
    if (commitShouldFail) {
      throw Exception('commit failed');
    }
  }
}

void main() {
  late StubMtlSenterService service;
  late MtlSenterCollectionBloc bloc;

  const task = MtlSenterTask(
    taskId: 'TASK-001',
    workOrderNo: 'WO-1',
  );

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    service = StubMtlSenterService(
      material: const MtlSenterMaterial(
        materialCode: 'MAT-001',
        materialName: '轴承',
        minPackageQty: 2,
        defaultDeliveryQty: 5,
      ),
      qtyInfo: const MtlSenterMaterial(
        materialCode: 'MAT-001',
        minPackageQty: 3,
        defaultDeliveryQty: 6,
      ),
      inventoryQty: 10,
    );
    bloc = MtlSenterCollectionBloc(service: service);
  });

  tearDown(() async {
    await bloc.close();
  });

  Future<void> _startFlow() async {
    bloc.add(const MtlSenterCollectionStarted(task: task, operatorId: '10001'));
    await bloc.stream.firstWhere((state) => state.task == task);
  }

  Future<MtlSenterCollectionState> _scanLocation() async {
    bloc.add(const MtlSenterBarcodeScanned('A1\$KW\$LOC-01'));
    return bloc.stream.firstWhere(
      (state) =>
          state.currentLocation == 'LOC-01' &&
          state.scanStep == MtlSenterScanStep.material,
    );
  }

  Future<MtlSenterCollectionState> _scanMaterial() async {
    bloc.add(const MtlSenterBarcodeScanned('MC123456'));
    return bloc.stream.firstWhere(
      (state) =>
          state.scanStep == MtlSenterScanStep.quantity &&
          state.currentMaterial?.materialCode == 'MAT-001',
    );
  }

  Future<MtlSenterCollectionState> _inputQuantity(String qty) async {
    bloc.add(MtlSenterBarcodeScanned(qty));
    return bloc.stream.firstWhere(
      (state) => state.status.isSuccess && state.stocks.isNotEmpty,
    );
  }

  test('start event primes task context and resets state', () async {
    await _startFlow();

    final state = bloc.state;
    expect(state.task, equals(task));
    expect(state.operatorId, equals('10001'));
    expect(state.scanStep, MtlSenterScanStep.location);
    expect(state.stocks, isEmpty);
  });

  test('location scan sets current location and switches to material step', () async {
    await _startFlow();

    final state = await _scanLocation();

    expect(state.currentLocation, 'LOC-01');
    expect(state.placeholder, '请扫描二维码');
    expect(service.lastInventoryLocation, isNull);
  });

  test('material scan loads metadata and inventory then switches to quantity step', () async {
    await _startFlow();
    await _scanLocation();

    final state = await _scanMaterial();

    expect(service.lastQrContent, 'MC123456');
    expect(service.lastInventoryLocation, 'LOC-01');
    expect(service.lastInventoryMaterial, 'MAT-001');
    expect(state.availableQty, 10);
    expect(state.minPackageQty, 3);
    expect(state.defaultDeliveryQty, 6);
    expect(state.placeholder, '请输入数量');
  });

  test('quantity input aggregates records and keeps focus on material step', () async {
    await _startFlow();
    await _scanLocation();
    await _scanMaterial();

    final first = await _inputQuantity('2');
    expect(first.stocks.single.quantity, closeTo(2, 1e-6));
    expect(first.scanStep, MtlSenterScanStep.material);
    expect(first.focus, isTrue);

    final second = await _inputQuantity('3');
    expect(second.stocks.single.quantity, closeTo(5, 1e-6));
    expect(second.collectedQtyMap['MAT-001@LOC-01'], closeTo(5, 1e-6));
  });

  test('quantity exceeding available stock surfaces error', () async {
    await _startFlow();
    await _scanLocation();
    await _scanMaterial();

    bloc.add(const MtlSenterBarcodeScanned('11'));

    final errorState = await bloc.stream.firstWhere(
      (state) => state.status.isError,
    );

    expect(errorState.status.message, contains('超过当前库存'));
    expect(errorState.focus, isTrue);
  });

  test('invalid barcode reports error without changing focus', () async {
    await _startFlow();

    bloc.add(const MtlSenterBarcodeScanned('UNKNOWN'));

    final errorState = await bloc.stream.firstWhere(
      (state) => state.status.isError,
    );

    expect(errorState.status.message, contains('采集内容不合法'));
    expect(errorState.scanStep, MtlSenterScanStep.location);
  });

  test('delete removes selected records and clears selection set', () async {
    await _startFlow();
    await _scanLocation();
    await _scanMaterial();
    final recorded = await _inputQuantity('4');

    final targetId = recorded.stocks.first.id;
    bloc.add(MtlSenterToggleSelection(targetId));
    await bloc.stream.firstWhere((state) => state.hasSelection);

    bloc.add(const MtlSenterDeleteSelected());
    final cleared = await bloc.stream.firstWhere(
      (state) => state.status.isSuccess && state.stocks.isEmpty,
    );

    expect(cleared.selectedIds, isEmpty);
    expect(cleared.collectedQtyMap, isEmpty);
  });

  test('submit sends payload to service and clears working buffers', () async {
    await _startFlow();
    await _scanLocation();
    await _scanMaterial();
    await _inputQuantity('2');

    bloc.add(const MtlSenterSubmitRequested());

    final submitted = await bloc.stream.firstWhere(
      (state) => state.status.isSuccess && state.status.message == '提交成功',
    );

    expect(service.lastSubmitRequest, isNotNull);
    expect(service.lastSubmitRequest!.mtlSenderInfos, hasLength(1));
    expect(submitted.stocks, isEmpty);
    expect(submitted.collectedQtyMap, isEmpty);
  });

  test('submit surfaces service error and keeps stocks intact', () async {
    service = StubMtlSenterService(
      material: const MtlSenterMaterial(materialCode: 'MAT-002'),
      inventoryQty: 5,
      commitShouldFail: true,
    );
    bloc = MtlSenterCollectionBloc(service: service);

    await _startFlow();
    await _scanLocation();
    await _scanMaterial();
    await _inputQuantity('1');

    bloc.add(const MtlSenterSubmitRequested());

    final errorState = await bloc.stream.firstWhere((state) => state.status.isError);

    expect(errorState.stocks, isNotEmpty);
    expect(service.lastSubmitRequest, isNotNull);
  });
}
