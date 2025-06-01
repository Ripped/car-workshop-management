import 'package:cwm_desktop_mobile/models/report_expenses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_expenses_total.g.dart';

@JsonSerializable()
class ReportExpensesTotal {
  double? total;
  List<ReportExpenses>? reportExpenses = [];

  ReportExpensesTotal(this.total, this.reportExpenses);

  factory ReportExpensesTotal.fromJson(Map<String, dynamic> json) =>
      _$ReportExpensesTotalFromJson(json);

  Map<String, dynamic> toJson() => _$ReportExpensesTotalToJson(this);
}
