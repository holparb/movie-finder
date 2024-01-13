import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:movie_finder/domain/entities/movie.dart';

import '../../fixtures/fixture_reader.dart';

void main() {

  MovieModel testMovieModel = MovieModel(id: 1, title: "title", overview: "overview", posterPath: "posterPath", voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [10, 20], genres: [], releaseDate: DateTime.parse("2023-12-15"), runtime: 157);

  test("Should be a subclass of Movie entity", () {
    // assert
    expect(testMovieModel, isA<Movie>());
  });

  test("Should return a valid model from a json file", () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture("movie_model.json"));
    // act
    final result = MovieModel.fromJson(jsonMap);
    // assert
    expect(result, testMovieModel);
  });
}