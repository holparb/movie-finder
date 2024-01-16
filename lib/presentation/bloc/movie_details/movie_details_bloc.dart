import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;

  MovieDetailsBloc(this._getMovieDetailsUseCase) : super(const MovieDetailsLoading()) {
    on<GetMovieDetails> (onGetMovieDetails);
  }

  void onGetMovieDetails(GetMovieDetails event, Emitter<MovieDetailsState> emit) async {
    emit(const MovieDetailsLoading());
    final dataState = await _getMovieDetailsUseCase(params: event.id);

    if(dataState is DataSuccess && dataState.data != null) {
      emit(MovieDetailsLoaded(dataState.data!));
    }

    if(dataState is DataFailure) {
      emit(MovieDetailsError(dataState.error! ));
    }
  }
}