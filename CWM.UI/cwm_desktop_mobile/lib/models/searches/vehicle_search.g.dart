// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleSearch _$VehicleSearchFromJson(Map<String, dynamic> json) =>
    VehicleSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?
      ..includeServiceHistory = json['includeServiceHistory'] as bool;

Map<String, dynamic> _$VehicleSearchToJson(VehicleSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
      'includeServiceHistory': instance.includeServiceHistory,
    };
