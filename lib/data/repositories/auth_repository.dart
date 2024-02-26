import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource authDataSource;

  const AuthRepositoryImpl(this.authDataSource);

  @override
  Future<DataState<UserModel>> login(Map<String, String> loginRequestBody) async {
    try {
      RequestTokenModel requestToken = await authDataSource.getRequestToken();
      loginRequestBody.putIfAbsent("request_token", () => requestToken.token);
      requestToken = await authDataSource.validateToken(loginRequestBody);
      final sessionId = await authDataSource.createSession(requestToken);
      UserModel user = await authDataSource.getUserAccountDetails(sessionId);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Generally it is not a good idea to store user and session data
      // in shared prefs for security reasons but for now it will be done this way to speed up practice
      await prefs.setString("sessionId", sessionId);
      await prefs.setString("userId", user.id as String);
      return DataSuccess(user);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
    on HttpError catch(error) {
      return DataFailure(HttpError(message: error.message));
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString("sessionId");
      if(sessionId == null) {
        return const DataFailure(DataError(message: "Session id could not be read from local storage"));
      }
      final success = await authDataSource.deleteSession({"session_id": sessionId});
      return success ? const DataSuccess(null) : const DataFailure(HttpError(message: "Session delete was unsuccessful!"));
    }
    on HttpError catch(error) {
      return DataFailure(HttpError(message: error.message));
    }
  }
}