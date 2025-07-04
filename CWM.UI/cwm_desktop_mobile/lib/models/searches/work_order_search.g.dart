// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderSearch _$WorkOrderSearchFromJson(Map<String, dynamic> json) =>
    WorkOrderSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..name = json['name'] as String?
      ..includeVehicle = json['includeVehicle'] as bool
      ..includePayment = json['includePayment'] as bool
      ..appointmentId = (json['appointmentId'] as num?)?.toInt()
      ..employeeUsername = json['employeeUsername'] as String?
      ..userId = (json['userId'] as num?)?.toInt();

Map<String, dynamic> _$WorkOrderSearchToJson(WorkOrderSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'name': instance.name,
      'includeVehicle': instance.includeVehicle,
      'includePayment': instance.includePayment,
      'appointmentId': instance.appointmentId,
      'employeeUsername': instance.employeeUsername,
      'userId': instance.userId,
    };
