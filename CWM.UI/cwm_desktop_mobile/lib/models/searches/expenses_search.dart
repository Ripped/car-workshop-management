import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'expenses_search.g.dart';

@JsonSerializable()
class ExpensesSearch extends BaseSearch {
  String? dateFrom;
  String? dateTo;
  String? description;

  ExpensesSearch();

  factory ExpensesSearch.fromJson(Map<String, dynamic> json) =>
      _$ExpensesSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExpensesSearchToJson(this);
}
