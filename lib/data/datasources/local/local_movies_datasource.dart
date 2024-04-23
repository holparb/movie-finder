import 'package:movie_finder/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_finder/core/constants.dart' as constants;

class LocalMoviesDataSource {

  const LocalMoviesDataSource();

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