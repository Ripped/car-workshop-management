import 'package:json_annotation/json_annotation.dart';

import 'city.dart';
import 'country.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String firstName;
  String lastName;
  DateTime birthDate;
  DateTime createDate;
  City? city;
  Country? citizenship;
  String image;
  String email;
  String mobile;
  String officePhone;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.birthDate,
      this.createDate,
      this.city,
      this.citizenship,
      this.image,
      this.email,
      this.mobile,
      this.officePhone);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
