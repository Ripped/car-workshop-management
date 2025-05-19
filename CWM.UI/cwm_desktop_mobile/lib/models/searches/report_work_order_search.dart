import 'package:json_annotation/json_annotation.dart';

part 'report_work_order_search.g.dart';

@JsonSerializable()
class ReportWorkOrderSearch {
  String? dateFrom;
  String? dateTo;

  ReportWorkOrderSearch();

  factory ReportWorkOrderSearch.fromJson(Map<String, dynamic> json) =>
      _$ReportWorkOrderSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportWorkOrderSearchToJson(this);
}
