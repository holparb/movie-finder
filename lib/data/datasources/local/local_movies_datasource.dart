import 'dart:convert';

import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/data/datasources/local/local_database.dart';
import 'package:movie_finder/data/models/genre_model.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/core/constants.dart' as constants;
import 'package:sqflite/sqflite.dart';

class LocalMoviesDataSource {

  final LocalDatabase _localDatabase;

  LocalMoviesDataSource(this._localDatabase);

  Future<MovieModel> upsertMovie(MovieModel movie) async {
    Database db = await _localDatabase.openDb();
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM ${LocalDatabase.movieTable} WHERE id = ?", [movie.id]));
    if (count == 0) {
      await db.insert(LocalDatabase.movieTable, movie.toMap());
    } else {
      await db.update(
          LocalDatabase.movieTable, movie.toMap(), where: "id = ?", whereArgs: [movie.id]);
    }
    movie.genres.forEach((genre) { upsertGenre(genre as GenreModel); });
    return movie;
  }

  Future<GenreModel> upsertGenre(GenreModel genre, [Database? db]) async {
    db ??= await _localDatabase.openDb();
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM ${LocalDatabase.genreTable} WHERE id = ?", [genre.id]));
    if (count == 0) {
      await db.insert(LocalDatabase.genreTable, genre.toMap());
    } else {
      await db.update(
          LocalDatabase.genreTable, genre.toMap(), where: "id = ?", whereArgs: [genre.id]);
    }
    return genre;
  }

  Future<List<GenreModel>> fetchGenres(List<int> genreIds, [Database? database]) async {
    database ??= await _localDatabase.openDb();
    List<Map<String, dynamic>> results = await database.query(LocalDatabase.genreTable,
        where: "id = ?", whereArgs: genreIds);

    List<GenreModel> genres = [];
    results.forEach((result) {
      GenreModel genre = GenreModel.fromJson(result);
      genres.add(genre);
    });
    return genres;
  }

  Future<MovieModel?> fetchMovie(int id) async {
    Database database = await _localDatabase.openDb();
    List<Map<String, dynamic>> results = await database.query(LocalDatabase.movieTable,
        where: "id = ?", whereArgs: [id]);
    if(results.isEmpty) return null;
    List<GenreModel> genres = await fetchGenres(json.decode(results.first["genre_ids"]).cast<int>());
    MovieModel movie = MovieModel.fromMap(results.first, genres);
    return movie;
  }

  Future<List<MovieModel>> fetchWatchlist() async {
    Database db = await _localDatabase.openDb();
    List<Map<String, dynamic>> results = await db.query(LocalDatabase.watchlistTable);
    List<MovieModel> watchlist = [];

    results.forEach((result) async {
      MovieModel? movie = await fetchMovie(result["id"]);
      if(movie != null) watchlist.add(movie);
    });
    return watchlist;
  }

  Future<void> writeWatchlist(List<MovieModel> watchlist) async {
    final database = await _localDatabase.openDb();
    final batch = database.batch();
    for (var movie in watchlist) {
      batch.insert(LocalDatabase.movieTable, movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      batch.insert(LocalDatabase.watchlistTable, {"movie_id": movie.id});
    }
    try {
      await batch.commit();
      writeWatchlistIds(watchlist);
      return;
    }
    catch (e) {
      throw const DataError(message: "writeWatchlist failed during batch execution");
    }
  }

  Future<void> writeWatchlistIds(List<MovieModel> watchlist) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(constants.watchlistIds, _createWatchlistIdsMap(watchlist));
    return;
  }

  List<String> _createWatchlistIdsMap(List<MovieModel> watchlist) {
    return watchlist.map((movie) => movie.id.toString()).toList(growable: false);
  }

  Future<List<String>?> readWatchlistIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(constants.watchlistIds);
  }

  Future<void> addToWatchlist(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchlistIds = await readWatchlistIds();
    if(watchlistIds == null) {
      throw Exception("Could not read watchlist ids!");
    }
    await prefs.setStringList(constants.watchlistIds, [...watchlistIds, id.toString()]);
    return;
  }

  Future<void> removeFromWatchlist(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? watchlistIds = await readWatchlistIds();
    if(watchlistIds == null) {
      throw Exception("Could not read watchlist ids!");
    }
    watchlistIds.remove(id.toString());
    await prefs.setStringList(constants.watchlistIds, watchlistIds);
    return;
  }
}