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
        formatString(TmdbApiConfig.watchListEndpoint, [userId]),
        queryParameters: {"session_id": sessionId}
    );
  }
}