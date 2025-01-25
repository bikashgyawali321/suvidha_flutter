import 'package:json_annotation/json_annotation.dart';

part 'service_name.g.dart';

@JsonSerializable()
class ServiceName {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'servicecode')
  final String serviceCode;

  ServiceName({
    required this.id,
    required this.name,
    required this.serviceCode,
  });

  factory ServiceName.fromJson(Map<String, dynamic> json) =>
      _$ServiceNameFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceNameToJson(this);
}
