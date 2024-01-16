import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';

class MovieDetailsSubtext extends StatelessWidget {
  const MovieDetailsSubtext({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    if (movie.runtime == null || movie.releaseDate == null) return const Text("");
    final year = movie.releaseDate!.year;
    final genre = movie.genres.first.name;
    final hours = movie.runtime! ~/ 60;
    final minutes = movie.runtime! % 60;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$year • $genre • ${hours}h ${minutes}m",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Color(0xfffdc432),),
              Text (
                "${movie.voteAverage!.toStringAsPrecision(2)}/10",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xfffdc432)),
              )
            ],
          )

      ]),
    );
  }
}
