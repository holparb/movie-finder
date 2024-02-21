import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/login_bloc.dart';
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
                            borderRadius: BorderRadius.circular(26.0)
                        )
                    ),
                    onPressed: () => onLoginButtonPressed(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<LoginBloc, AuthState>(
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
                BlocBuilder<LoginBloc, AuthState>(
                    builder: (context, state) {
                      if(state is LoginError) {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 8,),
                              Text("Login failed, try again!", style: TextStyle(color: Theme.of(context).colorScheme.error),),
                            ],
                          )
                        );
                      }
                      return const SizedBox(height: 8,);
                    },
                    buildWhen: (previousState, currentState) {
                      return true;
                      return (previousState is LoggingIn && currentState is LoginError)
                      || (previousState is LoginError && currentState is LoggingIn);
                    },
                ),
                MaterialButton(
                  highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () => onLoginCancel(context),
                    child: Text("Cancel", style: TextStyle(fontSize: 16),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginCancel(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(const InitAuthState());
    Navigator.pop(context);
  }

  void onLoginButtonPressed(BuildContext context) {
    if(_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(const InitAuthState());
      BlocProvider.of<LoginBloc>(context).add(LogIn(loginParams: LoginParams(username: "asd", password: "rofl")));
    }
  }
}
