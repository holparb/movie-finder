import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class WatchlistLoaderState extends Equatable {
  const WatchlistLoaderState();
}

class WatchlistEmpty extends WatchlistLoaderState {
  const WatchlistEmpty();

  @override
  List<Object?> get props => [];
}

class WatchlistLoading extends WatchlistLoaderState {
  const WatchlistLoading();

  @override
  List<Object?> get props => [];
}

class WatchlistError extends WatchlistLoaderState {
  final RepositoryError error;

  const WatchlistError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchlistLoaded extends WatchlistLoaderState {
  final List<Movie> watchlist;
  const WatchlistLoaded(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

