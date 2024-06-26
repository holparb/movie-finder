import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/config/tmdb_api_config.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/router/app_router.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 180,
        child: GestureDetector(
          onTap: () {
            context.pushRoute(MovieDetailsRoute(movie: movie));
            BlocProvider.of<MovieDetailsBloc>(context).add(GetMovieDetails(id: movie.id));
          },
          child: Column(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: "${TmdbApiConfig.imageBaseUrl}${movie.posterPath}",
                  placeholder: (context, url) => Image.asset('assets/images/image_placeholder.png'),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        ));
  }
}
