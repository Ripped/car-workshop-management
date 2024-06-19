import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_service_history.g.dart';

@JsonSerializable()
class VehicleServiceHistory {
  int id;
  DateTime serviceDate;
  Service service;
  String description;
  Vehicle? vehicle;

  VehicleServiceHistory(
      this.id, this.serviceDate, this.service, this.description, this.vehicle);

  factory VehicleServiceHistory.fromJson(Map<String, dynamic> json) =>
      _$VehicleServiceHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleServiceHistoryToJson(this);
}
