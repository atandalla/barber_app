import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/common.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/routing/router.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../exceptions/app_exceptions.dart';
import '../state/login_state.dart';
import '../widgets/social_login.dart';
import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateProvider);
    final loginUseCase = ref.watch(loginUseCaseProvider);
    // in case of error show a snackbar
    ref.listen(loginStateProvider, (prev, next) {
      if (next.hasError) {
        final error = next.error;
        debugPrint('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error is AppFirebaseException
                  ? error.message
                  : 'Error: Un problema ha ocurrido!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });

    return CommonPageScaffold(
      title: 'EcuaRed',
      showAppBar: false,
      child:
          loginState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const WelcomeText(),
                  // IconButton(
                  //   onPressed: () {
                  //     loginUseCase.signOut();
                  //   },
                  //   icon: Icon(Icons.close),
                  // ),

                  GapWidgets.h16,
                  UserPassForm(
                    buttonLabel: 'Iniciar Sesión',
                    onFormSubmit: (String email, String password) async {
                      ref
                          .read(loginStateProvider.notifier)
                          .loginWithEmailPassword(email, password);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('¿No tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          AppRouter.go(context, RouterNames.registerPage);
                        },
                        child: const Text('Regístrate'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          AppRouter.go(context, RouterNames.forgotPasswordPage);
                        },
                        child: const Text('Has olvidado tu contraseña?'),
                      ),
                    ],
                  ),
                  GapWidgets.h8,
                  const Text('O inicia sesión con'),
                  SocialLogin(
                    onGooglePressed: () {
                      ref.read(loginStateProvider.notifier).signInGoogle();
                    },
                    onApplePressed: () {
                      ref.read(loginStateProvider.notifier).signInApple();
                    },
                  ),
                ],
              ),
    );
  }
}
