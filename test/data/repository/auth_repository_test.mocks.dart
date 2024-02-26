// Mocks generated by Mockito 5.4.4 from annotations
// in movie_finder/test/data/repository/auth_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart'
    as _i5;
import 'package:movie_finder/data/models/request_token_model.dart' as _i3;
import 'package:movie_finder/data/models/user_model.dart' as _i4;

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

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRequestTokenModel_1 extends _i1.SmartFake
    implements _i3.RequestTokenModel {
  _FakeRequestTokenModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserModel_2 extends _i1.SmartFake implements _i4.UserModel {
  _FakeUserModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthDataSource extends _i1.Mock implements _i5.AuthDataSource {
  MockAuthDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);

  @override
  _i6.Future<_i3.RequestTokenModel> getRequestToken() => (super.noSuchMethod(
        Invocation.method(
          #getRequestToken,
          [],
        ),
        returnValue:
            _i6.Future<_i3.RequestTokenModel>.value(_FakeRequestTokenModel_1(
          this,
          Invocation.method(
            #getRequestToken,
            [],
          ),
        )),
      ) as _i6.Future<_i3.RequestTokenModel>);

  @override
  _i6.Future<_i3.RequestTokenModel> validateToken(
          Map<String, String>? requestBody) =>
      (super.noSuchMethod(
        Invocation.method(
          #validateToken,
          [requestBody],
        ),
        returnValue:
            _i6.Future<_i3.RequestTokenModel>.value(_FakeRequestTokenModel_1(
          this,
          Invocation.method(
            #validateToken,
            [requestBody],
          ),
        )),
      ) as _i6.Future<_i3.RequestTokenModel>);

  @override
  _i6.Future<String> createSession(_i3.RequestTokenModel? requestToken) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSession,
          [requestToken],
        ),
        returnValue: _i6.Future<String>.value(_i7.dummyValue<String>(
          this,
          Invocation.method(
            #createSession,
            [requestToken],
          ),
        )),
      ) as _i6.Future<String>);

  @override
  _i6.Future<_i4.UserModel> getUserAccountDetails(String? sessionId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserAccountDetails,
          [sessionId],
        ),
        returnValue: _i6.Future<_i4.UserModel>.value(_FakeUserModel_2(
          this,
          Invocation.method(
            #getUserAccountDetails,
            [sessionId],
          ),
        )),
      ) as _i6.Future<_i4.UserModel>);

  @override
  _i6.Future<bool> deleteSession(Map<String, String>? requestBody) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSession,
          [requestBody],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  String createUrlString(String? endpoint) => (super.noSuchMethod(
        Invocation.method(
          #createUrlString,
          [endpoint],
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #createUrlString,
            [endpoint],
          ),
        ),
      ) as String);

  @override
  dynamic get(String? url) => super.noSuchMethod(Invocation.method(
        #get,
        [url],
      ));

  @override
  dynamic post(
    String? url,
    Map<dynamic, dynamic>? body,
  ) =>
      super.noSuchMethod(Invocation.method(
        #post,
        [
          url,
          body,
        ],
      ));

  @override
  dynamic delete(
    String? url,
    Map<dynamic, dynamic>? body,
  ) =>
      super.noSuchMethod(Invocation.method(
        #delete,
        [
          url,
          body,
        ],
      ));
}
