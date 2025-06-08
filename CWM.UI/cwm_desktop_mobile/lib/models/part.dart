import 'package:json_annotation/json_annotation.dart';

part 'part.g.dart';

@JsonSerializable()
class Part {
  int id;
  String serialNumber;
  String manufacturer;
  String partName;
  String? image;
  double price;
  String description;

  Part(this.id, this.serialNumber, this.manufacturer, this.partName, this.image,
      this.price, this.description);

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  Map<String, dynamic> toJson() => _$PartToJson(this);
}
