import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';

abstract class RemoteDataSource {
  final http.Client client;

  const RemoteDataSource(this.client);

  /// Creates https://api.themoviedb.org/3/{endpoint} url with API key added as parameter
  /// and optional additional query parameters
  String createUrlString(String endpoint, {Map<String, String>? queryParameters}) {
    String urlString = "${TmdbApiConfig.baseUrl}$endpoint?api_key=${TmdbApiConfig.apiKey}";
    if(queryParameters != null && queryParameters.isNotEmpty) {
      urlString = "$urlString${_createQueryParametersString(queryParameters)}";
    }
    return urlString;
  }
  String _createQueryParametersString(Map<String, String> parameters) {
    String parameterString = "";
    parameters.forEach((key, value) {
      parameterString = "$parameterString&$key=$value";
    });
    return parameterString;
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
      log(exception.toString());
      throw DataError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      log("${response.statusCode}: ${response.reasonPhrase}");
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
    if (response.statusCode != 200 && response.statusCode != 201) {
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
      log(exception.toString());
      throw HttpError(message: exception.toString());
    }
    if (response.statusCode != 200) {
      log("${response.statusCode}: ${response.reasonPhrase ?? ""}");
      throw HttpError(message: "${response.statusCode}: ${response.reasonPhrase ?? ""}");
    }
    return json.decode(response.body);
  }
}