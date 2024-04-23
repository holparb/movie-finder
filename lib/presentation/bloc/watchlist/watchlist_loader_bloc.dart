import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_state.dart';

class WatchlistLoaderBloc extends Bloc<WatchlistLoaderEvent, WatchlistLoaderState> {
  final GetWatchlistUseCase _getWatchListUseCase;

  WatchlistLoaderBloc(this._getWatchListUseCase) : super(const WatchlistEmpty()) {
    on <GetWatchlist> (onGetWatchlist);
  }

  void onGetWatchlist(GetWatchlist event, Emitter<WatchlistLoaderState> emit) async {
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