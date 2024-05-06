import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class DatabaseHelper {
  static const String _databaseName = "localDatabase.db";
  static const int _databaseVersion = 1;

  Future<Database> openDb() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) => _createDatabase
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute(_createMovieTableQuery);
  }

  final String _createMovieTableQuery = """CREATE TABLE Movie (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    overview TEXT NOT NULL,
    poster_path TEXT NOT NULL,
    vote_average REAL,
    backdrop_path TEXT,
    genre_ids TEXT,
    genreId INTEGER,
    release_date DATETIME,
    runtime INTEGER
  )""";

  final String _createGenreTableQuery = """CREATE TABLE Genre (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
  )""";
}