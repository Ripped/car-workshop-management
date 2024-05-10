// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      (json['id'] as num).toInt(),
      $enumDecode(_$ServiceEnumMap, json['servicePerformed']),
      json['description'] as String,
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
      json['appointmentType'] == null
          ? null
          : AppointmentType.fromJson(
              json['appointmentType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'servicePerformed': _$ServiceEnumMap[instance.servicePerformed]!,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'appointmentType': instance.appointmentType,
    };

const _$ServiceEnumMap = {
  Service.electrical: 0,
  Service.mechanical: 1,
  Service.body: 2,
  Service.suspension: 3,
  Service.inspection: 4,
  Service.other: 5,
};
