import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/exceptions/auth_error.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';

abstract class DataSource {
  final http.Client client;

  DataSource(this.client);

  /// Creates https://api.themoviedb.org/3/{endpoint} url
  String createUrlString(String endpoint) {
    return "${TmdbApiConfig.baseUrl}$endpoint?api_key=${TmdbApiConfig.apiKey}";
  }

  /// Generic GET call
  ///
  /// Throws a [DataError] for all error codes.
  dynamic get(String url) async {
    final http.Response response;
    try {
      response = await client.get(Uri.parse(url));
    }
    on Exception catch (exception) {
      throw DataError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      throw DataError(message: response.reasonPhrase ?? "");
    }
    return json.decode(response.body);
  }

  /// Generic POST call
  ///
  /// Throws an [AuthError] for all error codes.
  dynamic post(String url, Map<dynamic, dynamic>? params) async {
    final response = await client.post(
      Uri.parse(url),
      body: jsonEncode(params),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode != 200) {
      throw AuthError(response.reasonPhrase ?? "");

    }
    return json.decode(response.body);
  }
}