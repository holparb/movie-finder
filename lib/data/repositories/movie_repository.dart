import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviesDataSource _remoteDataSource;
  final LocalUserDataSource userDataSource;

  MovieRepositoryImpl(this._remoteDataSource, this.userDataSource);

  @override
  Future<DataState<List<MovieModel>>> getTrendingMovies() async {
    try {
      List<MovieModel> movies = await _remoteDataSource.getTrendingMovies();
      return DataSuccess(movies);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  @override
  Future<DataState<MovieModel>> getMovieDetails(int id) async {
    try {
      MovieModel movie = await _remoteDataSource.getMovieDetails(id);
      return DataSuccess(movie);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  @override
  Future<DataState<List<MovieModel>>> getPopularMovies() async {
    try {
      List<MovieModel> movies = await _remoteDataSource.getPopularMovies();
      return DataSuccess(movies);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  @override
  Future<DataState<List<MovieModel>>> getTopRatedMovies() async {
    try {
      List<MovieModel> movies = await _remoteDataSource.getTopRatedMovies();
      return DataSuccess(movies);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  @override
  Future<DataState<List<MovieModel>>> getWatchlist() async {
    final userId = await userDataSource.readUserId();
    final sessionId = await userDataSource.readSessionId();
    if(userId == null || sessionId == null) {
      return const DataFailure(DataError(message: "Local user data could not be read!"));
    }
    try {
      List<MovieModel> movies = await _remoteDataSource.getWatchList(userId, sessionId);
      return DataSuccess(movies);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }
}