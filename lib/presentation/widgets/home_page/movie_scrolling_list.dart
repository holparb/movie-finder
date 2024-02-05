import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_item.dart';

class MovieScrollingList extends StatelessWidget {
  const MovieScrollingList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child:
      ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MovieListItem(movie: movies[index],);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: movies.length)
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontFamily: "AbeeZee"),
      ),
    );
  }
}

