import 'package:json_annotation/json_annotation.dart';

enum Service {
  @JsonValue(0)
  electrical,
  @JsonValue(1)
  mechanical,
  @JsonValue(2)
  body,
  @JsonValue(3)
  suspension,
  @JsonValue(4)
  inspection,
  @JsonValue(5)
  other
}
