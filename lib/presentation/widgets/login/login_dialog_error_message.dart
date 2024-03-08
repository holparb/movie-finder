import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';

class LoginDialogErrorMessage extends StatelessWidget {
  const LoginDialogErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is AuthError) {
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
        return (previousState is LoggingIn && currentState is AuthError)
            || (previousState is AuthError && currentState is LoggingIn)
            || (previousState is AuthError && currentState is NotLoggedIn);
      },
    );
  }
}
