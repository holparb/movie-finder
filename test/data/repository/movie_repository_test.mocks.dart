// Mocks generated by Mockito 5.4.4 from annotations
// in movie_finder/test/data/repository/movie_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart'
    as _i4;
import 'package:movie_finder/data/models/movie_model.dart' as _i3;

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

/// A class which mocks [MoviesDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesDataSource extends _i1.Mock implements _i4.MoviesDataSource {
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
  _i5.Future<List<_i3.MovieModel>> getMoviesList(String? endpoint) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMoviesList,
          [endpoint],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);

  @override
  _i5.Future<List<_i3.MovieModel>> getTrendingMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTrendingMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);

  @override
  _i5.Future<List<_i3.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);

  @override
  _i5.Future<List<_i3.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i5.Future<List<_i3.MovieModel>>.value(<_i3.MovieModel>[]),
      ) as _i5.Future<List<_i3.MovieModel>>);

  @override
  _i5.Future<_i3.MovieModel> getMovieDetails(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieDetails,
          [id],
        ),
        returnValue: _i5.Future<_i3.MovieModel>.value(_FakeMovieModel_1(
          this,
          Invocation.method(
            #getMovieDetails,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.MovieModel>);

  @override
  String createUrlString(String? endpoint) => (super.noSuchMethod(
        Invocation.method(
          #createUrlString,
          [endpoint],
        ),
        returnValue: _i6.dummyValue<String>(
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
