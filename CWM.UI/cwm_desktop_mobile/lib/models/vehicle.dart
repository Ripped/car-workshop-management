import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  int id;
  String chassis;
  String brand;
  String model;
  int cubicCapacity;
  int kilowatts;
  String transmision;
  DateTime productionDate;
  String fuel;
  User? user;

  Vehicle(
      this.id,
      this.chassis,
      this.brand,
      this.model,
      this.cubicCapacity,
      this.kilowatts,
      this.transmision,
      this.productionDate,
      this.fuel,
      this.user);

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
