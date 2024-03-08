import 'package:movie_finder/core/exceptions/repository_error.dart';

class DataError extends RepositoryError {
  const DataError({required super.message});
}