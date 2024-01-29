import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_popular_movies.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

class PopularMoviesBloc extends MoviesBloc {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  PopularMoviesBloc(this._getPopularMoviesUseCase) : super(){
    on <GetPopularMovies> (onGetPopularMovies);
  }

  void onGetPopularMovies(GetPopularMovies event, Emitter<MoviesState> emit) async {
    emit(const MoviesLoading());
    final dataState = await _getPopularMoviesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(PopularMoviesLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MoviesError(dataState.error!));
    }
  }
}