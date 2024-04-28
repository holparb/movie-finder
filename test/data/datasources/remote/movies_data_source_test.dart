import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/core/exceptions/http_error.dart';
import 'package:movie_finder/core/utils/format_string.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helper/test_data.dart';
import 'data_source_test.mocks.dart';
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
    final String movieDetailsUrlString = createUrlString(formatString(TmdbApiConfig.movieDetailEndpoint, [testMovieDetailModel.id.toString()]));
    test("Should return a valid MovieModel after http call", () async {
      // arrange
      when(mockClient.get(Uri.parse(movieDetailsUrlString)))
          .thenAnswer((_) async => http.Response(fixture("movie_detail_model.json"), 200));
      // act
      final result = await moviesDataSource.getMovieDetails(testMovieDetailModel.id);
      // assert
      expect(result, testMovieDetailModel);
    });

    test("Should catch exception if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(movieDetailsUrlString)))
          .thenAnswer((_) async => http.Response("error", 201));
      // act
      final call = moviesDataSource.getMovieDetails(1);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(movieDetailsUrlString)))
          .thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.getMovieDetails(1);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
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

  group("Fetch watchlist", () {
    const String userId = "123";
    final String watchlistUrlString = "${createUrlString(formatString(TmdbApiConfig.watchlistEndpoint, [userId]))}&session_id=$testSessionId";
    test("Should return a valid MovieModel list after fetching data", () async {
      // arrange
      when(mockClient.get(Uri.parse(watchlistUrlString)))
          .thenAnswer((_) async => http.Response(fixture("movie_list.json"), 200));
      // act
      final result = await moviesDataSource.getWatchList(userId, testSessionId);
      // assert
      expect(result.length, 3);
      expect(result, testMovieModels);
    });

    test("Should return DataError if status code is not 200", () async {
      // arrange
      when(mockClient.get(Uri.parse(watchlistUrlString)))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = moviesDataSource.getWatchList(userId, testSessionId);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should return DataError if an exception is thrown during fetch", () async {
      // arrange
      when(mockClient.get(Uri.parse(watchlistUrlString))).thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.getWatchList(userId, testSessionId);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });

  group("Add to watchlist", () {
    final String watchlistEditUrlString = "${createUrlString(formatString(TmdbApiConfig.watchlistEditEndpoint, [testUserModel.id.toString()]))}&session_id=$testSessionId";
    const int movieId = 1;
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": movieId,
      "watchlist": true
    };
    test("Should return true if success is returned by API", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("watchlist_edit_success_response.json"), 200));
      // act
      final result = await moviesDataSource.addToWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(result, true);
    });

    test("Should return false if failure is returned by API", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("watchlist_edit_failure_response.json"), 200));
      // act
      final result = await moviesDataSource.addToWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(result, false);
    });

    test("Should throw HttpError if code is not 200", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response("Something went wrong!", 400));
      // act
      final call =  moviesDataSource.addToWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(call, throwsA(isA<HttpError>()));
    });

    test("Should throw HttpError if Exception is thrown during http call", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenThrow(Exception("error"));
      // act
      final call =  moviesDataSource.addToWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(call, throwsA(isA<HttpError>()));
    });
  });

  group("Remove from watchlist", () {
    final String watchlistEditUrlString = "${createUrlString(formatString(TmdbApiConfig.watchlistEditEndpoint, [testUserModel.id.toString()]))}&session_id=$testSessionId";
    const int movieId = 1;
    Map<String, dynamic> body = {
      "media_type": "movie",
      "media_id": movieId,
      "watchlist": false
    };
    test("Should return true if success is returned by API", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("watchlist_edit_success_response.json"), 200));
      // act
      final result = await moviesDataSource.removeFromWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(result, true);
    });

    test("Should return false if failure is returned by API", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response(fixture("watchlist_edit_failure_response.json"), 200));
      // act
      final result = await moviesDataSource.removeFromWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(result, false);
    });

    test("Should throw HttpError if code is not 200", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenAnswer((_) async => http.Response("Something went wrong!", 400));
      // act
      final call =  moviesDataSource.removeFromWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(call, throwsA(isA<HttpError>()));
    });

    test("Should throw HttpError if Exception is thrown during http call", () async {
      // arrange
      when(mockClient.post(
          Uri.parse(watchlistEditUrlString),
          body: jsonEncode(body),
          headers: {
            "Content-Type": "application/json",
          })
      ).thenThrow(Exception("error"));
      // act
      final call =  moviesDataSource.removeFromWatchlist(movieId: movieId, userId: testUserModel.id.toString(), sessionId: testSessionId);
      // assert
      expect(call, throwsA(isA<HttpError>()));
    });
  });

  group("Search", () {
    const String query = "some text";
    final String urlString = "${createUrlString(TmdbApiConfig.searchMoviesEndpoint)}&query=$query";
    test("Should return a valid MovieModel list after search input", () async {
      // arrange
      when(mockClient.get(Uri.parse(urlString)))
          .thenAnswer((_) async => http.Response(fixture("movie_list.json"), 200));
      // act
      final result = await moviesDataSource.search(query);
      // assert
      expect(result.length, 3);
      expect(result, testMovieModels);
    });

    test("Should catch exception if status code is not 200 or 201", () async {
      // arrange
      when(mockClient.get(Uri.parse(urlString)))
          .thenAnswer((_) async => http.Response("Something went wrong!", 404));
      // act
      final call = moviesDataSource.search(query);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });

    test("Should catch exception if an exception is thrown during search", () async {
      // arrange
      when(mockClient.get(Uri.parse(urlString))).thenThrow(Exception("error message"));
      // act
      final call = moviesDataSource.search(query);
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });
}