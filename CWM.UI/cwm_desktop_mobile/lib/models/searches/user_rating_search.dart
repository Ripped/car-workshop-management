import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'user_rating_search.g.dart';

@JsonSerializable()
class UserRatingSearch extends BaseSearch {
  int? partId;
  bool includeUser = false;
  bool includePart = false;

  UserRatingSearch();

  factory UserRatingSearch.fromJson(Map<String, dynamic> json) =>
      _$UserRatingSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRatingSearchToJson(this);
}
