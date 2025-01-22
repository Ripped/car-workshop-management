// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_insert_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentInsertUpdate _$AppointmentInsertUpdateFromJson(
        Map<String, dynamic> json) =>
    AppointmentInsertUpdate(
      json['description'] as String,
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      json['userId'] as String?,
      json['appointmentTypeId'] as String?,
      json['vehicleId'] as String?,
    );

Map<String, dynamic> _$AppointmentInsertUpdateToJson(
        AppointmentInsertUpdate instance) =>
    <String, dynamic>{
      'description': instance.description,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'userId': instance.userId,
      'appointmentTypeId': instance.appointmentTypeId,
      'vehicleId': instance.vehicleId,
    };
