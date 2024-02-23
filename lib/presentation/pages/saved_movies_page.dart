import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/login_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/not_logged_in_screen.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_list.dart';

class SavedMoviesPage extends StatelessWidget {
  const SavedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, AuthState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return const SavedMoviesList();
        }
        return const NotLoggedInScreen();
      },
      listener: (context, state) {
        if (state is LoggedIn) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
