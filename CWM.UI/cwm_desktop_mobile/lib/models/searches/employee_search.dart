import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'employee_search.g.dart';

@JsonSerializable()
class EmployeeSearch extends BaseSearch {
  String? name;

  EmployeeSearch();

  factory EmployeeSearch.fromJson(Map<String, dynamic> json) =>
      _$EmployeeSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmployeeSearchToJson(this);
}
