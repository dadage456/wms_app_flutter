// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbound_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutboundTaskImpl _$$OutboundTaskImplFromJson(Map<String, dynamic> json) =>
    _$OutboundTaskImpl(
      outTaskId: (json['outtaskid'] as num).toInt(),
      outTaskNo: json['outtaskno'] as String,
      orderNo: json['orderno'] as String,
      poNumber: json['po_number'] as String,
      storeRoomNo: json['storeroomno'] as String,
      workStation: json['workstation'] as String,
      taskComment: json['taskcomment'] as String,
      scheduleGroupName: json['schedule_group_name'] as String?,
      wipSupplementFlag: json['wip_supplement_flag'] as String,
      createTime: json['createtime'] as String?,
      status: json['status'] as String?,
      taskQty: (json['taskqty'] as num?)?.toInt() ?? 0,
      finishQty: (json['finishqty'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OutboundTaskImplToJson(_$OutboundTaskImpl instance) =>
    <String, dynamic>{
      'outtaskid': instance.outTaskId,
      'outtaskno': instance.outTaskNo,
      'orderno': instance.orderNo,
      'po_number': instance.poNumber,
      'storeroomno': instance.storeRoomNo,
      'workstation': instance.workStation,
      'taskcomment': instance.taskComment,
      'schedule_group_name': instance.scheduleGroupName,
      'wip_supplement_flag': instance.wipSupplementFlag,
      'createtime': instance.createTime,
      'status': instance.status,
      'taskqty': instance.taskQty,
      'finishqty': instance.finishQty,
    };

_$OutboundTaskListResponseImpl _$$OutboundTaskListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OutboundTaskListResponseImpl(
  code: json['code'] as String,
  message: json['msg'] as String,
  data: OutboundTaskListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$OutboundTaskListResponseImplToJson(
  _$OutboundTaskListResponseImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

_$OutboundTaskListDataImpl _$$OutboundTaskListDataImplFromJson(
  Map<String, dynamic> json,
) => _$OutboundTaskListDataImpl(
  rows:
      (json['rows'] as List<dynamic>?)
          ?.map((e) => OutboundTask.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$OutboundTaskListDataImplToJson(
  _$OutboundTaskListDataImpl instance,
) => <String, dynamic>{'rows': instance.rows, 'total': instance.total};
