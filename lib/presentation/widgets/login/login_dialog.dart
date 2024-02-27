import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog_error_message.dart';
import 'package:movie_finder/presentation/widgets/login/login_text_form_field.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
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
                const Image(image: AssetImage("assets/images/tmdb_logo.png")),
                const SizedBox(height: 24,),
                LoginTextFormField(controller: usernameController, hintText: "Username", validatorErrorMessage: "Please enter username!"),
                const SizedBox(height: 16,),
                LoginTextFormField(controller: passwordController, hintText: "Password", validatorErrorMessage: "Please enter password!"),
                const SizedBox(height: 16,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0)
                        )
                    ),
                    onPressed: () => onLoginButtonPressed(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if(state is LoggingIn) {
                              return const CircularProgressIndicator();
                            }
                            return const Text(
                              "Login",
                              style: TextStyle(fontFamily: "AbeeZee", fontWeight: FontWeight.bold, fontSize: 16),
                            );
                          },
                      ),
                    )
                ),
                const LoginDialogErrorMessage(),
                MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => onLoginCancel(context),
                    child: const Text("Cancel", style: TextStyle(fontSize: 16),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLoginCancel(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(const InitAuthState());
    Navigator.pop(context);
  }

  void onLoginButtonPressed(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(const InitAuthState());
      BlocProvider.of<AuthBloc>(context).add(LogIn(loginParams: LoginParams(username: usernameController.text, password: passwordController.text)));
    }
  }
}
