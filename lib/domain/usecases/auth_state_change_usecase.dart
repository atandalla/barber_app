
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/interface/auth_interface.dart';
import '../../data/models/current_user.dart';
import '../../data/repository/auth_repository.dart';

// 1- First abstract the class
abstract interface class AuthStateUserCase {
  Stream<bool> isAuthenticated();
  CurrentUserDataModel? currentUser();
}

// 2- Implement the class
class _RegisterUserCase implements AuthStateUserCase {
  _RegisterUserCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  isAuthenticated() {
    return _authRepository.isUserAuthenticated();
  }

  @override
  currentUser() {
  return _authRepository.currentUser;
  }
}

// 3- Create a provider
final authStateUseCaseProvider = Provider<AuthStateUserCase>(
  (ref) => _RegisterUserCase(ref.watch(authRepositoryProvider)),
);
