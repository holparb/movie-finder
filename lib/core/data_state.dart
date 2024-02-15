import 'package:equatable/equatable.dart';
import 'package:movie_finder/core/exceptions/repository_error.dart';

abstract class DataState<T> extends Equatable {
  final T ? data;
  final RepositoryError ? error;

  const DataState({this.data, this.error});

  @override
  List<Object?> get props => [];
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  List<Object?> get props => [data];
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(RepositoryError error) : super(error: error);

  @override
  List<Object?> get props => [error];
}

