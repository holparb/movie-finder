import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class IsMovieOnWatchlistUseCase implements UseCase<bool, int> {
  final MovieRepository _movieRepository;

  IsMovieOnWatchlistUseCase(this._movieRepository);

  @override
  Future<bool> call({int? params}) async {
    return await _movieRepository.isMovieOnWatchlist(params!);
  }
}