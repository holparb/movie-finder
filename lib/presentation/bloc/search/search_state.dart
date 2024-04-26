import 'package:equatable/equatable.dart';
import 'package:movie_finder/domain/entities/movie.dart';

sealed class SearchState extends Equatable{
  const SearchState();
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
  final List<Movie> result;

  const SearchResult(this.result);

  @override
  List<Object?> get props => [result];
}

