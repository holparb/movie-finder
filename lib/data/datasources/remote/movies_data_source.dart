import 'dart:convert';

import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesDataSource {

  final http.Client client;

  MoviesDataSource(this.client);

  /// Creates https://api.themoviedb.org/3/{endpoint} url
  String _createUrlString(String endpoint) {
    return "${TmdbApiConfig.baseUrl}$endpoint?api_key=${TmdbApiConfig.apiKey}";
  }

  /// Calls the given url wraps the response in a [DataSuccess] object if data was successfully fetched
  ///
  /// Throws a [DataError] for all error codes.
  Future<http.Response> getResponse(String url) async {
    final http.Response response;
    try {
      response = await client.get(Uri.parse(url));
    }
    on Exception catch (exception) {
      throw DataError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      throw DataError(message: "Failed to fetch movies: error code ${response.statusCode}");
    }
    return response;
  }

  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await getResponse(_createUrlString(TmdbApiConfig.trendingMoviesEndpoint));
    final data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<MovieModel> getMovieDetails(int id) async {
    final response = await getResponse(_createUrlString("${TmdbApiConfig.movieDetailEndpoint}$id"));
    final jsonMap = json.decode(response.body);
    return MovieModel.fromJson(jsonMap);
  }
}