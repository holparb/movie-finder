import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';

import '../../helper/test_data.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([MoviesDataSource])
void main() {

  late MockMoviesDataSource remoteDataSource;
  late MovieRepositoryImplementation repository;

  setUp(() {
    remoteDataSource = MockMoviesDataSource();
    repository = MovieRepositoryImplementation(remoteDataSource);
  });

  group("Get trending movies from MovieRepositoryImplementation", () {
    test("Should return a valid movie list if no exception was thrown", () async {
      // arrange
      when(remoteDataSource.getTrendingMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getTrendingMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });
    
    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getTrendingMovies()).thenThrow(error);
      // act
      final result = await repository.getTrendingMovies();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });
  

}