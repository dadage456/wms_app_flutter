// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_pick_task_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlinePickTaskImpl _$$OnlinePickTaskImplFromJson(Map<String, dynamic> json) =>
    _$OnlinePickTaskImpl(
      outTaskId: (json['outtaskid'] as num).toInt(),
      outTaskNo: json['outtaskno'] as String,
      orderNo: json['orderno'] as String?,
      poNumber: json['po_number'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      workStation: json['workstation'] as String?,
      taskComment: json['taskcomment'] as String?,
      urgentFlag: json['wip_supplement_flag'] as String?,
      scheduleGroupName: json['schedule_group_name'] as String?,
      forceSite: json['forcesite'] as String?,
      forceBatch: json['forcebatch'] as String?,
      finishFlag: json['finshFlg'] as String?,
      createTime: json['createtime'] as String?,
      taskQty: json['taskqty'] as num? ?? 0,
      finishQty: json['finishqty'] as num? ?? 0,
    );

Map<String, dynamic> _$$OnlinePickTaskImplToJson(
        _$OnlinePickTaskImpl instance) =>
    <String, dynamic>{
      'outtaskid': instance.outTaskId,
      'outtaskno': instance.outTaskNo,
      'orderno': instance.orderNo,
      'po_number': instance.poNumber,
      'storeroomno': instance.storeRoomNo,
      'workstation': instance.workStation,
      'taskcomment': instance.taskComment,
      'wip_supplement_flag': instance.urgentFlag,
      'schedule_group_name': instance.scheduleGroupName,
      'forcesite': instance.forceSite,
      'forcebatch': instance.forceBatch,
      'finshFlg': instance.finishFlag,
      'createtime': instance.createTime,
      'taskqty': instance.taskQty,
      'finishqty': instance.finishQty,
    };

_$OnlinePickTaskListDataImpl _$$OnlinePickTaskListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskListDataImpl(
      rows: (json['rows'] as List<dynamic>?)
              ?.map((e) => OnlinePickTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OnlinePickTaskListDataImplToJson(
        _$OnlinePickTaskListDataImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'total': instance.total,
    };

_$OnlinePickTaskListResponseImpl _$$OnlinePickTaskListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskListResponseImpl(
      code: json['code'] as String,
      message: json['msg'] as String,
      data:
          OnlinePickTaskListData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OnlinePickTaskListResponseImplToJson(
        _$OnlinePickTaskListResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'data': instance.data,
    };

_$OnlinePickTaskQueryImpl _$$OnlinePickTaskQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickTaskQueryImpl(
      sortType: json['sortType'] as String? ?? '',
      sortColumn: json['sortColumn'] as String? ?? '',
      searchKey: json['searchKey'] as String? ?? '',
      userId: json['userId'] as String,
      roleOrUserId: json['roleoRuserId'] as String,
      roomTag: json['roomTag'] as String? ?? '1',
      batchFlag: json['batchflag'] as String? ?? '0',
      transferType: json['transferType'] as String? ?? '0',
      beatFlag: json['beatflag'] as String? ?? 'N',
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 100,
      finishFlag: json['finshFlg'] as String? ?? '0',
    );

Map<String, dynamic> _$$OnlinePickTaskQueryImplToJson(
        _$OnlinePickTaskQueryImpl instance) =>
    <String, dynamic>{
      'searchKey': instance.searchKey,
      'userId': instance.userId,
      'roleoRuserId': instance.roleOrUserId,
      'roomTag': instance.roomTag,
      'batchflag': instance.batchFlag,
      'transferType': instance.transferType,
      'beatflag': instance.beatFlag,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
      'finshFlg': instance.finishFlag,
    };
