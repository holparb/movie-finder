import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/pages/saved_movies_page.dart';
import 'package:movie_finder/presentation/widgets/login/not_logged_in_screen.dart';
import 'package:movie_finder/presentation/widgets/saved_movies_list/saved_movies.dart';

class MockLoginBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() async {
    loginBloc = MockLoginBloc();
  });

  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
        title: 'MovieFinder',
        theme: ThemeData(),
        home: BlocProvider<AuthBloc>(
            create: (_) => loginBloc,
            child: widget
        )
    );
  }

  testWidgets("Should display SavedMoviesList widget when logged in", (widgetTester) async {
    // arrange
    whenListen<AuthState>(
        loginBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
          const LoggingIn(),
          const LoggedIn("username")
        ],),
        initialState: const NotLoggedIn()
    );
    // act
    await expectLater(loginBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn(), const LoggingIn(), const LoggedIn("username")]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const SavedMoviesPage()));
    // assert
    expect(find.byType(SavedMovies), findsOneWidget);
  });

  testWidgets("Should display NotLoggedInScreen widget when logged in", (widgetTester) async {
    // arrange
    whenListen<AuthState>(
        loginBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
        ],),
        initialState: const NotLoggedIn()
    );
    // act
    await expectLater(loginBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const SavedMoviesPage()));
    // assert
    expect(find.byType(NotLoggedInScreen), findsOneWidget);
  });
}
