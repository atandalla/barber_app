import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenido a Barber Shop',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
