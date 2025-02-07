import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class NewOrderModel {
  @JsonKey(name: 'serviceName')
  final String serviceNameId;

  @JsonKey(name: 'longLat', fromJson: _longLatFromJson, toJson: _longLatToJson)
  final LongitudeLatitudeModel longitudeLatitude;
  @JsonKey(name: 'location')
  String location;

  NewOrderModel({
    required this.serviceNameId,
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
class DocsServiceNameForOrder {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'servicecode')
  final String serviceCode;

  DocsServiceNameForOrder({
    required this.id,
    required this.name,
    required this.serviceCode,
  });

  factory DocsServiceNameForOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsServiceNameForOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DocsServiceNameForOrderToJson(this);
}

@JsonSerializable()
class DocsServiceForOrder {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'serviceprovidername')
  final String serviceProviderName;
  @JsonKey(name: 'serviceprovideremail')
  final String serviceProviderEmail;
  @JsonKey(name: 'serviceproviderphone')
  final String serviceProviderPhone;
  @JsonKey(name: 'img')
  final List<String> img;
  @JsonKey(name: 'rating')
  final double rating;

  DocsServiceForOrder({
    required this.id,
    required this.serviceProviderName,
    required this.serviceProviderEmail,
    required this.serviceProviderPhone,
    required this.img,
    required this.rating,
  });

  factory DocsServiceForOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsServiceForOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DocsServiceForOrderToJson(this);
}

@JsonSerializable()
class DocsOrganizationForOrder {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'nameOrg')
  final String nameOrg;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'orgImg')
  final List<String> img;
  @JsonKey(name: 'rating')
  final num rating;
  @JsonKey(name: 'contactPerson')
  final String contactPerson;

  DocsOrganizationForOrder({
    required this.id,
    required this.nameOrg,
    required this.address,
    required this.img,
    required this.rating,
    required this.contactPerson,
  });

  factory DocsOrganizationForOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsOrganizationForOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DocsOrganizationForOrderToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class DocsOrder {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'service')
  final DocsServiceForOrder? service;

  @JsonKey(name: "serviceName")
  final String serviceNameId;

  @JsonKey(name: 'servicenames')
  final DocsServiceNameForOrder serviceName;

  @JsonKey(name: 'org')
  final DocsOrganizationForOrder? org;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'location')
  final String location;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'isActive')
  final bool isActive;

  @JsonKey(name: 'isBlocked')
  final bool isBlocked;

  @JsonKey(name: 'longLat')
  final LongitudeLatitudeModel longLat;

  final DateTime createdAt;
  final DateTime updatedAt;

  DocsOrder({
    required this.id,
    required this.serviceName,
    required this.serviceNameId,
    this.service,
    this.org,
    required this.status,
    required this.location,
    this.price,
    required this.isActive,
    required this.isBlocked,
    required this.longLat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DocsOrder.fromJson(Map<String, dynamic> json) =>
      _$DocsOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DocsOrderToJson(this);
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
