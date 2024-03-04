import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/data/datasources/remote/remote_data_source.dart';
import 'package:movie_finder/data/models/movie_model.dart';

class MoviesDataSource extends DataSource {

  MoviesDataSource(super.client);

  /// Returns list of movies for the given endpoint
  Future<List<MovieModel>> getMoviesList(String endpoint) async {
    final data = await get(createUrlString(endpoint));
    final List<dynamic> results = data['results'];
    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getTrendingMovies() async {
    return await getMoviesList(TmdbApiConfig.trendingMoviesEndpoint);
  }

  Future<List<MovieModel>> getPopularMovies() async {
    return await getMoviesList(TmdbApiConfig.popularMoviesEndpoint);
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    return await getMoviesList(TmdbApiConfig.topRatedMoviesEndpoint);
  }

  Future<MovieModel> getMovieDetails(int id) async {
    final data = await get(createUrlString("${TmdbApiConfig.movieDetailEndpoint}$id"));
    return MovieModel.fromJson(data);
  }
}