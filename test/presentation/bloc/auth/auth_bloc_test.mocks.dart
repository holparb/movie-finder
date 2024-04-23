// Mocks generated by Mockito 5.4.4 from annotations
// in movie_finder/test/presentation/bloc/auth/auth_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_finder/core/data_state.dart' as _i2;
import 'package:movie_finder/domain/entities/user.dart' as _i5;
import 'package:movie_finder/domain/usecases/is_user_logged_in.dart' as _i7;
import 'package:movie_finder/domain/usecases/login.dart' as _i3;
import 'package:movie_finder/domain/usecases/logout.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDataState_0<T> extends _i1.SmartFake implements _i2.DataState<T> {
  _FakeDataState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUsecase extends _i1.Mock implements _i3.LoginUsecase {
  MockLoginUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.DataState<_i5.User>> call({_i3.LoginParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.DataState<_i5.User>>.value(
            _FakeDataState_0<_i5.User>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.DataState<_i5.User>>);
}

/// A class which mocks [LogoutUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogoutUsecase extends _i1.Mock implements _i6.LogoutUsecase {
  MockLogoutUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.DataState<void>> call({dynamic params}) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue:
            _i4.Future<_i2.DataState<void>>.value(_FakeDataState_0<void>(
          this,
          Invocation.method(
            #call,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.DataState<void>>);
}

/// A class which mocks [IsUserLoggedInUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockIsUserLoggedInUseCase extends _i1.Mock
    implements _i7.IsUserLoggedInUseCase {
  MockIsUserLoggedInUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String?> call({dynamic params}) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);
}
