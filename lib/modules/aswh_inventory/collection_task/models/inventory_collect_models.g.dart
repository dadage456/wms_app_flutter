// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_collect_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryTaskItemImpl _$$InventoryTaskItemImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskItemImpl(
      checkItemId: (json['co_checkitemid'] as num?)?.toInt(),
      checkTaskId: (json['checktaskid'] as num?)?.toInt(),
      checkTaskNo: json['checktaskno'] as String?,
      taskComment: json['taskcomment'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      storeRoomName: json['storeroomname'] as String?,
      storeSiteNo: json['storesiteno'] as String?,
      storeSiteName: json['storesite'] as String?,
      palletNo: json['palletno'] as String?,
      materialCode: json['matcode2'] as String?,
      materialName: json['matname'] as String?,
      planQty: (json['qty'] as num?)?.toDouble() ?? 0,
      collectedQty: (json['collectdataqty'] as num?)?.toDouble() ?? 0,
      checkMethodName: json['checkmethod_nm'] as String?,
      batchNo: json['batchno'] as String?,
      serialNo: json['sn'] as String?,
      supplierCode: json['suppliercode'] as String?,
      endAddr: json['endaddr'] as String?,
      erpStoreRoom: json['erpstoreroom'] as String?,
      erpStoreSite: json['erpstoresite'] as String?,
      materialControlFlag: json['matcontrolflag'] as String?,
      isFinished: json['isfinish'] as bool? ?? false,
    );

Map<String, dynamic> _$$InventoryTaskItemImplToJson(
        _$InventoryTaskItemImpl instance) =>
    <String, dynamic>{
      'co_checkitemid': instance.checkItemId,
      'checktaskid': instance.checkTaskId,
      'checktaskno': instance.checkTaskNo,
      'taskcomment': instance.taskComment,
      'storeroomno': instance.storeRoomNo,
      'storeroomname': instance.storeRoomName,
      'storesiteno': instance.storeSiteNo,
      'storesite': instance.storeSiteName,
      'palletno': instance.palletNo,
      'matcode2': instance.materialCode,
      'matname': instance.materialName,
      'qty': instance.planQty,
      'collectdataqty': instance.collectedQty,
      'checkmethod_nm': instance.checkMethodName,
      'batchno': instance.batchNo,
      'sn': instance.serialNo,
      'suppliercode': instance.supplierCode,
      'endaddr': instance.endAddr,
      'erpstoreroom': instance.erpStoreRoom,
      'erpstoresite': instance.erpStoreSite,
      'matcontrolflag': instance.materialControlFlag,
      'isfinish': instance.isFinished,
    };

_$InventoryCollectingRecordImpl _$$InventoryCollectingRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryCollectingRecordImpl(
      taskComment: json['TaskComment'] as String,
      taskItemId: json['invTaskItemid'] as String,
      materialCode: json['matCode'] as String,
      materialId: json['materialId'] as String?,
      storeRoomNo: json['storeRoomNo'] as String,
      storeSiteNo: json['storeSiteNo'] as String,
      collectQty: (json['collectQty'] as num?)?.toDouble() ?? 0,
      batchNo: json['batchNo'] as String?,
      serialNo: json['sn'] as String?,
      trayNo: json['trayNo'] as String?,
      collectedAt: _dateTimeFromJson(json['collectedAt'] as String?),
    );

Map<String, dynamic> _$$InventoryCollectingRecordImplToJson(
        _$InventoryCollectingRecordImpl instance) =>
    <String, dynamic>{
      'TaskComment': instance.taskComment,
      'invTaskItemid': instance.taskItemId,
      'matCode': instance.materialCode,
      'materialId': instance.materialId,
      'storeRoomNo': instance.storeRoomNo,
      'storeSiteNo': instance.storeSiteNo,
      'collectQty': instance.collectQty,
      'batchNo': instance.batchNo,
      'sn': instance.serialNo,
      'trayNo': instance.trayNo,
      'collectedAt': _dateTimeToJson(instance.collectedAt),
    };

_$InventoryCollectCommandImpl _$$InventoryCollectCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryCollectCommandImpl(
      taskId: json['taskId'] as String,
      taskNo: json['taskNo'] as String,
      trayNo: json['trayNo'] as String,
      startAddr: json['startAddr'] as String,
      endAddr: json['endAddr'] as String,
      singleFlag: json['singleFlag'] as String? ?? '0',
      action: $enumDecodeNullable(
              _$InventoryCollectCommandActionEnumMap, json['action']) ??
          InventoryCollectCommandAction.inventoryDown,
    );

Map<String, dynamic> _$$InventoryCollectCommandImplToJson(
        _$InventoryCollectCommandImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskNo': instance.taskNo,
      'trayNo': instance.trayNo,
      'startAddr': instance.startAddr,
      'endAddr': instance.endAddr,
      'singleFlag': instance.singleFlag,
      'action': _$InventoryCollectCommandActionEnumMap[instance.action]!,
    };

const _$InventoryCollectCommandActionEnumMap = {
  InventoryCollectCommandAction.inventoryDown: 'inventoryDown',
  InventoryCollectCommandAction.inventoryReset: 'inventoryReset',
  InventoryCollectCommandAction.emptyTray: 'emptyTray',
};

