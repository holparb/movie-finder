import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_detail_picture.dart';

@RoutePage()
class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MovieDetailPicture(movie: movie),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movie.overview,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      )
    );
  }
}
