import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';

import '../../helper/test_data.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([MoviesDataSource, LocalUserDataSource])
void main() {

  late MockMoviesDataSource remoteDataSource;
  late MovieRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockMoviesDataSource();
    repository = MovieRepositoryImpl(remoteDataSource);
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

  group("Get movie details from MovieRepositoryImplementation", () {
    test("Should return a valid movie object if no exception was thrown", () async {
      // arrange
      when(remoteDataSource.getMovieDetails(testMovieDetailModel.id)).thenAnswer((_) async => testMovieDetailModel);
      // act
      final result = await repository.getMovieDetails(testMovieDetailModel.id);
      // assert
      expect(result, DataSuccess(testMovieDetailModel));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getMovieDetails(any)).thenThrow(error);
      // act
      final result = await repository.getMovieDetails(1);
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });

  group("Get popular movies from MovieRepositoryImplementation", () {
    test("Should return a valid movie list if no exception was thrown", () async {
      // arrange
      when(remoteDataSource.getPopularMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getPopularMovies()).thenThrow(error);
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });

  group("Get top rated movies from MovieRepositoryImplementation", () {
    test("Should return a valid movie list if no exception was thrown", () async {
      // arrange
      when(remoteDataSource.getTopRatedMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(remoteDataSource.getTopRatedMovies()).thenThrow(error);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });
}