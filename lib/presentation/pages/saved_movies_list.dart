import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';
import 'package:movie_finder/injection_container.dart';

class SavedMoviesPage extends StatelessWidget {
  const SavedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: onPressed, child: Text("login")),
    );
  }

  void onPressed() async {
    final user = await serviceLocator<AuthRepository>().login({"username": "holpmaster", "password": "HBala5841"});
    log(user.toString());
  }
}
