// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbound_task_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutboundTaskItemImpl _$$OutboundTaskItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OutboundTaskItemImpl(
      outTaskItemId: (json['outtaskitemid'] as num).toInt(),
      matCode: json['matcode'] as String,
      matName: json['matname'] as String,
      matInnerCode: json['matinnercode'] as String?,
      storeSiteNo: json['storesiteno'] as String,
      storeRoomNo: json['storeroomno'] as String,
      subInventoryCode: json['subinventoryCode'] as String,
      hintQty: (json['hintqty'] as num).toInt(),
      hintBatchNo: json['hintbatchno'] as String?,
      sn: json['sn'] as String?,
      orderNo: json['orderno'] as String,
    );

Map<String, dynamic> _$$OutboundTaskItemImplToJson(
        _$OutboundTaskItemImpl instance) =>
    <String, dynamic>{
      'outtaskitemid': instance.outTaskItemId,
      'matcode': instance.matCode,
      'matname': instance.matName,
      'matinnercode': instance.matInnerCode,
      'storesiteno': instance.storeSiteNo,
      'storeroomno': instance.storeRoomNo,
      'subinventoryCode': instance.subInventoryCode,
      'hintqty': instance.hintQty,
      'hintbatchno': instance.hintBatchNo,
      'sn': instance.sn,
      'orderno': instance.orderNo,
    };

_$OutboundTaskItemQueryImpl _$$OutboundTaskItemQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$OutboundTaskItemQueryImpl(
      outTaskId: json['outtaskid'] as String,
      workStation: json['workstation'] as String,
      searchKey: json['searchKey'] as String? ?? '',
      userId: json['userId'] as String,
      roleOrUserId: json['roleoRuserId'] as String,
      roomTag: json['roomTag'] as String? ?? '0',
      batchFlag: json['batchflag'] as String? ?? '0',
      transferType: json['transferType'] as String? ?? '0',
      beatFlag: json['beatflag'] as String? ?? 'N',
      pageIndex: (json['PageIndex'] as num?)?.toInt() ?? 1,
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$OutboundTaskItemQueryImplToJson(
        _$OutboundTaskItemQueryImpl instance) =>
    <String, dynamic>{
      'outtaskid': instance.outTaskId,
      'workstation': instance.workStation,
      'searchKey': instance.searchKey,
      'userId': instance.userId,
      'roleoRuserId': instance.roleOrUserId,
      'roomTag': instance.roomTag,
      'batchflag': instance.batchFlag,
      'transferType': instance.transferType,
      'beatflag': instance.beatFlag,
      'PageIndex': instance.pageIndex,
      'PageSize': instance.pageSize,
    };

_$OutboundTaskItemListDataImpl _$$OutboundTaskItemListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$OutboundTaskItemListDataImpl(
      rows: (json['rows'] as List<dynamic>)
          .map((e) => OutboundTaskItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$OutboundTaskItemListDataImplToJson(
        _$OutboundTaskItemListDataImpl instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'total': instance.total,
    };

_$OutboundTaskItemListResponseImpl _$$OutboundTaskItemListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OutboundTaskItemListResponseImpl(
      code: json['code'] as String,
      message: json['msg'] as String,
      data: OutboundTaskItemListData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OutboundTaskItemListResponseImplToJson(
        _$OutboundTaskItemListResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'data': instance.data,
    };

_$MaterialInfoResponseImpl _$$MaterialInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MaterialInfoResponseImpl(
      code: json['code'] as String,
      message: json['msg'] as String,
      data: MaterialInfo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MaterialInfoResponseImplToJson(
        _$MaterialInfoResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
      'data': instance.data,
    };

_$MaterialInfoImpl _$$MaterialInfoImplFromJson(Map<String, dynamic> json) =>
    _$MaterialInfoImpl(
      matCode: json['matcode'] as String,
    );

Map<String, dynamic> _$$MaterialInfoImplToJson(_$MaterialInfoImpl instance) =>
    <String, dynamic>{
      'matcode': instance.matCode,
    };

_$CancelTaskResponseImpl _$$CancelTaskResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CancelTaskResponseImpl(
      code: json['code'] as String,
      message: json['msg'] as String,
    );

Map<String, dynamic> _$$CancelTaskResponseImplToJson(
        _$CancelTaskResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.message,
    };
