// Mocks generated by Mockito 5.4.4 from annotations
// in movie_finder/test/data/repository/movie_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart'
    as _i9;
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart'
    as _i4;
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart'
    as _i5;
import 'package:movie_finder/data/models/movie_model.dart' as _i3;
import 'package:movie_finder/data/models/user_model.dart' as _i8;

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

class _FakeMovieModel_1 extends _i1.SmartFake implements _i3.MovieModel {
  _FakeMovieModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserAuthData_2 extends _i1.SmartFake implements _i4.UserAuthData {
  _FakeUserAuthData_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MoviesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesDataSource extends _i1.Mock implements _i5.MoviesDataSource {
  MockMoviesDataSource() {
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
  _i6.Future<List<_i3.MovieModel>> getTrendingMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTrendingMovies,
          [],
        ),
        returnValue: _i6.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i6.Future<List<_i3.MovieModel>>);

  @override
  _i6.Future<List<_i3.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i6.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i6.Future<List<_i3.MovieModel>>);

  @override
  _i6.Future<List<_i3.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i6.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i6.Future<List<_i3.MovieModel>>);

  @override
  _i6.Future<_i3.MovieModel> getMovieDetails(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieDetails,
          [id],
        ),
        returnValue: _i6.Future<_i3.MovieModel>.value(_FakeMovieModel_1(
          this,
          Invocation.method(
            #getMovieDetails,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.MovieModel>);

  @override
  _i6.Future<List<_i3.MovieModel>> getWatchList(
    String? userId,
    String? sessionId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchList,
          [
            userId,
            sessionId,
          ],
        ),
        returnValue: _i6.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i6.Future<List<_i3.MovieModel>>);

  @override
  _i6.Future<bool> editWatchlist({
    required int? movieId,
    required String? userId,
    required String? sessionId,
    required bool? add,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #editWatchlist,
          [],
          {
            #movieId: movieId,
            #userId: userId,
            #sessionId: sessionId,
            #add: add,
          },
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> addToWatchlist({
    required int? movieId,
    required String? userId,
    required String? sessionId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToWatchlist,
          [],
          {
            #movieId: movieId,
            #userId: userId,
            #sessionId: sessionId,
          },
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> removeFromWatchlist({
    required int? movieId,
    required String? userId,
    required String? sessionId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [],
          {
            #movieId: movieId,
            #userId: userId,
            #sessionId: sessionId,
          },
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<List<_i3.MovieModel>> search(String? query) => (super.noSuchMethod(
        Invocation.method(
          #search,
          [query],
        ),
        returnValue: _i6.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i6.Future<List<_i3.MovieModel>>);

  @override
  String createUrlString(
    String? endpoint, {
    Map<String, String>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUrlString,
          [endpoint],
          {#queryParameters: queryParameters},
        ),
        returnValue: _i7.dummyValue<String>(
          this,
          Invocation.method(
            #createUrlString,
            [endpoint],
            {#queryParameters: queryParameters},
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

/// A class which mocks [LocalUserDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalUserDataSource extends _i1.Mock
    implements _i4.LocalUserDataSource {
  MockLocalUserDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> writeUserData(
    String? sessionId,
    _i8.UserModel? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeUserData,
          [
            sessionId,
            user,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteUserData() => (super.noSuchMethod(
        Invocation.method(
          #deleteUserData,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<String?> readSessionId() => (super.noSuchMethod(
        Invocation.method(
          #readSessionId,
          [],
        ),
        returnValue: _i6.Future<String?>.value(),
      ) as _i6.Future<String?>);

  @override
  _i6.Future<String?> readUsername() => (super.noSuchMethod(
        Invocation.method(
          #readUsername,
          [],
        ),
        returnValue: _i6.Future<String?>.value(),
      ) as _i6.Future<String?>);

  @override
  _i6.Future<String?> readUserId() => (super.noSuchMethod(
        Invocation.method(
          #readUserId,
          [],
        ),
        returnValue: _i6.Future<String?>.value(),
      ) as _i6.Future<String?>);

  @override
  _i6.Future<_i4.UserAuthData> getUserAuthData() => (super.noSuchMethod(
        Invocation.method(
          #getUserAuthData,
          [],
        ),
        returnValue: _i6.Future<_i4.UserAuthData>.value(_FakeUserAuthData_2(
          this,
          Invocation.method(
            #getUserAuthData,
            [],
          ),
        )),
      ) as _i6.Future<_i4.UserAuthData>);
}

/// A class which mocks [LocalMoviesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalMoviesDataSource extends _i1.Mock
    implements _i9.LocalMoviesDataSource {
  MockLocalMoviesDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> writeWatchlistIds(List<_i3.MovieModel>? watchlist) =>
      (super.noSuchMethod(
        Invocation.method(
          #writeWatchlistIds,
          [watchlist],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<List<String>?> readWatchlistIds() => (super.noSuchMethod(
        Invocation.method(
          #readWatchlistIds,
          [],
        ),
        returnValue: _i6.Future<List<String>?>.value(),
      ) as _i6.Future<List<String>?>);

  @override
  _i6.Future<void> addToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #addToWatchlist,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> removeFromWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
