import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_state.dart';
import 'package:movie_finder/presentation/widgets/common/empty_list.dart';
import 'package:movie_finder/presentation/widgets/common/list_error.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_header.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies_list.dart';

class SavedMovies extends StatelessWidget {
  const SavedMovies({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SavedMoviesHeader(username: username),
        const SizedBox(height: 16),
        Expanded(
            child: BlocBuilder<WatchlistLoaderBloc, WatchlistLoaderState>(
              buildWhen: (previousState, currentState) {
                return currentState != previousState;
              },
              builder: (context, state) {
                return switch(state) {
                  WatchlistLoading() => const Center(child: CircularProgressIndicator()),
                  WatchlistError() => const ListError(text: "Couldn't load watchlist, try again!"),
                  WatchlistLoaded loaded => SavedMoviesList(movies: loaded.watchlist),
                  WatchlistEmpty() => const EmptyList(text: "No movies on your watchlist yet!")
                };
              },
            )
        )
      ]
    );
  }
}
