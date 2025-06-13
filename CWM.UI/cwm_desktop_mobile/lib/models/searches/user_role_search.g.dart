// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleSearch _$UserRoleSearchFromJson(Map<String, dynamic> json) =>
    UserRoleSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..userUsername = json['userUsername'] as String?
      ..includeUser = json['includeUser'] as bool;

Map<String, dynamic> _$UserRoleSearchToJson(UserRoleSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'userUsername': instance.userUsername,
      'includeUser': instance.includeUser,
    };
