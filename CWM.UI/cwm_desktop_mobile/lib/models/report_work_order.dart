import 'package:cwm_desktop_mobile/models/work_order_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_work_order.g.dart';

@JsonSerializable()
class ReportWorkOrder {
  double total;
  double totalHours;
  List<WorkOrderInfo> workOrderInfo = [];

  ReportWorkOrder(this.total, this.totalHours, this.workOrderInfo);

  factory ReportWorkOrder.fromJson(Map<String, dynamic> json) =>
      _$ReportWorkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ReportWorkOrderToJson(this);
}
