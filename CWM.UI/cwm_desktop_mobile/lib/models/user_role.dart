import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_role.g.dart';

@JsonSerializable()
class UserRole {
  int id;
  User? user;
  Role role;

  UserRole(
    this.id,
    this.user,
    this.role,
  );

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
}
