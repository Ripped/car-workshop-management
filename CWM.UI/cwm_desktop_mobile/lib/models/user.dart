import 'package:cwm_desktop_mobile/models/enums/gender.dart';
import 'package:json_annotation/json_annotation.dart';

import 'city.dart';
import 'country.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String firstName;
  String lastName;
  Gender gender;
  DateTime birthDate;
  City? city;
  Country? citizenship;
  String? image;
  String email;
  String mobile;
  String username;
  String password;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.birthDate,
      this.city,
      this.citizenship,
      this.image,
      this.email,
      this.mobile,
      this.username,
      this.password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
