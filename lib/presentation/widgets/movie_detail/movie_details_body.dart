import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_picture_and_title.dart';

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MovieDetailsPictureAndTitle(movie: movie),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              onPressed: onWatchlistButtonPressed,
              child: Row(
                children: [
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onWatchlistButtonPressed() {

  }
}
