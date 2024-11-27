import 'package:cwm_desktop_mobile/models/enums/garage_box.dart';
import 'package:json_annotation/json_annotation.dart';
import 'appointment.dart';
import 'vehicle.dart';

part 'work_order.g.dart';

@JsonSerializable()
class WorkOrder {
  int id;
  String orderNumber;
  DateTime startTime;
  DateTime endTime;
  GarageBox garageBox;
  String concerne;
  String description;
  String sugestions;
  Vehicle? vehicle;
  Appointment? appointment;

  WorkOrder(
      this.id,
      this.orderNumber,
      this.startTime,
      this.endTime,
      this.garageBox,
      this.concerne,
      this.description,
      this.sugestions,
      this.vehicle,
      this.appointment);

  factory WorkOrder.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$WorkOrderToJson(this);
}
