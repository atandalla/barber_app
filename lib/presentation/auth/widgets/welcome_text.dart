import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenido a EcuaRed !',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
