
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/interface/auth_interface.dart';
import '../../data/interface/user_interface.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/user_repository.dart';
import '../entity/user.dart';

abstract interface class UserUseCase {
  Stream<AppUser> getUserInfo(String uid);
  Stream<AppUser> getCurrentUserInfo();
  Future<void> signOut();
 
}

class _UserUseCase implements UserUseCase {
  const _UserUseCase(
    this._authRepository,
    this._userRepository,
  );

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  @override
  Stream<AppUser> getUserInfo(String uid) {
    return _userRepository
        .getExtraUserInfo(
          uid,
        )
        .map(
          (userDataModel) => AppUser.fromUserInfoDataModel(userDataModel),
        );
  }

  @override
  Future<void> signOut() async {
    await _authRepository.signOut();
  }


  @override
  Stream<AppUser> getCurrentUserInfo() {
    final user = _authRepository.currentUser;
    return getUserInfo(user.uid);
  }


}

// 3- Create a provider
final userUseCaseProvider = Provider<UserUseCase>(
  (ref) => _UserUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
