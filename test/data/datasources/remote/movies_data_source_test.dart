import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/models/movie_model.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helper/test_data.dart';
import 'movies_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {

  late MockClient mockClient;
  late MoviesDataSource moviesDataSource;

  MovieModel testMovieModel = MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], releaseDate: DateTime.parse("2023-12-15"), runtime: 157);

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
      when(mockClient.get(Uri.parse(createUrlString(TmdbApiConfig.trendingMoviesEndpoint))))
          .thenAnswer((_) async => throw Exception("error message"));
      // act
      final call = moviesDataSource.getTrendingMovies();
      // assert
      expect(() => call, throwsA(isA<DataError>()));
    });
  });
}