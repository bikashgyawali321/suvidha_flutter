// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderModel _$NewOrderModelFromJson(Map<String, dynamic> json) =>
    NewOrderModel(
      serviceId: json['service'] as String,
      longitudeLatitude:
          _longLatFromJson(json['longLat'] as Map<String, dynamic>),
      location: json['location'] as String,
    );

Map<String, dynamic> _$NewOrderModelToJson(NewOrderModel instance) =>
    <String, dynamic>{
      'service': instance.serviceId,
      'longLat': _longLatToJson(instance.longitudeLatitude),
      'location': instance.location,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['_id'] as String,
      userId: json['user'] as String,
      isActive: json['isActive'] as bool,
      price: json['price'] as num,
      location: json['location'] as String,
      status: json['status'] as String,
      rating: (json['rating'] as num).toDouble(),
      longitudeLatitude:
          _longLatFromJson(json['longLat'] as Map<String, dynamic>),
      review: json['review'] as String,
      isBlocked: json['isBlocked'] as bool,
      orgId: json['org'] as String,
      serviceNameId: json['service'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.userId,
      'service': instance.serviceNameId,
      'org': instance.orgId,
      'location': instance.location,
      'price': instance.price,
      'longLat': _longLatToJson(instance.longitudeLatitude),
      'status': instance.status,
      'rating': instance.rating,
      'isActive': instance.isActive,
      'review': instance.review,
      'isBlocked': instance.isBlocked,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

LongitudeLatitudeModel _$LongitudeLatitudeModelFromJson(
        Map<String, dynamic> json) =>
    LongitudeLatitudeModel(
      type: json['type'] as String,
      coordinates:
          (json['coordinates'] as List<dynamic>).map((e) => e as num).toList(),
    );

Map<String, dynamic> _$LongitudeLatitudeModelToJson(
        LongitudeLatitudeModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
