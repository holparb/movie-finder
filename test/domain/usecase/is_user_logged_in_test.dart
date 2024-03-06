import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/domain/usecases/is_user_logged_in.dart';

import 'usecase_test.mocks.dart';


void main() {
  late IsUserLoggedInUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = IsUserLoggedInUseCase(mockAuthRepository);
  });

  test("Should return username if user is logged in", () async  {
    // arrange
    String username = "username";
    when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => username);
    // act
    final result = await usecase();
    // assert
    expect(result, username);
  });

  test("Should return null if user is not logged in", () async {
    // arrange
    when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => null);
    // act
    final result = await usecase();
    // assert
    expect(result, null);
  });
}