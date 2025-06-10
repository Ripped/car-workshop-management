// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_insert_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderInsertUpdate _$WorkOrderInsertUpdateFromJson(
        Map<String, dynamic> json) =>
    WorkOrderInsertUpdate(
      json['orderNumber'] as String,
      (json['total'] as num).toDouble(),
      json['payment'] as bool,
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      $enumDecode(_$GarageBoxEnumMap, json['garageBox']),
      $enumDecode(_$ServiceEnumMap, json['servicePerformed']),
      json['concerne'] as String,
      json['description'] as String,
      json['sugestions'] as String,
      json['vehicleId'] as String?,
      json['userId'] as String?,
      json['appointmentId'] as String?,
      json['employeeId'] as String?,
    );

Map<String, dynamic> _$WorkOrderInsertUpdateToJson(
        WorkOrderInsertUpdate instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'total': instance.total,
      'payment': instance.payment,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'garageBox': _$GarageBoxEnumMap[instance.garageBox]!,
      'servicePerformed': _$ServiceEnumMap[instance.servicePerformed]!,
      'concerne': instance.concerne,
      'description': instance.description,
      'sugestions': instance.sugestions,
      'vehicleId': instance.vehicleId,
      'userId': instance.userId,
      'appointmentId': instance.appointmentId,
      'employeeId': instance.employeeId,
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
