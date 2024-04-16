import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class RemoveFromWatchlistUseCase implements UseCase<bool, int> {
  final MovieRepository _repository;

  const RemoveFromWatchlistUseCase(this._repository);

  @override
  Future<bool> call({int? params}) async {
    return await _repository.removeFromWatchlist(params!);
  }
}