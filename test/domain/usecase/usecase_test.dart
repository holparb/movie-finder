import 'package:mockito/annotations.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';

// Dummy test entry point for creating a common generated mock file for usecase tests
@GenerateMocks([MovieRepository, UserRepository])
void main() {}