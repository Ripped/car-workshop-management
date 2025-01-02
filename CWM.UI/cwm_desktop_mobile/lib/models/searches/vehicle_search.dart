import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'vehicle_search.g.dart';

@JsonSerializable()
class VehicleSearch extends BaseSearch {
  String? name;
  int? userId;
  bool includeServiceHistory = false;

  VehicleSearch();

  factory VehicleSearch.fromJson(Map<String, dynamic> json) =>
      _$VehicleSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VehicleSearchToJson(this);
}
