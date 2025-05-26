
import 'package:flutter/material.dart';

import '../../../core/common/common.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
  });

  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: onGooglePressed,
          child: Column(
            children: [

              const Text('Google'),
            ],
          ),
        ),
        GapWidgets.w16,
        OutlinedButton(
          onPressed: null,
          child: const Text('Apple'),
        ),
      ],
    );
  }
}
