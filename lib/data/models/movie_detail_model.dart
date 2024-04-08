import 'package:movie_finder/data/models/movie_model.dart';

class MovieDetailModel extends MovieModel {
  final bool onWatchlist;

  const MovieDetailModel({required super.id, required super.title, required super.overview, required super.posterPath, required super.voteAverage, required super.backdropPath, required super.genreIds, required super.genres, required super.releaseDate, required super.runtime, required this.onWatchlist});
  factory MovieDetailModel.fromMovieModel(MovieModel movieModel, bool onWatchlist) {
    return MovieDetailModel(
        id: movieModel.id,
        title: movieModel.title,
        overview: movieModel.overview,
        posterPath: movieModel.posterPath,
        voteAverage: movieModel.voteAverage,
        backdropPath: movieModel.backdropPath,
        genreIds: movieModel.genreIds,
        genres: movieModel.genres,
        releaseDate: movieModel.releaseDate,
        runtime: movieModel.runtime,
        onWatchlist: onWatchlist
    );
  }
}