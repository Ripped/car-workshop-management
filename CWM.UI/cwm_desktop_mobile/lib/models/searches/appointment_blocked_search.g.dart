// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_blocked_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBlockedSearch _$AppointmentBlockedSearchFromJson(
        Map<String, dynamic> json) =>
    AppointmentBlockedSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..blockedDate = json['blockedDate'] == null
          ? null
          : DateTime.parse(json['blockedDate'] as String);

Map<String, dynamic> _$AppointmentBlockedSearchToJson(
        AppointmentBlockedSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'blockedDate': instance.blockedDate?.toIso8601String(),
    };
