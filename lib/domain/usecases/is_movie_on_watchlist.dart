import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class IsMovieOnWatchListUseCase implements UseCase<bool, int> {
  final MovieRepository _userRepository;

  IsMovieOnWatchListUseCase(this._userRepository);

  @override
  Future<bool> call({int? params}) async {
    return await _userRepository.isMovieOnWatchlist(params!);
  }
}