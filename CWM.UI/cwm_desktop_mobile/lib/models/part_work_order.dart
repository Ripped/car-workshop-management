import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:cwm_desktop_mobile/models/work_order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_work_order.g.dart';

@JsonSerializable()
class PartWorkOrder {
  int id;
  DateTime serviceDate;
  Vehicle? vehicle;
  WorkOrder? workOrder;
  Part? part;

  PartWorkOrder(
    this.id,
    this.serviceDate,
    this.vehicle,
    this.workOrder,
    this.part,
  );

  factory PartWorkOrder.fromJson(Map<String, dynamic> json) =>
      _$PartWorkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PartWorkOrderToJson(this);
}
