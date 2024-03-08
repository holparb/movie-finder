import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/test_data.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthDataSource, LocalUserDataSource])
void main() {

  late MockAuthDataSource remoteDataSource;
  late MockLocalUserDataSource userDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthDataSource();
    userDataSource = MockLocalUserDataSource();
    repository = AuthRepositoryImpl(remoteDataSource, userDataSource);
  });

  Map<String, String> loginRequestBody = {
    "username": "user",
    "password": "password"
  };

  group("Login", () {
    test("Should return user account details after successfully logging in", () async {
      // arrange
      when(remoteDataSource.getRequestToken()).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.validateToken(loginRequestBody)).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.createSession(testRequestTokenModel)).thenAnswer((_) async => testSessionId);
      when(remoteDataSource.getUserAccountDetails(testSessionId)).thenAnswer((_) async => testUserModel);
      // act
      final result = await repository.login(loginRequestBody);
      // assert
      expect(result, DataSuccess(testUserModel));
    });
    
    test("Should return DataFailure when a DataError exception is thrown during request token request", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getRequestToken()).thenThrow(error);
      // act
      final result = await repository.login(loginRequestBody);
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<DataError>());
      expect(result.error, error);
    });

    test("Should return DataFailure when an HttpError exception is thrown during login validation", () async {
      // arrange
      HttpError error = const HttpError(message: "Post error!");
      when(remoteDataSource.getRequestToken()).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.validateToken(loginRequestBody)).thenThrow(error);
      // act
      final result = await repository.login(loginRequestBody);
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<HttpError>());
      expect(result.error, error);
    });

    test("Should return DataFailure when an HttpError exception is thrown during session creation", () async {
      // arrange
      HttpError error = const HttpError(message: "Post error!");
      when(remoteDataSource.getRequestToken()).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.validateToken(loginRequestBody)).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.createSession(testRequestTokenModel)).thenThrow(error);
      // act
      final result = await repository.login(loginRequestBody);
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<HttpError>());
      expect(result.error, error);
    });

    test("Should return DataFailure when a DataError exception is thrown during user account retrieval", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getRequestToken()).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.validateToken(loginRequestBody)).thenAnswer((_) async => testRequestTokenModel);
      when(remoteDataSource.createSession(testRequestTokenModel)).thenAnswer((_) async => testSessionId);
      when(remoteDataSource.getUserAccountDetails(testSessionId)).thenThrow(error);
      // act
      final result = await repository.login(loginRequestBody);
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<DataError>());
      expect(result.error, error);
    });
  });

  group("Logout", () {
    test("Should return DataSuccess when logout returns true", () async {
      final logoutBody = {
        "session_id": testSessionId
      };
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(remoteDataSource.deleteSession(logoutBody)).thenAnswer((_) async => true);
      // act
      final result = await repository.logout();
      // assert
      expect(result, const DataSuccess<void>(null));
    });

    test("Should return DataFailure when sessionId is not stored in local storage", () async {
      final logoutBody = {
        "session_id": testSessionId
      };
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => null);
      when(remoteDataSource.deleteSession(logoutBody)).thenAnswer((_) async => true);
      // act
      final result = await repository.logout();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<DataError>());
    });

    test("Should return DataFailure when data source returns false", () async {
      final logoutBody = {
        "session_id": testSessionId
      };
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(remoteDataSource.deleteSession(logoutBody)).thenAnswer((_) async => false);
      // act
      final result = await repository.logout();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<HttpError>());
    });

    test("Should return DataFailure when data source throws HttpError", () async {
      final logoutBody = {
        "session_id": testSessionId
      };
      const error = HttpError(message: "error message");
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(remoteDataSource.deleteSession(logoutBody)).thenThrow(error);
      // act
      final result = await repository.logout();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, isA<HttpError>());
      expect(result.error, error);
    });
  });

  group("User logged in status", () {
    test("Should return username if data source readSessionId returns sessionId", () async {
      // arrange
      const String username = "username";
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(userDataSource.readUsername()).thenAnswer((_) async => username);
      // act
      final result = await repository.isUserLoggedIn();
      // assert
      expect(result, username);
    });

    test("Should return false if data source readSessionId returns null", () async {
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => null);
      // act
      final username = await repository.isUserLoggedIn();
      // assert
      expect(username, null);
    });

    test("Should return null if data source readUsername returns null", () async {
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(userDataSource.readUsername()).thenAnswer((_) async => null);
      // act
      final username = await repository.isUserLoggedIn();
      // assert
      expect(username, null);
    });
  });
}