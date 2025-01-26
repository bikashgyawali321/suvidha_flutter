import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  final String service;
  final String serviceprovidername;
  final String serviceprovideremail;
  final String serviceproviderphone;
  final String description;
  final double price;
  final bool isActive;
  final String status;
  final List<String>? img;
  final int? totalratedby;
  final double? totalrating;
  final double? rating;

  Service({
    required this.service,
    required this.serviceprovidername,
    required this.serviceprovideremail,
    required this.serviceproviderphone,
    required this.description,
    required this.price,
    this.isActive = true,
    this.status = "Rejected",
    this.img,
    this.totalratedby,
    this.totalrating,
    this.rating,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
