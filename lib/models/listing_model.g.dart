// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) => ListingModel(
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ListingModelToJson(ListingModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'status': instance.status,
    };
