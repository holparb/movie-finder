import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';

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
      log("GET $url");
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
  /// Throws an [HttpError] for all error codes.
  dynamic post(String url, Map<dynamic, dynamic>? body) async {
    log("POST $url");
    log("POST body: ${body!.toString()}");
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );
    }
    on Exception catch (exception) {
      throw HttpError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      throw HttpError(message: "${response.statusCode}: ${response.reasonPhrase ?? ""}");
    }
    return json.decode(response.body);
  }

  /// Generic DELETE call
  ///
  /// Throws an [HttpError] for all error codes.
  dynamic delete(String url, Map<dynamic, dynamic>? body) async {
    log("DELETE $url");
    log("DELETE body: ${body!.toString()}");
    final http.Response response;
    try {
      response = await client.delete(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );
    }
    on Exception catch (exception) {
      throw HttpError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      throw HttpError(message: "${response.statusCode}: ${response.reasonPhrase ?? ""}");
    }
    return json.decode(response.body);
  }
}