import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/domain/usecases/login.dart';

import '../../helper/test_data.dart';
import 'usecase_test.mocks.dart';


void main() {
  late LoginUsecase usecase;
  late MockUserRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockUserRepository();
    usecase = LoginUsecase(mockAuthRepository);
  });

  const LoginParams loginParams = LoginParams(username: "username", password: "password");

  test("Should get user after successfully logging in", () async  {
    // arrange
    when(mockAuthRepository.login(loginParams.toJson())).thenAnswer((_) async => DataSuccess(testUser));
    // act
    final result = await usecase(params: loginParams);
    // assert
    expect(result, DataSuccess(testUser));
  });

  test("Should return DataFailure if a DataError was thrown during login", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockAuthRepository.login(loginParams.toJson())).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase(params: loginParams);
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, isA<DataError>());
    expect(result.error, error);
  });

  test("Should return DataFailure if a PostError was thrown during login", () async {
    // arrange
    HttpError error = const HttpError(message: "post error!");
    when(mockAuthRepository.login(loginParams.toJson())).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase(params: loginParams);
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, isA<HttpError>());
    expect(result.error, error);
  });
}