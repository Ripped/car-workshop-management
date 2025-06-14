// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num).toInt(),
      json['firstName'] as String,
      json['lastName'] as String,
      $enumDecode(_$GenderEnumMap, json['gender']),
      DateTime.parse(json['birthDate'] as String),
      json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      json['citizenship'] == null
          ? null
          : Country.fromJson(json['citizenship'] as Map<String, dynamic>),
      json['image'] as String?,
      json['email'] as String,
      json['mobile'] as String,
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': _$GenderEnumMap[instance.gender]!,
      'birthDate': instance.birthDate.toIso8601String(),
      'city': instance.city,
      'citizenship': instance.citizenship,
      'image': instance.image,
      'email': instance.email,
      'mobile': instance.mobile,
      'username': instance.username,
      'password': instance.password,
    };

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
};
