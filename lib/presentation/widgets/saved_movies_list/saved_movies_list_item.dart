import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/router/app_router.dart';

class SavedMoviesListItem extends StatelessWidget {
  const SavedMoviesListItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(MovieDetailsRoute(movie: movie));
        BlocProvider.of<MovieDetailsBloc>(context).add(GetMovieDetails(id: movie.id));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: "${TmdbApiConfig.imageBaseUrl}${movie.posterPath}",
                placeholder: (context, url) => Image.asset('assets/images/image_placeholder.png'),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child:  Text(
                            "${movie.releaseDate!.year}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.star, color: Color(0xfffdc432),),
                      Text (
                        movie.voteAverage!.toStringAsPrecision(2),
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xfffdc432)),
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
