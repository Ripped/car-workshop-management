// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportExpenses _$ReportExpensesFromJson(Map<String, dynamic> json) =>
    ReportExpenses(
      (json['total'] as num?)?.toDouble(),
      $enumDecodeNullable(_$ExpensesTypeEnumMap, json['expensesType']),
    );

Map<String, dynamic> _$ReportExpensesToJson(ReportExpenses instance) =>
    <String, dynamic>{
      'total': instance.total,
      'expensesType': _$ExpensesTypeEnumMap[instance.expensesType],
    };

const _$ExpensesTypeEnumMap = {
  ExpensesType.licenca: 0,
  ExpensesType.edukacija: 1,
  ExpensesType.hrana: 2,
  ExpensesType.plata: 3,
};
