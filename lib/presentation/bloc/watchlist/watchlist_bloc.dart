import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase _getWatchListUseCase;

  WatchlistBloc(this._getWatchListUseCase) : super(const WatchlistEmpy()) {
    on <GetWatchlist> (onGetWatchlist);
  }

  void onGetWatchlist(GetWatchlist event, Emitter<WatchlistState> emit) async {
    emit(const WatchlistLoading());
    final dataState = await _getWatchListUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(WatchlistLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(WatchlistError(dataState.error!));
    }
  }
}