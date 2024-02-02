import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();
}

class MovieDetailsLoaded extends MovieDetailsState {
  final Movie movie;

  const MovieDetailsLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();

  @override
  List<Object?> get props => [];
}

class MovieDetailsError extends MovieDetailsState {
  // Fallback movie object, this is the one present in a list but lacks certain fields obtained by a details query
  final DataError error;

  const MovieDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}