// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_work_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfWorkOrder _$ListOfWorkOrderFromJson(Map<String, dynamic> json) =>
    ListOfWorkOrder(
      json['orderNumber'] as String,
      DateTime.parse(json['startTime'] as String),
      DateTime.parse(json['endTime'] as String),
      (json['totalTime'] as num).toInt(),
      (json['totalSum'] as num).toDouble(),
      $enumDecode(_$ServiceEnumMap, json['servicePerformed']),
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListOfWorkOrderToJson(ListOfWorkOrder instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'totalTime': instance.totalTime,
      'totalSum': instance.totalSum,
      'servicePerformed': _$ServiceEnumMap[instance.servicePerformed]!,
      'user': instance.user,
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
