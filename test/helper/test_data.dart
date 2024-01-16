import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/domain/entities/genre.dart';
import 'package:movie_finder/domain/entities/movie.dart';

/// Helper file containing test data of models and entities used in tests

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

const Movie testMovieWithNoDetailsInfo = MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null);

MovieModel testMovieDetailModel = MovieModel(id: 1, title: "Movie", overview: "overview", posterPath: "posterPath",
    voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [],
    genres: const [Genre(id: 1, name: "name"), Genre(id: 2, name: "name2")], releaseDate: DateTime.parse("1997-07-12"), runtime: 157);

Movie testMovieDetail = Movie(id: 1, title: "Movie", overview: "overview", posterPath: "posterPath",
    voteAverage: 5.555, backdropPath: "backdropPath", genreIds: [],
    genres: const [Genre(id: 1, name: "genreName"), Genre(id: 2, name: "genreName2")], releaseDate: DateTime.parse("1997-07-12"), runtime: 157);