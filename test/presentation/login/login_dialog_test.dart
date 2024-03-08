import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_event.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_state.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog.dart';
import 'package:movie_finder/presentation/widgets/login/login_dialog_error_message.dart';
import 'package:movie_finder/presentation/widgets/login/login_text_form_field.dart';

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

  testWidgets("Should display form correctly with all major components", (widgetTester) async {
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
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialog()));
    // assert
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(LoginTextFormField), findsNWidgets(2));
    expect(find.byType(LoginDialogErrorMessage), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(MaterialButton), findsOneWidget);
    expect(find.byType(BlocBuilder<AuthBloc, AuthState>), findsNWidgets(2));
  });

  testWidgets("Login button should display \"Login\" text when state is NotLoggedIn", (widgetTester) async {
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
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialog()));
    // assert
    expect(find.text("Login"), findsOneWidget);
  });

  testWidgets("Login button should progress indicator when state is LoggingIn", (widgetTester) async {
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
    await widgetTester.pumpWidget(createWidgetUnderTest(const LoginDialog()));
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}