import 'dart:developer';

import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/data/datasources/remote/remote_data_source.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/core/utils/format_string.dart';

class UserDataSource extends RemoteDataSource {

  const UserDataSource(super.client);

  Future<List<MovieModel>> _getMoviesList(String endpoint, {Map<String, String>? queryParameters}) async {
    final data = await get(createUrlString(endpoint, queryParameters: queryParameters));
    final List<dynamic> results = data["results"];
    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<RequestTokenModel> getRequestToken() async {
    final data = await get(createUrlString(TmdbApiConfig.getRequestTokenEndpoint));
    log(data.toString());
    return RequestTokenModel.fromJson(data);
  }

  Future<RequestTokenModel> validateToken(Map<String, String> requestBody) async {
    final response = await post(createUrlString(TmdbApiConfig.authenticationEndpoint), requestBody);
    log(response.toString());
    return RequestTokenModel.fromJson(response);
  }

  Future<String> createSession(RequestTokenModel requestToken) async {
    final response = await post(createUrlString(TmdbApiConfig.createSessionEndpoint), requestToken.toJson());
    log(response.toString());
    return response["success"] ? response["session_id"] : null;
  }

  Future<UserModel> getUserAccountDetails(String sessionId) async {
    final data = await get("${createUrlString("/account")}&session_id=$sessionId");
    log(data.toString());
    return UserModel.fromJson(data, sessionId);
  }

  Future<bool> deleteSession(Map<String, String> requestBody) async {
    final response = await delete(createUrlString(TmdbApiConfig.deleteSession), requestBody);
    log(response.toString());
    return response["success"] ? true : false;
  }
}