import 'dart:developer';

import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
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
  Future<DataState<MovieModel>> getMovieDetails(int movieId) async {
    try {
      MovieModel movie = await _remoteDataSource.getMovieDetails(movieId);
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
    try {
      final userAuthData = await _localUserDataSource.getUserAuthData();
      List<MovieModel> watchlist = await _remoteDataSource.getWatchList(userAuthData.userId, userAuthData.sessionId);
      await _localMoviesDataSource.writeWatchlistIds(watchlist);
      return DataSuccess(watchlist);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }

  @override
  Future<bool> isMovieOnWatchlist(int movieId) async {
    final watchlistIds = await _localMoviesDataSource.readWatchlistIds();
    if(watchlistIds == null || watchlistIds.isEmpty) {
      return false;
    }
    return watchlistIds.contains(movieId.toString());
  }

  @override
  Future<bool> addToWatchlist(int movieId) async {
    try {
      final userAuthData = await _localUserDataSource.getUserAuthData();
      final success = await _remoteDataSource.addToWatchlist(movieId: movieId, userId: userAuthData.userId, sessionId: userAuthData.sessionId);
      if(success) {
        await _localMoviesDataSource.addToWatchlist(movieId);
      }
      return success;
    }
    catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removeFromWatchlist(int movieId) async {
    try {
      final userAuthData = await _localUserDataSource.getUserAuthData();
      final success = await _remoteDataSource.removeFromWatchlist(movieId: movieId, userId: userAuthData.userId, sessionId: userAuthData.sessionId);
      if(success) {
        await _localMoviesDataSource.removeFromWatchlist(movieId);
      }
      return success;
    }
    catch (e) {
      return false;
    }
  }

  @override
  Future<DataState<List<MovieModel>>> search(String query) async {
    try {
      List<MovieModel> results = await _remoteDataSource.search(query);
      log("Search result: ${results.toString()}");
      return DataSuccess(results);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
  }
}