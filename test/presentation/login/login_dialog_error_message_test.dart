import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/login_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog_error_message.dart';

class MockLoginBloc extends MockBloc<AuthEvent, AuthState> implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() async {
    loginBloc = MockLoginBloc();
  });

  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
        title: 'MovieFinder',
        theme: ThemeData(),
        home: BlocProvider<LoginBloc>(
            create: (_) => loginBloc,
            child: widget
        )
    );
  }

  testWidgets("Should display SizedBox when state is NotLoggedIn", (widgetTester) async {
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
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialogErrorMessage()));
    // assert
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets("Should display SizedBox when state is LoggingIn", (widgetTester) async {
    // arrange
    whenListen<AuthState>(
        loginBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
          const LoggingIn()
        ],),
        initialState: const NotLoggedIn()
    );
    // act
    await expectLater(loginBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn(), const LoggingIn()]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialogErrorMessage()));
    // assert
    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets("Should display error message when state is LoginError", (widgetTester) async {
    // arrange
    whenListen<AuthState>(
        loginBloc,
        Stream<AuthState>.fromIterable([
          const NotLoggedIn(),
          const LoggingIn(),
          const LoginError("Login error!")
        ],),
        initialState: const NotLoggedIn()
    );
    // act
    await expectLater(loginBloc.stream, emitsInOrder(<AuthState>[const NotLoggedIn(), const LoggingIn(), const LoginError("Login error!")]));
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialogErrorMessage()));
    // assert
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.text("Login failed, try again!"), findsOneWidget);
  });
}