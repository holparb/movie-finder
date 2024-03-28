import 'package:movie_finder/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.id, required super.username, required super.sessionId});

  factory UserModel.fromJson(Map<String, dynamic> json, String sessionId) {
    return UserModel(
        id: json["id"],
        username: json["username"],
        sessionId: sessionId
    );
  }

  @override
  String toString() {
    return "UserModel{$id, $username, $sessionId}";
  }
}