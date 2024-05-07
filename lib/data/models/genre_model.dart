import 'package:movie_finder/domain/entities/genre.dart';

class GenreModel extends Genre {
  const GenreModel({required super.id, required super.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
        id: json['id'] as int,
        name: json['name'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name
    };
  }
}