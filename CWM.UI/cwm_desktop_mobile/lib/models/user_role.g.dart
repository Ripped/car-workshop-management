// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      (json['id'] as num).toInt(),
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$RoleEnumMap = {
  Role.admin: 0,
  Role.employee: 1,
  Role.user: 2,
};
