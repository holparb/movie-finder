import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_item.dart';

class SavedMoviesList extends StatelessWidget {
  const SavedMoviesList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 310,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieListItem(movie: movies[index]);
        }
    );
  }
}
