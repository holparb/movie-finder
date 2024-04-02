import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';

class IsUserLoggedInUseCase implements UseCase<String?, void> {
  final UserRepository _userRepository;

  IsUserLoggedInUseCase(this._userRepository);

  @override
  Future<String?> call({void params}) async {
    return await _userRepository.isUserLoggedIn();
  }
}