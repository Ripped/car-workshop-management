import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'appointment_type_search.g.dart';

@JsonSerializable()
class AppointmentTypeSearch extends BaseSearch {
  String? name;

  AppointmentTypeSearch();

  factory AppointmentTypeSearch.fromJson(Map<String, dynamic> json) =>
      _$AppointmentTypeSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppointmentTypeSearchToJson(this);
}
