
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entity/image_type.dart';
import '../../../../domain/entity/user.dart';
import '../../../../domain/usecases/edit_profile_usecase.dart';
import '../../../../domain/usecases/user_usecase.dart';

final userProfileProvider = StreamProvider.family<AppUser?, String>(
  (ref, uid) {
    return ref.watch(userUseCaseProvider).getUserInfo(uid);
  },
);


final signOutProvider = FutureProvider.autoDispose(
  (ref) {
    return ref
        .watch(
          userUseCaseProvider,
        )
        .signOut();
  },
);


final currentUserStateProvider = StreamProvider.autoDispose<AppUser>(
  (ref) {
    return ref
        .watch(
          userUseCaseProvider,
        )
        .getCurrentUserInfo();
  },
);

final signOutStateProvider = Provider<Future<void>>(
  (ref) {
    return ref.watch(userUseCaseProvider).signOut();
  },
);


class EditProfileData {
  EditProfileData({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.bio,
  });
  final String uid;
  final String firstName;
  final String lastName;
  final String bio;
}

final editProfileStateProvider =
    FutureProvider.autoDispose.family<void, EditProfileData>(
  (ref, update) {
    return ref
        .watch(
          editProfileUseCaseProvider,
        )
        .editProfile(
          uid: update.uid,
          firstName: update.firstName,
          lastName: update.lastName,
          bio: update.bio,
        );
  },
);

class UploadImageMetadata {
  UploadImageMetadata({
    required this.uid,
    required this.filePath,
    required this.type,
  });

  final String uid;
  final String filePath;
  final ImageType type;
}

final updateImageStateProvider =
    FutureProvider.autoDispose.family<void, UploadImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).updateProfileImage(
          uid: metadata.uid,
          filePath: metadata.filePath,
          type: metadata.type,
        );
  },
);

final uploadProgressProvider =
    StreamProvider.autoDispose.family<double, UploadImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).getUploadProgress(
          uid: metadata.uid,
          filePath: metadata.filePath,
          type: metadata.type,
        );
  },
);

class DeleteImageMetadata {
  DeleteImageMetadata({
    required this.uid,
    required this.imageUrl,
    required this.type,
  });

  final String uid;
  final String imageUrl;
  final ImageType type;
}

final deleteImageStateProvider =
    FutureProvider.autoDispose.family<void, DeleteImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).deleteProfileImage(
          uid: metadata.uid,
          imageUrl: metadata.imageUrl,
          type: metadata.type,
        );
  },
);
