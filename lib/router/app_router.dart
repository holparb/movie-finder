import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/pages/main_page.dart';
import 'package:movie_finder/presentation/pages/movie_detail_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter
{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, initial: true),
    AutoRoute(page: MovieDetailsRoute.page)
  ];
}