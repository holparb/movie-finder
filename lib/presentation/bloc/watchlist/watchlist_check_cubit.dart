import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';

class WatchlistCheckCubit extends Cubit<bool> {
  WatchlistCheckCubit(this._isMovieOnWatchlistUseCase) : super(false);

  final IsMovieOnWatchlistUseCase _isMovieOnWatchlistUseCase;

  void checkIfMovieIsOnWatchlist(int id) async {
    final onWatchlist = await _isMovieOnWatchlistUseCase(params: id);
    emit(onWatchlist);
  }
}