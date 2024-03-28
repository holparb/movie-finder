import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_list_item.dart';

class SavedMoviesList extends StatelessWidget {
  const SavedMoviesList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return SavedMoviesListItem(movie: movies[index]);
        }
    );
  }
}
