import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_state.dart';

import '../../../helper/test_data.dart';
import 'watchlist_loader_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistUseCase])
void main() {

  late MockGetWatchlistUseCase mockGetWatchlistUseCase;
  late WatchlistLoaderBloc bloc;

  setUp(() {
    mockGetWatchlistUseCase = MockGetWatchlistUseCase();
    bloc = WatchlistLoaderBloc(mockGetWatchlistUseCase);
  });

  test("Initial state should be WatchlistEmpty", () {
    expect(bloc.state, const WatchlistEmpty());
  });

  group("GetWatchlist", () {
    blocTest<WatchlistLoaderBloc, WatchlistLoaderState>("Should return WatchlistLoaded with valid movies list if DataSuccess is returned from mockGetTrendingMoviesUseCase",
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
    blocTest<WatchlistLoaderBloc, WatchlistLoaderState>("Should return WatchlistError if DataFailure is returned from mockGetTrendingMoviesUseCase",
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
}