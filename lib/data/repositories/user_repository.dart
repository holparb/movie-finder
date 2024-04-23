import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/user_data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDataSource userDataSource;
  final LocalUserDataSource localUserDataSource;

  const UserRepositoryImpl(this.userDataSource, this.localUserDataSource);

  @override
  Future<DataState<UserModel>> login(Map<String, String> loginRequestBody) async {
    try {
      RequestTokenModel requestToken = await userDataSource.getRequestToken();
      loginRequestBody.putIfAbsent("request_token", () => requestToken.token);
      requestToken = await userDataSource.validateToken(loginRequestBody);
      final sessionId = await userDataSource.createSession(requestToken);
      UserModel user = await userDataSource.getUserAccountDetails(sessionId);
      // Generally it is not a good idea to store user and session data
      // in shared prefs for security reasons but for now it will be done this way to speed up practice
      await localUserDataSource.writeUserData(sessionId, user);
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
      final sessionId = await localUserDataSource.readSessionId();
      if(sessionId == null) {
        return const DataFailure(DataError(message: "Session id could not be read from local storage"));
      }
      final success = await userDataSource.deleteSession({"session_id": sessionId});
      if(!success) {
        return const DataFailure(HttpError(message: "Session delete was unsuccessful!"));
      }
      await localUserDataSource.deleteUserData();
      return const DataSuccess(null);
    }
    on HttpError catch(error) {
      return DataFailure(HttpError(message: error.message));
    }
  }

  @override
  Future<String?> isUserLoggedIn() async {
    final sessionId = await localUserDataSource.readSessionId();
    // User is logged in if a non empty session id is stored in shared prefs
    if(sessionId == null) {
      return null;
    }
    return await localUserDataSource.readUsername();
  }
}