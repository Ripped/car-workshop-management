// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_expenses_total.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportExpensesTotal _$ReportExpensesTotalFromJson(Map<String, dynamic> json) =>
    ReportExpensesTotal(
      (json['total'] as num?)?.toDouble(),
      (json['reportExpenses'] as List<dynamic>?)
          ?.map((e) => ReportExpenses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportExpensesTotalToJson(
        ReportExpensesTotal instance) =>
    <String, dynamic>{
      'total': instance.total,
      'reportExpenses': instance.reportExpenses,
    };
