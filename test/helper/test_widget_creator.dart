import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/config/app_theme.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';

Widget createWidgetUnderTest(Widget widget) {
  return MaterialApp(
      title: 'MovieFinder',
      theme: darkTheme,
      home: BlocProvider<MoviesBloc>(
          create: (_) => serviceLocator(),
          child: widget
      )
  );
}