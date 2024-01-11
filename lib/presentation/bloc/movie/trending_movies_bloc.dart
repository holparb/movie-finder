import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_event.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  final GetTrendingMoviesUseCase _getTrendingMoviesUseCase;

  MoviesBloc(this._getTrendingMoviesUseCase) : super(const MoviesEmpty()) {
    on <GetTrendingMovies> (onGetTrendingMovies);
  }

  void onGetTrendingMovies(GetTrendingMovies event, Emitter<MoviesState> emit) async {
    emit(const MoviesLoading());
    final dataState = await _getTrendingMoviesUseCase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(MoviesLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MoviesError(dataState.error!));
    }
  }
}