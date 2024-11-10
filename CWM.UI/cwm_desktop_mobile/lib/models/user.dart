import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String firstName;
  String lastName;
  String? email;
  String? address;
  String? mobile;
  bool? status;

  User(this.id, this.firstName, this.lastName, this.email, this.address,
      this.mobile, this.status);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
