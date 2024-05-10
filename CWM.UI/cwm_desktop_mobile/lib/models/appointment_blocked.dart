import 'package:json_annotation/json_annotation.dart';

part 'appointment_blocked.g.dart';

@JsonSerializable()
class AppointmentBlocked {
  int id;
  DateTime blockedDate;

  AppointmentBlocked(this.id, this.blockedDate);

  factory AppointmentBlocked.fromJson(Map<String, dynamic> json) =>
      _$AppointmentBlockedFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentBlockedToJson(this);
}
