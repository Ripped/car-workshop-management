import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_service_history.g.dart';

@JsonSerializable()
class VehicleServiceHistory {
  int id;
  DateTime serviceDate;
  Service serviceType;
  String description;
  String sugestions;
  Vehicle? vehicle;
  Employee? employee;
  User? user;

  VehicleServiceHistory(
      this.id,
      this.serviceDate,
      this.serviceType,
      this.description,
      this.sugestions,
      this.vehicle,
      this.employee,
      this.user);

  factory VehicleServiceHistory.fromJson(Map<String, dynamic> json) =>
      _$VehicleServiceHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleServiceHistoryToJson(this);
}
