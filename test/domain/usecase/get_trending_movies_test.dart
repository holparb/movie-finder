import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';

import '../../helper/test_data.dart';
import 'usecase_test.mocks.dart';

void main() {
  late GetTrendingMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMoviesUseCase(mockMovieRepository);
  });

  test("Should get trending movies from the repository", () async  {
    // arrange
    when(mockMovieRepository.getTrendingMovies()).thenAnswer((_) async => const DataSuccess(testMovies));
    // act
    final result = await usecase();
    // assert
    expect(result, const DataSuccess(testMovies));
  });

  test("Should return DataFailure if there was an error while getting the data", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockMovieRepository.getTrendingMovies()).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase();
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, error);
  });
}