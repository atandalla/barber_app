
import '../models/userinfo.dart';

abstract interface class UserRepository {
  Stream<UserInfoDataModel> getExtraUserInfo(String uid);
  Future<void> createUser(UserInfoDataModel user);
 
  Future<List<UserInfoDataModel>> searchUsers();
  Future<void> editUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  });
  Future<void> updateUserDeviceToken(String uid, String token);
  Future<void> updateAvatarImage({
    required String uid,
    String? photoUrl,
  });
  Future<void> updateCoverImage({
    required String uid,
    String? coverImageUrl,
  });
}
