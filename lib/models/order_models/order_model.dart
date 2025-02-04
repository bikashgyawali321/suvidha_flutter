import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class NewOrderModel {
  @JsonKey(name: 'service')
  final String serviceId;

  @JsonKey(name: 'longLat', fromJson: _longLatFromJson, toJson: _longLatToJson)
  final LongitudeLatitudeModel longitudeLatitude;
  @JsonKey(name: 'location')
  String location;

  NewOrderModel({
    required this.serviceId,
    required this.longitudeLatitude,
    required this.location,
  });

  factory NewOrderModel.fromJson(Map<String, dynamic> json) =>
      _$NewOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewOrderModelToJson(this);
}

@JsonSerializable()
class OrderModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'service')
  final String serviceNameId;
  @JsonKey(name: 'org')
  final String orgId;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'price')
  final num price;
  @JsonKey(name: 'longLat', fromJson: _longLatFromJson, toJson: _longLatToJson)
  final LongitudeLatitudeModel longitudeLatitude;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'rating')
  final double rating;
  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'review')
  final String review;
  @JsonKey(name: 'isBlocked')
  final bool isBlocked;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.isActive,
    required this.price,
    required this.location,
    required this.status,
    required this.rating,
    required this.longitudeLatitude,
    required this.review,
    required this.isBlocked,
    required this.orgId,
    required this.serviceNameId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class LongitudeLatitudeModel {
  String type;
  List<num> coordinates;

  LongitudeLatitudeModel({required this.type, required this.coordinates});

  factory LongitudeLatitudeModel.fromJson(Map<String, dynamic> json) =>
      _$LongitudeLatitudeModelFromJson(json);
  Map<String, dynamic> toJson() => _$LongitudeLatitudeModelToJson(this);
}

LongitudeLatitudeModel _longLatFromJson(Map<String, dynamic> json) {
  return LongitudeLatitudeModel.fromJson(json);
}

Map<String, dynamic> _longLatToJson(LongitudeLatitudeModel longLat) {
  return longLat.toJson();
}

@JsonSerializable()
class Pagination {
  final int total;
  final int page;
  final int limit;
  @JsonKey(defaultValue: false)
  final bool previousPage;
  @JsonKey(defaultValue: false)
  final bool nextPage;

  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.previousPage,
    required this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class OrderArrayResponse {
  @JsonKey(name: 'docs', fromJson: _docsFromJson)
  final List<DocsOrder> docs;
  @JsonKey(name: 'pagination', fromJson: Pagination.fromJson)
  final Pagination pagination;

  OrderArrayResponse({
    required this.docs,
    required this.pagination,
  });
  factory OrderArrayResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderArrayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderArrayResponseToJson(this);
  static List<DocsOrder> _docsFromJson(List<dynamic> json) =>
      json.map((e) => DocsOrder.fromJson(e as Map<String, dynamic>)).toList();
}

@JsonSerializable()
class DocsOrder {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'longLat', fromJson: _longLatFromJson, toJson: _longLatToJson)
  final LongitudeLatitudeModel longitudeLatitude;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(
    name: 'price',
    defaultValue: null,
  )
  final num? price;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'isBlocked')
  final bool isBlocked;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(
    name: 'service',
    fromJson: DocsServiceForOrder.fromJson,
    defaultValue: null,
    nullable: true,
    required: false,
  )
  final DocsServiceForOrder? service;
  @JsonKey(
      name: "servicename",
      fromJson: DocsServiceNameForOrder.fromJson,
      defaultValue: null)
  final DocsServiceNameForOrder? serviceName;

  DocsOrder(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.isActive,
      required this.isBlocked,
      required this.location,
      required this.longitudeLatitude,
      this.price,
      this.service,
      this.serviceName,
      required this.status});

  factory DocsOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsOrderFromJson(json);

  Map<String, dynamic> toJSon() => _$DocsOrderToJson(this);
}

@JsonSerializable()
class DocsServiceForOrder {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: 'org')
  final String organizationId;
  @JsonKey(name: 'service')
  final String? serviceNameId;
  @JsonKey(name: 'servicerprovidername')
  final String serviceProviderName;
  @JsonKey(name: "serviceprovideremail")
  final String serviceProviderEmail;
  @JsonKey(name: "serviceproviderphone")
  final String serviceProviderPhone;
  @JsonKey(name: 'description')
  final String serviceDescription;
  @JsonKey(name: "price")
  final num servicePrice;
  @JsonKey(name: "isBlocked")
  final bool isBlocked;
  @JsonKey(name: "isActive")
  final bool isActive;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'img', defaultValue: null)
  final List<String>? serviceProviderImage;
  @JsonKey(name: "rating")
  final num rating;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;

  DocsServiceForOrder(
      {required this.createdAt,
      required this.id,
      required this.isActive,
      required this.isBlocked,
      required this.message,
      required this.organizationId,
      required this.rating,
      required this.serviceDescription,
      this.serviceProviderImage,
      required this.serviceNameId,
      required this.servicePrice,
      required this.serviceProviderEmail,
      required this.serviceProviderName,
      required this.serviceProviderPhone,
      required this.status,
      required this.updatedAt});

  factory DocsServiceForOrder.fromJson(Map<String, dynamic>? json) =>
      _$DocsServiceForOrderFromJson(json ?? {});
  Map<String, dynamic> toJson() => _$DocsServiceForOrderToJson(this);
}

@JsonSerializable()
class DocsServiceNameForOrder {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "name")
  final String serviceName;
  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'servicecode')
  final String serviceCode;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  DocsServiceNameForOrder(
      {required this.createdAt,
      required this.id,
      required this.isActive,
      required this.serviceCode,
      required this.serviceName,
      required this.updatedAt});

  factory DocsServiceNameForOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsServiceNameForOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DocsServiceNameForOrderToJson(this);
}
