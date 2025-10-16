// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryTaskQueryImpl _$$InventoryTaskQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskQueryImpl(
      sortType: json['sortType'] as String? ?? 'desc',
      sortColumn: json['sortColumn'] as String? ?? 'createdate',
      searchKey: json['searchKey'] as String? ?? '',
      userId: json['userId'] as String,
      roleOrUserId: json['roleoRuserId'] as String,
      roomTag: json['roomTag'] as String? ?? '0',
      finishFlag: json['finshFlg'] as String? ?? '0',
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$InventoryTaskQueryImplToJson(
        _$InventoryTaskQueryImpl instance) =>
    <String, dynamic>{
      'sortType': instance.sortType,
      'sortColumn': instance.sortColumn,
      'searchKey': instance.searchKey,
      'userId': instance.userId,
      'roleoRuserId': instance.roleOrUserId,
      'roomTag': instance.roomTag,
      'finshFlg': instance.finishFlag,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
    };

_$InventoryTaskImpl _$$InventoryTaskImplFromJson(Map<String, dynamic> json) =>
    _$InventoryTaskImpl(
      taskComment: json['taskcomment'] as String,
      storeRoomNo: json['storeroomno'] as String,
      storeRoomName: json['storeroomname'] as String,
      checkTaskNo: json['checktaskno'] as String,
      checkTaskId: (json['checktaskid'] as num?)?.toInt(),
      status: json['status'] as String?,
      workStation: json['workstation'] as String?,
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$InventoryTaskImplToJson(_$InventoryTaskImpl instance) =>
    <String, dynamic>{
      'taskcomment': instance.taskComment,
      'storeroomno': instance.storeRoomNo,
      'storeroomname': instance.storeRoomName,
      'checktaskno': instance.checkTaskNo,
      'checktaskid': instance.checkTaskId,
      'status': instance.status,
      'workstation': instance.workStation,
      'memo': instance.memo,
    };

_$InventoryTaskListResponseImpl _$$InventoryTaskListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskListResponseImpl(
      rows: (json['rows'] as List<dynamic>?)
              ?.map((e) => InventoryTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <InventoryTask>[],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$InventoryTaskListResponseImplToJson(
        _$InventoryTaskListResponseImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'total': instance.total,
    };
