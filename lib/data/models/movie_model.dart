import 'package:movie_finder/data/models/genre_model.dart';
import 'package:movie_finder/domain/entities/genre.dart';
import 'package:movie_finder/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({required super.id, required super.title, required super.overview, required super.posterPath, required super.voteAverage, required super.backdropPath, required super.genreIds, required super.genres, required super.releaseDate, required super.runtime});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        overview: json['overview'] ?? "",
        posterPath: json['poster_path'] ?? "",
        voteAverage: json['vote_average'] ?? 0,
        backdropPath: json['backdrop_path'] ?? "",
        genreIds: json['genre_ids'] != null ?(json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList() : [],
        genres: json['genres'] != null ? (json['genres'] as List<dynamic>?)?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>)).toList() as List<Genre> : [],
        releaseDate: DateTime.tryParse(json['release_date']),
        runtime: json['runtime'] ?? 0
    );
  }

  @override
  String toString() {
    return 'MovieModel{$id, $title, $backdropPath}';
  }
}