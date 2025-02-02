// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReviewRatingModel _$NewReviewRatingModelFromJson(
        Map<String, dynamic> json) =>
    NewReviewRatingModel(
      serviceId: json['service'] as String,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String?,
    );

Map<String, dynamic> _$NewReviewRatingModelToJson(
        NewReviewRatingModel instance) =>
    <String, dynamic>{
      'service': instance.serviceId,
      'rating': instance.rating,
      'review': instance.review,
    };
