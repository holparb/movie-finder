import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/login_bloc.dart';

import '../../../helper/test_data.dart';
import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginUsecase])
void main() {

  late MockLoginUsecase usecase;
  late LoginBloc loginBloc;

  setUp(() {
    usecase = MockLoginUsecase();
    loginBloc = LoginBloc(usecase);
  });

  test("Initial state should be NotLoggedIn", () {
    expect(loginBloc.state, const NotLoggedIn());
  });

  group("GetMovieDetails", () {
    LoginParams loginParams = const LoginParams(username: "username", password: "password");
    blocTest<LoginBloc, AuthState>("Should return LoggedIn if DataSuccess is returned from usecase",
        build: () {
          when(usecase(params: loginParams)).thenAnswer((_) async => DataSuccess(testUser));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LogIn(loginParams: loginParams)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          const LoggedIn()
        ]
    );

    DataError error = const DataError(message: "Login failed!");
    blocTest<LoginBloc, AuthState>("Should return LoginError if DataFailure is returned from usecase",
        build: () {
          when(usecase(params: loginParams)).thenAnswer((_) async => DataFailure(error));
          return loginBloc;
        },
        act: (bloc) => bloc.add(LogIn(loginParams: loginParams)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          LoginError(error.message)
        ]
    );
  });
}