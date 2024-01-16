import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_subtext.dart';

class MovieDetailsPictureAndTitle extends StatelessWidget {
  const MovieDetailsPictureAndTitle({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: "${TmdbApiConfig.imageBaseUrl}${movie.backdropPath}",
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
              errorWidget: (_, __, ___) =>
                  Container(color: Colors.grey),
            ),
          ),
          Positioned.fill(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          movie.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      MovieDetailsSubtext(movie: movie)
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
