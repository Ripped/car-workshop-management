// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_service_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleServiceHistory _$VehicleServiceHistoryFromJson(
        Map<String, dynamic> json) =>
    VehicleServiceHistory(
      (json['id'] as num).toInt(),
      DateTime.parse(json['serviceDate'] as String),
      $enumDecode(_$ServiceEnumMap, json['serviceType']),
      json['description'] as String,
      json['vehicle'] == null
          ? null
          : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleServiceHistoryToJson(
        VehicleServiceHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceDate': instance.serviceDate.toIso8601String(),
      'serviceType': _$ServiceEnumMap[instance.serviceType]!,
      'description': instance.description,
      'vehicle': instance.vehicle,
    };

const _$ServiceEnumMap = {
  Service.electrical: 0,
  Service.mechanical: 1,
  Service.body: 2,
  Service.suspension: 3,
  Service.inspection: 4,
  Service.other: 5,
};
