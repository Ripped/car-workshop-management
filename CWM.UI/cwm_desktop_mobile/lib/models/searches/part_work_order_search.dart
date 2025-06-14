import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'part_work_order_search.g.dart';

@JsonSerializable()
class PartWorkOrderSearch extends BaseSearch {
  bool includeWorkOrder = false;
  bool includePart = false;
  int? userId;
  int? vehicleId;
  int? workOrderId;
  DateTime? serviceDate;

  PartWorkOrderSearch();

  factory PartWorkOrderSearch.fromJson(Map<String, dynamic> json) =>
      _$PartWorkOrderSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartWorkOrderSearchToJson(this);
}
