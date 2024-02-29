import 'package:flutter/material.dart';

class SavedMoviesHeader extends StatelessWidget {
  const SavedMoviesHeader({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Hello $username!", style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("You can see and manage your watchlist here", style: Theme.of(context).textTheme.headlineSmall,)
      ],
    );
  }
}
