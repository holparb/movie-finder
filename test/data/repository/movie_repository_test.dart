import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';

import '../../helper/test_data.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([MoviesDataSource, LocalUserDataSource, LocalMoviesDataSource])
void main() {

  late MockMoviesDataSource moviesRemoteDataSource;
  late MockLocalMoviesDataSource moviesLocalDataSource;
  late MockLocalUserDataSource userDataSource;

  late MovieRepositoryImpl repository;

  setUp(() {
    moviesRemoteDataSource = MockMoviesDataSource();
    moviesLocalDataSource = MockLocalMoviesDataSource();
    userDataSource = MockLocalUserDataSource();
    repository = MovieRepositoryImpl(moviesRemoteDataSource, moviesLocalDataSource, userDataSource);
  });

  group("Get trending movies from MovieRepositoryImplementation", () {
    test("Should return a valid movie list if no exception was thrown", () async {
      // arrange
      when(moviesRemoteDataSource.getTrendingMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getTrendingMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });
    
    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(moviesRemoteDataSource.getTrendingMovies()).thenThrow(error);
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
      when(moviesRemoteDataSource.getMovieDetails(testMovieDetailModel.id)).thenAnswer((_) async => testMovieDetailModel);
      // act
      final result = await repository.getMovieDetails(testMovieDetailModel.id);
      // assert
      expect(result, DataSuccess(testMovieDetailModel));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(moviesRemoteDataSource.getMovieDetails(any)).thenThrow(error);
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
      when(moviesRemoteDataSource.getPopularMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getPopularMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(moviesRemoteDataSource.getPopularMovies()).thenThrow(error);
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
      when(moviesRemoteDataSource.getTopRatedMovies()).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(moviesRemoteDataSource.getTopRatedMovies()).thenThrow(error);
      // act
      final result = await repository.getTopRatedMovies();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });

  group("Get watchlist", () {
    test("Should return a valid movie list if no exception was thrown", () async {
      // arrange
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(userDataSource.readUserId()).thenAnswer((_) async => testUserModel.id.toString());
      when(moviesRemoteDataSource.getWatchList(testUserModel.id.toString(), testSessionId)).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(result, const DataSuccess(testMovieModels));
    });

    test("Should return DataFailure when userId could not be read", () async {
      // arrange
      DataError error = const DataError(message: "Local user data could not be read!");
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(userDataSource.readUserId()).thenAnswer((_) async => null);
      when(moviesRemoteDataSource.getWatchList(testUserModel.id.toString(), testSessionId)).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });

    test("Should return DataFailure when sessionId could not be read", () async {
      // arrange
      DataError error = const DataError(message: "Local user data could not be read!");
      when(userDataSource.readSessionId()).thenAnswer((_) async => null);
      when(userDataSource.readUserId()).thenAnswer((_) async => testUserModel.id.toString());
      when(moviesRemoteDataSource.getWatchList(testUserModel.id.toString(), testSessionId)).thenAnswer((_) async => testMovieModels);
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });

    test("Should return DataFailure when a DataError exception is thrown by the remote data source", () async {
      // arrange
      DataError error = const DataError(message: "Data fetch failed!");
      when(userDataSource.readSessionId()).thenAnswer((_) async => testSessionId);
      when(userDataSource.readUserId()).thenAnswer((_) async => testUserModel.id.toString());
      when(moviesRemoteDataSource.getWatchList(testUserModel.id.toString(), testSessionId)).thenThrow(error);
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(result, isA<DataFailure>());
      expect(result.error, error);
    });
  });

  group("Is movie a watchlist", () {
    test("Should return true if a movieId is part of the stored watchlist ids", () async {
      // arrange
      when(moviesLocalDataSource.readWatchlistIds()).thenAnswer((_) async => testWatchlistIds);
      // act
      final result = await repository.isMovieOnWatchlist(1);
      // assert
      expect(result, true);
    });

    test("Should return false if a movieId is not part of the stored watchlist ids", () async {
      // arrange
      when(moviesLocalDataSource.readWatchlistIds()).thenAnswer((_) async => testWatchlistIds);
      // act
      final result = await repository.isMovieOnWatchlist(2);
      // assert
      expect(result, false);
    });

    test("Should return false if null is returned by readWatchlistIds()", () async {
      // arrange
      when(moviesLocalDataSource.readWatchlistIds()).thenAnswer((_) async => null);
      // act
      final result = await repository.isMovieOnWatchlist(2);
      // assert
      expect(result, false);
    });
  });
}