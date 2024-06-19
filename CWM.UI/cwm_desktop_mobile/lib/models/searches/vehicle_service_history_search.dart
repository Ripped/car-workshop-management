import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'vehicle_service_history_search.g.dart';

@JsonSerializable()
class VehicleServiceHistorySearch extends BaseSearch {
  String? name;
  bool includeVehicle = false;

  VehicleServiceHistorySearch();

  factory VehicleServiceHistorySearch.fromJson(Map<String, dynamic> json) =>
      _$VehicleServiceHistorySearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$VehicleServiceHistorySearchToJson(this);
}
