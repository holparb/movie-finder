import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/entities/genre.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/entities/user.dart';

/// Helper file containing test data of models and entities used in tests

const List<MovieModel> testMovieModels = [
MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
MovieModel(id: 2, title: "title2", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
MovieModel(id: 3, title: "title3", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null)
];

const List<String> testWatchlistIds = ["1", "5", "6"];

const List<Movie> testMovies = [
  MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
  MovieModel(id: 2, title: "title2", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null),
  MovieModel(id: 3, title: "title3", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null)
];

const Movie testMovieWithNoDetailsInfo = MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: null, runtime: null);

MovieModel testMovieDetailModel = MovieModel(id: 1, title: "Movie", overview: "overview", posterPath: "posterPath",
    voteAverage: 1.0, backdropPath: "backdropPath", genreIds: const [],
    genres: const [Genre(id: 1, name: "name"), Genre(id: 2, name: "name2")], releaseDate: DateTime.parse("1997-07-12"), runtime: 157);

Movie testMovieDetail = Movie(id: 1, title: "Movie", overview: "overview", posterPath: "posterPath",
    voteAverage: 5.555, backdropPath: "backdropPath", genreIds: const [],
    genres: const [Genre(id: 1, name: "genreName"), Genre(id: 2, name: "genreName2")], releaseDate: DateTime.parse("1997-07-12"), runtime: 157);


RequestTokenModel testRequestTokenModel = const RequestTokenModel(token: "5e29eca2e02b5adaf9a659e41bb4ca1bd6bcc0fd", expiresAt: "2030-03-13 05:48:07 UTC");

const String testSessionId = "acf5454hg7676gf3334";

UserModel testUserModel = const UserModel(id: 123, username: "test_user", sessionId: "acf5454hg7676gf3334");
User testUser = const User(id: 123, username: "test_user", sessionId: "acf5454hg7676gf3334");