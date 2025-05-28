import 'package:barber_app/presentation/admin/pages/admin_page.dart';
import 'package:barber_app/presentation/home/pages/home_page.dart';
import 'package:barber_app/presentation/splash_screen/splash_screen.dart';
import 'package:barber_app/presentation/welcome/welcome_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/auth.dart';
import '../../presentation/auth/pages/role_selection_page.dart';
import '../../presentation/home/pages/persistent_tab.dart';
import '../../presentation/splash_screen/splash_screen_provider.dart';
import '../../presentation/welcome/welcome_provider.dart';
import 'auth_change_provider.dart';
import 'route_names.dart';

final routerConfig = Provider<GoRouter>(
  (ref) => GoRouter(
    redirect: (context, state) {
      final splashCompleted = ref.watch(splashCompletedProvider);
      final userState = ref.watch(routerAuthStateProvider);

      final isAuthenticated = userState.value != null && userState.value!;
      print('isAuthenticated: $isAuthenticated');

      final isAuthPath = state.fullPath?.startsWith('/auth') ?? false;

      final onboardingCompleted = ref
          .watch(onboardingNotifierProvider)
          .maybeWhen(data: (value) => value, orElse: () => false);

      // if (!splashCompleted) return null;

      if (!onboardingCompleted) return '/auth/welcome';

      if (!isAuthenticated && !isAuthPath) {
        return '/auth';
      }

      return null;
    },
    initialLocation: '/',
    routes: <RouteBase>[


      GoRoute(
        path: '/auth',
        name: RouterNames.authPage.name,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'welcome',
            name: RouterNames.welcomePage.name,
            builder: (context, state) => const WelcomePage(),
          ),
          GoRoute(
            path: 'register',
            name: RouterNames.registerPage.name,
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'forgot-password',
            name: RouterNames.forgotPasswordPage.name,
            builder: (context, state) => ForgotPasswordPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/',
        name: RouterNames.homePage.name,
        builder: (context, state) => PersistentTab(),

        routes: [
          // GoRoute(
          //   path: 'profile/:userId',
          //   name: RouterNames.userProfilePage.name,
          //   builder: (context, state) => UserProfilePage(
          //     userId: state.pathParameters['userId']!,
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: 'edit',
          //       name: RouterNames.editProfilePage.name,
          //       builder: (context, state) => EditProfilePage(),
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'home',
          //   name: RouterNames.homePage.name,
          //   builder: (context, state) => HomeScreen(),
          // ),

          GoRoute(
            path: 'admin',
            name: RouterNames.adminPage.name,
            builder: (context, state) => AdminPage(),
          ),
        ],
      ),
    ],
  ),
);
