import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_state.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_state.dart';
import 'package:movie_finder/presentation/pages/movie_detail_page.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_body.dart';

import '../../helper/test_data.dart';

class MockMovieDetailsBloc extends MockBloc<MovieDetailsEvent, MovieDetailsState> implements MovieDetailsBloc {}
class MockWatchlistHandlerBloc extends MockBloc<WatchlistHandlerEvent, WatchlistHandlerState> implements WatchlistHandlerBloc {}
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockMovieDetailsBloc movieDetailsBloc;
  late MockWatchlistHandlerBloc watchlistHandlerBloc;
  late MockAuthBloc authBloc;

  Widget createWidgetUnderTest(Movie movie) {
    return MaterialApp(
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<MovieDetailsBloc>(create: (_) => movieDetailsBloc),
              BlocProvider<WatchlistHandlerBloc>(create: (_) => watchlistHandlerBloc),
              BlocProvider<AuthBloc>(create: (_) => authBloc)
            ],
            child: MovieDetailsPage(movie: movie)
          )
        )
    );
  }

  setUp(() {
    watchlistHandlerBloc = MockWatchlistHandlerBloc();
    movieDetailsBloc = MockMovieDetailsBloc();
    authBloc = MockAuthBloc();
  });

  setUpAll(() {
    initializeDependencies();
  });

  testWidgets("display loading indicator if state is MovieDetailsLoading", (widgetTester) async {
    // arrange
    whenListen<MovieDetailsState>(
        movieDetailsBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
        ],),
        initialState: const MovieDetailsLoading()
    );

    // act - make sure bloc stream is emitted before building widget
    await expectLater(movieDetailsBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("display MovieDetailsBody if state is MovieDetailsLoaded", (widgetTester) async {
    // arrange
    whenListen<MovieDetailsState>(
        movieDetailsBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
          MovieDetailsLoaded(testMovieDetail)
        ],),
        initialState: const MovieDetailsLoading()
    );
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const LoggedIn("username"),
        ],),
        initialState: const NotLoggedIn()
    );
    // act - make sure bloc stream is emitted before building widget
    await expectLater(movieDetailsBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading(), MovieDetailsLoaded(testMovieDetail)]));
    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("username")]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));
    // assert
    expect(find.byType(MovieDetailsBody), findsOneWidget);
  });

  testWidgets("display MovieDetailsBody with default provided Movie entit if state is MovieDetailsError", (widgetTester) async {
    // arrange
    const DataError error = DataError(message: "Error message");
    whenListen<MovieDetailsState>(
        movieDetailsBloc,
        Stream<MovieDetailsState>.fromIterable([
          const MovieDetailsLoading(),
          const MovieDetailsError(error)
        ],),
        initialState: const MovieDetailsLoading()
    );
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const LoggedIn("username"),
        ],),
        initialState: const NotLoggedIn()
    );
    whenListen<WatchlistHandlerState>(
        watchlistHandlerBloc,
        Stream<WatchlistHandlerState>.fromIterable([
          const NotOnWatchlist(),
        ],),
        initialState: const NotOnWatchlist()
    );
    // act - make sure bloc stream is emitted before building widget
    await expectLater(movieDetailsBloc.stream, emitsInOrder(<MovieDetailsState>[const MovieDetailsLoading(), const MovieDetailsError(error)]));
    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("username")]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const NotOnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieWithNoDetailsInfo));
    // assert
    MovieDetailsBody movieDetailsBody = widgetTester.firstWidget(find.byType(MovieDetailsBody));
    expect(movieDetailsBody, isNotNull);
    expect(movieDetailsBody.movie, testMovieWithNoDetailsInfo);
  });
}