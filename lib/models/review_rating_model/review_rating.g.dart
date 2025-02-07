// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewReviewRatingModel _$NewReviewRatingModelFromJson(
        Map<String, dynamic> json) =>
    NewReviewRatingModel(
      orderId: json['order'] as String?,
      bookingId: json['booking'] as String?,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String?,
    );

Map<String, dynamic> _$NewReviewRatingModelToJson(
        NewReviewRatingModel instance) =>
    <String, dynamic>{
      if (instance.orderId case final value?) 'order': value,
      if (instance.bookingId case final value?) 'booking': value,
      'rating': instance.rating,
      'review': instance.review,
    };
