
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/common.dart';
import '../../../exceptions/app_exceptions.dart';
import '../state/register_state.dart';
import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerStateProvider);

    ref.listen(
      registerStateProvider,
      (prev, next) {
        if (next.hasError) {
          final error = next.error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error is AppException ? error.message : 'An error occurred',
              ),
            ),
          );
        }
      },
    );

    return CommonPageScaffold(
      title: 'Registro',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const WelcomeText(),
          GapWidgets.h48,
          registerState.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : UserPassForm(
                  buttonLabel: 'Registrar',
                  onFormSubmit: (String email, String password) {
                    ref
                        .read(
                          registerStateProvider.notifier,
                        )
                        .registerWithEmailPassword(
                          email,
                          password,
                        );
                  },
                ),
          GapWidgets.h48,
        ],
      ),
    );
  }
}
