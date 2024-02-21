import 'package:flutter/material.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Log in with your TMDB account to see and manage your saved movies"),
          ElevatedButton(onPressed: () => onLoginPressed(context), child: const Text("Login"))
        ],
      ),
    );
  }

  void onLoginPressed(BuildContext context) {
    showDialog(context: context, builder: (context) => const LoginDialog(), barrierDismissible: false);
  }
}
