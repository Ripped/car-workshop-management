import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/garage_box.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'appointment.dart';
import 'vehicle.dart';

part 'work_order.g.dart';

@JsonSerializable()
class WorkOrder {
  int id;
  String orderNumber;
  double total;
  DateTime startTime;
  DateTime endTime;
  GarageBox garageBox;
  Service servicePerformed;
  String concerne;
  String description;
  String sugestions;
  Vehicle? vehicle;
  User? user;
  Appointment? appointment;
  Employee? employee;

  WorkOrder(
      this.id,
      this.orderNumber,
      this.total,
      this.startTime,
      this.endTime,
      this.garageBox,
      this.servicePerformed,
      this.concerne,
      this.description,
      this.sugestions,
      this.vehicle,
      this.user,
      this.appointment);

  factory WorkOrder.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$WorkOrderToJson(this);
}
