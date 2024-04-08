import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/models/movie_detail_model.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviesDataSource _remoteDataSource;
  final LocalMoviesDataSource _localMoviesDataSource;
  final LocalUserDataSource _localUserDataSource;

  const MovieRepositoryImpl(this._remoteDataSource, this._localMoviesDataSource, this._localUserDataSource);

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
  Future<DataState<MovieDetailModel>> getMovieDetails(int id) async {
    try {
      MovieModel movie = await _remoteDataSource.getMovieDetails(id);
      bool onWatchlist = await isMovieOnWatchlist(id);
      return DataSuccess(MovieDetailModel.fromMovieModel(movie, onWatchlist));
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
    final userId = await _localUserDataSource.readUserId();
    final sessionId = await _localUserDataSource.readSessionId();
    if(userId == null || sessionId == null) {
      return const DataFailure(DataError(message: "Local user data could not be read!"));
    }
    try {
      List<MovieModel> watchlist = await _remoteDataSource.getWatchList(userId, sessionId);
      await _localMoviesDataSource.writeWatchlistIds(watchlist);
      return DataSuccess(watchlist);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  Future<bool> isMovieOnWatchlist(int movieId) async {
    final watchlistIds = await _localMoviesDataSource.readWatchlistIds();
    if(watchlistIds == null || watchlistIds.isEmpty) {
      return false;
    }
    return watchlistIds.contains(movieId.toString());
  }
}