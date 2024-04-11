import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_state.dart';

import '../../../helper/test_data.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistUseCase, IsMovieOnWatchlistUseCase])
void main() {

  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late MockIsMovieOnWatchlistUseCase mockIsMovieOnWatchlistUseCase;
  late WatchlistBloc bloc;

  setUp(() {
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    mockIsMovieOnWatchlistUseCase = MockIsMovieOnWatchlistUseCase();
    bloc = WatchlistBloc(mockGetWatchlistUseCase, mockIsMovieOnWatchlistUseCase);
  });

  test("Initial state should be WatchlistEmpty", () {
    expect(bloc.state, const WatchlistEmpy());
  });

  group("GetWatchlist", () {
    blocTest<WatchlistBloc, WatchlistState>("Should return WatchlistLoaded with valid movies list if DataSuccess is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetWatchlistUseCase()).thenAnswer((_) async => const DataSuccess(testMovies));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetWatchlist()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const WatchlistLoading(),
          const WatchlistLoaded(testMovies)
        ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<WatchlistBloc, WatchlistState>("Should return WatchlistError if DataFailure is returned from mockGetTrendingMoviesUseCase",
        build: () {
          when(mockGetWatchlistUseCase()).thenAnswer((_) async => DataFailure(error));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetWatchlist()),
        wait: const Duration(seconds: 1),
        expect: () => [
          const WatchlistLoading(),
          WatchlistError(error)
        ]
    );
  });

  group("IsMovieOnWatchlist", () {
    const int id = 1;
    blocTest<WatchlistBloc, WatchlistState>("Should return true if true is returned from mockIsMovieOnWatchlistUseCase",
        build: () {
          when(mockIsMovieOnWatchlistUseCase(params: id)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(const IsMovieOnWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const IsMovieOnWatchlistResult(true)
        ]
    );

    blocTest<WatchlistBloc, WatchlistState>("Should return false if false is returned from mockIsMovieOnWatchlistUseCase",
        build: () {
          when(mockIsMovieOnWatchlistUseCase(params: id)).thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) => bloc.add(const IsMovieOnWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const IsMovieOnWatchlistResult(true)
        ]
    );
  });
}