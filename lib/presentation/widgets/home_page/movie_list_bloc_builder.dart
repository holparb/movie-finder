import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_state.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

class MovieListBlocBuilder extends StatelessWidget {
  const MovieListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState> (
      buildWhen: (previousState, currentState) {
        return previousState.movies != currentState.movies;
      },
      builder: (_, state) {
        if(state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is MoviesError) {
          return const Text("Couldn't load movies, try again!");
        }
        else if(state is MoviesLoaded) {
          return MovieScrollingList(movies: state.movies!,);
        }
        return const SizedBox();
      },
    );
  }
}
