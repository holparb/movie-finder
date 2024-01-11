import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';

class MovieDetailSubtext extends StatelessWidget {
  const MovieDetailSubtext({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    if(movie.runtime == null || movie.releaseDate == null) return const Text("");
    final year = movie.releaseDate!.year;
    final hours = movie.runtime! ~/ 60;
    final minutes = movie.runtime! % 60;
    return Center(
      child: Text.rich(
        TextSpan(
          text: "$year • ${hours}h ${minutes}m • ",
          style: Theme.of(context)
              .textTheme
              .bodyLarge,
          children: <TextSpan> [
            TextSpan(
              text: "${movie.voteAverage!}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: const Color(0xfffdc432))
            )
          ]
        )
      ),
    );
  }
}
