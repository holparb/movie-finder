import 'package:flutter/material.dart';
import 'package:movie_finder/presentation/widgets/login/login_text_form_field.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Login with TDMB",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontFamily: "AbeeZee"),
                ),
                const SizedBox(height: 24,),
                const LoginTextFormField(hintText: "Username", validatorErrorMessage: "Please enter username!"),
                const SizedBox(height: 16,),
                const LoginTextFormField(hintText: "Password", validatorErrorMessage: "Please enter password!"),
                const SizedBox(height: 16,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                        )
                    ),
                    onPressed: onLoginButtonPressed,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Login",
                        style: TextStyle(fontFamily: "AbeeZee", fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginButtonPressed() {
    if(_formKey.currentState!.validate()) {

    }
  }
}
