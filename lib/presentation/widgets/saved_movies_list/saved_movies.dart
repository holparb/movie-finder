import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_state.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/empty_list.dart';
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
                if(state is WatchlistLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(state is WatchlistError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.error_outline),
                        Text("Couldn't load watchlist, try again!", textAlign: TextAlign.center,)
                      ],
                    ),
                  );
                }
                if(state is WatchlistLoaded) {
                  return SavedMoviesList(movies: state.watchlist);
                }

                return const EmptyList();
              },
            )
        )
      ]
    );
  }
}
