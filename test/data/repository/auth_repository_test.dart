import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/repositories/auth_repository.dart';

import '../../helper/test_data.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([AuthDataSource])
void main() {

  late MockAuthDataSource remoteDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthDataSource();
    repository = AuthRepositoryImpl(remoteDataSource);
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
      expect(result.error, error);
    });
  });
}