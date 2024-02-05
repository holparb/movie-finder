import 'package:movie_finder/core/exceptions/repository_error.dart';

class AuthError extends RepositoryError {
  const AuthError({required super.message});
}