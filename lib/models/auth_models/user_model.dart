import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? email;
  String? name;
  String? password;
  String? phoneNumber;
  String? role;
  bool? isBlocked;
  bool? isEmailVerified;
  int? otp;
  DateTime? otpExpires;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? fcmTokens;
  @JsonKey(name: 'profilePic')
  String? profilePicture;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.password,
    this.phoneNumber,
    this.role,
    this.isBlocked,
    this.isEmailVerified,
    this.otp,
    this.otpExpires,
    this.createdAt,
    this.updatedAt,
    this.fcmTokens,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
