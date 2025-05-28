import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final onboardingRepositoryProvider = Provider((ref) => OnboardingRepository());

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, AsyncValue<bool>>(
  (ref) => OnboardingNotifier(ref),
);

class OnboardingNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;

  OnboardingNotifier(this.ref) : super(const AsyncLoading()) {
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    try {
      final repo = ref.read(onboardingRepositoryProvider);
      final completed = await repo.isCompleted();
      state = AsyncData(completed);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> completeOnboarding() async {
    try {
      final repo = ref.read(onboardingRepositoryProvider);
      await repo.setCompleted();
      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}


class OnboardingRepository {
  final _key = 'onboarding_done';

  Future<void> setCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  Future<bool> isCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
