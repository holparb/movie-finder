import 'package:equatable/equatable.dart';

class RequestToken extends Equatable{
  final String token;
  final String expiresAt;

  RequestToken({required this.token, required this.expiresAt});

  @override
  List<Object?> get props => [token];
}