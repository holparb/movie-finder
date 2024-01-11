import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double? voteAverage;
  final String? backdropPath;
  final List<int>? genreIds;
  final DateTime? releaseDate;
  final int? runtime;


  const Movie({required this.id, required this.title, required this.overview, required this.posterPath, required this.voteAverage, required this.backdropPath, required this.genreIds, required this.releaseDate, required this.runtime});

  @override
  List<Object?> get props => [id, title];
}