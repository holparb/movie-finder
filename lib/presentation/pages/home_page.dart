import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_event.dart';
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionHeader(title: "Trending movies"),
              MovieListBlocBuilder()
            ],
          ),
        ),
      ),
      //MovieDetailPage(movie: Movie(id: 1, title: "Movie1", overview: "sdadada", posterPath: "ddsfsd", voteAverage: 1.0, backdropPath: "/jXJxMcVoEuXzym3vFnjqDW4ifo6.jpg", genreIds: [10, 20], releaseDate: DateTime.parse("2023-12-14"), runtime: 157),)
    );
  }

  void onPressed(BuildContext context) async {
    context.read<MoviesBloc>().add(const GetTrendingMovies());
  }
}
