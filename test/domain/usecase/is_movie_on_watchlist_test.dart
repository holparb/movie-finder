import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';

import 'usecase_test.mocks.dart';


void main() {
  late IsMovieOnWatchlistUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = IsMovieOnWatchlistUseCase(mockMovieRepository);
  });

  test("Should return true if repository returns true", () async  {
    // arrange
    when(mockMovieRepository.isMovieOnWatchlist(any)).thenAnswer((_) async => true);
    // act
    final result = await usecase(params: 1);
    // assert
    expect(result, true);
  });

  test("Should return false if repository returns false", () async  {
    // arrange
    when(mockMovieRepository.isMovieOnWatchlist(any)).thenAnswer((_) async => false);
    // act
    final result = await usecase(params: 1);
    // assert
    expect(result, false);
  });
}