// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrder _$WorkOrderFromJson(Map<String, dynamic> json) => WorkOrder(
      (json['id'] as num).toInt(),
      json['orderNumber'] as String,
      (json['total'] as num).toDouble(),
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      $enumDecode(_$GarageBoxEnumMap, json['garageBox']),
      $enumDecode(_$ServiceEnumMap, json['servicePerformed']),
      json['concerne'] as String,
      json['description'] as String,
      json['sugestions'] as String,
      json['vehicle'] == null
          ? null
          : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['appointment'] == null
          ? null
          : Appointment.fromJson(json['appointment'] as Map<String, dynamic>),
    )..employee = json['employee'] == null
        ? null
        : Employee.fromJson(json['employee'] as Map<String, dynamic>);

Map<String, dynamic> _$WorkOrderToJson(WorkOrder instance) => <String, dynamic>{
      'id': instance.id,
      'orderNumber': instance.orderNumber,
      'total': instance.total,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'garageBox': _$GarageBoxEnumMap[instance.garageBox]!,
      'servicePerformed': _$ServiceEnumMap[instance.servicePerformed]!,
      'concerne': instance.concerne,
      'description': instance.description,
      'sugestions': instance.sugestions,
      'vehicle': instance.vehicle,
      'user': instance.user,
      'appointment': instance.appointment,
      'employee': instance.employee,
    };

const _$GarageBoxEnumMap = {
  GarageBox.box_1: 0,
  GarageBox.box_2: 1,
  GarageBox.box_3: 2,
  GarageBox.box_4: 3,
  GarageBox.box_5: 4,
  GarageBox.box_6: 5,
};

const _$ServiceEnumMap = {
  Service.electrical: 0,
  Service.mechanical: 1,
  Service.body: 2,
  Service.suspension: 3,
  Service.inspection: 4,
  Service.other: 5,
};
