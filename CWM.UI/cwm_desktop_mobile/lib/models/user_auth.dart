import 'package:json_annotation/json_annotation.dart';

import 'enums/role.dart';

part 'user_auth.g.dart';

@JsonSerializable()
class UserAuth {
  int? id;
  String firstName;
  String lastName;
  String? email;
  String? address;
  String? mobile;
  bool? status;
  List<Role> roles = [];

  UserAuth(this.id, this.firstName, this.lastName, this.email, this.address,
      this.mobile, this.status);

  factory UserAuth.fromJson(Map<String, dynamic> json) =>
      _$UserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthToJson(this);
}
