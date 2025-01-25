import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

//new booking model
@JsonSerializable()
class NewBooking {
  @JsonKey(name: 'service')
  final String serviceId;
  @JsonKey(name: 'bookingdate')
  DateTime bookingDate;
  @JsonKey(name: 'bookingtime', defaultValue: null)
  DateTime? bookingTime;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'totalprice', defaultValue: null)
  double totalPrice;
  @JsonKey(name: 'optionalContact', defaultValue: null)
  String? optionalContact;
  @JsonKey(name: 'optionalEmail', defaultValue: null)
  String? optionalEmail;

  NewBooking({
    required this.serviceId,
    required this.bookingDate,
    this.bookingTime,
    required this.location,
    required this.totalPrice,
    this.optionalContact,
    this.optionalEmail,
  });

  factory NewBooking.fromJson(Map<String, dynamic> json) =>
      _$NewBookingFromJson(json);

  Map<String, dynamic> toJson() => _$NewBookingToJson(this);
}

//booking model
@JsonSerializable()
class Booking {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'service')
  final String serviceId;
  @JsonKey(name: 'bookingdate')
  final DateTime bookingDate;
  @JsonKey(name: 'bookingtime', defaultValue: null)
  final DateTime? bookingTime;
  @JsonKey(name: 'bookingstatus')
  final String bookingStatus;
  @JsonKey(name: 'rejectionMessage', defaultValue: '')
  final String? rejectionMessage;
  @JsonKey(name: 'bookingMessage')
  final String bookingMessage;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'totalprice')
  final double totalPrice;
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'isPublished', defaultValue: true)
  final bool isPublished;
  @JsonKey(name: 'org')
  final String? orgId;
  @JsonKey(name: 'optionalContact')
  final String? optionalContact;
  @JsonKey(name: 'optionalEmail')
  final String? optionalEmail;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'updatedBy')
  final String updatedBy;
  @JsonKey(name: 'updatedNumber')
  final int updatedNumber;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.bookingDate,
    required this.bookingTime,
    required this.bookingStatus,
    this.rejectionMessage,
    required this.bookingMessage,
    required this.location,
    required this.totalPrice,
    required this.isActive,
    required this.isPublished,
    this.orgId,
    this.optionalContact,
    this.optionalEmail,
    required this.updatedAt,
    required this.updatedBy,
    required this.updatedNumber,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

//update booking model
@JsonSerializable()
class UpdateBooking {
  @JsonKey(name: 'bookingdate')
  DateTime bookingDate;
  @JsonKey(name: 'bookingtime', defaultValue: null)
  DateTime? bookingTime;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'optionalContact', defaultValue: '')
  String? optionalContact;
  @JsonKey(name: 'optionalEmail', defaultValue: '')
  String? optionalEmail;

  UpdateBooking({
    required this.bookingDate,
    required this.bookingTime,
    required this.location,
    required this.optionalContact,
    required this.optionalEmail,
  });

  factory UpdateBooking.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBookingToJson(this);
}

//array response for booking
@JsonSerializable()
class BookingArrayResponse {
  @JsonKey(name: 'pagination', fromJson: Pagination.fromJson)
  final Pagination pagination;

  @JsonKey(
      name: 'docs', fromJson: _docsBookingsFromJson, toJson: _docsBookingToJson)
  List<DocsBooking> docs;
  BookingArrayResponse({required this.pagination, required this.docs});

  factory BookingArrayResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingArrayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingArrayResponseToJson(this);

  static List<DocsBooking> _docsBookingsFromJson(List<dynamic> json) =>
      json.map((e) => DocsBooking.fromJson(e as Map<String, dynamic>)).toList();

  static List<Map<String, dynamic>> _docsBookingToJson(
          List<DocsBooking> docs) =>
      docs.map((e) => e.toJson()).toList();
}

//pagination
@JsonSerializable()
class Pagination {
  final int total;
  final int page;
  final int limit;
  @JsonKey(defaultValue: false)
  final bool previousPage;
  @JsonKey(defaultValue: false)
  final bool nextPage;

  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.previousPage,
    required this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

//booking model for doc response
@JsonSerializable()
class DocsBooking {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'org', fromJson: DocsOrganization.fromJson)
  final DocsOrganization org;
  @JsonKey(name: 'servicename', fromJson: DocsServiceName.fromJson)
  final DocsServiceName serviceName;

  @JsonKey(name: 'service', fromJson: DocsServiceForBooking.fromJson)
  final DocsServiceForBooking service;
  @JsonKey(name: "bookingdate")
  final DateTime bookingDate;
  @JsonKey(name: 'bookingtime', defaultValue: null)
  final DateTime? bookingTime;
  @JsonKey(name: "bookingstatus", defaultValue: 'Pending')
  final String bookingStatus;
  @JsonKey(name: 'location')
  final String location;
  @JsonKey(name: 'totalprice')
  final num totalPrice;
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'isPublished')
  final bool isPublished;
  @JsonKey(name: 'optionalContact', defaultValue: null)
  final String? optionalContact;
  @JsonKey(name: 'optionalEmail', defaultValue: null)
  final String? optionalEmail;

  DocsBooking({
    required this.id,
    required this.bookingDate,
    required this.bookingStatus,
    required this.org,
    required this.isActive,
    required this.location,
    required this.isPublished,
    required this.serviceName,
    required this.service,
    required this.totalPrice,
    this.bookingTime,
    this.optionalContact,
    this.optionalEmail,
  });

  factory DocsBooking.fromJson(Map<String, dynamic> json) =>
      _$DocsBookingFromJson(json);

  Map<String, dynamic> toJson() => _$DocsBookingToJson(this);
}

//service name model for service name object in in response
@JsonSerializable()
class DocsServiceName {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;

  DocsServiceName({
    required this.id,
    required this.name,
  });

  factory DocsServiceName.fromJson(Map<String, dynamic> json) =>
      _$DocsServiceNameFromJson(json);

  Map<String, dynamic> toJson() => _$DocsServiceNameToJson(this);
}

//docs organization model for organization object in response
@JsonSerializable()
class DocsOrganization {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'nameOrg')
  final String organizationName;

  DocsOrganization({
    required this.id,
    required this.organizationName,
  });

  factory DocsOrganization.fromJson(Map<String, dynamic> json) =>
      _$DocsOrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$DocsOrganizationToJson(this);
}

//service model for service object in response
@JsonSerializable()
class DocsServiceForBooking {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: "serviceprovidername")
  final String serviceProviderName;
  @JsonKey(name: 'serviceprovideremail')
  final String serviceProviderEmail;
  @JsonKey(name: "serviceproviderphone")
  final String serviceProviderPhoneNumber;

  @JsonKey(name: 'price')
  final num totalPrice;
  @JsonKey(name: 'img', defaultValue: null)
  final List<String>? images;

  DocsServiceForBooking({
    required this.id,
    required this.serviceProviderName,
    required this.serviceProviderEmail,
    required this.serviceProviderPhoneNumber,
    required this.totalPrice,
    this.images,
  });
  factory DocsServiceForBooking.fromJson(Map<String, dynamic> json) =>
      _$DocsServiceForBookingFromJson(json);

  Map<String, dynamic> toJson() => _$DocsServiceForBookingToJson(this);
}
