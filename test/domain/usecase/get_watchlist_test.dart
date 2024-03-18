import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';

import '../../helper/test_data.dart';
import 'usecase_test.mocks.dart';

void main() {
  late GetWatchListUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchListUseCase(mockMovieRepository);
  });

  test("Should get watchlist from the repository", () async  {
    // arrange
    when(mockMovieRepository.getWatchlist()).thenAnswer((_) async => const DataSuccess(testMovies));
    // act
    final result = await usecase();
    // assert
    expect(result, const DataSuccess(testMovies));
  });

  test("Should return DataFailure if there was an error while getting the data", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockMovieRepository.getWatchlist()).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase();
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, error);
  });
}