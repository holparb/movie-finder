import 'package:movie_finder/core/exceptions/repository_error.dart';

class HttpError extends RepositoryError {
  const HttpError({required super.message});
}