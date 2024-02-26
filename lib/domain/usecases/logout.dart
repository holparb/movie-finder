import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';

class LogoutUsecase implements UseCase<DataState<void>, void> {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  @override
  Future<DataState<void>> call({void params}) async {
    return await authRepository.logout();
  }
}