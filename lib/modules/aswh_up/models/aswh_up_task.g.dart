// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aswh_up_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AswhUpTaskAdapter extends TypeAdapter<AswhUpTask> {
  @override
  final int typeId = 20;

  @override
  AswhUpTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AswhUpTask(
      inTaskId: fields[0] as int,
      inTaskNo: fields[1] as String,
      inboundOrderNo: fields[2] as String?,
      sourceOrderNo: fields[3] as String?,
      storeRoomNo: fields[4] as String?,
      workStation: fields[5] as String?,
      partnerName: fields[6] as String?,
      taskComment: fields[7] as String?,
      taskQty: fields[8] as num,
      finishQty: fields[9] as num,
    );
  }

  @override
  void write(BinaryWriter writer, AswhUpTask obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.inTaskId)
      ..writeByte(1)
      ..write(obj.inTaskNo)
      ..writeByte(2)
      ..write(obj.inboundOrderNo)
      ..writeByte(3)
      ..write(obj.sourceOrderNo)
      ..writeByte(4)
      ..write(obj.storeRoomNo)
      ..writeByte(5)
      ..write(obj.workStation)
      ..writeByte(6)
      ..write(obj.partnerName)
      ..writeByte(7)
      ..write(obj.taskComment)
      ..writeByte(8)
      ..write(obj.taskQty)
      ..writeByte(9)
      ..write(obj.finishQty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AswhUpTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AswhUpTaskImpl _$$AswhUpTaskImplFromJson(Map<String, dynamic> json) =>
    _$AswhUpTaskImpl(
      inTaskId: (json['intaskid'] as num?)?.toInt() ?? 0,
      inTaskNo: json['intaskno'] as String? ?? '',
      inboundOrderNo: json['data2'] as String?,
      sourceOrderNo: json['data3'] as String?,
      storeRoomNo: json['storeroomno'] as String?,
      workStation: json['workstation'] as String?,
      partnerName: json['parname'] as String?,
      taskComment: json['taskcomment'] as String?,
      taskQty: json['taskqty'] as num? ?? 0,
      finishQty: json['finishqty'] as num? ?? 0,
    );

Map<String, dynamic> _$$AswhUpTaskImplToJson(_$AswhUpTaskImpl instance) =>
    <String, dynamic>{
      'intaskid': instance.inTaskId,
      'intaskno': instance.inTaskNo,
      'data2': instance.inboundOrderNo,
      'data3': instance.sourceOrderNo,
      'storeroomno': instance.storeRoomNo,
      'workstation': instance.workStation,
      'parname': instance.partnerName,
      'taskcomment': instance.taskComment,
      'taskqty': instance.taskQty,
      'finishqty': instance.finishQty,
    };

_$AswhUpTaskListDataImpl _$$AswhUpTaskListDataImplFromJson(
        Map<String, dynamic> json) =>
    _$AswhUpTaskListDataImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      rows: (json['rows'] as List<dynamic>?)
              ?.map((e) => AswhUpTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AswhUpTask>[],
    );

Map<String, dynamic> _$$AswhUpTaskListDataImplToJson(
        _$AswhUpTaskListDataImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rows': instance.rows,
    };

_$AswhUpTaskQueryImpl _$$AswhUpTaskQueryImplFromJson(
        Map<String, dynamic> json) =>
    _$AswhUpTaskQueryImpl(
      sortType: json['sortType'] as String? ?? '',
      sortColumn: json['sortColumn'] as String? ?? '',
      searchKey: json['searchKey'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
  roleOrUserId: json['roleoRuserId'] as String? ?? '',
  roomTag: json['roomtag'] as String? ?? '0',
  batchFlag: json['batchflag'] as String? ?? '0',
  transferType: json['transferType'] as String? ?? '0',
  beatFlag: json['beatflag'] as String? ?? 'N',
  pageIndex: (() {
    final parsed = _stringToInt(json['PageIndex']);
    return parsed == 0 ? 1 : parsed;
  })(),
  pageSize: (() {
    final parsed = _stringToInt(json['PageSize']);
    return parsed == 0 ? 100 : parsed;
  })(),
  finishFlag: json['finshFlg'] as String? ?? '0',
    );

Map<String, dynamic> _$$AswhUpTaskQueryImplToJson(
        _$AswhUpTaskQueryImpl instance) =>
    <String, dynamic>{
      'sortType': instance.sortType,
      'sortColumn': instance.sortColumn,
      'searchKey': instance.searchKey,
      'userId': instance.userId,
      'roleoRuserId': instance.roleOrUserId,
      'roomtag': instance.roomTag,
      'batchflag': instance.batchFlag,
      'transferType': instance.transferType,
      'beatflag': instance.beatFlag,
      'PageIndex': _intToString(instance.pageIndex),
      'PageSize': _intToString(instance.pageSize),
      'finshFlg': instance.finishFlag,
    };
