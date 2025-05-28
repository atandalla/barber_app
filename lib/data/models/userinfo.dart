import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable()
class UserInfoDataModel {
  const UserInfoDataModel({
    required this.uid,
    this.email,
    this.displayName,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.coverImageUrl,
    this.bio,
    this.deviceTokens,
    this.role,
  });

  final String uid;
  final String? displayName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final String? coverImageUrl;
  final String? bio;
  final List<String>? deviceTokens;
  final String? role;

  factory UserInfoDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDataModelToJson(this);
}
