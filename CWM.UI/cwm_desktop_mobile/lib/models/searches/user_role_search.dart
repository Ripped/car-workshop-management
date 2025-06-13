import 'package:json_annotation/json_annotation.dart';

import 'base_search.dart';

part 'user_role_search.g.dart';

@JsonSerializable()
class UserRoleSearch extends BaseSearch {
  String? userUsername;
  bool includeUser = false;

  UserRoleSearch();

  factory UserRoleSearch.fromJson(Map<String, dynamic> json) =>
      _$UserRoleSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRoleSearchToJson(this);
}
