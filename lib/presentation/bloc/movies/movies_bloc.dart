import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_event.dart';
import 'package:movie_finder/presentation/bloc/movies/movies_state.dart';

abstract class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(const MoviesEmpty());
}