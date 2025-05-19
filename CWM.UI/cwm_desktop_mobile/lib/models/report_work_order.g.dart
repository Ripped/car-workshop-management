// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_work_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportWorkOrder _$ReportWorkOrderFromJson(Map<String, dynamic> json) =>
    ReportWorkOrder(
      (json['total'] as num).toDouble(),
      (json['totalHours'] as num).toDouble(),
      (json['workOrderInfo'] as List<dynamic>)
          .map((e) => WorkOrderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportWorkOrderToJson(ReportWorkOrder instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHours': instance.totalHours,
      'workOrderInfo': instance.workOrderInfo,
    };
