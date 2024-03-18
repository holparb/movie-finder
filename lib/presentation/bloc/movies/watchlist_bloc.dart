import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

class WatchlistBloc extends MoviesBloc {
  final GetWatchlistUseCase _getWatchListUseCase;

  WatchlistBloc(this._getWatchListUseCase) : super(){
    on <GetWatchlist> (onGetWatchlist);
  }

  void onGetWatchlist(GetWatchlist event, Emitter<MoviesState> emit) async {
    emit(const MoviesLoading());
    final dataState = await _getWatchListUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(WatchlistLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MoviesError(dataState.error!));
    }
  }
}