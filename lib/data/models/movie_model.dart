import 'package:movie_finder/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({required super.id, required super.title, required super.overview, required super.posterPath, required super.voteAverage, required super.backdropPath, required super.genreIds, required super.releaseDate, required super.runtime});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        overview: json['overview'] ?? "",
        posterPath: json['poster_path'] ?? "",
        voteAverage: json['vote_average'] ?? 0,
        backdropPath: json['backdrop_path'] ?? "",
        genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
        releaseDate: json['release_date'] != null ? DateTime.parse(json['release_date']) : null,
        runtime: json['runtime'] ?? 0
    );
  }

  @override
  String toString() {
    return 'MovieModel{$id, $title, $backdropPath}';
  }
}