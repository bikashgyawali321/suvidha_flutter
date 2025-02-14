// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewBooking _$NewBookingFromJson(Map<String, dynamic> json) => NewBooking(
      serviceId: json['service'] as String,
      bookingDate: DateTime.parse(json['bookingdate'] as String),
      bookingTime: json['bookingtime'] == null
          ? null
          : DateTime.parse(json['bookingtime'] as String),
      location: json['location'] as String,
      totalPrice: (json['totalprice'] as num).toDouble(),
      optionalContact: json['optionalContact'] as String?,
      optionalEmail: json['optionalEmail'] as String?,
    );

Map<String, dynamic> _$NewBookingToJson(NewBooking instance) =>
    <String, dynamic>{
      'service': instance.serviceId,
      'bookingdate': instance.bookingDate.toIso8601String(),
      'bookingtime': instance.bookingTime?.toIso8601String(),
      'location': instance.location,
      'totalprice': instance.totalPrice,
      'optionalContact': instance.optionalContact,
      'optionalEmail': instance.optionalEmail,
    };

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['_id'] as String,
      userId: json['user'] as String,
      serviceId: json['service'] as String,
      bookingDate: DateTime.parse(json['bookingdate'] as String),
      bookingTime: json['bookingtime'] == null
          ? null
          : DateTime.parse(json['bookingtime'] as String),
      bookingStatus: json['bookingstatus'] as String,
      rejectionMessage: json['rejectionMessage'] as String? ?? '',
      bookingMessage: json['bookingMessage'] as String,
      location: json['location'] as String,
      totalPrice: (json['totalprice'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      isPublished: json['isPublished'] as bool? ?? true,
      orgId: json['org'] as String?,
      optionalContact: json['optionalContact'] as String?,
      optionalEmail: json['optionalEmail'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      updatedBy: json['updatedBy'] as String,
      updatedNumber: (json['updatedNumber'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.userId,
      'service': instance.serviceId,
      'bookingdate': instance.bookingDate.toIso8601String(),
      'bookingtime': instance.bookingTime?.toIso8601String(),
      'bookingstatus': instance.bookingStatus,
      'rejectionMessage': instance.rejectionMessage,
      'bookingMessage': instance.bookingMessage,
      'location': instance.location,
      'totalprice': instance.totalPrice,
      'isActive': instance.isActive,
      'isPublished': instance.isPublished,
      'org': instance.orgId,
      'optionalContact': instance.optionalContact,
      'optionalEmail': instance.optionalEmail,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'updatedBy': instance.updatedBy,
      'updatedNumber': instance.updatedNumber,
      'createdAt': instance.createdAt.toIso8601String(),
    };

UpdateBooking _$UpdateBookingFromJson(Map<String, dynamic> json) =>
    UpdateBooking(
      bookingDate: DateTime.parse(json['bookingdate'] as String),
      bookingTime: json['bookingtime'] == null
          ? null
          : DateTime.parse(json['bookingtime'] as String),
      location: json['location'] as String,
      optionalContact: json['optionalContact'] as String? ?? '',
      optionalEmail: json['optionalEmail'] as String? ?? '',
    );

Map<String, dynamic> _$UpdateBookingToJson(UpdateBooking instance) =>
    <String, dynamic>{
      'bookingdate': instance.bookingDate.toIso8601String(),
      'bookingtime': instance.bookingTime?.toIso8601String(),
      'location': instance.location,
      'optionalContact': instance.optionalContact,
      'optionalEmail': instance.optionalEmail,
    };

BookingArrayResponse _$BookingArrayResponseFromJson(
        Map<String, dynamic> json) =>
    BookingArrayResponse(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      docs: BookingArrayResponse._docsBookingsFromJson(json['docs'] as List),
    );

Map<String, dynamic> _$BookingArrayResponseToJson(
        BookingArrayResponse instance) =>
    <String, dynamic>{
      'pagination': instance.pagination,
      'docs': BookingArrayResponse._docsBookingToJson(instance.docs),
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      previousPage: json['previousPage'] as bool? ?? false,
      nextPage: json['nextPage'] as bool? ?? false,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'previousPage': instance.previousPage,
      'nextPage': instance.nextPage,
    };

DocsBooking _$DocsBookingFromJson(Map<String, dynamic> json) => DocsBooking(
      id: json['_id'] as String,
      bookingDate: DateTime.parse(json['bookingdate'] as String),
      bookingStatus: json['bookingstatus'] as String? ?? 'Pending',
      org: DocsOrganization.fromJson(json['org'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool,
      location: json['location'] as String,
      isPublished: json['isPublished'] as bool,
      serviceName:
          DocsServiceName.fromJson(json['servicename'] as Map<String, dynamic>),
      service: DocsServiceForBooking.fromJson(
          json['service'] as Map<String, dynamic>),
      totalPrice: json['totalprice'] as num,
      bookingTime: json['bookingtime'] == null
          ? null
          : DateTime.parse(json['bookingtime'] as String),
      optionalContact: json['optionalContact'] as String?,
      optionalEmail: json['optionalEmail'] as String?,
    );

Map<String, dynamic> _$DocsBookingToJson(DocsBooking instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'org': instance.org,
      'servicename': instance.serviceName,
      'service': instance.service,
      'bookingdate': instance.bookingDate.toIso8601String(),
      'bookingtime': instance.bookingTime?.toIso8601String(),
      'bookingstatus': instance.bookingStatus,
      'location': instance.location,
      'totalprice': instance.totalPrice,
      'isActive': instance.isActive,
      'isPublished': instance.isPublished,
      'optionalContact': instance.optionalContact,
      'optionalEmail': instance.optionalEmail,
    };

DocsServiceName _$DocsServiceNameFromJson(Map<String, dynamic> json) =>
    DocsServiceName(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DocsServiceNameToJson(DocsServiceName instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

DocsOrganization _$DocsOrganizationFromJson(Map<String, dynamic> json) =>
    DocsOrganization(
      id: json['_id'] as String,
      organizationName: json['nameOrg'] as String,
    );

Map<String, dynamic> _$DocsOrganizationToJson(DocsOrganization instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nameOrg': instance.organizationName,
    };

DocsServiceForBooking _$DocsServiceForBookingFromJson(
        Map<String, dynamic> json) =>
    DocsServiceForBooking(
      id: json['_id'] as String,
      serviceProviderName: json['serviceprovidername'] as String,
      serviceProviderEmail: json['serviceprovideremail'] as String,
      serviceProviderPhoneNumber: json['serviceproviderphone'] as String,
      totalPrice: json['price'] as num,
      images: (json['img'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DocsServiceForBookingToJson(
        DocsServiceForBooking instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'serviceprovidername': instance.serviceProviderName,
      'serviceprovideremail': instance.serviceProviderEmail,
      'serviceproviderphone': instance.serviceProviderPhoneNumber,
      'price': instance.totalPrice,
      'img': instance.images,
    };
