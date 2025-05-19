import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_report.g.dart';

@JsonSerializable()
class ListOfServiceReport {
  DateTime startTime;
  DateTime endTime;
  double time;
  double totalTime;
  Service servicePerformed;
  Employee employee;

  ListOfServiceReport(this.time, this.startTime, this.endTime, this.totalTime,
      this.servicePerformed, this.employee);

  factory ListOfServiceReport.fromJson(Map<String, dynamic> json) =>
      _$ListOfServiceReportFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfServiceReportToJson(this);
}
