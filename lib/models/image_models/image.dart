import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {

  @JsonKey(name:'_id')
  String? id;
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
    this.id,
    this.url,
    this.publicId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);


  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
