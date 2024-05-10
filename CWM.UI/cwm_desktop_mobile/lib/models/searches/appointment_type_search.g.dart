// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_type_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentTypeSearch _$AppointmentTypeSearchFromJson(
        Map<String, dynamic> json) =>
    AppointmentTypeSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?;

Map<String, dynamic> _$AppointmentTypeSearchToJson(
        AppointmentTypeSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
    };
