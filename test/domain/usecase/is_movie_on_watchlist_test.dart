import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';

import 'usecase_test.mocks.dart';


void main() {
  late IsMovieOnWatchListUseCase usecase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = IsMovieOnWatchListUseCase(mockRepository);
  });

  test("Should return true if user is logged in", () async  {
    // arrange
    when(mockRepository.isMovieOnWatchlist(any)).thenAnswer((_) async => true);
    // act
    final result = await usecase(params: 1);
    // assert
    expect(result, true);
  });

  test("Should return null if user is not logged in", () async {
    // arrange
    when(mockRepository.isMovieOnWatchlist(any)).thenAnswer((_) async => false);
    // act
    final result = await usecase(params: 1);
    // assert
    expect(result, false);
  });
}