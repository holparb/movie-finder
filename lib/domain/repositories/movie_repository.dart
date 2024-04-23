import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<DataState<List<Movie>>> getTrendingMovies();
  Future<DataState<List<Movie>>> getPopularMovies();
  Future<DataState<List<Movie>>> getTopRatedMovies();
  Future<DataState<Movie>> getMovieDetails(int id);
  Future<DataState<List<Movie>>> getWatchlist();
  Future<bool> isMovieOnWatchlist(int id);
  Future<bool> addToWatchlist(int id);
  Future<bool> removeFromWatchlist(int id);
}