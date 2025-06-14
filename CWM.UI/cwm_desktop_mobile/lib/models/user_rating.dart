import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_rating.g.dart';

@JsonSerializable()
class UserRating {
  int id;
  double productRating;
  User? user;
  Part? part;

  UserRating(
    this.id,
    this.productRating,
    this.user,
    this.part,
  );

  factory UserRating.fromJson(Map<String, dynamic> json) =>
      _$UserRatingFromJson(json);

  Map<String, dynamic> toJson() => _$UserRatingToJson(this);
}
