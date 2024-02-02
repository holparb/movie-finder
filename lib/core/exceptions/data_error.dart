import 'package:equatable/equatable.dart';

class DataError extends Equatable implements Exception {
  final String message;

  const DataError({required this.message});

  @override
  List<Object?> get props => [message];
}