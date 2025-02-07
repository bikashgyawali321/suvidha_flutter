import 'package:json_annotation/json_annotation.dart';

part 'review_rating.g.dart';

@JsonSerializable()
class NewReviewRatingModel {
  @JsonKey(
    name: 'order',
    includeIfNull: false,
    
  )
  String? orderId;

  @JsonKey(
    name: "booking",
    includeIfNull: false,
  )
  String? bookingId;

  @JsonKey(name: 'rating')
  double rating;

  @JsonKey(name: 'review')
  String? review;

  NewReviewRatingModel({
    this.orderId,
    this.bookingId,
    required this.rating,
    this.review,
  });

  factory NewReviewRatingModel.fromJson(Map<String, dynamic> json) =>
      _$NewReviewRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewReviewRatingModelToJson(this);
}
