// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSearch _$NotificationSearchFromJson(Map<String, dynamic> json) =>
    NotificationSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?
      ..includeUser = json['includeUser'] as bool;

Map<String, dynamic> _$NotificationSearchToJson(NotificationSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
      'includeUser': instance.includeUser,
    };
