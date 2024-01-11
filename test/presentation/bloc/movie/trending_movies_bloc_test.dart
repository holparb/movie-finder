import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_event.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_state.dart';

import '../../../helper/test_data.dart';
import 'trending_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTrendingMoviesUseCase])
void main() {

  late MockGetTrendingMoviesUseCase usecase;
  late MoviesBloc moviesBloc;

  setUp(() {
    usecase = MockGetTrendingMoviesUseCase();
    moviesBloc = MoviesBloc(usecase);
  });

  test("Initial state should be MoviesLoading", () {
    expect(moviesBloc.state, const MoviesEmpty());
  });

  group("GetTrendingMovies", () {
    blocTest<MoviesBloc, MoviesState>("Should return MoviesLoaded with valid movies list if DataSuccess is returned from usecase",
      build: () {
          when(usecase()).thenAnswer((_) async => const DataSuccess(testMovies));
          return moviesBloc;
        },
      act: (bloc) => bloc.add(const GetTrendingMovies()),
      wait: const Duration(seconds: 1),
      expect: () => [
        const MoviesLoading(),
        const MoviesLoaded(testMovies)
      ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<MoviesBloc, MoviesState>("Should return MoviesError if DataFailure is returned from usecase",
        build: () {
          when(usecase()).thenAnswer((_) async => DataFailure(error));
          return moviesBloc;
        },
        act: (bloc) => bloc.add(const GetTrendingMovies()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          MoviesError(error)
        ]
    );
  });
}