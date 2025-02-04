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

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      previousPage: json['previousPage'] as bool? ?? false,
      nextPage: json['nextPage'] as bool? ?? false,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'previousPage': instance.previousPage,
      'nextPage': instance.nextPage,
    };

OrderArrayResponse _$OrderArrayResponseFromJson(Map<String, dynamic> json) =>
    OrderArrayResponse(
      docs: OrderArrayResponse._docsFromJson(json['docs'] as List),
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderArrayResponseToJson(OrderArrayResponse instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'pagination': instance.pagination,
    };

DocsOrder _$DocsOrderFromJson(Map<String, dynamic> json) => DocsOrder(
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool,
      isBlocked: json['isBlocked'] as bool,
      location: json['location'] as String,
      longitudeLatitude:
          _longLatFromJson(json['longLat'] as Map<String, dynamic>),
      price: json['price'] as num?,
      service: DocsServiceForOrder.fromJson(
          json['service'] as Map<String, dynamic>?),
      serviceName: DocsServiceNameForOrder.fromJson(
          json['servicename'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$DocsOrderToJson(DocsOrder instance) => <String, dynamic>{
      '_id': instance.id,
      'longLat': _longLatToJson(instance.longitudeLatitude),
      'location': instance.location,
      'price': instance.price,
      'status': instance.status,
      'isActive': instance.isActive,
      'isBlocked': instance.isBlocked,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'service': instance.service,
      'servicename': instance.serviceName,
    };

DocsServiceForOrder _$DocsServiceForOrderFromJson(Map<String, dynamic> json) =>
    DocsServiceForOrder(
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      isBlocked: json['isBlocked'] as bool,
      message: json['message'] as String,
      organizationId: json['org'] as String,
      rating: json['rating'] as num,
      serviceDescription: json['description'] as String,
      serviceProviderImage:
          (json['img'] as List<dynamic>?)?.map((e) => e as String).toList(),
      serviceNameId: json['service'] as String?,
      servicePrice: json['price'] as num,
      serviceProviderEmail: json['serviceprovideremail'] as String,
      serviceProviderName: json['servicerprovidername'] as String,
      serviceProviderPhone: json['serviceproviderphone'] as String,
      status: json['status'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DocsServiceForOrderToJson(
        DocsServiceForOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'org': instance.organizationId,
      'service': instance.serviceNameId,
      'servicerprovidername': instance.serviceProviderName,
      'serviceprovideremail': instance.serviceProviderEmail,
      'serviceproviderphone': instance.serviceProviderPhone,
      'description': instance.serviceDescription,
      'price': instance.servicePrice,
      'isBlocked': instance.isBlocked,
      'isActive': instance.isActive,
      'status': instance.status,
      'img': instance.serviceProviderImage,
      'rating': instance.rating,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

DocsServiceNameForOrder _$DocsServiceNameForOrderFromJson(
        Map<String, dynamic> json) =>
    DocsServiceNameForOrder(
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      serviceCode: json['servicecode'] as String,
      serviceName: json['name'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$DocsServiceNameForOrderToJson(
        DocsServiceNameForOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.serviceName,
      'isActive': instance.isActive,
      'servicecode': instance.serviceCode,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt,
    };
