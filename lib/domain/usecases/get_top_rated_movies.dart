import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class GetTopRatedMoviesUseCase implements UseCase<DataState<List<Movie>>, void> {
  final MovieRepository _movieRepository;

  GetTopRatedMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<List<Movie>>> call({void params}) async {
    return await _movieRepository.getTopRatedMovies();
  }
}