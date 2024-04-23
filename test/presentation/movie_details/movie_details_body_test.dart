import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_body.dart';
import 'package:movie_finder/presentation/widgets/movie_detail/movie_details_picture_and_title.dart';

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
                child: MovieDetailsBody(movie: movie)
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

  testWidgets("Basic parts should render correctly", (widgetTester) async {
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

    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("username")]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const NotOnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));

    expect(find.byType(MovieDetailsPictureAndTitle), findsOneWidget);
    expect(find.text(testMovieDetail.overview), findsOneWidget);
  });

  testWidgets("Button should not render if state is NotLoggedIn", (widgetTester) async {
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
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

    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn()]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const NotOnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));

    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets("Button should render if state is LoggedIn", (widgetTester) async {
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const LoggedIn("User"),
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

    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("User")]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const NotOnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets("AddToWatchlistButton should render if state is LoggedIn and NotOnWatchlist", (widgetTester) async {
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const LoggedIn("User"),
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

    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("User")]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const NotOnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));

    expect(find.byType(AddToWatchlistButton), findsOneWidget);
  });

  testWidgets("AddedToWatchlistButton should render if state is LoggedIn and NotOnWatchlist", (widgetTester) async {
    whenListen<AuthState>(
        authBloc,
        Stream<AuthState>.fromIterable([
          const LoggedIn("User"),
        ],),
        initialState: const NotLoggedIn()
    );
    whenListen<WatchlistHandlerState>(
        watchlistHandlerBloc,
        Stream<WatchlistHandlerState>.fromIterable([
          const OnWatchlist(),
        ],),
        initialState: const NotOnWatchlist()
    );

    await expectLater(authBloc.stream, emitsInOrder(<AuthState>[const LoggedIn("User")]));
    await expectLater(watchlistHandlerBloc.stream, emitsInOrder(<WatchlistHandlerState>[const OnWatchlist()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(testMovieDetail));

    expect(find.byType(AddedToWatchlistButton), findsOneWidget);
  });
}