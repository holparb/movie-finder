import 'package:movie_finder/core/exceptions/repository_error.dart';

class SqliteError extends RepositoryError {
  const SqliteError({required super.message});
}