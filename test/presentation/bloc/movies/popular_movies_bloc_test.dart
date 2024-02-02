import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_popular_movies.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

import '../../../helper/test_data.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
void main() {

  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late PopularMoviesBloc bloc;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    bloc = PopularMoviesBloc(mockGetPopularMoviesUseCase);
  });

  test("Initial state should be MoviesEmpty", () {
    expect(bloc.state, const MoviesEmpty());
  });

  group("GetPopularMovies", () {
    blocTest<PopularMoviesBloc, MoviesState>("Should return MoviesLoaded with valid movies list if DataSuccess is returned from mockGetTrendingMoviesUseCase",
      build: () {
          when(mockGetPopularMoviesUseCase()).thenAnswer((_) async => const DataSuccess(testMovies));
          return bloc;
        },
      act: (bloc) => bloc.add(const GetPopularMovies()),
      wait: const Duration(seconds: 1),
      expect: () => [
        const MoviesLoading(),
        const PopularMoviesLoaded(testMovies)
      ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<PopularMoviesBloc, MoviesState>("Should return MoviesError if DataFailure is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetPopularMoviesUseCase()).thenAnswer((_) async => DataFailure(error));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetPopularMovies()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          MoviesError(error)
        ]
    );
  });
}