import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_bloc_builder.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

import '../../helper/test_data.dart';

class MockTrendingMoviesBloc extends MockBloc<MoviesEvent, MoviesState> implements TrendingMoviesBloc {}
class MockPopularMoviesBloc extends MockBloc<MoviesEvent, MoviesState> implements PopularMoviesBloc {}

void main() {
  late MockTrendingMoviesBloc trendingMoviesMockBloc;
  late MockPopularMoviesBloc popularMoviesMockBloc;

  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
        title: 'MovieFinder',
        theme: ThemeData(),
        home: MultiBlocProvider(
            providers: [
              BlocProvider<TrendingMoviesBloc>(create: (_) => trendingMoviesMockBloc,),
              BlocProvider<PopularMoviesBloc>(create: (_) => popularMoviesMockBloc),
            ],
            child: widget
        )
    );
  }

  setUp(() async {
    trendingMoviesMockBloc = MockTrendingMoviesBloc();
    popularMoviesMockBloc = MockPopularMoviesBloc();
  });

  group("TrendingMoviesListBlocBuilder", () {
    testWidgets("movies should display empty widget when state is MoviesEmpty", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          trendingMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesEmpty(),
          ],),
          initialState: const MoviesEmpty()
      );
      // act
      await expectLater(trendingMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesEmpty()]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const TrendingMoviesListBlocBuilder()));
      // assert
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets("display loading indicator if state is MoviesLoading", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          trendingMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      expect(trendingMoviesMockBloc.state, const MoviesEmpty());
      await expectLater(trendingMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading()]));
      expect(trendingMoviesMockBloc.state, const MoviesLoading());
      await widgetTester.pumpWidget(createWidgetUnderTest(const TrendingMoviesListBlocBuilder()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("display error text when state is MoviesError", (widgetTester) async {
      const DataError error = DataError(message: "Error message");
      // arrange
      whenListen<MoviesState>(
          trendingMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
            const MoviesError(error)
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      await expectLater(trendingMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const MoviesError(error)]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const TrendingMoviesListBlocBuilder()));

      // assert
      expect(find.text("Couldn't load movies, try again!"), findsOneWidget);
    });

    testWidgets("display list when state is TrendingMoviesLoaded", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          trendingMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
            const TrendingMoviesLoaded(testMovies)
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      await expectLater(trendingMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const TrendingMoviesLoaded(testMovies)]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const TrendingMoviesListBlocBuilder()));

      // assert
      expect(find.byType(MovieScrollingList), findsOneWidget);
    });
  });

  group("PopularMoviesListBlocBuilder", () {
    testWidgets("movies should display empty widget when state is MoviesEmpty", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          popularMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesEmpty(),
          ],),
          initialState: const MoviesEmpty()
      );
      // act
      await expectLater(popularMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesEmpty()]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const PopularMoviesListBlocBuilder()));
      // assert
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets("display loading indicator if state is MoviesLoading", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          popularMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      await expectLater(popularMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading()]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const PopularMoviesListBlocBuilder()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("display error text when state is MoviesError", (widgetTester) async {
      const DataError error = DataError(message: "Error message");
      // arrange
      whenListen<MoviesState>(
          popularMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
            const MoviesError(error)
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      await expectLater(popularMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const MoviesError(error)]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const PopularMoviesListBlocBuilder()));

      // assert
      expect(find.text("Couldn't load movies, try again!"), findsOneWidget);
    });

    testWidgets("display list when state is PopularMoviesLoaded", (widgetTester) async {
      // arrange
      whenListen<MoviesState>(
          popularMoviesMockBloc,
          Stream<MoviesState>.fromIterable([
            const MoviesLoading(),
            const PopularMoviesLoaded(testMovies)
          ],),
          initialState: const MoviesEmpty()
      );

      // act - make sure bloc stream is emitted before building widget
      await expectLater(popularMoviesMockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const PopularMoviesLoaded(testMovies)]));
      await widgetTester.pumpWidget(createWidgetUnderTest(const PopularMoviesListBlocBuilder()));

      // assert
      expect(find.byType(MovieScrollingList), findsOneWidget);
    });
  });
}