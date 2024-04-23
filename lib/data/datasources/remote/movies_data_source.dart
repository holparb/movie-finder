import 'dart:developer';

import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/utils/format_string.dart';
import 'package:movie_finder/data/datasources/remote/remote_data_source.dart';
import 'package:movie_finder/data/models/movie_model.dart';

class MoviesDataSource extends RemoteDataSource {

  MoviesDataSource(super.client);
  /// Returns list of movies for the given endpoint
  Future<List<MovieModel>> _getMoviesList(String endpoint, {Map<String, String>? queryParameters}) async {
    final data = await get(createUrlString(endpoint, queryParameters: queryParameters));
    final List<dynamic> results = data["results"];
    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getTrendingMovies() async {
    return await _getMoviesList(TmdbApiConfig.trendingMoviesEndpoint);
  }

  Future<List<MovieModel>> getPopularMovies() async {
    return await _getMoviesList(TmdbApiConfig.popularMoviesEndpoint);
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    return await _getMoviesList(TmdbApiConfig.topRatedMoviesEndpoint);
  }

  Future<MovieModel> getMovieDetails(int id) async {
    final data = await get(createUrlString(formatString(TmdbApiConfig.movieDetailEndpoint, [id.toString()])));
    return MovieModel.fromJson(data);
  }

  Future<List<MovieModel>> getWatchList(String userId, String sessionId) async {
    return await _getMoviesList(
        formatString(TmdbApiConfig.watchlistEndpoint, [userId]),
        queryParameters: {"session_id": sessionId}
    );
  }

  Future<bool> editWatchlist({required int movieId, required String userId, required String sessionId, required bool add}) async {
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": movieId,
      "watchlist": add
    };
    final response = await post(
        createUrlString(formatString(
            TmdbApiConfig.watchlistEditEndpoint, [userId]),
            queryParameters: {"session_id": sessionId}
        ),
        body);
    log(response.toString());
    return response["success"] ? true : false;
  }

  Future<bool> addToWatchlist({required int movieId, required String userId, required String sessionId}) async {
    return await editWatchlist(movieId: movieId, userId: userId, sessionId: sessionId, add: true);
  }

  Future<bool> removeFromWatchlist({required int movieId, required String userId, required String sessionId}) async {
    return await editWatchlist(movieId: movieId, userId: userId, sessionId: sessionId, add: false);
  }
}