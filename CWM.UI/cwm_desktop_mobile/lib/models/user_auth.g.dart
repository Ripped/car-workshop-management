// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) => UserAuth(
      (json['id'] as num?)?.toInt(),
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String?,
      json['address'] as String?,
      json['mobile'] as String?,
      json['status'] as bool?,
    )..roles = (json['roles'] as List<dynamic>)
        .map((e) => $enumDecode(_$RoleEnumMap, e))
        .toList();

Map<String, dynamic> _$UserAuthToJson(UserAuth instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'mobile': instance.mobile,
      'status': instance.status,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
    };

const _$RoleEnumMap = {
  Role.admin: 0,
  Role.employee: 1,
  Role.user: 2,
};
