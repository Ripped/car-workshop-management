// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartSearch _$PartSearchFromJson(Map<String, dynamic> json) => PartSearch()
  ..page = json['page'] as int
  ..pageSize = json['pageSize'] as int
  ..name = json['name'] as String?;

Map<String, dynamic> _$PartSearchToJson(PartSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
    };
