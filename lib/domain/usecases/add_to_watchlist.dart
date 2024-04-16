import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class AddToWatchlistUseCase implements UseCase<bool, int> {
  final MovieRepository _repository;

  const AddToWatchlistUseCase(this._repository);

  @override
  Future<bool> call({int? params}) async {
    return await _repository.addToWatchlist(params!);
  }
}