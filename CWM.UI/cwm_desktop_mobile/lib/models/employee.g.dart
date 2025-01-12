// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      (json['id'] as num).toInt(),
      json['firstName'] as String,
      json['lastName'] as String,
      DateTime.parse(json['birthDate'] as String),
      json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      json['citizenship'] == null
          ? null
          : Country.fromJson(json['citizenship'] as Map<String, dynamic>),
      json['email'] as String,
      json['mobile'] as String,
      json['adress'] as String,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate.toIso8601String(),
      'city': instance.city,
      'citizenship': instance.citizenship,
      'email': instance.email,
      'mobile': instance.mobile,
      'adress': instance.adress,
    };
