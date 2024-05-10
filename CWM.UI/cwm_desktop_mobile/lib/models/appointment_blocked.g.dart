// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_blocked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBlocked _$AppointmentBlockedFromJson(Map<String, dynamic> json) =>
    AppointmentBlocked(
      (json['id'] as num).toInt(),
      DateTime.parse(json['blockedDate'] as String),
    );

Map<String, dynamic> _$AppointmentBlockedToJson(AppointmentBlocked instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blockedDate': instance.blockedDate.toIso8601String(),
    };
