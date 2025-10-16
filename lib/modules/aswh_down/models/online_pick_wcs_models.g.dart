// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_pick_wcs_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlinePickWcsCommandImpl _$$OnlinePickWcsCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlinePickWcsCommandImpl(
      commandId: json['interfaceWmsToWcsId'] as String?,
      taskId: json['taskId'] as String?,
      taskNo: json['taskNo'] as String?,
      proofNo: json['proofno'] as String?,
      proofId: json['proofid'] as String?,
      palletNo: json['palno'] as String?,
      startAddress: json['saddr'] as String?,
      destinationAddress: json['daddr'] as String?,
      stackerNo: json['dvno'] as String?,
      sendTime: json['sendtime2'] as String?,
      state: json['state2'] as String?,
      taskType: json['tasktype2'] as String?,
      changeType: json['changetype2'] as String?,
      ioType: json['typ2'] as String?,
      weightGrade: json['weightGrade2'] as String?,
      heightGrade: json['highGrade2'] as String?,
      errorMessage: json['wcsErrMessage2'] as String?,
    );

Map<String, dynamic> _$$OnlinePickWcsCommandImplToJson(
        _$OnlinePickWcsCommandImpl instance) =>
    <String, dynamic>{
      'interfaceWmsToWcsId': instance.commandId,
      'taskId': instance.taskId,
      'taskNo': instance.taskNo,
      'proofno': instance.proofNo,
      'proofid': instance.proofId,
      'palno': instance.palletNo,
      'saddr': instance.startAddress,
      'daddr': instance.destinationAddress,
      'dvno': instance.stackerNo,
      'sendtime2': instance.sendTime,
      'state2': instance.state,
      'tasktype2': instance.taskType,
      'changetype2': instance.changeType,
      'typ2': instance.ioType,
      'weightGrade2': instance.weightGrade,
      'highGrade2': instance.heightGrade,
      'wcsErrMessage2': instance.errorMessage,
    };
