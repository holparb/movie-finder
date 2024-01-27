import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<DataState<List<Movie>>> getTrendingMovies();
  Future<DataState<Movie>> getMovieDetails(int id);
  Future<DataState<List<Movie>>> getPopularMovies();
}