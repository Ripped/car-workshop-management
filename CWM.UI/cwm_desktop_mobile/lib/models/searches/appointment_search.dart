import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'appointment_search.g.dart';

@JsonSerializable()
class AppointmentSearch extends BaseSearch {
  String? serviceName;
  String? appointmentId;
  int? userId;
  bool includeUser = false;
  bool includeAppointmentType = false;

  AppointmentSearch();

  factory AppointmentSearch.fromJson(Map<String, dynamic> json) =>
      _$AppointmentSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppointmentSearchToJson(this);
}
