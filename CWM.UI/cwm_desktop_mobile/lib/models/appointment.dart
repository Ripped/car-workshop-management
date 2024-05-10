import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  int id;
  Service servicePerformed;
  String description;
  DateTime startDate;
  DateTime endDate;
  AppointmentType? appointmentType;

  Appointment(this.id, this.servicePerformed, this.description, this.startDate,
      this.endDate, this.appointmentType);

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
