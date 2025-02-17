// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_work_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartWorkOrder _$PartWorkOrderFromJson(Map<String, dynamic> json) =>
    PartWorkOrder(
      (json['id'] as num).toInt(),
      DateTime.parse(json['serviceDate'] as String),
      json['vehicle'] == null
          ? null
          : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      json['workOrder'] == null
          ? null
          : WorkOrder.fromJson(json['workOrder'] as Map<String, dynamic>),
      json['part'] == null
          ? null
          : Part.fromJson(json['part'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartWorkOrderToJson(PartWorkOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceDate': instance.serviceDate.toIso8601String(),
      'vehicle': instance.vehicle,
      'workOrder': instance.workOrder,
      'part': instance.part,
    };
