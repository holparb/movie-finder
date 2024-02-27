import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog.dart';
import 'package:movie_finder/presentation/widgets/login/not_logged_in_screen.dart';

class MockLoginBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
        title: "MovieFinder",
        theme: ThemeData(),
        home: widget
    );
  }

  testWidgets("Should render all major components", (widgetTester) async {
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest(const NotLoggedInScreen()));
    // assert
    Padding padding = widgetTester.firstWidget(find.byType(Padding));
    expect(padding, isNotNull);
    expect(padding.padding, const EdgeInsets.symmetric(horizontal: 16));
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets("Should render non button Text widgets with correct text", (widgetTester) async {
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest(const NotLoggedInScreen()));
    // assert
    Text notLoggedInTitle = find.byType(Text).evaluate().elementAt(0).widget as Text;
    expect(notLoggedInTitle, isNotNull);
    expect(notLoggedInTitle.data, "Not logged in into TMDB");

    Text notLoggedInSubtext = find.byType(Text).evaluate().elementAt(1).widget as Text;
    expect(notLoggedInSubtext, isNotNull);
    expect(notLoggedInSubtext.data, "Log into your TMDB account to view your watchlist");
  });

  testWidgets("Should render button Text child with correct text", (widgetTester) async {
    // act
    await widgetTester.pumpWidget(createWidgetUnderTest(const NotLoggedInScreen()));
    // assert
    ElevatedButton button = widgetTester.firstWidget(find.byType(ElevatedButton));
    expect(button, isNotNull);
    expect(button.child, isA<Text>());
    Text buttonText = button.child as Text;
    expect(buttonText.data, "Log in to TMDB");
  });

  testWidgets("Should execute showDialog and display LoginDialog when button is tapped", (widgetTester) async {
    // arrange
    MockLoginBloc loginBloc = MockLoginBloc();
    whenListen<AuthState>(
        loginBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
        ],),
        initialState: const NotLoggedIn()
    );
    // act
    await expectLater(loginBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn()]));
    await widgetTester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (_) => loginBloc,
          child: MaterialApp(
              title: "MovieFinder",
              theme: ThemeData(),
              home: const NotLoggedInScreen()
          ),
        )
    );
    await widgetTester.tap(find.byType(ElevatedButton));
    await widgetTester.pump();
    // assert
    expect(find.byType(LoginDialog), findsOneWidget);
  });
}