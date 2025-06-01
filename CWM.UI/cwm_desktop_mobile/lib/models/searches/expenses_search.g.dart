// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesSearch _$ExpensesSearchFromJson(Map<String, dynamic> json) =>
    ExpensesSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..dateFrom = json['dateFrom'] as String?
      ..dateTo = json['dateTo'] as String?;

Map<String, dynamic> _$ExpensesSearchToJson(ExpensesSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'dateFrom': instance.dateFrom,
      'dateTo': instance.dateTo,
    };
