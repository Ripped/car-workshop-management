import 'package:cwm_desktop_mobile/models/list_of_work_order.dart';
import 'package:cwm_desktop_mobile/models/service_report.dart';

import 'package:json_annotation/json_annotation.dart';

part 'work_order_info.g.dart';

@JsonSerializable()
class WorkOrderInfo {
  DateTime workOrderDate;
  double totalAmount;
  List<ListOfWorkOrder> workOrders = [];
  List<ListOfServiceReport> serviceReports = [];

  WorkOrderInfo(this.workOrderDate, this.totalAmount, this.workOrders);

  factory WorkOrderInfo.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkOrderInfoToJson(this);
}
