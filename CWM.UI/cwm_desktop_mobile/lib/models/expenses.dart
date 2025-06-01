import 'package:cwm_desktop_mobile/models/enums/expenses_type.dart';
import 'package:json_annotation/json_annotation.dart';

import 'employee.dart';

part 'expenses.g.dart';

@JsonSerializable()
class Expenses {
  int id;
  String description;
  DateTime date;
  Employee? employee;
  double totalAmount;
  ExpensesType expensesType;

  Expenses(this.id, this.description, this.date, this.employee,
      this.totalAmount, this.expensesType);

  factory Expenses.fromJson(Map<String, dynamic> json) =>
      _$ExpensesFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesToJson(this);
}
