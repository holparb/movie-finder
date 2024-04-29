import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class SearchMoviesUseCase implements UseCase<DataState<List<Movie>>, String> {
  final MovieRepository _movieRepository;

  const SearchMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<List<Movie>>> call({String params = ""}) async {
    return await _movieRepository.search(params);
  }

}