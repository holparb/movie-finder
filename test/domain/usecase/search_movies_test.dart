import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/search_movies.dart';

import '../../helper/test_data.dart';
import 'usecase_test.mocks.dart';

void main() {
  late SearchMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;
  const String query = "some text";

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMoviesUseCase(mockMovieRepository);
  });

  test("Should get valid results", () async  {
    // arrange
    when(mockMovieRepository.search(query)).thenAnswer((_) async => const DataSuccess(testMovies));
    // act
    final result = await usecase(params: query);
    // assert
    expect(result, const DataSuccess(testMovies));
  });

  test("Should return DataFailure if there was an error while getting the data", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockMovieRepository.search(query)).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase(params: query);
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, error);
  });
}