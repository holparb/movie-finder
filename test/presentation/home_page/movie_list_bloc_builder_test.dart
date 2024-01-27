import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/presentation/bloc/movies/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_bloc_builder.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

import '../../helper/test_data.dart';

class MockMoviesBlock extends MockBloc<MoviesEvent, MoviesState> implements TrendingMoviesBloc {}

void main() {
  late MockMoviesBlock mockBloc;

  Widget createWidgetUnderTest(Widget listBlocBuilder) {
    return MaterialApp(
        home: BlocProvider<TrendingMoviesBloc>(
            create: (_) => mockBloc,
            child: listBlocBuilder
        )
    );
  }

  setUp(() {
    mockBloc = MockMoviesBlock();
  });

  testWidgets("movies should trigger state to change from empty to loading", (widgetTester) async {
    // arrange
    whenListen<MoviesState>(
        mockBloc,
        Stream<MoviesState>.fromIterable([
          const MoviesEmpty(),
        ],),
        initialState: const MoviesEmpty()
    );
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest(const MoviesListBlocBuilder()));
    // assert
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets("display loading indicator if state is MoviesLoading", (widgetTester) async {
    // arrange
    whenListen<MoviesState>(
      mockBloc,
      Stream<MoviesState>.fromIterable([
        const MoviesLoading(),
      ],),
      initialState: const MoviesEmpty()
    );

    // act - make sure bloc stream is emitted before building widget
    expect(mockBloc.state, const MoviesEmpty());
    await expectLater(mockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading()]));
    expect(mockBloc.state, const MoviesLoading());
    await widgetTester.pumpWidget(createWidgetUnderTest(const MoviesListBlocBuilder()));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("display error text when state is MoviesError", (widgetTester) async {
    const DataError error = DataError(message: "Error message");
    // arrange
    whenListen<MoviesState>(
        mockBloc,
        Stream<MoviesState>.fromIterable([
          const MoviesLoading(),
          const MoviesError(error)
        ],),
        initialState: const MoviesEmpty()
    );

    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const MoviesError(error)]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const MoviesListBlocBuilder()));

    // assert
    expect(find.text("Couldn't load movies, try again!"), findsOneWidget);
  });

  testWidgets("display list when state is TrendingMoviesLoaded", (widgetTester) async {
    // arrange
    whenListen<MoviesState>(
        mockBloc,
        Stream<MoviesState>.fromIterable([
          const MoviesLoading(),
          const TrendingMoviesLoaded(testMovies)
        ],),
        initialState: const MoviesEmpty()
    );

    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const TrendingMoviesLoaded(testMovies)]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const TrendingMoviesListBlocBuilder()));

    // assert
    expect(find.byType(MovieScrollingList), findsOneWidget);
  });

  testWidgets("display list when state is PopularMoviesLoaded", (widgetTester) async {
    // arrange
    whenListen<MoviesState>(
        mockBloc,
        Stream<MoviesState>.fromIterable([
          const MoviesLoading(),
          const PopularMoviesLoaded(testMovies)
        ],),
        initialState: const MoviesEmpty()
    );

    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const PopularMoviesLoaded(testMovies)]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const PopularMoviesListBlocBuilder()));

    // assert
    expect(find.byType(MovieScrollingList), findsOneWidget);
  });

}