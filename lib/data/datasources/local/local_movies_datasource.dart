import 'dart:convert';
import 'dart:developer';

import 'package:movie_finder/core/exceptions/sqlite_error.dart';
import 'package:movie_finder/data/datasources/local/local_database.dart';
import 'package:movie_finder/data/models/genre_model.dart';
import 'package:movie_finder/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/core/constants.dart' as constants;
import 'package:sqflite/sqflite.dart';

class LocalMoviesDataSource {


  LocalMoviesDataSource();

  Future<MovieModel> upsertMovie(MovieModel movie) async {
    Database database = await LocalDatabase.instance.database;
    var count = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM ${LocalDatabase.movieTable} WHERE id = ?", [movie.id]));
    if (count == 0) {
      await database.insert(LocalDatabase.movieTable, movie.toMap());
    } else {
      await database.update(
          LocalDatabase.movieTable, movie.toMap(), where: "id = ?", whereArgs: [movie.id]);
    }
    for (var genre in movie.genres) {
      upsertGenre(genre as GenreModel);
    }
    return movie;
  }

  Future<GenreModel> upsertGenre(GenreModel genre, [Database? database]) async {
    database ??= await LocalDatabase.instance.database;
    var count = Sqflite.firstIntValue(await database.rawQuery(
        "SELECT COUNT(*) FROM ${LocalDatabase.genreTable} WHERE id = ?", [genre.id]));
    if (count == 0) {
      await database.insert(LocalDatabase.genreTable, genre.toMap());
    } else {
      await database.update(
          LocalDatabase.genreTable, genre.toMap(), where: "id = ?", whereArgs: [genre.id]);
    }
    return genre;
  }

  Future<List<GenreModel>> fetchGenres(List<int> genreIds, [Database? database]) async {
    database ??= await LocalDatabase.instance.database;
    List<Map<String, dynamic>> results = await database.query(LocalDatabase.genreTable,
        where: "id = ?", whereArgs: genreIds);

    List<GenreModel> genres = [];
    for (var result in results) {
      GenreModel genre = GenreModel.fromJson(result);
      genres.add(genre);
    }
    return genres;
  }

  Future<MovieModel> insertMovie(MovieModel movie) async {
    Database database = await LocalDatabase.instance.database;
    for (var (genre as GenreModel) in movie.genres) {
      log("Inserting genre ${genre.name}");
      database.insert(LocalDatabase.genreTable, genre.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    log("Inserting movie ${movie.title}");
    database.insert(LocalDatabase.movieTable, movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return movie;
  }

  Future<List<MovieModel>> insertMovies(List<MovieModel> movies) async {
    Database database = await LocalDatabase.instance.database;
    final batch = database.batch();
    for (var movie in movies) {
      log("Inserting movie ${movie.title}");
      for (var (genre as GenreModel) in movie.genres) {
        log("Inserting genre ${genre.name}");
        batch.insert(LocalDatabase.genreTable, genre.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
      batch.insert(LocalDatabase.movieTable, movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    try {
      batch.commit();
    }
    catch (e) {
      throw const SqliteError(message: "Inserting movies failed during batch execution");
    }
    return movies;
  }

  Future<MovieModel?> fetchMovie(int id, [Database? database]) async {
    database ??= await LocalDatabase.instance.database;
    List<Map<String, dynamic>> results = await database.query(LocalDatabase.movieTable,
        where: "id = ?", whereArgs: [id]);
    if(results.isEmpty) return null;
    List<GenreModel> genres = await fetchGenres(json.decode(results.first["genre_ids"]).cast<int>());
    MovieModel movie = MovieModel.fromMap(results.first, genres);
    return movie;
  }

  Future<List<MovieModel>> fetchMovies(List<int> ids, [Database? database]) async {
    database ??= await LocalDatabase.instance.database;
    List<MovieModel> movies = [];
    for(var id in ids) {
      MovieModel? movie = await fetchMovie(id, database);
      if (movie != null) movies.add(movie);
    }
    return movies;
  }

  Future<List<MovieModel>> fetchWatchlist() async {
    Database database = await LocalDatabase.instance.database;
    List<Map<String, dynamic>> results = await database.query(LocalDatabase.watchlistTable);
    return await fetchMovies(results.map((result) => result["id"] as int).toList(), database);
  }

  Future<void> writeWatchlist(List<MovieModel> watchlist) async {
    final database = await LocalDatabase.instance.database;
    final batch = database.batch();
    for (var movie in watchlist) {
      batch.insert(LocalDatabase.watchlistTable, {"movie_id": movie.id});
      batch.insert(LocalDatabase.movieTable, movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    try {
      await batch.commit();
      await writeWatchlistIds(watchlist);
      return;
    }
    catch (e) {
      throw const SqliteError(message: "writeWatchlist failed during batch execution");
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