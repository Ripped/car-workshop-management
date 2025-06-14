// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatingSearch _$UserRatingSearchFromJson(Map<String, dynamic> json) =>
    UserRatingSearch()
      ..page = (json['page'] as num).toInt()
      ..pageSize = (json['pageSize'] as num).toInt()
      ..partId = (json['partId'] as num?)?.toInt()
      ..includeUser = json['includeUser'] as bool
      ..includePart = json['includePart'] as bool;

Map<String, dynamic> _$UserRatingSearchToJson(UserRatingSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'partId': instance.partId,
      'includeUser': instance.includeUser,
      'includePart': instance.includePart,
    };
