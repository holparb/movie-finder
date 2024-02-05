import 'package:equatable/equatable.dart';

class AuthError extends Equatable implements Exception {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}