import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';

Widget createWidgetUnderTest(Widget widget) {
  return MaterialApp(
      title: 'MovieFinder',
      theme: ThemeData(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TrendingMoviesBloc>(create: (_) => serviceLocator()),
          BlocProvider<MovieDetailsBloc>(create: (_) => serviceLocator())
        ],
        child: widget
      )
  );
}