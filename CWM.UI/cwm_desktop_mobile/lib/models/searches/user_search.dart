import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'user_search.g.dart';

@JsonSerializable()
class UserSearch extends BaseSearch {
  String? name;
  int? userId;

  UserSearch();

  factory UserSearch.fromJson(Map<String, dynamic> json) =>
      _$UserSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserSearchToJson(this);
}
