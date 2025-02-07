import 'package:json_annotation/json_annotation.dart';

part 'listing_model.g.dart';

@JsonSerializable()
class ListingModel {
  int? page;
  int? limit;
  String? status;

  ListingModel({this.page, this.limit, this.status});

  factory ListingModel.fromJson(Map<String, dynamic> json) =>
      _$ListingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListingModelToJson(this);
}
