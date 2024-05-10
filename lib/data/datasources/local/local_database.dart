import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class LocalDatabase {
  static const String _databaseName = "localDatabase.db";
  static const int _databaseVersion = 1;

  static const String movieTable = "movie";
  static const String genreTable = "genre";
  static const String watchlistTable = "watchlist";

  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onUpgrade: (db, oldVersion, newVersion) => _createDatabase
    );
  }

  Future<void> _createDatabase(Database db, int oldVersion, int newVersion) async {
    log("Creating database");
    await db.execute(_createGenreTable);
    await db.execute(_createMovieTable);
    await db.execute(_createWatchlistTable);
    return;
  }

  final String _createMovieTable = """CREATE TABLE $movieTable (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    overview TEXT NOT NULL,
    poster_path TEXT NOT NULL,
    vote_average REAL,
    backdrop_path TEXT,
    genre_ids TEXT,
    release_date INTEGER,
    runtime INTEGER
  )""";

  final String _createWatchlistTable = """CREATE TABLE $watchlistTable (
    movie_id INTEGER PRIMARY KEY,
  )""";

  final String _createGenreTable = """CREATE TABLE $genreTable (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
  )""";
}