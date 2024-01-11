import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class MoviesState extends Equatable{
  final List<Movie> ? movies;
  final DataError ? error;

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

class MoviesLoaded extends MoviesState {
  const MoviesLoaded(List<Movie> movies) : super(movies: movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesError extends MoviesState {
  const MoviesError(DataError error) : super(error: error);

  @override
  List<Object?> get props => [error];

}