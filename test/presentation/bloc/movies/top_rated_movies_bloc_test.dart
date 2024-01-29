import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';
import 'package:movie_finder/presentation/bloc/movies/top_rated_movies_bloc.dart';

import '../../../helper/test_data.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMoviesUseCase])
void main() {

  late MockGetTopRatedMoviesUseCase mockGetTopRatedMoviesUseCase;
  late TopRatedMoviesBloc bloc;

  setUp(() {
    mockGetTopRatedMoviesUseCase = MockGetTopRatedMoviesUseCase();
    bloc = TopRatedMoviesBloc(mockGetTopRatedMoviesUseCase);
  });

  test("Initial state should be MoviesEmpty", () {
    expect(bloc.state, const MoviesEmpty());
  });

  group("GetPopularMovies", () {
    blocTest<TopRatedMoviesBloc, MoviesState>("Should return MoviesLoaded with valid movies list if DataSuccess is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetTopRatedMoviesUseCase()).thenAnswer((_) async => const DataSuccess(testMovies));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetTopRatedMovies()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          const TopRatedMoviesLoaded(testMovies)
        ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<TopRatedMoviesBloc, MoviesState>("Should return MoviesError if DataFailure is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetTopRatedMoviesUseCase()).thenAnswer((_) async => DataFailure(error));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetTopRatedMovies()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          MoviesError(error)
        ]
    );
  });
}