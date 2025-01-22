import 'package:json_annotation/json_annotation.dart';

part 'appointment_insert_update.g.dart';

@JsonSerializable()
class AppointmentInsertUpdate {
  String description;
  DateTime startTime;
  DateTime endTime;
  String? userId;
  String? appointmentTypeId;
  String? vehicleId;

  AppointmentInsertUpdate(
    this.description,
    this.startTime,
    this.endTime,
    this.userId,
    this.appointmentTypeId,
    this.vehicleId,
  );

  factory AppointmentInsertUpdate.fromJson(Map<String, dynamic> json) =>
      _$AppointmentInsertUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentInsertUpdateToJson(this);
}
