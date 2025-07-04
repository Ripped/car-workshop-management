// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentSearch _$AppointmentSearchFromJson(Map<String, dynamic> json) =>
    AppointmentSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..serviceName = json['serviceName'] as String?
      ..appointmentId = json['appointmentId'] as String?
      ..userId = (json['userId'] as num?)?.toInt()
      ..appointmentTypeId = (json['appointmentTypeId'] as num?)?.toInt()
      ..includeUser = json['includeUser'] as bool
      ..includeAppointmentType = json['includeAppointmentType'] as bool;

Map<String, dynamic> _$AppointmentSearchToJson(AppointmentSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'serviceName': instance.serviceName,
      'appointmentId': instance.appointmentId,
      'userId': instance.userId,
      'appointmentTypeId': instance.appointmentTypeId,
      'includeUser': instance.includeUser,
      'includeAppointmentType': instance.includeAppointmentType,
    };
