import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'appointment_blocked_search.g.dart';

@JsonSerializable()
class AppointmentBlockedSearch extends BaseSearch {
  DateTime? blockedDate;

  AppointmentBlockedSearch();

  factory AppointmentBlockedSearch.fromJson(Map<String, dynamic> json) =>
      _$AppointmentBlockedSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppointmentBlockedSearchToJson(this);
}
