import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_bloc_builder.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MovieFinder", style: GoogleFonts.aBeeZee(textStyle: const TextStyle(
          color: Colors.red,
          fontSize: 34,
        )),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TrendingMoviesBloc>(
              create: (_) => serviceLocator<TrendingMoviesBloc>()..add(const GetTrendingMovies()), lazy: false,
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
                SectionHeader(title: "Trending movies"),
                TrendingMoviesListBlocBuilder(),
                SizedBox(height: 16,),
                SectionHeader(title: "Popular movies"),
                PopularMoviesListBlocBuilder()
              ],
            ),
          ),
        )
      ),
    );
  }

  void onPressed(BuildContext context) async {
    context.read<TrendingMoviesBloc>().add(const GetTrendingMovies());
  }
}
