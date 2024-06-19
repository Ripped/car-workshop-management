// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_service_history_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleServiceHistorySearch _$VehicleServiceHistorySearchFromJson(
        Map<String, dynamic> json) =>
    VehicleServiceHistorySearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?
      ..includeVehicle = json['includeVehicle'] as bool;

Map<String, dynamic> _$VehicleServiceHistorySearchToJson(
        VehicleServiceHistorySearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
      'includeVehicle': instance.includeVehicle,
    };
