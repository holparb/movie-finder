import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';

import '../../helper/test_data.dart';
import 'get_trending_movies_test.mocks.dart';

@GenerateMocks([MovieRepository])
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
}