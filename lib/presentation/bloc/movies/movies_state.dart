import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class MoviesState extends Equatable{
  final List<Movie> ? movies;
  final RepositoryError ? error;

  const MoviesState({this.movies, this.error});

  @override
  List<Object?> get props => [];
}

class MoviesEmpty extends MoviesState {
  const MoviesEmpty();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class TrendingMoviesLoaded extends MoviesState {
  const TrendingMoviesLoaded(List<Movie> movies) : super(movies: movies);

  @override
  List<Object?> get props => [movies];
}

class PopularMoviesLoaded extends MoviesState {
  const PopularMoviesLoaded(List<Movie> movies) : super(movies: movies);

  @override
  List<Object?> get props => [movies];
}

class TopRatedMoviesLoaded extends MoviesState {
  const TopRatedMoviesLoaded(List<Movie> movies) : super(movies: movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesError extends MoviesState {
  const MoviesError(RepositoryError error) : super(error: error);

  @override
  List<Object?> get props => [error];
}