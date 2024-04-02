import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/usecase.dart';
import 'package:movie_finder/domain/entities/user.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';

class LoginUsecase implements UseCase<DataState<User>, LoginParams> {
  final UserRepository _userRepository;

  LoginUsecase(this._userRepository);

  @override
  Future<DataState<User>> call({LoginParams? params}) async {
    return await _userRepository.login(params!.toJson());
  }
}

class LoginParams {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  Map<String, String> toJson() => {
    "username": username,
    "password": password,
  };
}