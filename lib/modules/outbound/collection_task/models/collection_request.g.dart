// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionTaskItemQueryImpl _$$CollectionTaskItemQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectionTaskItemQueryImpl(
      outTaskNo: json['outtaskno'] as String? ?? '',
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

Map<String, dynamic> _$$CollectionTaskItemQueryImplToJson(
        _$CollectionTaskItemQueryImpl instance) =>
    <String, dynamic>{
      'outtaskno': instance.outTaskNo,
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
