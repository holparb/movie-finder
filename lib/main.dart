import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/router/app_router.dart';
import 'package:movie_finder/config/app_theme.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_event.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = serviceLocator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
        create: (_) => serviceLocator()..add(const GetTrendingMovies()),
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
