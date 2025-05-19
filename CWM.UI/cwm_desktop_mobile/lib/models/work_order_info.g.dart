// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkOrderInfo _$WorkOrderInfoFromJson(Map<String, dynamic> json) =>
    WorkOrderInfo(
      DateTime.parse(json['workOrderDate'] as String),
      (json['totalAmount'] as num).toDouble(),
      (json['workOrders'] as List<dynamic>)
          .map((e) => ListOfWorkOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..serviceReports = (json['serviceReports'] as List<dynamic>)
        .map((e) => ListOfServiceReport.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$WorkOrderInfoToJson(WorkOrderInfo instance) =>
    <String, dynamic>{
      'workOrderDate': instance.workOrderDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'workOrders': instance.workOrders,
      'serviceReports': instance.serviceReports,
    };
