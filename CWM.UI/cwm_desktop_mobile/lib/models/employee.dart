import 'package:json_annotation/json_annotation.dart';

import 'city.dart';
import 'country.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  int id;
  String firstName;
  String lastName;
  DateTime birthDate;
  City? city;
  Country? citizenship;
  String email;
  String mobile;
  String adress;

  Employee(this.id, this.firstName, this.lastName, this.birthDate, this.city,
      this.citizenship, this.email, this.mobile, this.adress);

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
