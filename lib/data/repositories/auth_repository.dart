import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource authDataSource;
  final LocalUserDataSource userDataSource;

  const AuthRepositoryImpl(this.authDataSource, this.userDataSource);

  @override
  Future<DataState<UserModel>> login(Map<String, String> loginRequestBody) async {
    try {
      RequestTokenModel requestToken = await authDataSource.getRequestToken();
      loginRequestBody.putIfAbsent("request_token", () => requestToken.token);
      requestToken = await authDataSource.validateToken(loginRequestBody);
      final sessionId = await authDataSource.createSession(requestToken);
      UserModel user = await authDataSource.getUserAccountDetails(sessionId);
      // Generally it is not a good idea to store user and session data
      // in shared prefs for security reasons but for now it will be done this way to speed up practice
      await userDataSource.writeUserData(sessionId, user);
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
      final sessionId = await userDataSource.readSessionId();
      if(sessionId == null) {
        return const DataFailure(DataError(message: "Session id could not be read from local storage"));
      }
      final success = await authDataSource.deleteSession({"session_id": sessionId});
      if(!success) {
        return const DataFailure(HttpError(message: "Session delete was unsuccessful!"));
      }
      await userDataSource.deleteUserData();
      return const DataSuccess(null);
    }
    on HttpError catch(error) {
      return DataFailure(HttpError(message: error.message));
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final sessionId = await userDataSource.readSessionId();
    // User is logged in if a non empty session id is stored in shared prefs
    return sessionId != null ? true : false;
  }

}