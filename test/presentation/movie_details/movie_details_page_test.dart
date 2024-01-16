import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie_finder/presentation/pages/movie_detail_page.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_body.dart';

import '../../helper/test_data.dart';

class MockMovieDetailsBloc extends MockBloc<MovieDetailsEvent, MovieDetailsState> implements MovieDetailsBloc {}

void main() {
  late MockMovieDetailsBloc mockBloc;

  Widget createWidgetUnderTest(Movie movie) {
    return MaterialApp(
        home: Scaffold(
          body: BlocProvider<MovieDetailsBloc>(
              create: (_) => mockBloc,
              child: MovieDetailsPage(movie: movie)
          ),
        )
    );
  }

  setUp(() {
    mockBloc = MockMovieDetailsBloc();
  });

  testWidgets("display loading indicator if state is MovieDetailsLoading", (widgetTester) async {
    // arrange
    whenListen<MovieDetailsState>(
        mockBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
        ],),
        initialState: const MovieDetailsLoading()
    );
    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("display MovieDetailsBody if state is MovieDetailsLoaded", (widgetTester) async {
    // arrange
    whenListen<MovieDetailsState>(
        mockBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
          MovieDetailsLoaded(testMovieDetail)
        ],),
        initialState: const MovieDetailsLoading()
    );
    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading(), MovieDetailsLoaded(testMovieDetail)]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));
    // assert
    expect(find.byType(MovieDetailsBody), findsOneWidget);
  });

  testWidgets("display MovieDetailsBody with default provided Movie entit if state is MovieDetailsError", (widgetTester) async {
    // arrange
    const DataError error = DataError(message: "Error message");
    whenListen<MovieDetailsState>(
        mockBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
          const MovieDetailsError(error)
        ],),
        initialState: const MovieDetailsLoading()
    );
    // act - make sure bloc stream is emitted before building widget
    await expectLater(mockBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading(), const MovieDetailsError(error)]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieWithNoDetailsInfo));
    // assert
    MovieDetailsBody movieDetailsBody = widgetTester.firstWidget(find.byType(MovieDetailsBody));
    expect(movieDetailsBody, isNotNull);
    expect(movieDetailsBody.movie, testMovieWithNoDetailsInfo);
  });
}