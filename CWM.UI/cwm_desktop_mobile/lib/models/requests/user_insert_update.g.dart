// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_insert_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInsertUpdate _$UserInsertUpdateFromJson(Map<String, dynamic> json) =>
    UserInsertUpdate(
      json['firstName'] as String,
      json['lastName'] as String,
      $enumDecode(_$GenderEnumMap, json['gender']),
      DateTime.parse(json['birthDate'] as String),
      json['cityId'] as String?,
      json['citizenshipId'] as String?,
      json['image'] as String,
      json['username'] as String,
      json['password'] as String,
      json['email'] as String,
      json['mobile'] as String,
    );

Map<String, dynamic> _$UserInsertUpdateToJson(UserInsertUpdate instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': _$GenderEnumMap[instance.gender]!,
      'birthDate': instance.birthDate.toIso8601String(),
      'cityId': instance.cityId,
      'citizenshipId': instance.citizenshipId,
      'image': instance.image,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'mobile': instance.mobile,
    };

const _$GenderEnumMap = {
  Gender.male: 0,
  Gender.female: 1,
};
