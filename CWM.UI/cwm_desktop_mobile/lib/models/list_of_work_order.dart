import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_of_work_order.g.dart';

@JsonSerializable()
class ListOfWorkOrder {
  String orderNumber;
  DateTime startTime;
  DateTime endTime;
  int totalTime;
  double totalSum;
  Service servicePerformed;
  User user;
  Employee? employee;

  ListOfWorkOrder(
      this.orderNumber,
      this.startTime,
      this.endTime,
      this.totalTime,
      this.totalSum,
      this.servicePerformed,
      this.user,
      this.employee);

  factory ListOfWorkOrder.fromJson(Map<String, dynamic> json) =>
      _$ListOfWorkOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfWorkOrderToJson(this);
}
