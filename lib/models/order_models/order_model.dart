import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class NewOrderModel {
  @JsonKey(name: 'service')
  final String serviceId;

  @JsonKey(name: 'price')
  final num price;
  @JsonKey(name: 'long')
  final double longitude;
  @JsonKey(name: 'lat')
  final double lattitude;
  @JsonKey(name: 'location')
  String location;

  NewOrderModel({
    required this.serviceId,
    required this.price,
    required this.longitude,
    required this.lattitude,
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
