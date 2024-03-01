import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({super.key, required this.onChange, required this.hintText, required this.validatorErrorMessage, this.hideText = false});

  final Function(String) onChange;
  final String hintText;
  final String validatorErrorMessage;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hideText,
      onChanged: onChange,
      style: TextStyle(fontFamily: "AbeeZee", color: Theme.of(context).colorScheme.onSurfaceVariant),
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant, width: 1.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
          borderRadius: BorderRadius.circular(16.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return validatorErrorMessage;
        }
        return null;
      },
    );
  }
}
