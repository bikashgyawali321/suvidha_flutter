// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderModel _$NewOrderModelFromJson(Map<String, dynamic> json) =>
    NewOrderModel(
      serviceId: json['service'] as String,
      price: json['price'] as num,
      longitude: (json['long'] as num).toDouble(),
      lattitude: (json['lat'] as num).toDouble(),
      location: json['location'] as String,
    );

Map<String, dynamic> _$NewOrderModelToJson(NewOrderModel instance) =>
    <String, dynamic>{
      'service': instance.serviceId,
      'price': instance.price,
      'long': instance.longitude,
      'lat': instance.lattitude,
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
      'status': instance.status,
      'rating': instance.rating,
      'isActive': instance.isActive,
      'review': instance.review,
      'isBlocked': instance.isBlocked,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
