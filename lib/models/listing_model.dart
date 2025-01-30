import 'package:json_annotation/json_annotation.dart';

part 'listing_model.g.dart';

@JsonSerializable()
class ListingModel {
  int? page;
  int? limit;

  ListingModel({this.page, this.limit});

  factory ListingModel.fromJson(Map<String, dynamic> json) =>
      _$ListingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListingModelToJson(this);
}
