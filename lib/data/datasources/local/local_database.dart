import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

class LocalDatabase {
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
    await db.execute(_createGenreTable);
    await db.execute(_createMovieTable);
    await db.execute(_createWatchlistTable);
    return;
  }

  final String _createMovieTable = """CREATE TABLE Movie (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    overview TEXT NOT NULL,
    poster_path TEXT NOT NULL,
    vote_average REAL,
    backdrop_path TEXT,
    genre_ids TEXT,
    release_date DATETIME,
    runtime INTEGER,
    genre_id INTEGER,
    FOREIGN KEY(genre_id) REFERENCES Genre (id) ON DELETE NO ACTION ON UPDATE NO ACTION
  )""";

  final String _createWatchlistTable = """CREATE TABLE Watchlist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movie_id INTEGER,
    FOREIGN KEY(movie_id) REFERENCES Movie (id) ON DELETE NO ACTION ON UPDATE NO ACTION
  )""";

  final String _createGenreTable = """CREATE TABLE Genre (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
  )""";
}