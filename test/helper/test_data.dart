import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/domain/entities/movie.dart';

const List<MovieModel> testMovieModels = [
MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
MovieModel(id: 2, title: "title2", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
MovieModel(id: 3, title: "title3", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null)
];

const List<Movie> testMovies = [
  MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
  MovieModel(id: 2, title: "title2", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
  MovieModel(id: 3, title: "title3", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null)
];

const Movie testMovieWithNullReleaseDateAndRuntime = MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null);