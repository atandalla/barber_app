import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/collections.dart';
import '../../exceptions/app_exceptions.dart';
import '../interface/user_interface.dart';
import '../models/userinfo.dart';

class _UserRemoteDataSource implements UserRepository {
  const _UserRemoteDataSource(this.databaseDataSource);

  final FirebaseFirestore databaseDataSource;

  @override
  Future<void> createUser(UserInfoDataModel user) {
    try {
      return databaseDataSource
          .collection(CollectionsName.users.name)
          .doc(user.uid)
          .set(user.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Stream<UserInfoDataModel> getExtraUserInfo(String uid) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .snapshots()
        .map(
          (event) =>
              UserInfoDataModel.fromJson({...event.data()!, 'uid': event.id}),
        );
  }

  @override
  Future<List<UserInfoDataModel>> searchUsers() {
    return databaseDataSource.collection(CollectionsName.users.name).get().then(
      (value) {
        return value.docs
            .map((e) => UserInfoDataModel.fromJson({...e.data(), 'uid': e.id}))
            .toList();
      },
    );
  }

  @override
  Future<void> editUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  }) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update({'firstName': firstName, 'lastName': lastName, 'bio': bio});
  }

  @override
  Future<void> updateAvatarImage({required String uid, String? photoUrl}) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update({'photoUrl': photoUrl});
  }

  @override
  Future<void> updateCoverImage({required String uid, String? coverImageUrl}) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update({'coverImageUrl': coverImageUrl});
  }

  @override
  Future<void> updateUserDeviceToken(String uid, String token) {
    final ref = databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid);

    return ref.set({
      'deviceTokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> updateUserRole({required String uid, required String role}) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update({'role': role});
  }
}

final userDataSourceProvider = Provider(
  (ref) => _UserRemoteDataSource(FirebaseFirestore.instance),
);
