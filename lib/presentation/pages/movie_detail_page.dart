import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_event.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_body.dart';

@RoutePage()
class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
      listenWhen: (_, state) => state is MovieDetailsError,
      listener: (context, state) => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Movie details could not be loaded, some data will not be available!"))),
      builder: (_, state) {
        if(state is MovieDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is MovieDetailsError) {
          // Display details page but with an object from the list as fallback, which may be missing some fields
          return MovieDetailsBody(movie: movie);
        }
        if(state is MovieDetailsLoaded) {
          // Display details page
          return BlocProvider<WatchlistHandlerBloc>(
            create: (_) => serviceLocator<WatchlistHandlerBloc>()..add(CheckWatchlistStatus(movie.id)),
            child: MovieDetailsBody(movie: state.movie)
          );
        }
        return const SizedBox();
      }
    );
  }
}
