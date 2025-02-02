import 'package:json_annotation/json_annotation.dart';

part 'review_rating.g.dart';

@JsonSerializable()
class NewReviewRatingModel {
  @JsonKey(name: 'service')
  String serviceId;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'review')
  String? review;

  NewReviewRatingModel({
    required this.serviceId,
    required this.rating,
    this.review,
  });

  factory NewReviewRatingModel.fromJson(Map<String, dynamic> json) =>
      _$NewReviewRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewReviewRatingModelToJson(this);
}
