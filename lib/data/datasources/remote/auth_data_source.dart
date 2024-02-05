import 'dart:developer';

import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/data/datasources/remote/data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';

class AuthDataSource extends DataSource {
  AuthDataSource(super.client);

  Future<RequestTokenModel> getRequestToken() async {
    final data = await get(createUrlString(TmdbApiConfig.getRequestTokenEndpoint));
    return RequestTokenModel.fromJson(data.body);
  }

  Future<RequestTokenModel> validateToken(String requestToken) async {
    final data = await get(createUrlString("${TmdbApiConfig.authenticationEndpoint}$requestToken"));
    log(data.toString());
    return RequestTokenModel(token: "token", expiresAt: DateTime.now());
  }
}