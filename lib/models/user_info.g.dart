// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'id': instance.id,
      'email': instance.email,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
