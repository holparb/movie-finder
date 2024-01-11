import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

class GetMovieDetailsUseCase implements UseCase<DataState<Movie>, int> {
  final MovieRepository repository;

  GetMovieDetailsUseCase(this.repository);

  @override
  Future<DataState<Movie>> call({int? params}) async {
    return await repository.getMovieDetails(params!);
  }

}