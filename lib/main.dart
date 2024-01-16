import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/router/app_router.dart';
import 'package:movie_finder/config/app_theme.dart';
import 'package:movie_finder/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = serviceLocator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
        create: (_) => serviceLocator<MovieDetailsBloc>(),
        child: MaterialApp.router(
            title: 'MovieFinder',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            routerConfig: _appRouter.config()
        )
    );

  }
}
