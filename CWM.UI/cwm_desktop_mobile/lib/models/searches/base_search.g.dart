// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSearch _$BaseSearchFromJson(Map<String, dynamic> json) => BaseSearch()
  ..page = (json['page'] as num).toInt()
  ..pageSize = (json['pageSize'] as num).toInt();

Map<String, dynamic> _$BaseSearchToJson(BaseSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
