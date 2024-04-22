import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/domain/usecases/add_to_watchlist.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';
import 'package:movie_finder/domain/usecases/remove_from_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_state.dart';

import 'watchlist_handler_bloc_test.mocks.dart';

@GenerateMocks([IsMovieOnWatchlistUseCase, AddToWatchlistUseCase, RemoveFromWatchlistUseCase])
void main() {
  late MockIsMovieOnWatchlistUseCase isMovieOnWatchlistUseCase;
  late MockAddToWatchlistUseCase addToWatchlistUseCase;
  late MockRemoveFromWatchlistUseCase removeFromWatchlistUseCase;
  late WatchlistHandlerBloc bloc;

  const int id = 1;

  setUp(() {
    isMovieOnWatchlistUseCase = MockIsMovieOnWatchlistUseCase();
    addToWatchlistUseCase = MockAddToWatchlistUseCase();
    removeFromWatchlistUseCase = MockRemoveFromWatchlistUseCase();
    bloc = WatchlistHandlerBloc(addToWatchlistUseCase, removeFromWatchlistUseCase, isMovieOnWatchlistUseCase);
  });

  test("Initial state should be NotOnWatchlist", () {
    expect(bloc.state, const NotOnWatchlist());
  });

  group("CheckWatchlistStatus", () {
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return OnWatchlist if true is returned from isMovieOnWatchlistUseCase",
        build: () {
          when(isMovieOnWatchlistUseCase(params: id)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(const CheckWatchlistStatus(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const OnWatchlist()
        ]
    );
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return NotOnWatchlist if false is returned from isMovieOnWatchlistUseCase",
        build: () {
          when(isMovieOnWatchlistUseCase(params: id)).thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) => bloc.add(const CheckWatchlistStatus(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const NotOnWatchlist()
        ]
    );
  });

  group("AddToWatchlist", () {
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return OnWatchlist if true is returned from addToWatchlistUseCase",
        build: () {
          when(addToWatchlistUseCase(params: id)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const OnWatchlist()
        ]
    );
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return WatchlistHandlerError if false is returned from addToWatchlistUseCase",
        build: () {
          when(addToWatchlistUseCase(params: id)).thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) => bloc.add(const AddToWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const WatchlistHandlerError()
        ]
    );
  });

  group("RemoveFromWatchlist", () {
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return NotOnWatchlist if true is returned from removeFromWatchlistUseCase",
        build: () {
          when(removeFromWatchlistUseCase(params: id)).thenAnswer((_) async => true);
          return bloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const NotOnWatchlist()
        ]
    );
    blocTest<WatchlistHandlerBloc, WatchlistHandlerState>("Should return WatchlistHandlerError if false is returned from removeFromWatchlistUseCase",
        build: () {
          when(removeFromWatchlistUseCase(params: id)).thenAnswer((_) async => false);
          return bloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const WatchlistHandlerError()
        ]
    );
  });
}