import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/post_error.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/models/request_token_model.dart';
import 'package:movie_finder/data/models/user_model.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';

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
      return DataSuccess(user);
    }
    on DataError catch(error) {
      return DataFailure(error);
    }
    on PostError catch(error) {
      return DataFailure(PostError(message: error.message));
    }
  }

  @override
  Future<DataState<void>> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

}