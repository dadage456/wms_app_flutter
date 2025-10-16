// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryTaskFilterImpl _$$InventoryTaskFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskFilterImpl(
      sortType: json['sortType'] as String? ?? 'desc',
      sortColumn: json['sortColumn'] as String? ?? 'createdate',
      searchKey: json['searchKey'] as String? ?? '',
      userId: json['userId'] as String,
      roleOrUserId: json['roleoRuserId'] as String,
      roomTag: json['roomTag'] as String? ?? '1',
      finishFlag: json['finshFlg'] as String? ?? '0',
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$InventoryTaskFilterImplToJson(
        _$InventoryTaskFilterImpl instance) =>
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

_$InventoryTaskSummaryImpl _$$InventoryTaskSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskSummaryImpl(
      taskComment: json['taskcomment'] as String,
      storeRoomNo: json['storeroomno'] as String,
      storeRoomName: json['storeroomname'] as String,
      checkTaskNo: json['checktaskno'] as String,
      checkTaskId: (json['checktaskid'] as num?)?.toInt(),
      status: json['status'] as String?,
      workStation: json['workstation'] as String?,
    );

Map<String, dynamic> _$$InventoryTaskSummaryImplToJson(
        _$InventoryTaskSummaryImpl instance) =>
    <String, dynamic>{
      'taskcomment': instance.taskComment,
      'storeroomno': instance.storeRoomNo,
      'storeroomname': instance.storeRoomName,
      'checktaskno': instance.checkTaskNo,
      'checktaskid': instance.checkTaskId,
      'status': instance.status,
      'workstation': instance.workStation,
    };

_$InventoryTaskListDataImpl _$$InventoryTaskListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryTaskListDataImpl(
      rows: (json['rows'] as List<dynamic>?)
              ?.map((e) =>
                  InventoryTaskSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <InventoryTaskSummary>[],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$InventoryTaskListDataImplToJson(
        _$InventoryTaskListDataImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'total': instance.total,
    };
