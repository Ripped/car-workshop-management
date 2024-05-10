import 'package:json_annotation/json_annotation.dart';

part 'appointment_type.g.dart';

@JsonSerializable()
class AppointmentType {
  int id;
  String name;
  String color;

  AppointmentType(this.id, this.name, this.color);

  factory AppointmentType.fromJson(Map<String, dynamic> json) =>
      _$AppointmentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentTypeToJson(this);
}
