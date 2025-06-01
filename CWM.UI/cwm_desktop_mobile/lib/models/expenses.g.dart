// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expenses _$ExpensesFromJson(Map<String, dynamic> json) => Expenses(
      (json['id'] as num).toInt(),
      json['description'] as String,
      DateTime.parse(json['date'] as String),
      json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
      (json['totalAmount'] as num).toDouble(),
      $enumDecode(_$ExpensesTypeEnumMap, json['expensesType']),
    );

Map<String, dynamic> _$ExpensesToJson(Expenses instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'employee': instance.employee,
      'totalAmount': instance.totalAmount,
      'expensesType': _$ExpensesTypeEnumMap[instance.expensesType]!,
    };

const _$ExpensesTypeEnumMap = {
  ExpensesType.licenca: 0,
  ExpensesType.edukacija: 1,
  ExpensesType.hrana: 2,
  ExpensesType.plata: 3,
};
