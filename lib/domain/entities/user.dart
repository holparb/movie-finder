import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String sessionId;

  const User({required this.id, required this.username, required this.sessionId});

  @override
  List<Object?> get props => [id, username];
}