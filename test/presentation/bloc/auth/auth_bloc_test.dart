import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/domain/usecases/logout.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';

import '../../../helper/test_data.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([LoginUsecase, LogoutUsecase])
void main() {

  late MockLoginUsecase loginUsecase;
  late MockLogoutUsecase logoutUsecase;
  late AuthBloc authBloc;

  setUp(() {
    loginUsecase = MockLoginUsecase();
    logoutUsecase = MockLogoutUsecase();
    authBloc = AuthBloc(loginUsecase, logoutUsecase);
  });

  test("Initial state should be NotLoggedIn", () {
    expect(authBloc.state, const NotLoggedIn());
  });

  group("Login", () {
    LoginParams loginParams = const LoginParams(username: "username", password: "password");
    blocTest<AuthBloc, AuthState>("Should return LoggedIn if DataSuccess is returned from loginUsecase",
        build: () {
          when(loginUsecase(params: loginParams)).thenAnswer((_) async => DataSuccess(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(LogIn(loginParams: loginParams)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          LoggedIn(testUser.username)
        ]
    );

    DataError error = const DataError(message: "Login failed!");
    blocTest<AuthBloc, AuthState>("Should return LoginError if DataFailure is returned from loginUsecase",
        build: () {
          when(loginUsecase(params: loginParams)).thenAnswer((_) async => DataFailure(error));
          return authBloc;
        },
        act: (bloc) => bloc.add(LogIn(loginParams: loginParams)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          AuthError(error.message)
        ]
    );
  });

  group("Logout", () {
    LoginParams loginParams = const LoginParams(username: "username", password: "password");
    blocTest<AuthBloc, AuthState>("Should return NotLoggedIn if DataSuccess is returned from logoutUsecase",
        build: () {
          when(loginUsecase(params: loginParams)).thenAnswer((_) async => DataSuccess(testUser));
          when(logoutUsecase()).thenAnswer((_) async => const DataSuccess<void>(null));
          return authBloc;
        },
        act: (bloc) { bloc.add(LogIn(loginParams: loginParams)); bloc.add(const LogOut()); },
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          LoggedIn(testUser.username),
          const NotLoggedIn()
        ]
    );

    HttpError error = const HttpError(message: "Logout failed!");
    blocTest<AuthBloc, AuthState>("Should set state to AuthErrorLogout  if DataFailure is returned from logoutUsecase",
        build: () {
          when(loginUsecase(params: loginParams)).thenAnswer((_) async => DataSuccess(testUser));
          when(logoutUsecase()).thenAnswer((_) async => DataFailure(error));
          return authBloc;
        },
        act: (bloc) { bloc.add(LogIn(loginParams: loginParams)); bloc.add(const LogOut());},
        wait: const Duration(seconds: 1),
        expect: () => [
          const LoggingIn(),
          LoggedIn(testUser.username),
          AuthError(error.message)
        ]
    );
  });
}