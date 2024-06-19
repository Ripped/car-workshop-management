import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'work_order_search.g.dart';

@JsonSerializable()
class WorkOrderSearch extends BaseSearch {
  String? name;
  bool includeVehicle = false;

  WorkOrderSearch();

  factory WorkOrderSearch.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WorkOrderSearchToJson(this);
}
