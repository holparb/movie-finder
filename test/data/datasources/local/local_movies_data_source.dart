import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/core/constants.dart' as constants;

import '../../../helper/test_data.dart';

void main() {
  late LocalMoviesDataSource localMoviesDataSource;

  setUp(() async {
    localMoviesDataSource = const LocalMoviesDataSource();
  });

  test("Writing watchlist ids", () async {
    // arrange
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // act
    await localMoviesDataSource.writeWatchlistIds(testMovieModels);
    //assert
    expect(prefs.getStringList(constants.watchlistIds), testMovieModels.map((movie) => movie.id.toString()).toList(growable: false));
  });

  test("Add to watchlist", () async {
    // arrange
    SharedPreferences.setMockInitialValues({
      "watchlistIds" : ["1", "2", "3"]
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // act
    await localMoviesDataSource.addToWatchlist(4);
    //assert
    expect(prefs.getStringList(constants.watchlistIds), ["1", "2", "3", "4"]);
  });

  test("Remove from watchlist", () async {
    // arrange
    SharedPreferences.setMockInitialValues({
      "watchlistIds" : ["1", "2", "3"]
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // act
    await localMoviesDataSource.removeFromWatchlist(3);
    //assert
    expect(prefs.getStringList(constants.watchlistIds), ["1", "2"]);
  });
}