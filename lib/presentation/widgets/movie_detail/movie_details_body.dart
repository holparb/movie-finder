import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_state.dart';
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
            isUserLoggedIn(context) ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<WatchlistHandlerBloc, WatchlistHandlerState>(
                listenWhen: (previous, current) => current is WatchlistHandlerError,
                listener: (_, state) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Could not add/remove movie from/to watchlist!")));
                },
                buildWhen: (previous, current) => true,//current != previous,
                builder: (_, state) {
                  return switch (state) {
                    OnWatchlist() => AddedToWatchlistButton(onButtonPress: removeFromWatchlist,),
                    NotOnWatchlist() => AddToWatchlistButton(onButtonPress: addToWatchlist),
                    WatchlistHandlerError() => const SizedBox(),
                  };
                },
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }

  bool isUserLoggedIn(BuildContext context) {
    return (BlocProvider.of<AuthBloc>(context).state is LoggedIn);
  }

  void addToWatchlist(BuildContext context) {
    BlocProvider.of<WatchlistHandlerBloc>(context).add(AddToWatchlist(movie.id));
  }

  void removeFromWatchlist(BuildContext context) {
    BlocProvider.of<WatchlistHandlerBloc>(context).add(RemoveFromWatchlist(movie.id));
  }
}

class AddToWatchlistButton extends StatelessWidget {
  const AddToWatchlistButton({super.key, required this.onButtonPress});

  final void Function(BuildContext context) onButtonPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onButtonPress(context),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          backgroundColor: Colors.white,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.all(16.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: Colors.black,),
          const SizedBox(width: 16,),
          Text("Add to watchlist", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),)
        ],
      ),
    );
  }
}

class AddedToWatchlistButton extends StatelessWidget {
  const AddedToWatchlistButton({super.key, required this.onButtonPress});

  final void Function(BuildContext context) onButtonPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onButtonPress(context),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
          padding: const EdgeInsets.all(16.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check, color: Colors.white,),
          const SizedBox(width: 16,),
          Text("Added to watchlist", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),)
        ],
      ),
    );
  }
}



