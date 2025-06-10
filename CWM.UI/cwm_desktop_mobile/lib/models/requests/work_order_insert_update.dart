import 'package:cwm_desktop_mobile/models/enums/garage_box.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_order_insert_update.g.dart';

@JsonSerializable()
class WorkOrderInsertUpdate {
  String orderNumber;
  double total;
  bool payment;
  DateTime startTime;
  DateTime endTime;
  GarageBox garageBox;
  Service servicePerformed;
  String concerne;
  String description;
  String sugestions;
  String? vehicleId;
  String? userId;
  String? appointmentId;
  String? employeeId;

  WorkOrderInsertUpdate(
      this.orderNumber,
      this.total,
      this.payment,
      this.startTime,
      this.endTime,
      this.garageBox,
      this.servicePerformed,
      this.concerne,
      this.description,
      this.sugestions,
      this.vehicleId,
      this.userId,
      this.appointmentId,
      this.employeeId);

  factory WorkOrderInsertUpdate.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderInsertUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkOrderInsertUpdateToJson(this);
}
