import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue(0)
  admin,
  @JsonValue(1)
  employee,
  @JsonValue(2)
  user
}
