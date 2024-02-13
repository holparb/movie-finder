import 'dart:developer';

import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/data/datasources/remote/data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';

class AuthDataSource extends DataSource {
  AuthDataSource(super.client);

  Future<RequestTokenModel> getRequestToken() async {
    final data = await get(createUrlString(TmdbApiConfig.getRequestTokenEndpoint));
    return RequestTokenModel.fromJson(data);
  }

  Future<RequestTokenModel> validateToken(Map<String, String> requestBody) async {
    final response = await post(createUrlString(TmdbApiConfig.authenticationEndpoint), requestBody);
    return RequestTokenModel.fromJson(response);
  }

  Future<String> createSession(RequestTokenModel requestToken) async {
    final response = await post(createUrlString(TmdbApiConfig.createSessionEndpoint), requestToken.toJson());
    log(response.toString());
    return response["success"] ? response["session_id"] : null;
  }

  Future<UserModel> getUserAccountDetails(String sessionId) async {
    final data = await get("${createUrlString("/account")}&session_id=$sessionId");
    return UserModel.fromJson(data, sessionId);
  }
}