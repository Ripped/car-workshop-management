import 'package:cwm_desktop_mobile/models/enums/expenses_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_expenses.g.dart';

@JsonSerializable()
class ReportExpenses {
  double? total;
  ExpensesType? expensesType;

  ReportExpenses(this.total, this.expensesType);

  factory ReportExpenses.fromJson(Map<String, dynamic> json) =>
      _$ReportExpensesFromJson(json);

  Map<String, dynamic> toJson() => _$ReportExpensesToJson(this);
}
