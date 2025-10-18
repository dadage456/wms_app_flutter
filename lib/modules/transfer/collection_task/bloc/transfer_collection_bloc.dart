import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../models/page_status.dart';
import '../../../../utils/error_handler.dart';
import '../models/transfer_collection_models.dart';
import '../../services/transfer_task_service.dart';
import 'transfer_collection_event.dart';
import 'transfer_collection_state.dart';

class TransferCollectionBloc
    extends Bloc<TransferCollectionEvent, TransferCollectionState> {
  TransferCollectionBloc({required TransferTaskService service})
      : _service = service,
        super(const TransferCollectionState()) {
    on<TransferStarted>(_onStarted);
    on<TransferResetRequested>(_onResetRequested);
    on<ScanInputSubmitted>(_onScanInputSubmitted);
    on<QuantityConfirmed>(_onQuantityConfirmed);
    on<TransferModeToggled>(_onModeToggled);
    on<InventoryQueryRequested>(_onInventoryQueryRequested);
    on<CollectedItemChecked>(_onCollectedItemChecked);
    on<CollectedItemsDeleted>(_onCollectedItemsDeleted);
    on<TransferSubmitRequested>(_onSubmitRequested);
    on<TransferTabChanged>(_onTabChanged);
    on<TransferFocusRequested>(_onFocusRequested);
    on<TransferStatusCleared>(_onStatusCleared);
  }

  final TransferTaskService _service;
  final Uuid _uuid = const Uuid();

  Future<void> _onStarted(
    TransferStarted event,
    Emitter<TransferCollectionState> emit,
  ) async {
    var context = state.context.copyWith(
      storeRoom: event.storeRoom,
      erpStoreRoom: event.erpStoreRoom,
    );
    context = context.resetForNext(
      presetSource: context.mode == TransferMode.moveIn
          ? '${context.storeRoom}MOVESITE'
          : context.sourceSite,
      presetTarget: context.mode == TransferMode.moveOut
          ? '${context.storeRoom}MOVESITE'
          : context.targetSite,
    );
    emit(
      state.copyWith(
        context: context.updatePlaceholder(),
        status: CollectionStatus.normal(),
        submitStatus: CollectionStatus.normal(),
        collectedItems: const [],
        selectedIds: {},
        quantityDict: const {},
        serialDict: const {},
      ),
    );
  }

  Future<void> _onResetRequested(
    TransferResetRequested event,
    Emitter<TransferCollectionState> emit,
  ) async {
    emit(
      state.copyWith(
        context: state.context
            .resetForNext(presetSource: state.context.sourceSite, presetTarget: state.context.targetSite)
            .updatePlaceholder(),
        status: CollectionStatus.normal(),
      ),
    );
  }

  Future<void> _onScanInputSubmitted(
    ScanInputSubmitted event,
    Emitter<TransferCollectionState> emit,
  ) async {
    final input = event.input.trim();
    if (input.isEmpty) {
      emit(
        state.copyWith(
          status: CollectionStatus.error('输入内容为空，请重新扫描'),
        ),
      );
      return;
    }

    switch (state.context.step) {
      case TransferScanStep.sourceSite:
        await _handleSourceSiteScan(input, emit);
        break;
      case TransferScanStep.targetSite:
        await _handleTargetSiteScan(input, emit);
        break;
      case TransferScanStep.material:
        await _handleMaterialScan(input, emit);
        break;
      case TransferScanStep.quantity:
        final quantity = double.tryParse(input);
        if (quantity == null) {
          emit(
            state.copyWith(
              status: CollectionStatus.error('请输入合法的数量'),
            ),
          );
          return;
        }
        await _onQuantityConfirmed(QuantityConfirmed(quantity), emit);
        break;
    }
  }

  Future<void> _handleSourceSiteScan(
    String input,
    Emitter<TransferCollectionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final resolvedSite = _extractSiteCode(input);
      if (resolvedSite.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('库位条码解析失败，请重试')));
        return;
      }

      final siteInfo = await _service.validateStoreSite(
        storeRoomNo: state.context.storeRoom.isEmpty
            ? ''
            : state.context.storeRoom,
        storeSiteNo: resolvedSite,
      );

      if (siteInfo == null) {
        emit(state.copyWith(status: CollectionStatus.error('库位【$resolvedSite】不存在或不在当前库房')));
        return;
      }

      if (siteInfo.isFrozen) {
        emit(state.copyWith(status: CollectionStatus.error('库位【$resolvedSite】已冻结，无法采集')));
        return;
      }

      final storeRoom = state.context.storeRoom.isNotEmpty
          ? state.context.storeRoom
          : (siteInfo.storeRoomNo ?? '');
      if (storeRoom.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('未能识别库房信息，请检查库位条码')));
        return;
      }

      final context = state.context.copyWith(
        sourceSite: resolvedSite,
        storeRoom: storeRoom,
        placeholder: '请扫描目标库位',
        step: state.context.targetSite.isEmpty
            ? TransferScanStep.targetSite
            : TransferScanStep.material,
        focus: true,
      );
      emit(
        state.copyWith(
          context: context.updatePlaceholder(),
          status: CollectionStatus.success('来源库位校验通过'),
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

  Future<void> _handleTargetSiteScan(
    String input,
    Emitter<TransferCollectionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final resolvedSite = _extractSiteCode(input);
      if (resolvedSite.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('目标库位条码解析失败，请重试')));
        return;
      }

      final siteInfo = await _service.validateStoreSite(
        storeRoomNo: state.context.storeRoom.isEmpty
            ? ''
            : state.context.storeRoom,
        storeSiteNo: resolvedSite,
      );

      if (siteInfo == null) {
        emit(state.copyWith(status: CollectionStatus.error('目标库位【$resolvedSite】不存在')));
        return;
      }

      if (siteInfo.isFrozen) {
        emit(state.copyWith(status: CollectionStatus.error('目标库位【$resolvedSite】已冻结，无法采集')));
        return;
      }

      final storeRoom = state.context.storeRoom.isNotEmpty
          ? state.context.storeRoom
          : (siteInfo.storeRoomNo ?? '');
      if (storeRoom.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('未能识别库房信息，请检查库位条码')));
        return;
      }

      final context = state.context.copyWith(
        targetSite: resolvedSite,
        erpStoreRoom: siteInfo.resolvedErpStoreRoom ?? state.context.erpStoreRoom,
        placeholder: '请扫描物料条码',
        step: state.context.isReadyForQuantity
            ? TransferScanStep.material
            : TransferScanStep.material,
        focus: true,
        storeRoom: storeRoom,
      );
      emit(
        state.copyWith(
          context: context.updatePlaceholder(),
          status: CollectionStatus.success('目标库位校验通过'),
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
    String input,
    Emitter<TransferCollectionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));

      final context = state.context;
      if (context.sourceSite.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请先扫描来源库位')));
        return;
      }
      if (context.targetSite.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请先扫描目标库位')));
        return;
      }

      final materialDetail = await _service.fetchMaterialByQr(input);
      final materialCode = materialDetail.resolvedMaterialCode;
      if (materialCode.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('条码未包含物料信息')));
        return;
      }

      final inventory = await _service.fetchTransferInventory(
        sourceSite: context.sourceSite,
        targetSite: context.targetSite,
      );

      final matchedInventory = inventory.firstWhereOrNull(
        (row) => row.materialCode == materialCode,
      );

      final updatedContext = context.copyWith(
        materialCode: materialCode,
        materialName:
            materialDetail.materialName ?? matchedInventory?.materialCode ?? context.materialName,
        batchNo: materialDetail.batchNo ?? matchedInventory?.batchNo ?? '',
        serialNo: materialDetail.serialNo ?? matchedInventory?.serialNo ?? '',
        projectNumber:
            materialDetail.projectNumber ?? matchedInventory?.projectNumber ?? '',
        supplier: materialDetail.ownerCode ?? matchedInventory?.ownerCode ?? '',
        erpStoreRoom:
            materialDetail.erpStoreRoom ?? matchedInventory?.erpStoreRoom ?? context.erpStoreRoom,
        step: TransferScanStep.quantity,
        placeholder: '请输入移库数量',
        focus: true,
        currentInventory: matchedInventory,
      );

      emit(
        state.copyWith(
          context: updatedContext.updatePlaceholder(),
          inventoryRows: inventory,
          status: CollectionStatus.success('物料校验成功'),
          activeTab: TransferTab.collection,
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

  Future<void> _onQuantityConfirmed(
    QuantityConfirmed event,
    Emitter<TransferCollectionState> emit,
  ) async {
    try {
      final context = state.context;
      final quantity = event.quantity;
      if (quantity <= 0) {
        emit(state.copyWith(status: CollectionStatus.error('移库数量必须大于0')));
        return;
      }
      if (!context.isReadyForQuantity) {
        emit(state.copyWith(status: CollectionStatus.error('请先完成库位与物料扫描')));
        return;
      }

      final key = _buildQuantityKey(context);
      final alreadyCollected = state.quantityDict[key] ?? 0;

      final relatedRows = state.inventoryRows.where((row) {
        final batch = (row.batchNo ?? '').trim();
        final serial = (row.serialNo ?? '').trim();
        return row.storeSiteNo == context.sourceSite &&
            row.materialCode == context.materialCode &&
            (batch.isEmpty || context.batchNo.isEmpty || batch == context.batchNo) &&
            (serial.isEmpty || context.serialNo.isEmpty || serial == context.serialNo);
      }).toList();

      final availableQty = relatedRows.fold<double>(
            0,
            (previousValue, row) => previousValue + (row.quantity),
          ) -
          alreadyCollected;

      if (availableQty < quantity) {
        emit(
          state.copyWith(
            status: CollectionStatus.error(
              '库位库存不足，剩余${availableQty.toStringAsFixed(2)}',
            ),
          ),
        );
        return;
      }

      final serialKey = _buildSerialKey(context);
      if (serialKey != null && state.serialDict.containsKey(serialKey)) {
        emit(
          state.copyWith(
            status: CollectionStatus.error('序列号已采集，请勿重复录入'),
          ),
        );
        return;
      }

      final item = TransferCollectedItem(
        id: _uuid.v4(),
        sourceSite: context.sourceSite,
        targetSite: context.targetSite,
        materialCode: context.materialCode,
        materialName: context.materialName,
        batchNo: context.batchNo.isEmpty ? null : context.batchNo,
        serialNo: context.serialNo.isEmpty ? null : context.serialNo,
        quantity: quantity,
        supplier: context.supplier.isEmpty ? null : context.supplier,
        erpRoom: context.erpStoreRoom.isEmpty ? null : context.erpStoreRoom,
        projectNumber: context.projectNumber.isEmpty ? null : context.projectNumber,
      );

      final updatedItems = [...state.collectedItems, item];
      final updatedQuantityDict = Map<String, double>.from(state.quantityDict)
        ..update(key, (value) => value + quantity, ifAbsent: () => quantity);
      final updatedSerialDict = Map<String, String>.from(state.serialDict);
      if (serialKey != null) {
        updatedSerialDict[serialKey] = serialKey;
      }

      final nextContext = context
          .resetForNext(
            keepMode: context.mode,
            presetSource: context.sourceSite,
            presetTarget: context.targetSite,
          )
          .updatePlaceholder();

      emit(
        state.copyWith(
          context: nextContext,
          collectedItems: updatedItems,
          quantityDict: updatedQuantityDict,
          serialDict: updatedSerialDict,
          selectedIds: {},
          status: CollectionStatus.success('采集成功'),
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

  Future<void> _onModeToggled(
    TransferModeToggled event,
    Emitter<TransferCollectionState> emit,
  ) async {
    final context = state.context
        .resetForNext(keepMode: event.mode)
        .copyWith(mode: event.mode)
        .updatePlaceholder();
    emit(
      state.copyWith(
        context: context,
        status: CollectionStatus.success('已切换至${event.mode.label}模式'),
        selectedIds: {},
      ),
    );
  }

  Future<void> _onInventoryQueryRequested(
    InventoryQueryRequested event,
    Emitter<TransferCollectionState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CollectionStatus.loading()));
      final context = state.context;
      if (context.sourceSite.isEmpty || context.materialCode.isEmpty) {
        emit(state.copyWith(status: CollectionStatus.error('请先完成库位与物料扫描')));
        return;
      }

      final inventory = await _service.fetchInventoryBySiteAndMaterial(
        storeSite: context.sourceSite,
        materialCode: context.materialCode,
        batchNo: context.batchNo,
      );

      emit(
        state.copyWith(
          inventoryRows: inventory,
          activeTab: TransferTab.inventory,
          status: CollectionStatus.success('库存查询完成'),
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

  void _onCollectedItemChecked(
    CollectedItemChecked event,
    Emitter<TransferCollectionState> emit,
  ) {
    final updated = Set<String>.from(state.selectedIds);
    if (event.checked) {
      updated.add(event.itemId);
    } else {
      updated.remove(event.itemId);
    }
    emit(state.copyWith(selectedIds: updated));
  }

  void _onCollectedItemsDeleted(
    CollectedItemsDeleted event,
    Emitter<TransferCollectionState> emit,
  ) {
    if (state.selectedIds.isEmpty) {
      emit(state.copyWith(status: CollectionStatus.error('请先勾选需要删除的明细')));
      return;
    }

    final remaining = <TransferCollectedItem>[];
    final newQuantityDict = Map<String, double>.from(state.quantityDict);
    final newSerialDict = Map<String, String>.from(state.serialDict);

    for (final item in state.collectedItems) {
      if (state.selectedIds.contains(item.id)) {
        final key = _buildQuantityKeyForItem(item);
        final serialKey = _buildSerialKeyForItem(item);
        final currentQty = newQuantityDict[key] ?? 0;
        final updatedQty = (currentQty - item.quantity).clamp(0, double.infinity);
        if (updatedQty <= 0.0001) {
          newQuantityDict.remove(key);
        } else {
          newQuantityDict[key] = updatedQty.toDouble();
        }
        if (serialKey != null) {
          newSerialDict.remove(serialKey);
        }
      } else {
        remaining.add(item);
      }
    }

    emit(
      state.copyWith(
        collectedItems: remaining,
        selectedIds: {},
        quantityDict: newQuantityDict,
        serialDict: newSerialDict,
        status: CollectionStatus.success('已删除选中明细'),
      ),
    );
  }

  Future<void> _onSubmitRequested(
    TransferSubmitRequested event,
    Emitter<TransferCollectionState> emit,
  ) async {
    if (state.collectedItems.isEmpty) {
      emit(state.copyWith(submitStatus: CollectionStatus.error('当前无采集数据')));
      return;
    }

    try {
      emit(state.copyWith(submitStatus: CollectionStatus.loading()));
      final entries = state.collectedItems
          .map(
            (item) => TransferSubmitEntry(
              outSite: item.sourceSite,
              inSite: item.targetSite,
              materialCode: item.materialCode,
              batchNo: item.batchNo,
              serialNo: item.serialNo,
              quantity: item.quantity,
              supplier: item.supplier,
              erpRoom: item.erpRoom,
              projectNumber: item.projectNumber,
            ),
          )
          .toList();
      final filterSites = {
        for (final item in state.collectedItems) item.sourceSite,
      };
      final payload = TransferSubmitPayload(
        entries: entries,
        filter: filterSites.join(','),
      );

      await _service.submitTransfer(payload);

      emit(
        state.copyWith(
          submitStatus: CollectionStatus.success('提交成功'),
          collectedItems: const [],
          quantityDict: const {},
          serialDict: const {},
          selectedIds: {},
          context: state.context
              .resetForNext(
                presetSource: state.context.sourceSite,
                presetTarget: state.context.targetSite,
              )
              .updatePlaceholder(),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          submitStatus: CollectionStatus.error(ErrorHandler.handleError(error)),
        ),
      );
    }
  }

  void _onTabChanged(
    TransferTabChanged event,
    Emitter<TransferCollectionState> emit,
  ) {
    emit(state.copyWith(activeTab: TransferTab.values[event.index]));
  }

  void _onFocusRequested(
    TransferFocusRequested event,
    Emitter<TransferCollectionState> emit,
  ) {
    emit(state.copyWith(context: state.context.copyWith(focus: event.shouldFocus)));
  }

  void _onStatusCleared(
    TransferStatusCleared event,
    Emitter<TransferCollectionState> emit,
  ) {
    emit(state.clearStatus());
  }

  String _extractSiteCode(String input) {
    if (input.contains(r'\$KW\$')) {
      final parts = input.split(r'\$');
      if (parts.length > 2) {
        return parts[2].trim();
      }
    }
    return input.trim();
  }

  String _buildQuantityKey(TransferScanContext context) {
    final batchOrSerial = context.serialNo.isNotEmpty
        ? context.serialNo
        : context.batchNo.isNotEmpty
            ? context.batchNo
            : '';
    final erpRoom = context.erpStoreRoom.isNotEmpty ? context.erpStoreRoom : '';
    final project = context.projectNumber.isNotEmpty ? context.projectNumber : '';
    final supplier = context.supplier.isNotEmpty ? context.supplier : '';
    return [
      context.sourceSite,
      context.targetSite,
      context.materialCode,
      batchOrSerial,
      erpRoom,
      project,
      supplier,
    ].join('|');
  }

  String _buildQuantityKeyForItem(TransferCollectedItem item) {
    final batchOrSerial = item.serialNo ?? item.batchNo ?? '';
    final erpRoom = item.erpRoom ?? '';
    final project = item.projectNumber ?? '';
    final supplier = item.supplier ?? item.ownerCode ?? '';
    return [
      item.sourceSite,
      item.targetSite,
      item.materialCode,
      batchOrSerial,
      erpRoom,
      project,
      supplier,
    ].join('|');
  }

  String? _buildSerialKey(TransferScanContext context) {
    if (context.serialNo.isEmpty) return null;
    return '${context.materialCode}@${context.serialNo}';
  }

  String? _buildSerialKeyForItem(TransferCollectedItem item) {
    final serial = item.serialNo;
    if (serial == null || serial.isEmpty) return null;
    return '${item.materialCode}@$serial';
  }
}
