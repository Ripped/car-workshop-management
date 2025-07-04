// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_work_order_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartWorkOrderSearch _$PartWorkOrderSearchFromJson(Map<String, dynamic> json) =>
    PartWorkOrderSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..partName = json['partName'] as String?
      ..includeWorkOrder = json['includeWorkOrder'] as bool
      ..includePart = json['includePart'] as bool
      ..userId = (json['userId'] as num?)?.toInt()
      ..vehicleId = (json['vehicleId'] as num?)?.toInt()
      ..workOrderId = (json['workOrderId'] as num?)?.toInt()
      ..serviceDate = json['serviceDate'] == null
          ? null
          : DateTime.parse(json['serviceDate'] as String);

Map<String, dynamic> _$PartWorkOrderSearchToJson(
        PartWorkOrderSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'partName': instance.partName,
      'includeWorkOrder': instance.includeWorkOrder,
      'includePart': instance.includePart,
      'userId': instance.userId,
      'vehicleId': instance.vehicleId,
      'workOrderId': instance.workOrderId,
      'serviceDate': instance.serviceDate?.toIso8601String(),
    };
