import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'publicId', includeIfNull: false)
  String? publicId;

  @JsonKey(name: 'isActive')
  bool? isActive;

  @JsonKey(name: 'createdAt')
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  Image({
    this.url,
    this.publicId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor for creating a new instance from a JSON map
  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  /// Method to convert this object into a JSON map
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
