// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      (json['id'] as num).toInt(),
      json['description'] as String,
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
      json['appointmentType'] == null
          ? null
          : AppointmentType.fromJson(
              json['appointmentType'] as Map<String, dynamic>),
    )
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>)
      ..vehicle = json['vehicle'] == null
          ? null
          : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>);

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'appointmentType': instance.appointmentType,
      'user': instance.user,
      'vehicle': instance.vehicle,
    };
