import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class GetWatchlistUseCase implements UseCase<DataState<List<Movie>>, void> {
  final MovieRepository repository;

  const GetWatchlistUseCase(this.repository);

  @override
  Future<DataState<List<Movie>>> call({void params}) async {
    return await repository.getWatchlist();
  }
}