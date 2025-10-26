// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_pick_task_item_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlinePickTaskItemImpl _$$OnlinePickTaskItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskItemImpl(
      outTaskItemId: (json['outtaskitemid'] as num).toInt(),
      outTaskId: (json['outtaskid'] as num).toInt(),
      outTaskNo: json['outtaskno'] as String?,
      materialCode: json['matcode'] as String?,
      materialName: json['matname'] as String?,
      oldMaterialCode: json['matinnercode'] as String?,
      storeSiteNo: json['storesiteno'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      subInventoryCode: json['subinventoryCode'] as String?,
      orderNo: json['orderno'] as String?,
      taskComment: json['taskcomment'] as String?,
      palletNo: json['palletno'] as String?,
      taskQty: json['hintqty'] as num? ?? 0,
      collectedQty: json['collectedqty'] as num? ?? 0,
      repositoryQty: json['repqty'] as num? ?? 0,
      hintBatchNo: json['hintbatchno'] as String?,
      batchNo: json['batchno'] as String?,
      serialNumber: json['sn'] as String?,
      wcsState: json['wcsstate'] as String?,
    );

Map<String, dynamic> _$$OnlinePickTaskItemImplToJson(
        _$OnlinePickTaskItemImpl instance) =>
    <String, dynamic>{
      'outtaskitemid': instance.outTaskItemId,
      'outtaskid': instance.outTaskId,
      'outtaskno': instance.outTaskNo,
      'matcode': instance.materialCode,
      'matname': instance.materialName,
      'matinnercode': instance.oldMaterialCode,
      'storesiteno': instance.storeSiteNo,
      'storeroomno': instance.storeRoomNo,
      'subinventoryCode': instance.subInventoryCode,
      'orderno': instance.orderNo,
      'taskcomment': instance.taskComment,
      'palletno': instance.palletNo,
      'hintqty': instance.taskQty,
      'collectedqty': instance.collectedQty,
      'repqty': instance.repositoryQty,
      'hintbatchno': instance.hintBatchNo,
      'batchno': instance.batchNo,
      'sn': instance.serialNumber,
      'wcsstate': instance.wcsState,
    };

_$OnlinePickTaskItemListDataImpl _$$OnlinePickTaskItemListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskItemListDataImpl(
      rows: (json['rows'] as List<dynamic>?)
              ?.map(
                  (e) => OnlinePickTaskItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OnlinePickTaskItemListDataImplToJson(
        _$OnlinePickTaskItemListDataImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'total': instance.total,
    };

_$OnlinePickTaskItemQueryImpl _$$OnlinePickTaskItemQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskItemQueryImpl(
      outTaskId: (json['outtaskid'] as num).toInt(),
      outTaskNo: json['outtaskno'] as String?,
      workStation: json['workstation'] as String?,
      roomTag: json['roomTag'] as String? ?? '1',
      roleOrUserId: json['roleoRuserId'] as String,
      userId: json['userId'] as String,
      sortType: json['sortType'] as String? ?? '',
      sortColumn: json['sortColumn'] as String? ?? '',
      searchKey: json['searchKey'] as String? ?? '',
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 100,
      finishFlag: json['finshFlg'] as String? ?? '0',
      beatFlag: json['beatflag'] as String? ?? 'N',
      forceSite: json['forcesite'] as String?,
      forceBatch: json['forcebatch'] as String?,
    );

Map<String, dynamic> _$$OnlinePickTaskItemQueryImplToJson(
        _$OnlinePickTaskItemQueryImpl instance) =>
    <String, dynamic>{
      'outtaskid': instance.outTaskId,
      'outtaskno': instance.outTaskNo,
      'workstation': instance.workStation,
      'roomTag': instance.roomTag,
      'roleoRuserId': instance.roleOrUserId,
      'userId': instance.userId,
      'searchKey': instance.searchKey,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
      'finshFlg': instance.finishFlag,
      'beatflag': instance.beatFlag,
      'forcesite': instance.forceSite,
      'forcebatch': instance.forceBatch,
    };
