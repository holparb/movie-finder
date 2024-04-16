import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/usecases/add_to_watchlist.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';
import 'package:movie_finder/domain/usecases/remove_from_watchlist.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_event.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_state.dart';

class WatchlistHandlerBloc extends Bloc<WatchlistHandlerEvent, WatchlistHandlerState> {
  final AddToWatchlistUseCase _addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase _removeFromWatchlistUseCase;
  final IsMovieOnWatchlistUseCase _isMovieOnWatchlistUseCase;

  WatchlistHandlerBloc(this._addToWatchlistUseCase, this._removeFromWatchlistUseCase, this._isMovieOnWatchlistUseCase) : super(const NotOnWatchlist()) {
    on <CheckWatchlistStatus> (onCheckWatchlistStatus);
    on <AddToWatchlist> (onAddToWatchlist);
    on <RemoveFromWatchlist> (onRemoveFromWatchlist);
  }

  void onCheckWatchlistStatus(CheckWatchlistStatus event, Emitter<WatchlistHandlerState> emit) async {
    final onWatchlist = await _isMovieOnWatchlistUseCase(params: event.id);
    emit(onWatchlist ? const OnWatchlist() : const NotOnWatchlist());
  }

  void onAddToWatchlist(AddToWatchlist event, Emitter<WatchlistHandlerState> emit) async {
    final success = await _addToWatchlistUseCase(params: event.id);
    emit(success ? const OnWatchlist() : const WatchlistHandlerError());
  }

  void onRemoveFromWatchlist(RemoveFromWatchlist event, Emitter<WatchlistHandlerState> emit) async {
    final success = await _removeFromWatchlistUseCase(params: event.id);
    emit(success ? const NotOnWatchlist() : const WatchlistHandlerError());
  }
}