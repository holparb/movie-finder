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
  const LoggedIn();

  @override
  List<Object?> get props => [];
}

class LoginError extends AuthState {
  final String errorMessage;
  const LoginError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}