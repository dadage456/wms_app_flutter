// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoodsUpTaskItemQueryRequestImpl _$$GoodsUpTaskItemQueryRequestImplFromJson(
  Map<String, dynamic> json,
) => _$GoodsUpTaskItemQueryRequestImpl(
  inTaskNo: json['intaskno'] as String? ?? '',
  storeRoomNo: json['storeroomno'] as String? ?? '',
  forceSite: json['forcesite'] as String? ?? '',
  forceBatch: json['forcebatch'] as String? ?? '',
  taskComment: json['taskcomment'] as String? ?? '',
  taskFinishFlag: json['taskFinishFlag'] as String? ?? '0',
  roomTag: json['roomtag'] as String? ?? '0',
  workStation: json['workstation'] as String? ?? '',
  finishFlag: json['finshFlg'] as String? ?? '0',
  sortType: json['sortType'] as String? ?? '',
  sortColumn: json['sortColumn'] as String? ?? '',
  searchKey: json['searchKey'] as String? ?? '',
  beatFlag: json['beatflag'] as String? ?? 'N',
  collecter: (json['collecter'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$GoodsUpTaskItemQueryRequestImplToJson(
  _$GoodsUpTaskItemQueryRequestImpl instance,
) => <String, dynamic>{
  'intaskno': instance.inTaskNo,
  'storeroomno': instance.storeRoomNo,
  'forcesite': instance.forceSite,
  'forcebatch': instance.forceBatch,
  'taskcomment': instance.taskComment,
  'taskFinishFlag': instance.taskFinishFlag,
  'roomtag': instance.roomTag,
  'workstation': instance.workStation,
  'finshFlg': instance.finishFlag,
  'sortType': instance.sortType,
  'sortColumn': instance.sortColumn,
  'searchKey': instance.searchKey,
  'beatflag': instance.beatFlag,
  'collecter': instance.collecter,
};
