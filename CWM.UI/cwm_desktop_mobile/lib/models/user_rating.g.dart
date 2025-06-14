// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRating _$UserRatingFromJson(Map<String, dynamic> json) => UserRating(
      (json['id'] as num).toInt(),
      (json['productRating'] as num).toDouble(),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['part'] == null
          ? null
          : Part.fromJson(json['part'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRatingToJson(UserRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productRating': instance.productRating,
      'user': instance.user,
      'part': instance.part,
    };
