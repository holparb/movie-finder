import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';

class LogoutUsecase implements UseCase<DataState<void>, void> {
  final UserRepository _userRepository;

  LogoutUsecase(this._userRepository);

  @override
  Future<DataState<void>> call({void params}) async {
    return await _userRepository.logout();
  }
}