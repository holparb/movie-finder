import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/entities/user.dart';

abstract class AuthRepository {
  Future<DataState<User>> login(Map<String, String> loginRequest);
  Future<DataState<void>> logout();
}