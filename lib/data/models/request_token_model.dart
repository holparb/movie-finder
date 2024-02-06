import 'package:movie_finder/domain/entities/request_token.dart';

class RequestTokenModel extends RequestToken {
  RequestTokenModel({required super.token, required super.expiresAt});

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      token: json["request_token"],
      expiresAt: json["expires_at"]
    );
  }

  Map<String, dynamic> toJson() => {
    "request_token": token
  };
}