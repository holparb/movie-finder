import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable{
  const AuthState();
}

class NotLoggedIn extends AuthState {
  const NotLoggedIn();

  @override
  List<Object?> get props => [];
}

class LoggingIn extends AuthState {
  const LoggingIn();

  @override
  List<Object?> get props => [];
}

class LoggedIn extends AuthState {
  final String username;
  const LoggedIn(this.username);

  @override
  List<Object?> get props => [username];
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}