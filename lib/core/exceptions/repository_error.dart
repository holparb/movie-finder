import 'package:equatable/equatable.dart';

abstract class RepositoryError extends Equatable implements Exception {
  final String message;

  const RepositoryError({required this.message});

  @override
  List<Object?> get props => [message];
}