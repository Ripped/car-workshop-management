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
      ..includeVehicle = json['includeVehicle'] as bool
      ..vehicleId = (json['vehicleId'] as num?)?.toInt()
      ..serviceDate = json['serviceDate'] == null
          ? null
          : DateTime.parse(json['serviceDate'] as String);

Map<String, dynamic> _$VehicleServiceHistorySearchToJson(
        VehicleServiceHistorySearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
      'includeVehicle': instance.includeVehicle,
      'vehicleId': instance.vehicleId,
      'serviceDate': instance.serviceDate?.toIso8601String(),
    };
