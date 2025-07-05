import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'notification_search.g.dart';

@JsonSerializable()
class NotificationSearch extends BaseSearch {
  String? name;
  bool includeUser = false;

  NotificationSearch();

  factory NotificationSearch.fromJson(Map<String, dynamic> json) =>
      _$NotificationSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationSearchToJson(this);
}
