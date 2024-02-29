import 'package:flutter/material.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_header.dart';

class SavedMovies extends StatelessWidget {
  const SavedMovies({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SavedMoviesHeader(username: username),
        const SizedBox(height: 16),
      ]
    );
  }
}
