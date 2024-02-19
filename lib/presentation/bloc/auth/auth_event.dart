import 'package:movie_finder/domain/usecases/login.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class CheckUserLoginStatus extends AuthEvent {
  const CheckUserLoginStatus();
}

class LogIn extends AuthEvent {
  final LoginParams loginParams;
  const LogIn({required this.loginParams});
}