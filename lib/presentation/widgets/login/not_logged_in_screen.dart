import 'package:flutter/material.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Not logged in into TMDB",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32,),
            Text(
              "Log into your TMDB account to view your watchlist",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                  backgroundColor: Theme.of(context).colorScheme.outlineVariant,
                  padding: const EdgeInsets.all(16.0)
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) => const LoginDialog(), barrierDismissible: false);
                },
                child: Text("Log in to TMDB", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold))
            )
          ],
        ),
      ),
    );
  }
}
