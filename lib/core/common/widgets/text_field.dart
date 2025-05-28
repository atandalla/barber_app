import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.fieldController,
    required this.fieldValidator,
    required this.label,
    this.obscureText = false,
  });

  final TextEditingController fieldController;
  final String? Function(String?) fieldValidator;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 14.0),

      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14.0),
        border: const OutlineInputBorder(),
      ),
      validator: fieldValidator,
    );
  }
}
