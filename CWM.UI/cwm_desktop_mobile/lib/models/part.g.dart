// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Part _$PartFromJson(Map<String, dynamic> json) => Part(
      json['id'] as int,
      json['serialNumber'] as String,
      json['manufacturer'] as String,
      json['partName'] as String,
      json['image'] as String,
      (json['price'] as num).toDouble(),
      json['description'] as String,
    );

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
      'id': instance.id,
      'serialNumber': instance.serialNumber,
      'manufacturer': instance.manufacturer,
      'partName': instance.partName,
      'image': instance.image,
      'price': instance.price,
      'description': instance.description,
    };
