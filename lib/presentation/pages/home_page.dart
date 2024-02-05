import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/top_rated_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_bloc_builder.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopRatedMoviesBloc>(
              create: (_) => serviceLocator<TopRatedMoviesBloc>()..add(const GetTopRatedMovies()), lazy: false,
            ),
            BlocProvider<PopularMoviesBloc>(
              create: (_) => serviceLocator<PopularMoviesBloc>()..add(const GetPopularMovies()), lazy: false,
            ),
          ],
          child: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(title: "Popular movies"),
                PopularMoviesListBlocBuilder(),
                SizedBox(height: 16,),
                SectionHeader(title: "Top rated movies"),
                TopRatedMoviesListBlocBuilder(),
              ],
            ),
          ),
        )
    );
  }

  void onPressed(BuildContext context) async {
    context.read<TrendingMoviesBloc>().add(const GetTrendingMovies());
  }
}
