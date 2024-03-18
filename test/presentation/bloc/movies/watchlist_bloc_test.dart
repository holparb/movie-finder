import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';
import 'package:movie_finder/presentation/bloc/movies/watchlist_bloc.dart';

import '../../../helper/test_data.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistUseCase])
void main() {

  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late WatchlistBloc bloc;

  setUp(() {
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    bloc = WatchlistBloc(mockGetWatchlistUseCase);
  });

  test("Initial state should be MoviesEmpty", () {
    expect(bloc.state, const MoviesEmpty());
  });

  group("GetPopularMovies", () {
    blocTest<WatchlistBloc, MoviesState>("Should return WatchlistLoaded with valid movies list if DataSuccess is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetWatchlistUseCase()).thenAnswer((_) async => const DataSuccess(testMovies));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetWatchlist()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          const WatchlistLoaded(testMovies)
        ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<WatchlistBloc, MoviesState>("Should return MoviesError if DataFailure is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetWatchlistUseCase()).thenAnswer((_) async => DataFailure(error));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetWatchlist()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MoviesLoading(),
          MoviesError(error)
        ]
    );
  });
}