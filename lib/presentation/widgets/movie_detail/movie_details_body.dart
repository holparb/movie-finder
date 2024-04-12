import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_check_cubit.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_picture_and_title.dart';

class MovieDetailsBody extends StatefulWidget {
  const MovieDetailsBody({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailsBody> createState() => _MovieDetailsBodyState();
}

class _MovieDetailsBodyState extends State<MovieDetailsBody> {

  late bool onWatchlist;

  @override
  void initState() {
    super.initState();
    onWatchlist = BlocProvider.of<WatchlistCheckCubit>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MovieDetailsPictureAndTitle(movie: widget.movie),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.movie.overview,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            isUserLoggedIn(context) ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocListener<WatchlistCheckCubit, bool>(
                listener: (context, result) {
                  setState(() {
                    onWatchlist = result;
                  });
                },
                child: ElevatedButton(
                  onPressed: onWatchlistButtonPress,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      backgroundColor: onWatchlist ? Theme.of(context).colorScheme.outlineVariant : Colors.white,
                      padding: const EdgeInsets.all(16.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(onWatchlist ? Icons.check : Icons.add, color: onWatchlist ? Colors.white : Colors.black,),
                      const SizedBox(width: 16,),
                      onWatchlist ? Text(
                          "Added to watchlist",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ) :
                      Text(
                          "Add to watchlist",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }

  bool isUserLoggedIn(BuildContext context) {
    return true;
    //return (BlocProvider.of<AuthBloc>(context).state is LoggedIn);
  }

  void addToWatchlist() {

  }

  void removeFromWatchlist() {

  }

  void onWatchlistButtonPress() {
    setState(() {
      onWatchlist = !onWatchlist;
    });
  }
}

class AddToWatchlistButton extends StatelessWidget {
  const AddToWatchlistButton({super.key, required this.onButtonPress});

  final void Function() onButtonPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonPress,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.all(16.0)
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check),
          SizedBox(width: 16,),
          Text("Added to watchlist")
        ],
      ),
    );
  }
}

class AddedToWatchlistButton extends StatelessWidget {
  const AddedToWatchlistButton({super.key, required this.onButtonPress});

  final void Function() onButtonPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonPress,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.all(16.0)
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check),
          SizedBox(width: 16,),
          Text("Added to watchlist")
        ],
      ),
    );
  }
}



