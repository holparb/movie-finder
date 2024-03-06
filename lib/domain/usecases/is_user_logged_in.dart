import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';

class IsUserLoggedInUseCase implements UseCase<String?, void> {
  final AuthRepository authRepository;

  IsUserLoggedInUseCase(this.authRepository);

  @override
  Future<String?> call({void params}) async {
    return await authRepository.isUserLoggedIn();
  }
}