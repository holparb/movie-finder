import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/domain/usecases/logout.dart';

import 'usecase_test.mocks.dart';

void main() {
  late LogoutUsecase usecase;
  late MockUserRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockUserRepository();
    usecase = LogoutUsecase(mockAuthRepository);
  });

  test("Should get user after successfully logging in", () async  {
    // arrange
    when(mockAuthRepository.logout()).thenAnswer((_) async => const DataSuccess<void>(null));
    // act
    final result = await usecase();
    // assert
    expect(result, const DataSuccess<void>(null));
  });

  test("Should return DataFailure if a DataError was thrown during logout", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockAuthRepository.logout()).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase();
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, isA<DataError>());
    expect(result.error, error);
  });

  test("Should return DataFailure if an HttpError was thrown during login", () async {
    // arrange
    HttpError error = const HttpError(message: "Http error!");
    when(mockAuthRepository.logout()).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase();
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, isA<HttpError>());
    expect(result.error, error);
  });
}