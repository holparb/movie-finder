import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_event.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_state.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_bloc_builder.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_scrolling_list.dart';

import '../../helper/test_data.dart';

class MockMoviesBlock extends MockBloc<MoviesEvent, MoviesState> implements MoviesBloc {}

void main() {
  late MockMoviesBlock mockBloc;

  Widget createWidgetUnderTest() {
    return MaterialApp(
        home: BlocProvider<MoviesBloc>(
            create: (_) => mockBloc,
            child: const MovieListBlocBuilder()
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
    await widgetTester.pumpWidget(createWidgetUnderTest());
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
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("display list when state is MoviesLoaded", (widgetTester) async {
    // arrange
    whenListen<MoviesState>(
        mockBloc,
        Stream<MoviesState>.fromIterable([
          const MoviesLoading(),
          const MoviesLoaded(testMovies)
        ],),
        initialState: const MoviesEmpty()
    );

    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MoviesState>[const MoviesLoading(), const MoviesLoaded(testMovies)]));
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(MovieScrollingList), findsOneWidget);
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
    await widgetTester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text("Couldn't load movies, try again!"), findsOneWidget);
  });
}