import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();
}

class WatchlistEmpy extends WatchlistState {
  const WatchlistEmpy();

  @override
  List<Object?> get props => [];
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();

  @override
  List<Object?> get props => [];
}

class WatchlistError extends WatchlistState {
  final RepositoryError error;

  const WatchlistError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchlistLoaded extends WatchlistState {
  final List<Movie> watchlist;
  const WatchlistLoaded(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

