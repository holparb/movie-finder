import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/top_rated_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

/// Generic class for building movie lists based on bloc state
/// The type is the loaded movie state type, e.g.: TrendingMoviesLoaded
sealed class MoviesListBlocBuilder<B extends MoviesBloc, S extends MoviesState> extends StatelessWidget {
  const MoviesListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, MoviesState> (
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
        else if(state is S) {
          return MovieScrollingList(movies: state.movies!,);
        }
        return const Text("No movies, list empty");
      },
    );
  }
}

class TrendingMoviesListBlocBuilder extends MoviesListBlocBuilder<TrendingMoviesBloc, TrendingMoviesLoaded> {
  const TrendingMoviesListBlocBuilder({super.key});
}

class PopularMoviesListBlocBuilder extends MoviesListBlocBuilder<PopularMoviesBloc, PopularMoviesLoaded> {
  const PopularMoviesListBlocBuilder({super.key});
}

class TopRatedMoviesListBlocBuilder extends MoviesListBlocBuilder<TopRatedMoviesBloc, TopRatedMoviesLoaded> {
  const TopRatedMoviesListBlocBuilder({super.key});
}
