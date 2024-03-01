import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';

class SavedMoviesHeader extends StatelessWidget {
  const SavedMoviesHeader({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hello $username!", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
            MaterialButton(
              highlightColor: Theme.of(context).colorScheme.outlineVariant,
              splashColor: Theme.of(context).colorScheme.outlineVariant,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(const LogOut());
              },
              child: Text("Log out", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline))
            )
          ],
        ),
        SizedBox(
          width: 300,
          child: Text("You can see and manage your watchlist here", style: Theme.of(context).textTheme.bodyLarge,),
        )
      ],
    );
  }
}
