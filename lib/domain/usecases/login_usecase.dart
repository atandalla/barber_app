
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/interface/auth_interface.dart';
import '../../data/interface/user_interface.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/user_repository.dart';

// 1- First abstract the class
abstract interface class LoginUserCase {
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<bool> loginWithGoogle();
  Future<bool> loginWithApple();
  Future<void> signOut();
}

// 2- Implement the class
class _LoginUserCase implements LoginUserCase {
  _LoginUserCase(
    this._authRepository,
    // this._notificationRepository,
    this._userRepository,
  );

  final AuthRepository _authRepository;
  // final NotificationRepository _notificationRepository;
  final UserRepository _userRepository;

  @override
  loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );
    final isUserLoggedIn = user.email != null;
    requestPermission(user);
    return isUserLoggedIn;
  }

  @override
  loginWithGoogle() async {
    final user = await _authRepository.loginWithGoogle();
    final isUserLoggedIn = user.email != null;
    requestPermission(user);
    return isUserLoggedIn;
  }

  @override
  loginWithApple() async {
    final user = await _authRepository.loginWithApple();
    final isUserLoggedIn = user.email != null;
    requestPermission(user);
    return isUserLoggedIn;
  }

  Future<void> requestPermission(user) async {
    if (user.uid == null) return;
    // await _notificationRepository.requestPermission();
    // final token = await _notificationRepository.token;

    // if (token != null) {
    //   await _userRepository.updateUserDeviceToken(user.uid, token);
    // }
  }

  
  @override
  Future<void> signOut() async {
 await _authRepository.signOut();
  }
}

// 3- Create a provider
final loginUseCaseProvider = Provider<LoginUserCase>(
  (ref) => _LoginUserCase(
    ref.watch(authRepositoryProvider),
    // ref.watch(notificationRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
