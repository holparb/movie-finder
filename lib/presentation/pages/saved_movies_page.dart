import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/not_logged_in_screen.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies.dart';

class SavedMoviesPage extends StatelessWidget {
  const SavedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState && (currentState is LoggedIn || currentState is NotLoggedIn);
        },
        builder: (context, state) {
          if (state is LoggedIn) {
            return SavedMovies(username: state.username);
          }
          else {
            return const NotLoggedInScreen();
          }
        },
        listenWhen: (previousState, currentState) {
          return previousState is LoggingIn && currentState is LoggedIn;
        },
        listener: (context, state) {
          if (state is LoggedIn) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
