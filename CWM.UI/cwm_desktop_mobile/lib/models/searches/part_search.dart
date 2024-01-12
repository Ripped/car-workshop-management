import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'part_search.g.dart';

@JsonSerializable()
class PartSearch extends BaseSearch {
  String? name;

  PartSearch();

  factory PartSearch.fromJson(Map<String, dynamic> json) =>
      _$PartSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartSearchToJson(this);
}
