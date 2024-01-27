import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

class TrendingMoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;

  TrendingMoviesBloc(this._getTrendingMoviesUseCase) : super(const MoviesEmpty()) {
    on <GetTrendingMovies> (onGetTrendingMovies);
  }

  void onGetTrendingMovies(GetTrendingMovies event, Emitter<MoviesState> emit) async {
    emit(const MoviesLoading());
    final dataState = await _getTrendingMoviesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(TrendingMoviesLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MoviesError(dataState.error!));
    }
  }
}