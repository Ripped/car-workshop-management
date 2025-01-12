// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeSearch _$EmployeeSearchFromJson(Map<String, dynamic> json) =>
    EmployeeSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?;

Map<String, dynamic> _$EmployeeSearchToJson(EmployeeSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
    };
