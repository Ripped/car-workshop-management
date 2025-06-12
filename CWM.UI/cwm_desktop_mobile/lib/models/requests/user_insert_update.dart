import 'package:cwm_desktop_mobile/models/enums/gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_insert_update.g.dart';

@JsonSerializable()
class UserInsertUpdate {
  String firstName;
  String lastName;
  Gender gender;
  DateTime birthDate;
  String? cityId;
  String? citizenshipId;
  String image;
  String username;
  String password;
  String email;
  String mobile;

  UserInsertUpdate(
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.cityId,
    this.citizenshipId,
    this.image,
    this.username,
    this.password,
    this.email,
    this.mobile,
  );

  factory UserInsertUpdate.fromJson(Map<String, dynamic> json) =>
      _$UserInsertUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$UserInsertUpdateToJson(this);
}
