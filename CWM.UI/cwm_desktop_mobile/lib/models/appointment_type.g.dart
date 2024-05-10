// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentType _$AppointmentTypeFromJson(Map<String, dynamic> json) =>
    AppointmentType(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['color'] as String,
    );

Map<String, dynamic> _$AppointmentTypeToJson(AppointmentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
