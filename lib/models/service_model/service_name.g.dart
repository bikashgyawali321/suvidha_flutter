// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceName _$ServiceNameFromJson(Map<String, dynamic> json) => ServiceName(
      id: json['_id'] as String?,
      name: json['name'] as String,
      serviceCode: json['servicecode'] as String,
    );

Map<String, dynamic> _$ServiceNameToJson(ServiceName instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'servicecode': instance.serviceCode,
    };
