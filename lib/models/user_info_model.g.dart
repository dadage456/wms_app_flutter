// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoModelImpl _$$UserInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoModelImpl(
      userId: (json['userId'] as num).toInt(),
      deptId: (json['deptId'] as num).toInt(),
      userName: json['userName'] as String,
      nickName: json['nickName'] as String,
      sex: json['sex'] as String,
      avatar: json['avatar'] as String?,
      status: json['status'] as String,
      delFlag: json['delFlag'] as String,
    );

Map<String, dynamic> _$$UserInfoModelImplToJson(_$UserInfoModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'deptId': instance.deptId,
      'userName': instance.userName,
      'nickName': instance.nickName,
      'sex': instance.sex,
      'avatar': instance.avatar,
      'status': instance.status,
      'delFlag': instance.delFlag,
    };
