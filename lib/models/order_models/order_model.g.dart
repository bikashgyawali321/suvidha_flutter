// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderModel _$NewOrderModelFromJson(Map<String, dynamic> json) =>
    NewOrderModel(
      serviceNameId: json['serviceName'] as String,
      longitudeLatitude:
          _longLatFromJson(json['longLat'] as Map<String, dynamic>),
      location: json['location'] as String,
    );

Map<String, dynamic> _$NewOrderModelToJson(NewOrderModel instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceNameId,
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

DocsServiceNameForOrder _$DocsServiceNameForOrderFromJson(
        Map<String, dynamic> json) =>
    DocsServiceNameForOrder(
      id: json['_id'] as String,
      name: json['name'] as String,
      serviceCode: json['servicecode'] as String,
    );

Map<String, dynamic> _$DocsServiceNameForOrderToJson(
        DocsServiceNameForOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'servicecode': instance.serviceCode,
    };

DocsServiceForOrder _$DocsServiceForOrderFromJson(Map<String, dynamic> json) =>
    DocsServiceForOrder(
      id: json['_id'] as String,
      serviceProviderName: json['serviceprovidername'] as String,
      serviceProviderEmail: json['serviceprovideremail'] as String,
      serviceProviderPhone: json['serviceproviderphone'] as String,
      img: (json['img'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$DocsServiceForOrderToJson(
        DocsServiceForOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'serviceprovidername': instance.serviceProviderName,
      'serviceprovideremail': instance.serviceProviderEmail,
      'serviceproviderphone': instance.serviceProviderPhone,
      'img': instance.img,
      'rating': instance.rating,
    };

DocsOrganizationForOrder _$DocsOrganizationForOrderFromJson(
        Map<String, dynamic> json) =>
    DocsOrganizationForOrder(
      id: json['_id'] as String,
      nameOrg: json['nameOrg'] as String,
      address: json['address'] as String,
      img: (json['orgImg'] as List<dynamic>).map((e) => e as String).toList(),
      rating: json['rating'] as num,
      contactPerson: json['contactPerson'] as String,
    );

Map<String, dynamic> _$DocsOrganizationForOrderToJson(
        DocsOrganizationForOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nameOrg': instance.nameOrg,
      'address': instance.address,
      'orgImg': instance.img,
      'rating': instance.rating,
      'contactPerson': instance.contactPerson,
    };

DocsOrder _$DocsOrderFromJson(Map<String, dynamic> json) => DocsOrder(
      id: json['_id'] as String,
      serviceName: DocsServiceNameForOrder.fromJson(
          json['servicenames'] as Map<String, dynamic>),
      serviceNameId: json['serviceName'] as String,
      service: json['service'] == null
          ? null
          : DocsServiceForOrder.fromJson(
              json['service'] as Map<String, dynamic>),
      org: json['org'] == null
          ? null
          : DocsOrganizationForOrder.fromJson(
              json['org'] as Map<String, dynamic>),
      status: json['status'] as String,
      location: json['location'] as String,
      price: json['price'] as num?,
      isActive: json['isActive'] as bool,
      isBlocked: json['isBlocked'] as bool,
      longLat: LongitudeLatitudeModel.fromJson(
          json['longLat'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DocsOrderToJson(DocsOrder instance) => <String, dynamic>{
      '_id': instance.id,
      if (instance.service?.toJson() case final value?) 'service': value,
      'serviceName': instance.serviceNameId,
      'servicenames': instance.serviceName.toJson(),
      if (instance.org?.toJson() case final value?) 'org': value,
      'status': instance.status,
      'location': instance.location,
      if (instance.price case final value?) 'price': value,
      'isActive': instance.isActive,
      'isBlocked': instance.isBlocked,
      'longLat': instance.longLat.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
