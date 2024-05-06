import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class SearchState extends Equatable{
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchState {
  const SearchEmpty();

  @override
  List<Object?> get props => [];
}

class SearchInProgress extends SearchState {
  const SearchInProgress();

  @override
  List<Object?> get props => [];
}

class SearchResult extends SearchState {
  final List<Movie> results;

  const SearchResult(this.results);

  @override
  List<Object?> get props => [results];
}

class SearchError extends SearchState {
  final RepositoryError error;

  const SearchError(this.error);

  @override
  List<Object?> get props => [error];
}

