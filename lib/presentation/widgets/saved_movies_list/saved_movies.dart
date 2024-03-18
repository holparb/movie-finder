import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/empty_list.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_header.dart';

class SavedMovies extends StatelessWidget {
  const SavedMovies({super.key, required this.username, required this.watchlist});

  final String username;
  final List<Movie> watchlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SavedMoviesHeader(username: username),
        const SizedBox(height: 16),
        Expanded(
            child: watchlist.isEmpty ? const EmptyList() : SizedBox()
        )

      ]
    );
  }
}
