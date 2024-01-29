import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helper/test_data.dart';
import 'movies_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {

  late MockClient mockClient;
  late MoviesDataSource moviesDataSource;

  setUp(() {
    mockClient = MockClient();
    moviesDataSource = MoviesDataSource(mockClient);
  });

  String createUrlString(String endpoint) {
    return "${TmdbApiConfig.baseUrl}$endpoint?api_key=${TmdbApiConfig.apiKey}";
  }

  group("Fetch trending movies", () {
    test("Should return a valid MovieModel list after fetching data", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.trendingMoviesEndpoint))))
          .thenAnswer((_) async => http.Response(fixture("movie_list.json"), 200));
      // act
      final result = await moviesDataSource.getTrendingMovies();
      // assert
      expect(result.length, 3);
      expect(result, testMovieModels);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.trendingMoviesEndpoint))))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = moviesDataSource.getTrendingMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.trendingMoviesEndpoint)))).thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.getTrendingMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });
  
  group("get movie details", () { 
    test("Should return a valid MovieModel after http call", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString("${TmdbApiConfig.movieDetailEndpoint}${testMovieDetailModel.id}"))))
          .thenAnswer((_) async => http.Response(fixture("movie_detail_model.json"), 200));
      // act
      final result = await moviesDataSource.getMovieDetails(testMovieDetailModel.id);
      // assert
      expect(result, testMovieDetailModel);
    });
  });

  test("Should catch exception if status code is not 200", () async {
    // arrange
    when(mockClient.get(Uri.parse(createUrlString("${TmdbApiConfig.movieDetailEndpoint}${testMovieDetailModel.id}"))))
        .thenAnswer((_) async => http.Response("error", 201));
    // act
    final call = moviesDataSource.getMovieDetails(1);
    // assert
    expect(() => call, throwsA(isA<DataError>()));
  });

  test("Should catch exception if an exception is thrown during fetch", () async {
    // arrange
    when(mockClient.get(Uri.parse(createUrlString("${TmdbApiConfig.movieDetailEndpoint}${testMovieDetailModel.id}"))))
        .thenThrow(Exception("error message"));
    // act
    final call = moviesDataSource.getMovieDetails(1);
    // assert
    expect(() => call, throwsA(isA<DataError>()));
  });

  group("Fetch popular movies", () {
    test("Should return a valid MovieModel list after fetching data", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.popularMoviesEndpoint))))
          .thenAnswer((_) async => http.Response(fixture("movie_list.json"), 200));
      // act
      final result = await moviesDataSource.getPopularMovies();
      // assert
      expect(result.length, 3);
      expect(result, testMovieModels);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.popularMoviesEndpoint))))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = moviesDataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.popularMoviesEndpoint)))).thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
      });
    });

  group("Fetch top rated movies", () {
    test("Should return a valid MovieModel list after fetching data", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.topRatedMoviesEndpoint))))
          .thenAnswer((_) async => http.Response(fixture("movie_list.json"), 200));
      // act
      final result = await moviesDataSource.getTopRatedMovies();
      // assert
      expect(result.length, 3);
      expect(result, testMovieModels);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.topRatedMoviesEndpoint))))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = moviesDataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.topRatedMoviesEndpoint)))).thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });
}