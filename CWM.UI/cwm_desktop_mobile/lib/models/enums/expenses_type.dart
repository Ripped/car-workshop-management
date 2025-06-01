import 'package:json_annotation/json_annotation.dart';

enum ExpensesType {
  @JsonValue(0)
  licenca,
  @JsonValue(1)
  edukacija,
  @JsonValue(2)
  hrana,
  @JsonValue(3)
  plata
}
