// Mocks generated by Mockito 5.4.4 from annotations
// in movie_finder/test/domain/usecase/get_trending_movies_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_finder/core/data_state.dart' as _i2;
import 'package:movie_finder/domain/entities/movie.dart' as _i5;
import 'package:movie_finder/domain/repositories/movie_repository.dart' as _i3;

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

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i3.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.DataState<List<_i5.Movie>>> getTrendingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTrendingMovies,
          [],
        ),
        returnValue: _i4.Future<_i2.DataState<List<_i5.Movie>>>.value(
            _FakeDataState_0<List<_i5.Movie>>(
          this,
          Invocation.method(
            #getTrendingMovies,
            [],
          ),
        )),
      ) as _i4.Future<_i2.DataState<List<_i5.Movie>>>);

  @override
  _i4.Future<_i2.DataState<_i5.Movie>> getMovieDetails(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetails,
          [id],
        ),
        returnValue: _i4.Future<_i2.DataState<_i5.Movie>>.value(
            _FakeDataState_0<_i5.Movie>(
          this,
          Invocation.method(
            #getMovieDetails,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.DataState<_i5.Movie>>);
}
