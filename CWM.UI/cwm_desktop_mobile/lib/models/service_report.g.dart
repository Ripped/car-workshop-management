// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfServiceReport _$ListOfServiceReportFromJson(Map<String, dynamic> json) =>
    ListOfServiceReport(
      (json['time'] as num).toDouble(),
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      (json['totalTime'] as num).toDouble(),
      $enumDecode(_$ServiceEnumMap, json['servicePerformed']),
      Employee.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListOfServiceReportToJson(
        ListOfServiceReport instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'time': instance.time,
      'totalTime': instance.totalTime,
      'servicePerformed': _$ServiceEnumMap[instance.servicePerformed]!,
      'employee': instance.employee,
    };

const _$ServiceEnumMap = {
  Service.electrical: 0,
  Service.mechanical: 1,
  Service.body: 2,
  Service.suspension: 3,
  Service.inspection: 4,
  Service.other: 5,
};