_$InventoryCollectStateSnapshotImpl
    _$$InventoryCollectStateSnapshotImplFromJson(Map<String, dynamic> json) =>
        _$InventoryCollectStateSnapshotImpl(
          taskId: json['taskId'] as String,
          taskComment: json['taskComment'] as String,
          activeTrayNo: json['activeTrayNo'] as String?,
          activeStoreSiteNo: json['activeStoreSiteNo'] as String?,
          lastScannedCode: json['lastScannedCode'] as String?,
          taskItems: (json['taskItems'] as List<dynamic>?)
                  ?.map((e) =>
                      InventoryTaskItem.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <InventoryTaskItem>[],
          collectedRecords: (json['collectedRecords'] as List<dynamic>?)
                  ?.map((e) => InventoryCollectingRecord.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const <InventoryCollectingRecord>[],
          updatedAt: _dateTimeFromJson(json['updatedAt'] as String?),
        );

Map<String, dynamic> _$$InventoryCollectStateSnapshotImplToJson(
        _$InventoryCollectStateSnapshotImpl instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskComment': instance.taskComment,
      'activeTrayNo': instance.activeTrayNo,
      'activeStoreSiteNo': instance.activeStoreSiteNo,
      'lastScannedCode': instance.lastScannedCode,
      'taskItems': instance.taskItems,
      'collectedRecords': instance.collectedRecords,
      'updatedAt': _dateTimeToJson(instance.updatedAt),
    };

_$InventoryPalletInfoImpl _$$InventoryPalletInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryPalletInfoImpl(
      palletNo: json['palletNo'] as String?,
      storeSite: json['storeSite'] as String?,
      storeRoom: json['storeRoom'] as String?,
      materialCode: json['matCode'] as String?,
      materialName: json['matName'] as String?,
      inventoryQty: (json['InventoryQty'] as num?)?.toDouble() ?? 0,
      erpStoreRoom: json['erpStoreRoom'] as String?,
      erpStoreSite: json['erpStoreSite'] as String?,
      batchNo: json['batchNo'] as String?,
      serialNo: json['sn'] as String?,
    );

Map<String, dynamic> _$$InventoryPalletInfoImplToJson(
        _$InventoryPalletInfoImpl instance) =>
    <String, dynamic>{
      'palletNo': instance.palletNo,
      'storeSite': instance.storeSite,
      'storeRoom': instance.storeRoom,
      'matCode': instance.materialCode,
      'matName': instance.materialName,
      'InventoryQty': instance.inventoryQty,
      'erpStoreRoom': instance.erpStoreRoom,
      'erpStoreSite': instance.erpStoreSite,
      'batchNo': instance.batchNo,
      'sn': instance.serialNo,
    };

_$InventoryMatControlImpl _$$InventoryMatControlImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryMatControlImpl(
      materialCode: json['matCode'] as String?,
      batchRequired: json['batchFlag'] as bool? ?? true,
      supplierRequired: json['supplierFlag'] as bool? ?? true,
      serialRequired: json['snFlag'] as bool? ?? false,
      validityRequired: json['validFlag'] as bool? ?? false,
      controlFlag: json['matControlFlag'] as String?,
    );

Map<String, dynamic> _$$InventoryMatControlImplToJson(
        _$InventoryMatControlImpl instance) =>
    <String, dynamic>{
      'matCode': instance.materialCode,
      'batchFlag': instance.batchRequired,
      'supplierFlag': instance.supplierRequired,
      'snFlag': instance.serialRequired,
      'validFlag': instance.validityRequired,
      'matControlFlag': instance.controlFlag,
    };

_$InventorySiteInfoImpl _$$InventorySiteInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$InventorySiteInfoImpl(
      storeRoomNo: json['storeroomno'] as String?,
      storeSiteNo: json['storesiteno'] as String?,
      storeSiteName: json['storesite'] as String?,
      frozenFlag: json['isfrozen'] as String?,
      erpStoreSite: json['erpstoresite'] as String?,
      siteFlag: json['siteflag'] as String?,
    );

Map<String, dynamic> _$$InventorySiteInfoImplToJson(
        _$InventorySiteInfoImpl instance) =>
    <String, dynamic>{
      'storeroomno': instance.storeRoomNo,
      'storesiteno': instance.storeSiteNo,
      'storesite': instance.storeSiteName,
      'isfrozen': instance.frozenFlag,
      'erpstoresite': instance.erpStoreSite,
      'siteflag': instance.siteFlag,
    };

_$InventoryTaskItemQueryImpl _$$InventoryTaskItemQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskItemQueryImpl(
      taskComment: json['taskcomment'] as String,
      checkTaskNo: json['checktaskno'] as String,
      checkTaskId: json['checktaskid'] as String?,
      roomTag: json['roomTag'] as String? ?? '1',
      sortType: json['sortType'] as String?,
      sortColumn: json['sortColumn'] as String?,
      searchKey: json['searchKey'] as String?,
    );

Map<String, dynamic> _$$InventoryTaskItemQueryImplToJson(
        _$InventoryTaskItemQueryImpl instance) =>
    <String, dynamic>{
      'taskcomment': instance.taskComment,
      'checktaskno': instance.checkTaskNo,
      'checktaskid': instance.checkTaskId,
      'roomTag': instance.roomTag,
      'sortType': instance.sortType,
      'sortColumn': instance.sortColumn,
      'searchKey': instance.searchKey,
    };
