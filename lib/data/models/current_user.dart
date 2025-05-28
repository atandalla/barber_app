import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUserDataModel {
  const CurrentUserDataModel({
    required this.uid,
    this.email,
    this.displayName,
    this.role,
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? role;

  factory CurrentUserDataModel.fromFirebaseUser(User user) {
    return CurrentUserDataModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      role: 'user',
    );
  }

  factory CurrentUserDataModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserDataModelToJson(this);
}
