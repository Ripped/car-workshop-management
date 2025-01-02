import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  int id;
  String description;
  DateTime startDate;
  DateTime endDate;
  AppointmentType? appointmentType;
  User? user;
  Vehicle? vehicle;

  Appointment(this.id, this.description, this.startDate, this.endDate,
      this.appointmentType);

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
