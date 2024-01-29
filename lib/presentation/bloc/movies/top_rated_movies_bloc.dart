import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

class TopRatedMoviesBloc extends MoviesBloc {
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;

  TopRatedMoviesBloc(this._getTopRatedMoviesUseCase) {
    on <GetTopRatedMovies> (onGetTopRatedMovies);
  }

  void onGetTopRatedMovies(GetTopRatedMovies event, Emitter<MoviesState> emit) async {
    emit(const MoviesLoading());
    final dataState = await _getTopRatedMoviesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(TopRatedMoviesLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MoviesError(dataState.error!));
    }
  }
}