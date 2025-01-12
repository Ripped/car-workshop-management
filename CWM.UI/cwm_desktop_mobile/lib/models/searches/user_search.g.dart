// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearch _$UserSearchFromJson(Map<String, dynamic> json) => UserSearch()
  ..page = (json['page'] as num).toInt()
  ..pageSize = (json['pageSize'] as num).toInt()
  ..name = json['name'] as String?;

Map<String, dynamic> _$UserSearchToJson(UserSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
    };
