// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      (json['id'] as num).toInt(),
      json['chassis'] as String,
      json['brand'] as String,
      json['model'] as String,
      (json['cubicCapacity'] as num).toInt(),
      (json['kilowatts'] as num).toInt(),
      json['transmision'] as String,
      DateTime.parse(json['productionDate'] as String),
      json['fuel'] as String,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'chassis': instance.chassis,
      'brand': instance.brand,
      'model': instance.model,
      'cubicCapacity': instance.cubicCapacity,
      'kilowatts': instance.kilowatts,
      'transmision': instance.transmision,
      'productionDate': instance.productionDate.toIso8601String(),
      'fuel': instance.fuel,
      'user': instance.user,
    };
